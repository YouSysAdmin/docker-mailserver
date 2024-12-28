# Mail server

Use Docker for your own simple mail server with RoundCube as a web frontend for email

## .env
### Config FQDN

`DOMAIN` mail server domain (MX), mail.example.com etc.

### Mailserver port expose
`MAILSERVER_EXTERNAL_IP_25` external IP for port 25 SMTP  (explicit TLS => STARTTLS, Authentication is DISABLED => use port 465/587 instead)

`MAILSERVER_EXTERNAL_IP_143` external IP for port 143 IMAP4 (explicit TLS => STARTTLS)

`MAILSERVER_EXTERNAL_IP_465` external IP for port 465 ESMTP (implicit TLS)

`MAILSERVER_EXTERNAL_IP_587` external IP for port 587 ESMTP (explicit TLS => STARTTLS)

`MAILSERVER_EXTERNAL_IP_993` external IP for port 993 IMAP4 (implicit TLS)

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

## Configure
### Update your DNS
1. Add an A record with your server's IP `mail.example.com A 1.1.1.1`
2. Add a TXT SPF record `example.com TXT "v=spf1 mx ~all"` 
3. Add an MX record `mail.example.com MX mail.example.com`
4. Add a DMARK record `_dmarc.example.com TXT "v=DMARC1; p=none; rua=mailto:dmarc-reports@example.com"`
5. Add a DKIM record (this step will be below after setting up a DKIM key)

### Make `.env` file with config options
```shell
cp example.env .env
```
### Edit `.env` file
Change the `DOMAIN`, `SSL_CERTIFICATE_EMAIL` and `CLOUDFLARE_API_TOKEN` (if you want to use DNS challenge for letsencrypt) variable values.  
`DOMAIN` should be have subdomain from domain what you want to use, `mail.example.com` as example if your planning 
to use email `user@example.com`  
The mail web interface will also be hosted on the `mail.example.com` domain.  

### Start server
```shell
# Start server
./up.sh

# Add first user 
./tools/add-user.sh admin@example.com MyLongPassword
```

### Generate DKIM key
```shell
./tools/mailserver-config.sh config dkim

# output
Record: mail._domainkey
TYPE: TXT
Value:
"v=DKIM1;h=sha256;k=rsa;p=MIIBIjANBgkqhk...."
```
add a DNS record from output to your DNS 