
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
gusta@NATHANHOAMB:~$ az vm create   --resource-group Cloud_B2   --name azure2.tp2   --image Ubuntu2404   --size Standard_B1s   --location francecentral   --public-ip-sku Standard   --ssh-key-values .ssh/c
loud_tp.pub   --custom-data ./cloud-init.txt
The default value of '--size' will be changed to 'Standard_D2s_v5' from 'Standard_DS1_v2' in a future release.
Selecting "northeurope" may reduce your costs. The region you've selected may cost more for the same services. You can disable this message in the future with the command "az config set core.display_region_identified=false". Learn more at https://go.microsoft.com/fwlink/?linkid=222571

{
  "fqdns": "",
  "id": "/subscriptions/eee3936d-aca0-4fc8-bdd6-13976fa23a67/resourceGroups/Cloud_B2/providers/Microsoft.Compute/virtualMachines/azure2.tp2",
  "location": "francecentral",
  "macAddress": "7C-ED-8D-83-C8-B1",
  "powerState": "VM running",
  "privateIpAddress": "172.17.0.8",
  "publicIpAddress": "51.11.218.15",
  "resourceGroup": "Cloud_B2"
}
```

🌞 Vérifier que cloud-init a bien fonctionné

```sh
PS C:\Users\gusta> ssh gusta@51.11.218.15
The authenticity of host '51.11.218.15 (51.11.218.15)' can't be established.
ED25519 key fingerprint is SHA256:H9NIsKl33aMsAiQ0ZtP2rMvY3QJryiTN1S1WRx6lW5c.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '51.11.218.15' (ED25519) to the list of known hosts.
Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.14.0-1012-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Nov  5 16:21:48 UTC 2025

  System load:  0.25              Processes:             115
  Usage of /:   5.6% of 28.02GB   Users logged in:       0
  Memory usage: 29%               IPv4 address for eth0: 172.17.0.8
  Swap usage:   0%

Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

gusta@azure2:~$ sudo systemctl status cloud-init
● cloud-init.service - Cloud-init: Network Stage
     Loaded: loaded (/usr/lib/systemd/system/cloud-init.service; enabled; preset: enabled)
     Active: active (exited) since Wed 2025-11-05 16:19:49 UTC; 3min 32s ago
   Main PID: 706 (code=exited, status=0/SUCCESS)
        CPU: 1.978s

Nov 05 16:19:48 azure2 cloud-init[710]: |   + oo  + o o  .|
Nov 05 16:19:48 azure2 cloud-init[710]: |    ...oo o + .E.|
Nov 05 16:19:48 azure2 cloud-init[710]: |     o oo+ = + . |
Nov 05 16:19:48 azure2 cloud-init[710]: |      +.S * + o  |
Nov 05 16:19:48 azure2 cloud-init[710]: |   o .o+ + + . . |
Nov 05 16:19:48 azure2 cloud-init[710]: |  . ++ =..o o    |
Nov 05 16:19:48 azure2 cloud-init[710]: |   +. * o...     |
Nov 05 16:19:48 azure2 cloud-init[710]: |    oo   .       |
Nov 05 16:19:48 azure2 cloud-init[710]: +----[SHA256]-----+
Nov 05 16:19:49 azure2 systemd[1]: Finished cloud-init.service - Cloud-init: Network Stage.

gusta@azure2:~$ cloud-init status
status: done
gusta@azure2:~$ ls -al /var/log/cloud-init*
-rw-r----- 1 root   adm   4432 Nov  5 16:19 /var/log/cloud-init-output.log
-rw-r----- 1 syslog adm 137487 Nov  5 16:19 /var/log/cloud-init.log
```

3. Write your own
   
🌞 Utilisez cloud-init pour préconfigurer une VM comme azure2.tp2 :

```sh
#cloud-config
users:
  - default
  - name: gusta
    passwd: 19f206370da5163bc7133197fa31d20f
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
DB_PASSWORD=t'as ce juice

```
- Après execution du script
  ```sh
  
  
  
  








