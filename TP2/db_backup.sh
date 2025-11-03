#!/bin/bash

# on définit tout pleins de trucs comme ça c'est fait (et parce que t'as dis en cours que >
DB_NAME="meow_database"
DB_USER="backup"
DB_PASS=""
DB_HOST="127.0.0.1"
AZ_STORAGE_ACCOUNT="gustabstorage"
AZ_STORAGE_KEY=""
AZ_CONTAINER_NAME="bobby"
BACKUP_DIR="/tmp"

#Noms des fichiers
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${TIMESTAMP}.sql"
ARCHIVE_FILE="${BACKUP_DIR}/${DB_NAME}_${TIMESTAMP}.tar.gz"

# Dumping
echo "[$(date)] Backup de la database $DB_NAME..."
mysqldump -h $DB_HOST -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_FILE

# Compression
echo "[$(date)] Compressing to $ARCHIVE_FILE..."
tar -czf $ARCHIVE_FILE -C $BACKUP_DIR $(basename $BACKUP_FILE)

# clean 1/2
rm -f $BACKUP_FILE
echo "[$(date)] Fichier .sql local supprimé."

# on envoi sur le blob
echo "[$(date)] Uploading $ARCHIVE_FILE to Azure Blob Storage..."
az storage blob upload \
    --account-name $AZ_STORAGE_ACCOUNT \
    --account-key $AZ_STORAGE_KEY \
    --container-name $AZ_CONTAINER_NAME \
    --name $(basename $ARCHIVE_FILE) \
    --file $ARCHIVE_FILE \
    --overwrite

echo "[$(date)] Envoi vers Azure terminé."

    # clean 2/2
rm -f $ARCHIVE_FILE
echo "[$(date)] Archive .tar.gz locale supprimée."
