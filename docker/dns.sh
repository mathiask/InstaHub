#!/bin/bash

if [ -z "$INSTAHUB_DNSNAME" ]; then
  echo "INSTAHUB_DNSNAME must be set."
  exit 1
fi
if [ -z "$INSTAHUB_IPADDRESS" ]; then
  echo "INSTAHUB_IPADDRESS must be set."
  exit 1
fi

docker run -d --name dns \
  -p 53:53/tcp \
  gists/dnsmasq \
  dnsmasq --no-daemon --user=dnsmasq --group=dnsmasq \
          --address=/$INSTAHUB_DNSNAME/$INSTAHUB_IPADDRESS

echo -e "\nDNS up and running..."
