
<!--
Skill Pack Version: 1.0.0
Skill Pack License: GPL-3.0-only
Maintainer: Nasim Kabiliravi <kabiliravi@gmail.com>
Website: http://kabiliravi.com
LinkedIn: https://www.linkedin.com/in/nasim-kabi-liravi/
-->

==> Detected Debian GNU/Linux 13 (trixie) (family: debian); mode: DRY-RUN

==> Installing prerequisites and Apache
[dry-run] apt-get update -y
[dry-run] apt-get install -y apache2 ca-certificates curl lsb-release gnupg

==> Adding upstream PHP repository (latest PHP builds)
[dry-run] curl -fsSLo /tmp/debsuryorg-archive-keyring.deb https://packages.sury.org/debsuryorg-archive-keyring.deb
[dry-run] dpkg -i /tmp/debsuryorg-archive-keyring.deb && rm -f /tmp/debsuryorg-archive-keyring.deb
[dry-run] echo "deb [signed-by=/usr/share/keyrings/debsuryorg-archive-keyring.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php-sury.list
[dry-run] apt-get update -y

==> Target PHP version: 8.4
[dry-run] apt-get install -y php8.4-cgi php8.4-cli php8.4-common php8.4-mbstring php8.4-xml php8.4-curl php8.4-zip

==> Disabling conflicting PHP handlers (mod_php / php-fpm conf)

==> Enabling CGI + actions modules
[dry-run] a2enmod cgid actions alias

==> Installing php-cgi handler into /usr/local/lib/php-cgi-handler
[dry-run] install -d -m 0755 '/usr/local/lib/php-cgi-handler'
[dry-run] ln -sfn '/usr/bin/php-cgi8.4' '/usr/local/lib/php-cgi-handler/php-cgi'
[dry-run] sed -e 's#__HANDLER_DIR__#/usr/local/lib/php-cgi-handler#g' '/home/nkabiliravi/projects/agentic-sdlc-skill-pack/.agents/skills/06-deployment-and-infrastructure/webserver/apache/apache-php-cgi-setup/scripts/../templates/php-cgi.conf' > /etc/apache2/conf-available/php-cgi.conf
[dry-run] a2enconf php-cgi

==> Validating Apache configuration
[dry-run] apache2ctl configtest  (abort if this fails)

==> Restarting Apache
[dry-run] systemctl enable apache2
[dry-run] systemctl restart apache2
[dry-run] systemctl is-active --quiet apache2

==> Smoke test
[dry-run] create temp probe in DocumentRoot, curl http://127.0.0.1/<probe>.php, expect 'PHP_CGI_OK <ver> cgi-fcgi', delete probe

==> Done. PHP 8.4 is served by php-cgi through Apache (apache2).
