#!/usr/bin/env bash
# Install latest PHP + php-cgi, enable it in Apache via mod_cgid/mod_actions, configtest and restart.
# Dry-run by default; pass --apply to change the host.
#
# Usage: sudo ./install-php-cgi.sh [--apply] [--php-version X.Y] [--extensions "mbstring xml curl zip"] [--no-repo]
set -euo pipefail

APPLY=0
PHP_VERSION="latest"
EXTENSIONS="mbstring xml curl zip"
ADD_REPO=1
HANDLER_DIR="/usr/local/lib/php-cgi-handler"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE="${SCRIPT_DIR}/../templates/php-cgi.conf"
TS="$(date +%Y%m%d%H%M%S)"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --apply) APPLY=1 ;;
    --php-version) PHP_VERSION="$2"; shift ;;
    --extensions) EXTENSIONS="$2"; shift ;;
    --no-repo) ADD_REPO=0 ;;
    -h|--help) sed -n '2,6p' "$0"; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 2 ;;
  esac
  shift
done

log()  { printf '\n==> %s\n' "$*"; }
run()  { if [[ $APPLY -eq 1 ]]; then echo "+ $*"; eval "$@"; else echo "[dry-run] $*"; fi; }
die()  { echo "ERROR: $*" >&2; exit 1; }

[[ -f "$TEMPLATE" ]] || die "template not found: $TEMPLATE"
if [[ $APPLY -eq 1 && $EUID -ne 0 ]]; then die "--apply must run as root (use sudo)"; fi

# ---------- OS detection ----------
. /etc/os-release
case " ${ID} ${ID_LIKE:-} " in
  *" debian "*|*" ubuntu "*) FAMILY=debian ;;
  *" rhel "*|*" fedora "*|*" centos "*) FAMILY=rhel ;;
  *) die "Unsupported OS: ${PRETTY_NAME:-$ID}" ;;
esac
log "Detected ${PRETTY_NAME} (family: ${FAMILY}); mode: $([[ $APPLY -eq 1 ]] && echo APPLY || echo DRY-RUN)"

# ---------- Debian / Ubuntu ----------
debian_setup() {
  export DEBIAN_FRONTEND=noninteractive
  log "Installing prerequisites and Apache"
  run "apt-get update -y"
  run "apt-get install -y apache2 ca-certificates curl lsb-release gnupg"

  if [[ $ADD_REPO -eq 1 ]]; then
    log "Adding upstream PHP repository (latest PHP builds)"
    if [[ "$ID" == "ubuntu" ]]; then
      run "apt-get install -y software-properties-common"
      run "add-apt-repository -y ppa:ondrej/php"
    else
      run "curl -fsSLo /tmp/debsuryorg-archive-keyring.deb https://packages.sury.org/debsuryorg-archive-keyring.deb"
      run "dpkg -i /tmp/debsuryorg-archive-keyring.deb && rm -f /tmp/debsuryorg-archive-keyring.deb"
      run "echo \"deb [signed-by=/usr/share/keyrings/debsuryorg-archive-keyring.gpg] https://packages.sury.org/php/ \$(lsb_release -sc) main\" > /etc/apt/sources.list.d/php-sury.list"
    fi
    run "apt-get update -y"
  fi

  if [[ "$PHP_VERSION" == "latest" ]]; then
    PHP_VERSION="$(apt-cache pkgnames 2>/dev/null | grep -E '^php[0-9]+\.[0-9]+-cgi$' \
      | sed -E 's/^php([0-9.]+)-cgi$/\1/' | sort -V | tail -1 || true)"
    if [[ -z "$PHP_VERSION" ]]; then
      [[ $APPLY -eq 1 ]] && die "Could not resolve latest php-cgi package"
      PHP_VERSION="X.Y"; echo "[dry-run] latest version resolves after the repo is added"
    fi
  fi
  log "Target PHP version: ${PHP_VERSION}"

  local pkgs="php${PHP_VERSION}-cgi php${PHP_VERSION}-cli php${PHP_VERSION}-common"
  for e in $EXTENSIONS; do pkgs+=" php${PHP_VERSION}-${e}"; done
  run "apt-get install -y ${pkgs}"
  PHP_CGI_BIN="/usr/bin/php-cgi${PHP_VERSION}"

  log "Disabling conflicting PHP handlers (mod_php / php-fpm conf)"
  for m in /etc/apache2/mods-enabled/php*.load; do
    [[ -e "$m" ]] && run "a2dismod -f $(basename "$m" .load)"
  done
  for c in /etc/apache2/conf-enabled/php*-fpm.conf /etc/apache2/conf-enabled/php*-cgi.conf; do
    [[ -e "$c" ]] && run "a2disconf $(basename "$c" .conf)"
  done

  log "Enabling CGI + actions modules"
  if apache2ctl -M 2>/dev/null | grep -q mpm_prefork_module; then
    run "a2enmod cgi actions alias"
  else
    run "a2enmod cgid actions alias"
  fi

  install_handler
  run "sed -e 's#__HANDLER_DIR__#${HANDLER_DIR}#g' '${TEMPLATE}' > /etc/apache2/conf-available/php-cgi.conf"
  run "a2enconf php-cgi"

  APACHECTL=apache2ctl; SERVICE=apache2
}

# ---------- RHEL / Rocky / Alma / Fedora ----------
rhel_setup() {
  local major; major="${VERSION_ID%%.*}"
  log "Installing Apache"
  run "dnf install -y httpd curl"

  if [[ $ADD_REPO -eq 1 && "$ID" != "fedora" ]]; then
    log "Adding EPEL + Remi repositories (latest PHP builds)"
    run "dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-${major}.noarch.rpm || true"
    run "dnf install -y https://rpms.remirepo.net/enterprise/remi-release-${major}.rpm || true"
  fi

  if [[ "$PHP_VERSION" == "latest" ]]; then
    PHP_VERSION="$(dnf -q module list php 2>/dev/null | grep -oE 'remi-[0-9]+\.[0-9]+' \
      | sed 's/remi-//' | sort -V | tail -1 || true)"
    if [[ -z "$PHP_VERSION" ]]; then
      [[ $APPLY -eq 1 && $ADD_REPO -eq 1 ]] && die "Could not resolve latest PHP module stream"
      PHP_VERSION="distro"
    fi
  fi
  log "Target PHP version: ${PHP_VERSION}"
  if [[ "$PHP_VERSION" != "distro" && "$PHP_VERSION" != "X.Y" ]]; then
    run "dnf module reset -y php"
    run "dnf module enable -y php:remi-${PHP_VERSION}"
  fi

  # On RHEL the php-cgi binary ships in php-cli.
  local pkgs="php-cli php-common"
  for e in $EXTENSIONS; do
    case "$e" in curl) ;; zip) pkgs+=" php-pecl-zip" ;; *) pkgs+=" php-${e}" ;; esac  # curl is built into php-common
  done
  run "dnf install -y $(echo "$pkgs" | tr ' ' '\n' | sort -u | tr '\n' ' ')"
  PHP_CGI_BIN="/usr/bin/php-cgi"

  log "Disabling conflicting PHP handlers (mod_php / php-fpm conf)"
  for c in /etc/httpd/conf.d/php.conf /etc/httpd/conf.modules.d/*-php.conf; do
    [[ -e "$c" ]] && run "mv '$c' '$c.bak-${TS}'"
  done

  log "Enabling CGI + actions modules"
  run "grep -qE '^\s*LoadModule (cgid|cgi)_module' /etc/httpd/conf.modules.d/*.conf || echo 'LoadModule cgid_module modules/mod_cgid.so' > /etc/httpd/conf.modules.d/01-cgi.conf"
  run "grep -qE '^\s*LoadModule actions_module' /etc/httpd/conf.modules.d/*.conf || echo 'LoadModule actions_module modules/mod_actions.so' > /etc/httpd/conf.modules.d/00-actions.conf"

  install_handler
  run "sed -e 's#__HANDLER_DIR__#${HANDLER_DIR}#g' '${TEMPLATE}' > /etc/httpd/conf.d/php-cgi.conf"

  if command -v getenforce >/dev/null 2>&1 && [[ "$(getenforce)" != "Disabled" ]]; then
    log "Labelling handler dir for SELinux"
    run "semanage fcontext -a -t httpd_sys_script_exec_t '${HANDLER_DIR}(/.*)?' 2>/dev/null || semanage fcontext -m -t httpd_sys_script_exec_t '${HANDLER_DIR}(/.*)?'"
    run "restorecon -Rv '${HANDLER_DIR}'"
  fi

  APACHECTL=apachectl; SERVICE=httpd
}

install_handler() {
  log "Installing php-cgi handler into ${HANDLER_DIR}"
  run "install -d -m 0755 '${HANDLER_DIR}'"
  run "ln -sfn '${PHP_CGI_BIN}' '${HANDLER_DIR}/php-cgi'"
}

"${FAMILY}_setup"

# ---------- Validate + restart ----------
log "Validating Apache configuration"
if [[ $APPLY -eq 1 ]]; then
  "$APACHECTL" configtest || die "configtest failed — Apache NOT restarted. Fix config or roll back (see SKILL.md)."
else
  echo "[dry-run] $APACHECTL configtest  (abort if this fails)"
fi

log "Restarting Apache"
run "systemctl enable ${SERVICE}"
run "systemctl restart ${SERVICE}"
run "systemctl is-active --quiet ${SERVICE}"

# ---------- Smoke test ----------
log "Smoke test"
if [[ $APPLY -eq 1 ]]; then
  "$PHP_CGI_BIN" -v | head -1
  DOCROOT="$("$APACHECTL" -S 2>/dev/null | awk -F'"' '/Main DocumentRoot/{print $2}')"
  DOCROOT="${DOCROOT:-/var/www/html}"
  PROBE="${DOCROOT}/.php-cgi-probe-${TS}.php"
  echo '<?php echo "PHP_CGI_OK ", PHP_VERSION, " ", PHP_SAPI;' > "$PROBE"
  chmod 0644 "$PROBE"
  trap 'rm -f "$PROBE"' EXIT
  OUT="$(curl -fsS "http://127.0.0.1/$(basename "$PROBE")" || true)"
  rm -f "$PROBE"
  if [[ "$OUT" == PHP_CGI_OK*cgi* ]]; then
    echo "SUCCESS: $OUT"
  else
    die "Smoke test failed. Response: ${OUT:-<empty>} — check ${SERVICE} error log."
  fi
else
  echo "[dry-run] create temp probe in DocumentRoot, curl http://127.0.0.1/<probe>.php, expect 'PHP_CGI_OK <ver> cgi-fcgi', delete probe"
fi

log "Done. PHP ${PHP_VERSION} is served by php-cgi through Apache (${SERVICE})."
