#!/bin/bash

#Az authentification
az login --identity --allow-no-subscriptions


# Name description

KeyVaultName="secrettVaultt"
SecretName="DBPASSWORD"
SecretName2="flasksecrett"

#Recovery of secrecy

SECRET_VALUE=$(az keyvault secret show --vault-name "$KeyVaultName" --name "$SecretName" --query val>


#Replacement in.env file
sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=$SECRET_VALUE/" /opt/meow/.env

echo " DB_PASSWORD updated in .env"


info "Simple flask secret recovery....."
FLASK_SECRET=$(az keyvault secret show --vault-name "$KeyVaultName" --name "$SecretName2" --query va>
echo "Good ! Lauching the injection of flask secret inside .env..."

sed -i "s/^FLASK_SECRET_KEY=.*/FLASK_SECRET_KEY=${FLASK_SECRET}/" /opt/meow/.env
echo "Good ! Ready to start the web server....."
