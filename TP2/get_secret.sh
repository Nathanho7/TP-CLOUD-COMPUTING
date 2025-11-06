#!/bin/bash

echo "--- [get_secrets.sh] Démarrage du script ---"

az login --identity --allow-no-subscriptions > /dev/null
echo " Connexion réussie."

# --- 2. Configuration des noms ---
KeyVaultName="conorVault"
DBSecretName="DBPASSWORD"
FlaskSecretName="faikkoFlask"    #


# --- 3. Récupération des Secrets ---
DB_VALUE=$(az keyvault secret show --vault-name "$KeyVaultName" --name "$DBSecretName" --query value -o tsv)
echo "Secret '${DBSecretName}' récupéré."

FLASK_VALUE=$(az keyvault secret show --vault-name "$KeyVaultName" --name "$FlaskSecretName" --query value -o tsv)
echo " Secret '${FlaskSecretName}' récupéré."

# --- 4. Mise à jour du fichier .env ---
ENV_FILE="/opt/meow/.env"
echo " Mise à jour du fichier ${ENV_FILE}..."

# Remplacer la ligne DB_PASSWORD
sed -i "s!^DB_PASSWORD=.*!DB_PASSWORD=${DB_VALUE}!" $ENV_FILE

sed -i "s!^FLASK_SECRET_KEY=.*!FLASK_SECRET_KEY=${FLASK_VALUE}!" $ENV_FILE

echo " Fichier ${ENV_FILE} mis à jour avec succès."

# --- 5. Vérification (optionnelle mais recommandée) ---
grep -v 'DB_PASSWORD\|FLASK_SECRET_KEY' $ENV_FILE
echo " --- Script terminé ---"

