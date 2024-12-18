#!/bin/bash

set -e 
cd $DEVBOX_PROJECT_ROOT

if [ ! -f "age_key.txt" ]; then
    echo "Generating age key"
    age-keygen -o age_key.txt
fi
public_key=`grep -oE 'age\S+' age_key.txt`
sed -i "s/AGE_PUBLIC_KEY/$public_key/" .sops.yaml

if [ ! -f "flask_app_secrets.enc.json" ]; then
    echo 
    read -s -p "Enter the Secret key for Flask APP: " secret_key
    echo
    read -s -p "Enter the DB password for Flask APP: " db_password
    echo

    echo '{}' | jq --arg secret_key "$secret_key" --arg db_password "$db_password" '.secret_key = $secret_key | .db_password = $db_password' > flask_app_secrets.enc.json
    sops --encrypt --in-place flask_app_secrets.enc.json
fi