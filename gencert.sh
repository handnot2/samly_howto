#!/bin/sh

NAME=${1:-samly}

C="US"
ST="Midlands"
L="Safeville"
O="Samly Famly"
OU="Howto"
CN="samly.howto"
SUBJ="/C=${C}/ST=${ST}/L=${L}/O=${O}/OU=${OU}/CN=${CN}"

echo "Generating SP certificate ..."
openssl req -new -x509 -sha256 -days 365 -nodes \
  -newkey rsa:4096 \
  -out ${NAME}.crt \
  -keyout ${NAME}.pem \
  -subj "${SUBJ}"
