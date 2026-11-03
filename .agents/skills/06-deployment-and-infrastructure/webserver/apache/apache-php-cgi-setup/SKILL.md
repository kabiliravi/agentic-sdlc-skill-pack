---
name: apache-php-cgi-setup
description: Install the latest stable PHP with the php-cgi binary, wire it into Apache via mod_cgid/mod_actions (CGI handler), validate the config and restart Apache on Debian/Ubuntu or RHEL-family hosts.
---

# Apache PHP-CGI Setup
<!--
Version: 1.0.0
License: GPL-3.0-only
Author: Nasim Kabiliravi <kabiliravi@gmail.com>
Website: http://kabiliravi.com
LinkedIn: https://www.linkedin.com/in/nasim-kabi-liravi/
-->
Installs the newest PHP release available from the trusted upstream packager (Ondřej Surý PPA/sury.org on Debian/Ubuntu, Remi on RHEL/Rocky/Alma), installs `php-cgi`, enables Apache's CGI modules, registers `.php` files to run through `php-cgi`, runs `apachectl configtest`, restarts Apache and smoke-tests it.

## Required author choices
Read `config/project.yaml` (if present) for: `webserver.apache.php_version` (`latest` default, or a pinned `X.Y`), `webserver.apache.php_extensions` (default `mbstring xml curl zip`), target host/environment and change window. Record anything missing in `outputs/assumptions-and-gaps.md`. Never run against production without explicit human approval.

## Steps
1. **Pre-flight** – confirm root/sudo, OS family (`/etc/os-release`), that Apache is installed (or will be installed), and whether `mod_php`/`php-fpm` handlers already exist (they would conflict with the CGI handler for `.php`).
2. **Dry-run first** – run `scripts/install-php-cgi.sh` (no flags). It prints the exact command plan and detected latest PHP version without changing the host. Save output to `outputs/webserver/apache/php-cgi-plan.md`.
3. **Approval gate** – show the plan to the user; continue only after approval.
4. **Apply** – `sudo scripts/install-php-cgi.sh --apply [--php-version X.Y] [--extensions "mbstring xml"]`. The script:
   - adds the upstream PHP repo and resolves the highest available `X.Y` (unless pinned);
   - installs Apache + `phpX.Y-cgi` (Debian) / `php-cli` which ships `php-cgi` (RHEL) + extensions;
   - disables `mod_php*` and any `php-fpm` `.php` handler conf (backed up as `*.bak-<timestamp>`);
   - enables `cgid` (or `cgi` with prefork) and `actions`, installs `templates/php-cgi.conf` with the handler path for the detected version, and enables it;
   - on SELinux hosts labels the handler dir `httpd_sys_script_exec_t`;
   - runs `apachectl configtest`; **aborts before restart if the test fails**;
   - restarts Apache with `systemctl restart apache2|httpd` and enables it at boot;
   - smoke-tests with a temporary PHP file over `http://127.0.0.1/`, then deletes it.
5. **Verify** – confirm `php-cgi -v` version, `apachectl -M | grep -E 'cgid?_module|actions_module'`, and the smoke test result (`Server API => CGI/FastCGI`).
6. **Report** – write `outputs/webserver/apache/php-cgi-setup-report.md`: OS, PHP version, modules enabled, files changed/backed up, configtest output, restart status, smoke-test result and rollback commands.

## Security notes
- The handler directory is only reachable via internal redirect (`Require env REDIRECT_STATUS`) and `cgi.force_redirect` stays on, so `php-cgi` cannot be invoked directly from a URL.
- Do not leave `phpinfo()` files in the web root; the script removes its probe automatically.
- CGI spawns a process per request; for high-traffic sites recommend `php-fpm` + `mod_proxy_fcgi` instead and log that as a decision.

## Rollback
`a2disconf php-cgi && a2enmod phpX.Y` (Debian) or remove `/etc/httpd/conf.d/php-cgi.conf` and restore `php.conf.bak-*` (RHEL), then `apachectl configtest && systemctl restart apache2|httpd`.

## Outputs
`outputs/webserver/apache/php-cgi-plan.md`, `outputs/webserver/apache/php-cgi-setup-report.md`, `outputs/assumptions-and-gaps.md`.

## Shared execution contract
1. Read `config/project.yaml`, `config/enterprise-standards.yaml`, `schemas/artifact-contract.md` and the provided source artifacts first. If a file is absent, log it in `outputs/assumptions-and-gaps.md`; never invent approved requirements, infrastructure inventory, security classification, or test results.
2. Explicitly distinguish evidence, estimates, assumptions and decisions.
3. Write deterministic, version-controlled artifacts under `outputs/` with date, version, approver and source references. Re-run idempotently and report diff.
4. Deliver an execution summary with changed files, quality-check results, assumptions, open risks and the next approval gate. Do not claim a host was changed until the command output confirms it.
5. Enforce human approval before changing servers or deploying to production. Dry-run by default. Minimize permissions, redact secrets and PII from outputs/logs.
