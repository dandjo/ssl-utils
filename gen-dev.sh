#!/bin/bash

openssl genrsa -out dev.key 2048
openssl req -x509 -new -nodes -key dev.key -sha256 -days 1825 -out dev.pem
openssl req -new -key dev.key -out dev.csr
openssl x509 -req -in dev.csr -CA dev.pem -CAkey dev.key -CAcreateserial -out dev.crt -days 365 -sha256 -extfile dev.ext
rm *.srl *.csr

echo "
###############################################################
Configure your webserver to use the 'dev.crt' as certificate
and 'dev.key' as certificate-key.
Here's an example for Nginx:
    ssl_certificate /path/to/your/certs/dev.crt;
    ssl_certificate_key /path/to/your/certs/dev.key;
Do not forget to import 'dev.pem' in your browser as Authority.
In Chrome for examle navigate to:
    Settings > Advanced > Manage certificates > Authorities
###############################################################
"
