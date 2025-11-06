
# I. Un p'tit nom DNS¶

🌞 Prouvez que c'est effectif

```sh
az>> vm show -d -g Cloud_B2 -n azure1.tp1
{
  "etag": "\"1\"",
  "fqdns": "meowcloudtp2.francecentral.cloudapp.azure.com",
  "hardwareProfile": {
    "vmSize": "Standard_B1s"
  },
  "id": "/subscriptions/eee3936d-aca0-4fc8-bdd6-13976fa23a67/resourceGroups/Cloud_B2/providers/Microsoft.Compute/virtualMachines/azure1.tp1",
  "location": "francecentral",
  "macAddresses": "60-45-BD-1A-20-E5",
  "name": "azure1.tp1",
  "networkProfile": {
    "networkInterfaces": [
      {
        "id": "/subscriptions/eee3936d-aca0-4fc8-bdd6-13976fa23a67/resourceGroups/Cloud_B2/providers/Microsoft.Network/networkInterfaces/azure1.tp1VMNic",
        "resourceGroup": "Cloud_B2"
      }
    ]
  },
  "osProfile": {
    "adminUsername": "gusta",
    "allowExtensionOperations": true,
    "computerName": "azure1.tp1",
    "linuxConfiguration": {
      "disablePasswordAuthentication": true,
      "patchSettings": {
        "assessmentMode": "ImageDefault",
        "patchMode": "ImageDefault"
      },
      "provisionVMAgent": true,
      "ssh": {
        "publicKeys": [
          {
            "keyData": "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFKfNBsLGQIjr72g/O56IE6Ock8Xf6PQoYlOA66o0KO5 gusta@NATHANHO_AMB\n",
            "path": "/home/gusta/.ssh/authorized_keys"
          }
        ]
      }
    },
    "requireGuestProvisionSignal": true,
    "secrets": []
  },
  "powerState": "VM running",
  "privateIps": "172.17.0.5",
  "provisioningState": "Succeeded",
  "publicIps": "4.233.57.23",
  "resourceGroup": "Cloud_B2",
  "securityProfile": {
    "securityType": "TrustedLaunch",
    "uefiSettings": {
      "secureBootEnabled": true,
      "vTpmEnabled": true
    }
  },
  "storageProfile": {
    "dataDisks": [],
    "diskControllerType": "SCSI",
    "imageReference": {
      "exactVersion": "24.04.202510010",
      "offer": "ubuntu-24_04-lts",
      "publisher": "Canonical",
      "sku": "server",
      "version": "latest"
    },
    "osDisk": {
      "caching": "ReadWrite",
      "createOption": "FromImage",
      "deleteOption": "Detach",
      "diskSizeGB": 30,
      "managedDisk": {
        "id": "/subscriptions/eee3936d-aca0-4fc8-bdd6-13976fa23a67/resourceGroups/Cloud_B2/providers/Microsoft.Compute/disks/azure1.tp1_disk1_fa04ebfd4760471ea1e857450ab33ab8",
        "resourceGroup": "Cloud_B2",
        "storageAccountType": "Premium_LRS"
      },
      "name": "azure1.tp1_disk1_fa04ebfd4760471ea1e857450ab33ab8",
      "osType": "Linux"
    }
  },
  "tags": {},
  "timeCreated": "2025-11-05T04:26:27.6106909+00:00",
  "type": "Microsoft.Compute/virtualMachines",
  "vmId": "801f8eec-ae6b-406d-9cd8-b00a4cfbfbd2"
}
```

- Avec la cmd curl
  ```sh
  gusta@azure1:~$ curl http://meowcloudtp2.francecentral.cloudapp.azure.com:8000/ | head -n 20
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!DOCTYPE html>
  <html lang="en">
  <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Purr Messages - Cat Message Board</title>
      <style>
          /* Modern CSS with cat-themed design */
          :root {
              --primary: #ff6b6b;
              --secondary: #4ecdc4;
              --accent: #ffd166;
              --dark: #1a1a2e;
              --light: #f8f9fa;
              --gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
              --cat-paw: #ff9a8b;
          }

        * {
            margin: 0;
   91 12566   91 11424    0     0   509k      0 --:--:-- --:--:-- --:--:--  531k
    ```

 # II. cloud-init¶

## 2. Gooooo

🌞 Tester cloud-init

- Cloud-init.txt
  ```sh
  #cloud-config
  users:
    - default
    - name: gusta
      sudo: ALL=(ALL) NOPASSWD:ALL
      groups: sudo
      shell: /bin/bash
      ssh_authorized_keys:
        - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFKfNBsLGQIjr72g/O56IE6Ock8Xf6PQoYlOA66o0KO5
    ```
Avec WSL

```sh
gusta@NATHANHOAMB:~$ az vm create   --resource-group Cloud_B2   --name azure1.tp2   --image Ubuntu2404
   --size Standard_B1s   --location francecentral   --public-ip-sku Standard   --ssh-key-values .ssh/c
loud_tp.pub   --custom-data ./cloud-init.txt
The default value of '--size' will be changed to 'Standard_D2s_v5' from 'Standard_DS1_v2' in a future release.
Selecting "northeurope" may reduce your costs. The region you've selected may cost more for the same services. You can disable this message in the future with the command "az config set core.display_region_identified=false". Learn more at https://go.microsoft.com/fwlink/?linkid=222571

{
  "fqdns": "",
  "id": "/subscriptions/eee3936d-aca0-4fc8-bdd6-13976fa23a67/resourceGroups/Cloud_B2/providers/Microsoft.Compute/virtualMachines/azure1.tp2",
  "location": "francecentral",
  "macAddress": "60-45-BD-19-15-B8",
  "powerState": "VM running",
  "privateIpAddress": "172.17.0.7",
  "publicIpAddress": "4.211.177.197",
  "resourceGroup": "Cloud_B2"
}
```

🌞 Vérifier que cloud-init a bien fonctionné

```sh
gusta@azure1:~$
sudo systemctl status cloud-init
● cloud-init.service - Cloud-init: Network Stage
     Loaded: loaded (/usr/lib/systemd/system/cloud-init.service; enabled; preset: enabled)
     Active: active (exited) since Thu 2025-11-06 16:31:44 UTC; 4min 14s ago
   Main PID: 707 (code=exited, status=0/SUCCESS)
        CPU: 1.546s

Nov 06 16:31:44 azure1 cloud-init[711]: |     . o *.+ o + |
Nov 06 16:31:44 azure1 cloud-init[711]: |      . o o . = .|
Nov 06 16:31:44 azure1 cloud-init[711]: |       o   + E . |
Nov 06 16:31:44 azure1 cloud-init[711]: |      . S   = + =|
Nov 06 16:31:44 azure1 cloud-init[711]: |       .   + o *=|
Nov 06 16:31:44 azure1 cloud-init[711]: |          . . +++|
Nov 06 16:31:44 azure1 cloud-init[711]: |              *=o|
Nov 06 16:31:44 azure1 cloud-init[711]: |             .o*B|
Nov 06 16:31:44 azure1 cloud-init[711]: +----[SHA256]-----+
Nov 06 16:31:44 azure1 systemd[1]: Finished cloud-init.service - Cloud-init: Network Stage.
gusta@azure1:~$ cloud-init status
status: done
gusta@azure1:~$ ls -al /var/log/cloud-init*
-rw-r----- 1 root   adm   4432 Nov  6 16:31 /var/log/cloud-init-output.log
-rw-r----- 1 syslog adm 137171 Nov  6 16:31 /var/log/cloud-init.log
```

3. Write your own
   
🌞 Utilisez cloud-init pour préconfigurer une VM comme azure2.tp2 :

```sh
#cloud-config
users:
  - default
  - name: gusta
    passwd: 910e5b66355abe4e675821357a313ec7
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: sudo
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFKfNBsLGQIjr72g/O56IE6Ock8Xf6PQoYlOA66o0KO5

package_update: true
packages:
 - mysql-server

write_files:
  - owner: root:root
    path: /root
    content: |
      CREATE DATABASE meow_database;
      CREATE USER 'meow'@'%' IDENTIFIED BY 'meow';
      ALTER USER 'meow' IDENTIFIED BY 'meow';
      GRANT ALL ON meow_database.* TO 'meow'@'%';
      FLUSH PRIVILEGES;

runcmd:
  - systemctl start mysql
  - until mysqladmin ping --silent; do sleep 5; done
  - mysql -u root < /root/init.sql
  - systemctl restart mysql
```


🌞 Testez que ça fonctionne

Depuis WSL 

```sh
gusta@NATHANHOAMB:~$ az vm create   --resource-group Cloud_B2   --name azure3.tp2   --image Ubuntu2404   --size Standard_B1s   --location francecentral   --public-ip-sku Standard   --ssh-key-values .ssh/cloud_tp.pub   --custom-data ./cloud-init.txt
The default value of '--size' will be changed to 'Standard_D2s_v5' from 'Standard_DS1_v2' in a future release.
Selecting "northeurope" may reduce your costs. The region you've selected may cost more for the same services. You can disable this message in the future with the command "az config set core.display_region_identified=false". Learn more at https://go.microsoft.com/fwlink/?linkid=222571

{
  "fqdns": "",
  "id": "/subscriptions/eee3936d-aca0-4fc8-bdd6-13976fa23a67/resourceGroups/Cloud_B2/providers/Microsoft.Compute/virtualMachines/azure3.tp2",
  "location": "francecentral",
  "macAddress": "00-22-48-3A-80-BC",
  "powerState": "VM running",
  "privateIpAddress": "172.17.0.9",
  "publicIpAddress": "4.178.183.2",
  "resourceGroup": "Cloud_B2"
}
```
- CO SSH
  ```sh
  PS C:\Users\gusta> ssh gusta@4.178.183.2
  The authenticity of host '4.178.183.2 (4.178.183.2)' can't be established.
  ED25519 key fingerprint is SHA256:KB/Zq3WVQ9EZjApHSu7+YM2tiK0RNKxFaKmeGjO55aA.
  This key is not known by any other names.
  Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
  Warning: Permanently added '4.178.183.2' (ED25519) to the list of known hosts.
  Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.14.0-1012-azure x86_64)
  
   * Documentation:  https://help.ubuntu.com
   * Management:     https://landscape.canonical.com
   * Support:        https://ubuntu.com/pro
  
   System information as of Wed Oct  1 04:15:08 UTC 2025
  
    System load:    1.15      Processes:             23
    Usage of /home: unknown   Users logged in:       0
    Memory usage:   5%        IPv4 address for eth0: 10.10.10.2
    Swap usage:     0%
  
  Expanded Security Maintenance for Applications is not enabled.
  
  36 updates can be applied immediately.
  21 of these updates are standard security updates.
  To see these additional updates run: apt list --upgradable
  
  Enable ESM Apps to receive additional future security updates.
  See https://ubuntu.com/esm or run: sudo pro status
  
  
  
  The programs included with the Ubuntu system are free software;
  the exact distribution terms for each program are described in the
  individual files in /usr/share/doc/*/copyright.
  
  Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
  applicable law.
  
  To run a command as administrator (user "root"), use "sudo <command>".
  See "man sudo_root" for details.
  
  gusta@azure3:~$

  gusta@azure3:~$ systemctl status mysql.service
  mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| meow_database      |
| mysql              |
| performance_schema |
| sys                |
+--------------------+  
    ```

 
  # III. Gestion de secrets

  🌞 Récupérer votre secret depuis la VM
  ```sh
PS C:\Users\gusta> ssh az1
Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.14.0-1012-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Nov  5 21:59:50 UTC 2025

  System load:  0.0                Processes:             116
  Usage of /:   10.0% of 28.02GB   Users logged in:       0
  Memory usage: 43%                IPv4 address for eth0: 172.17.0.5
  Swap usage:   0%

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

Expanded Security Maintenance for Applications is not enabled.

15 updates can be applied immediately.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


*** System restart required ***
Last login: Wed Nov  5 18:18:18 2025 from 78.243.5.44
gusta@azure1:~$ az login --identity --allow-no-subscriptions
[
  {
    "environmentName": "AzureCloud",
    "id": "413600cf-bd4e-4c7c-8a61-69e73cddf731",
    "isDefault": true,
    "name": "N/A(tenant level account)",
    "state": "Enabled",
    "tenantId": "413600cf-bd4e-4c7c-8a61-69e73cddf731",
    "user": {
      "assignedIdentityInfo": "MSI",
      "name": "systemAssignedIdentity",
      "type": "servicePrincipal"
    }
  }
]

gusta@azure1:~$ az login --identity --allow-no-subscriptions
[
  {
    "environmentName": "AzureCloud",
    "id": "413600cf-bd4e-4c7c-8a61-69e73cddf731",
    "isDefault": true,
    "name": "N/A(tenant level account)",
    "state": "Enabled",
    "tenantId": "413600cf-bd4e-4c7c-8a61-69e73cddf731",
    "user": {
      "assignedIdentityInfo": "MSI",
      "name": "systemAssignedIdentity",
      "type": "servicePrincipal"
    }
  }
]

gusta@azure1:~$ az keyvault secret show --vault-name conorVault --name vaultsecret
{
  "attributes": {
    "created": "2025-11-05T22:13:34+00:00",
    "enabled": true,
    "expires": null,
    "notBefore": null,
    "recoverableDays": 90,
    "recoveryLevel": "Recoverable+Purgeable",
    "updated": "2025-11-05T22:13:34+00:00"
  },
  "contentType": null,
  "id": "https://conorvault.vault.azure.net/secrets/vaultsecret/66b24dd6c8844f9490becfb896c3545f",
  "kid": null,
  "managed": null,
  "name": "vaultsecret",
  "tags": {},
  "value": "lamineyamalunonueve"
}
gusta@azure1:~$
```

# 2. Gérer les secrets de l'application¶

## A. Script pour récupérer les secrets

🌞 Coder un script bash : get_secrets.sh

```sh
--> dispo dans le depot git
```

🌞 Environnement du script get_secrets.sh

```sh
gusta@azure1:~$ sudo mv get_secrets.sh /usr/local/bin
gusta@azure1:~$ sudo chown webapp:webapp /usr/local/bin/get_secrets.sh
gusta@azure1:~$ sudo chmod +x /usr/local/bin/get_secrets.sh
gusta@azure1:~$ sudo chmod -R o= /usr/local/bin/get_secrets.sh
gusta@azure1:~$ ls -l /usr/local/bin | grep get_secrets
-rwxr-x--- 1 webapp webapp 623 Nov  5 23:33 get_secrets.sh
```

* TEST
  
-Avant execution du script

```sh
# Flask Configuration
FLASK_SECRET_KEY=ewnFw95H7qBeGiVvkQl9YmnJohW6NCMMqR0arxfnWYASeCDvzwQwzLxMCboAOi3e
FLASK_DEBUG=False
FLASK_HOST=0.0.0.0
FLASK_PORT=8000

# Database Configuration
DB_HOST=172.17.0.6
DB_PORT=3306
DB_NAME=meow_database
DB_USER=meow
DB_PASSWORD=meowmeow
```
- Après execution du script
  ```sh
  gusta@azure1:~$ sudo /usr/local/bin/get_secrets.sh
  [
    {
      "environmentName": "AzureCloud",
      "id": "413600cf-bd4e-4c7c-8a61-69e73cddf731",
      "isDefault": true,
      "name": "N/A(tenant level account)",
      "state": "Enabled",
      "tenantId": "413600cf-bd4e-4c7c-8a61-69e73cddf731",
      "user": {
        "assignedIdentityInfo": "MSI",
        "name": "systemAssignedIdentity",
        "type": "servicePrincipal"
      }
    }
  ]
  DB_PASSWORD updated in .env
  Verifying file contents:
  # Flask Configuration
  FLASK_SECRET_KEY=ewnFw95H7qBeGiVvkQl9YmnJohW6NCMMqR0arxfnWYASeCDvzwQwzLxMCboAOi3e
  FLASK_DEBUG=False
  FLASK_HOST=0.0.0.0
  FLASK_PORT=8000
  
  # Database Configuration
  DB_HOST=172.17.0.6
  DB_PORT=3306
  DB_NAME=meow_database
  DB_USER=meow
  DB_PASSWORD=meow
  ```

# B. Exécution automatique

🌞 Ajouter le script en ExecStartPre= dans webapp.service

```sh
gusta@azure1:~$ sudo systemctl edit webapp.service
 [Unit]
 Description=Super Webapp MEOW

 [Service]
 User=webapp
 WorkingDirectory=/opt/meow
 ExecStartPre=/usr/local/bin/get_secrets.sh
 ExecStart=/opt/meow/bin/python app.py

 [Install]
 WantedBy=multi-user.target

gusta@azure1:~$ sudo systemctl daemon-reload
gusta@azure1:~$ sudo systemctl restart webapp.service
```

  🌞 Prouvez que la ligne en ExecStartPre= a bien été exécutée

  ```sh
gusta@azure1:~$ sudo systemctl status webapp.service
● webapp.service - Super Webapp MEOW
     Loaded: loaded (/etc/systemd/system/webapp.service; disabled; preset: enabled)
     Active: active (running) since Thu 2025-11-06 00:22:16 UTC; 1min 15s ago
   Main PID: 17319 (python)
      Tasks: 1 (limit: 978)
     Memory: 61.0M (peak: 62.6M)
        CPU: 697ms
     CGroup: /system.slice/webapp.service
             └─17319 /opt/meow/bin/python app.py
```

# C. Secret Flask

🌞 Intégrez la gestion du secret Flask dans votre script get_secrets.sh

```sh
gusta@azure1:~$ NEW_FLASK_KEY=$(openssl rand -hex 32)
gusta@azure1:~$ az keyvault secret set --vault-name conorVault --name faikkoFlask --value "$NEW_FLASK_KEY"
{
  "attributes": {
    "created": "2025-11-06T00:34:25+00:00",
    "enabled": true,
    "expires": null,
    "notBefore": null,
    "recoverableDays": 90,
    "recoveryLevel": "Recoverable+Purgeable",
    "updated": "2025-11-06T00:34:25+00:00"
  },
  "contentType": null,
  "id": "https://conorvault.vault.azure.net/secrets/faikkoFlask/e4fa4390a28d4aa3a51351c3cfc30c86",
  "kid": null,
  "managed": null,
  "name": "faikkoFlask",
  "tags": {
    "file-encoding": "utf-8"
  },
  "value": "2cc0c5b785f5616c13d985b6b55b9e706b1f3a272fde4e21389dfd23d513af0c"
}
```


  🌞 Redémarrer le service

  ```sh
gusta@azure1:~$ sudo /usr/local/bin/get_secrets.sh
--- [get_secrets.sh] Démarrage du script ---
[get_secrets.sh] Connexion réussie.
[get_secrets.sh] Secret 'DBPASSWORD' récupéré.
[get_secrets.sh] Secret 'faikkoFlask' récupéré.
[get_secrets.sh] Mise à jour du fichier /opt/meow/.env...
[get_secrets.sh] Fichier /opt/meow/.env mis à jour avec succès.
# Flask Configuration
FLASK_DEBUG=False
FLASK_HOST=0.0.0.0
FLASK_PORT=8000

# Database Configuration
DB_HOST=172.17.0.6
DB_PORT=3306
DB_NAME=meow_database
DB_USER=meow

[get_secrets.sh] --- Script terminé ---
```
  

  # IV. Blob Storage

 ##  1. Un premier ptit blobz

 🌞 Upload un fichier dans le Blob Container depuis azure2.tp2

 ```sh
gusta@azure2:~$ az login --identity
[
  {
    "environmentName": "AzureCloud",
    "homeTenantId": "413600cf-bd4e-4c7c-8a61-69e73cddf731",
    "id": "eee3936d-aca0-4fc8-bdd6-13976fa23a67",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Azure for Students",
    "state": "Enabled",
    "tenantId": "413600cf-bd4e-4c7c-8a61-69e73cddf731",
    "user": {
      "assignedIdentityInfo": "MSI",
      "name": "systemAssignedIdentity",
      "type": "servicePrincipal"
    }
  }
]
gusta@azure2:~$ echo "meow" > /tmp/meow.txt

gusta@azure2:~$ az storage blob upload --account-name michkastorage --container-name blobmeowtp2  --name meow.txt  --file /tmp/meow.txt  --auth-mode login
Finished[#############################################################]  100.0000%
{
  "client_request_id": "e533a231-bb34-11f0-a87e-6045bd6bf1b9",
  "content_md5": "rWBtaiSi3smCvCmTqq+RYA==",
  "date": "2025-11-06T17:20:31+00:00",
  "encryption_key_sha256": null,
  "encryption_scope": null,
  "etag": "\"0x8DE1D58CA245D4C\"",
  "lastModified": "2025-11-06T17:20:31+00:00",
  "request_id": "aefb1403-b01e-00df-4941-4ff9e8000000",
  "request_server_encrypted": true,
  "version": "2022-11-02",
  "version_id": null
}
```

🌞 Download un fichier du Blob Container

DEPUIS WSL
```sh
gusta@NATHANHOAMB:~$ az storage blob download \
    --account-name michkastorage \
    --container-name blobmeowtp2 \
    --name meow.txt \
    --file /home/gusta/meow.txt \
    --auth-mode login
Finished[#############################################################]  100.0000%
{
  "container": "blobmeowtp2",
  "content": "",
  "contentMd5": null,
  "deleted": false,
  "encryptedMetadata": null,
  "encryptionKeySha256": null,
  "encryptionScope": null,
  "hasLegalHold": null,
  "hasVersionsOnly": null,
  "immutabilityPolicy": {
    "expiryTime": null,
    "policyMode": null
  },
  "isAppendBlobSealed": null,
  "isCurrentVersion": null,
  "lastAccessedOn": null,
  "metadata": {},
  "name": "meow.txt",
  "objectReplicationDestinationPolicy": null,
  "objectReplicationSourceProperties": [],
  "properties": {
    "appendBlobCommittedBlockCount": null,
    "blobTier": null,
    "blobTierChangeTime": null,
    "blobTierInferred": null,
    "blobType": "BlockBlob",
    "contentLength": 5,
    "contentRange": "bytes None-None/5",
    "contentSettings": {
      "cacheControl": null,
      "contentDisposition": null,
      "contentEncoding": null,
      "contentLanguage": null,
      "contentMd5": "rWBtaiSi3smCvCmTqq+RYA==",
      "contentType": "text/plain"
    },
    "copy": {
      "completionTime": null,
      "destinationSnapshot": null,
      "id": null,
      "incrementalCopy": null,
      "progress": null,
      "source": null,
      "status": null,
      "statusDescription": null
    },
    "creationTime": "2025-11-06T17:20:31+00:00",
    "deletedTime": null,
    "etag": "\"0x8DE1D58CA245D4C\"",
    "lastModified": "2025-11-06T17:20:31+00:00",
    "lease": {
      "duration": null,
      "state": "available",
      "status": "unlocked"
    },
    "pageBlobSequenceNumber": null,
    "pageRanges": null,
    "rehydrationStatus": null,
    "remainingRetentionDays": null,
    "serverEncrypted": true
  },
  "rehydratePriority": null,
  "requestServerEncrypted": true,
  "snapshot": null,
  "tagCount": null,
  "tags": null,
  "versionId": null
}
gusta@NATHANHOAMB:~$ cat meow.txt
meow

- Depuis powershell sinon
PS C:\Users\gusta> cat meow.txt
meow
```

# 2. Haïssez-moi¶

## B. Utilisateur MySQL

🌞 Créer un ptit user SQL pour notre script

```sh
mysql> CREATE USER 'backup'@'localhost' IDENTIFIED BY 'lamineyamalunonueve!';
Query OK, 0 rows affected (0.03 sec)

mysql> GRANT SELECT, LOCK TABLES, SHOW VIEW, TRIGGER ON meow_database.* TO 'backup'@'localhost';
Query OK, 0 rows affected (0.02 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.01 sec)

mysql> exit
Bye
```

🌞 Tester que vous pouvez vous connecter avec cet utilisateur

```sh
gusta@azure2:~$ mysql -u backup -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 15
Server version: 8.0.43-0ubuntu0.24.04.2 (Ubuntu)

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

## C. Script db_backup.sh¶

🌞 Ecrire le script db_backup.sh

```sh
Script dispo dans le depot git
```

🌞 Environnement du script db_backup.sh

```sh
gusta@azure2:~$ sudo nano db_backup.sh
gusta@azure2:~$ sudo mv db_backup.sh /usr/local/bin/
gusta@azure2:~$ sudo useradd backup
useradd: user 'backup' already exists
gusta@azure2:~$ sudo chown backup:backup /usr/local/bin/db_backup.sh
gusta@azure2:~$ sudo chmod 500 /usr/local/bin/db_backup.sh
gusta@azure2:~$ ls -l /usr/local/bin/db_backup.sh
-r-x------ 1 backup backup 1346 Nov  6 17:59 /usr/local/bin/db_backup.sh
```

🌞 Récupérer le blob

-AVant p'tite demo apres l'execu du script 
```sh
gusta@azure2:~$ sudo -u backup /usr/local/bin/db_backup.sh
Démarrage du script de backup
 Création de la sauvegarde SQL : /tmp/dump_2025-11-06_19-53-24.sql...
 Sauvegarde SQL créé.
 Compression : /tmp/meow_database_2025-11-06_19-53-24.tar.gz...
tar: Removing leading `/' from member names
 Archive créée.
 Upload de l'archive vers le Blob Storage...
Finished[#############################################################]  100.0000%
 Upload terminé.
Cleanup du ficher d'archive
Fichier local /tmp/meow_database_2025-11-06_19-53-24.tar.gz supprimé.
--- [db_backup.sh] Sauvegarde terminée avec succès ---
```

```sh
gusta@NATHANHOAMB:~$ az storage blob download \
  --account-name "michkastorage" \
  --container-name "blobmeowtp2" \
  --name "meow_database_2025-11-06_19-53-24.tar.gz" \
  --file "meow_database_2025-11-06_19-53-24.tar.gz" \
  --auth-mode login
Finished[#############################################################]  100.0000%
{
  "container": "blobmeowtp2",
  "content": "",
  "contentMd5": null,
  "deleted": false,
  "encryptedMetadata": null,
  "encryptionKeySha256": null,
  "encryptionScope": null,
  "hasLegalHold": null,
  "hasVersionsOnly": null,
  "immutabilityPolicy": {
    "expiryTime": null,
    "policyMode": null
  },
  "isAppendBlobSealed": null,
  "isCurrentVersion": null,
  "lastAccessedOn": null,
  "metadata": {},
  "name": "meow_database_2025-11-06_19-53-24.tar.gz",
  "objectReplicationDestinationPolicy": null,
  "objectReplicationSourceProperties": [],
  "properties": {
    "appendBlobCommittedBlockCount": null,
    "blobTier": null,
    "blobTierChangeTime": null,
    "blobTierInferred": null,
    "blobType": "BlockBlob",
    "contentLength": 984,
    "contentRange": "bytes None-None/984",
    "contentSettings": {
      "cacheControl": null,
      "contentDisposition": null,
      "contentEncoding": null,
      "contentLanguage": null,
      "contentMd5": "Ozt+dJWDdKl9Tt4A8O8cZQ==",
      "contentType": "application/x-tar"
    },
    "copy": {
      "completionTime": null,
      "destinationSnapshot": null,
      "id": null,
      "incrementalCopy": null,
      "progress": null,
      "source": null,
      "status": null,
      "statusDescription": null
    },
    "creationTime": "2025-11-06T19:53:25+00:00",
    "deletedTime": null,
    "etag": "\"0x8DE1D6E2642117C\"",
    "lastModified": "2025-11-06T19:53:25+00:00",
    "lease": {
      "duration": null,
      "state": "available",
      "status": "unlocked"
    },
    "pageBlobSequenceNumber": null,
    "pageRanges": null,
    "rehydrationStatus": null,
    "remainingRetentionDays": null,
    "serverEncrypted": true
  },
  "rehydratePriority": null,
  "requestServerEncrypted": true,
  "snapshot": null,
  "tagCount": null,
  "tags": null,
  "versionId": null
}

gusta@NATHANHOAMB:~$ ls | grep "meow"
meow.txt
meow_database_2025-11-06_19-53-24.tar.gz
```

## D. Service¶
🌞 Ecrire un fichier /etc/systemd/system/db_backup.service

```sh













