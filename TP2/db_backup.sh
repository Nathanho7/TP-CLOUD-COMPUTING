#!/bin/bash

#Si le script echoue mieux de pas continuer
set -e

# Force l'Azure CLI à écrire son cache dans /tmp (où on a le droit)
# au lieu de /var/backups (car il en a pas le droit : dossier home de backup)
export AZURE_CONFIG_DIR=/tmp/.az-backup-cache

echo "Démarrage du script de backup"

DB_USER="backup"
DB_PASS="lamineyamalunonueve!"
DB_NAME="meow_database"
DB_HOST="localhost"
STORAGE_ACCOUNT="michkastorage"
CONTAINER_NAME="blobmeowtp2"
AZ_STORAGE_KEY="INndpG+ESkI8oEy15FP8Lc1cFSUcpPxWlUjFuYrDqoGxyq4RKqhC+AdpvR7DpRz+LyRIuC4wNz>
BACKUP_DIR="/tmp"
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
SQL_FILE="${BACKUP_DIR}/dump_${TIMESTAMP}.sql"
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${TIMESTAMP}.tar.gz"
BLOB_NAME="${DB_NAME}_${TIMESTAMP}.tar.gz"


echo " Création de la sauvegarde SQL : ${SQL_FILE}..."
export MYSQL_PWD="$DB_PASS"
mysqldump --user="$DB_USER" --host="$DB_HOST" --no-tablespaces "$DB_NAME" > "$SQL_FILE"
unset MYSQL_PWD
echo " Sauvegarde SQL créé."

echo " Compression : ${BACKUP_FILE}..."
tar -czf "$BACKUP_FILE" "$SQL_FILE" --remove-files
echo " Archive créée."

echo " Upload de l'archive vers le Blob Storage..."
az storage blob upload \
  --account-name "$STORAGE_ACCOUNT" \
  --container-name "$CONTAINER_NAME" \
  --name "$BLOB_NAME" \
  --file "$BACKUP_FILE" \
  --account-key "$AZ_STORAGE_KEY" > /dev/null
echo " Upload terminé."

echo "Cleanup du ficher d'archive"
rm "$BACKUP_FILE"
echo "Fichier local ${BACKUP_FILE} supprimé."
