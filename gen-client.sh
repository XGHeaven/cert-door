#!/bin/bash

openssl genrsa -out client.key 2048

openssl req -new \
  -subj "/C=CN/CN=Client" \
  -out client.csr \
  -key client.key

openssl x509 -req -in client.csr \
  -CA root.crt \
  -CAkey root.key \
  -passin "pass:root" \
  -days 365 \
  -set_serial 77242 \
  -out client.crt
openssl pkcs12 -export -clcerts \
  -in client.crt \
  -inkey client.key \
  -out client.p12 \
  -password "pass:client"
