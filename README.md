# Mail server

## .env
### Config FQDN

`DOMAIN` mail server domain (MX)

### Config default (first) user
This user can receive all emails for domain for all unregistered user

`DEFAULT_USER_NAME` using for add default user via `add-default-user.sh` script

`DEFAULT_USER_PASSWORD` using for add default user via `add-default-user.sh` script

### Configure Letsencrypt
`CLOUDFLARE_API_TOKEN` Cloudflare API token if using DNS challenge

`SSL_CERTIFICATE_EMAIL` Letsencrypt email

### Configure WEB server
`WEB_ACCESS_LOGS` enable/disable access logs (false by default)

`WEB_EXTERNAL_IP` external IP (127.0.0.1 by default)

`WEB_EXTERNAL_HTTP_PORT` external HTTP port (80 by default)

`WEB_EXTERNAL_HTTPS_PORT` external HTTPS port (443 by default)

### Configure Roundcube
`ROUNDCUBE_VERSION` Roundcube version (https://hub.docker.com/r/roundcube/roundcubemail/tags)

## 