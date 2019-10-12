#!/bin/bash

openssl genrsa -des3 -passout "pass:root" -out root.key 4096
openssl req -new -x509 \
  -key root.key \
  -sha256 \
  -set_serial 77240 \
  -subj "/C=CN/ST=Hangzhou/CN=Root Sign CA" \
  -passin pass:root \
  -days 1024 \
  -out root.crt
