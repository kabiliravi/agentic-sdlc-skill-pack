# Apache PHP-CGI Setup Report
- Date: 2026-11-03 · Skill: apache-php-cgi-setup · Host: local (Debian GNU/Linux 13 trixie) · Approver: user (in-session "execute")
- Inputs: config/project.yaml (no `webserver` section → defaults: php_version=latest, extensions=mbstring xml curl zip) — logged as assumption.

## Result (evidence)
| Check | Result |
|---|---|
| PHP installed | **8.6.0RC3** (pre-release) from packages.sury.org — see Risk |
| php-cgi binary | /usr/bin/php-cgi8.6 → /usr/local/lib/php-cgi-handler/php-cgi |
| Apache modules | cgid_module, actions_module enabled; no mod_php present |
| Config | /etc/apache2/conf-available/php-cgi.conf enabled (a2enconf) |
| configtest | Syntax OK |
| Service | apache2 restarted, enabled at boot, active |
| Smoke test | `PHP_CGI_OK 8.6.0RC3 cgi-fcgi` (probe removed) |
| Direct handler URL | 403 (blocked as designed) |

## Files changed
- /etc/apt/sources.list.d/php-sury.list, /usr/share/keyrings/debsuryorg-archive-keyring.gpg (new)
- /etc/apache2/conf-available/php-cgi.conf (new), mods-enabled: cgid, actions
- /usr/local/lib/php-cgi-handler/ (new)

## Risk / open issue
- Script picked the highest version number, which was a release candidate (8.6.0RC3). Latest **stable** available: 8.5.12. Script fixed to skip ~alpha/~beta/~rc builds. Host still runs 8.6 RC pending decision.

## Rollback
`a2disconf php-cgi && a2dismod cgid actions && apache2ctl configtest && systemctl restart apache2`; optionally `apt-get purge 'php8.6*'` and remove php-sury.list.

Logs: outputs/webserver/apache/php-cgi-plan.md, outputs/webserver/apache/php-cgi-apply.log
