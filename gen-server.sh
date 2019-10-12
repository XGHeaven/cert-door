#!/bin/bash

openssl genrsa -out server.key 2048

openssl req -new \
  -subj "/C=CN/O=X/ST=Hangzhou/CN=*.xgheaven.com" \
  -key server.key \
  -sha256 \
  -out server.csr

openssl x509 -req -in server.csr \
  -CA root.crt \
  -CAkey root.key \
  -passin "pass:root" \
  -days 365 \
  -out server.crt \
  -set_serial 77241 \
  -sha256 \
  -extfile server.ext
