#!/bin/sh

echo "Waiting for ${WAIT_FOR_URL}"

while [[ "$(curl --insecure -s -o /dev/null -w ''%{http_code}'' ${WAIT_FOR_URL})" != "200" ]]; do sleep 1; done
