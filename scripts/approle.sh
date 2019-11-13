#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

# Extract "foo" and "baz" arguments from the input into
# FOO and BAZ shell variables.
# jq will ensure that the values are properly quoted
# and escaped for consumption by the shell.
eval "$(jq -r '@sh "secret_id=\(.secret_id) role_id=\(.role_id) vault_addr=\(.vault_addr)"')"

response=$(curl --request POST --data "{\"role_id\": \"${role_id}\", \"secret_id\": \"${secret_id}\"}" ${vault_addr}/v1/auth/approle/login)


# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
# 
jq -n --arg vault_token "$(echo ${response} | jq -r .auth.client_token)" '{"vault_token":$vault_token}'
