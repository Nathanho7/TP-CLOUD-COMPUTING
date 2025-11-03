# I. Un p'tit nom DNS

➜ Définissez un nom de domaine pour joindre notre azure1.tp2
Fait sur la WebUI

🌞 Prouvez que c'est effectif

```sh
PS C:\Users\gusta> az network public-ip show  --resource-group B2_CScloud  --name azure1.tp1PublicIP  --query "{vm:'azure1.tp2', ip:ipAddress, dns:dnsSettings.fqdn}"  -o table
Vm          Ip             Dns
----------  -------------  ---------------------------------------------
azure1.tp2  20.19.160.221  meowtp2cloud.francecentral.cloudapp.azure.com

- Curl

PS C:\Users\gusta> curl http://meowtp2cloud.francecentral.cloudapp.azure.com:8000


StatusCode        : 200
StatusDescription : OK
Content           : <!DOCTYPE html>
                    <html lang="en">
                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Purr Messages - Cat Message Board</title>
                        <...
RawContent        : HTTP/1.1 200 OK
                    Connection: close
                    Content-Length: 12566
                    Content-Type: text/html; charset=utf-8
                    Date: Thu, 30 Oct 2025 19:48:17 GMT
                    Server: Werkzeug/3.1.3 Python/3.12.3

                    <!DOCTYPE html>
                    <html la...
Forms             : {messageForm}
Headers           : {[Connection, close], [Content-Length, 12566], [Content-Type, text/html;
                    charset=utf-8], [Date, Thu, 30 Oct 2025 19:48:17 GMT]...}
Images            : {}
InputFields       : {@{innerHTML=; innerText=; outerHTML=<INPUT id=username class=form-input
                    maxLength=50 required placeholder="Your name...">; outerText=; tagName=INPUT;
                    id=username; class=form-input; maxLength=50; required=; placeholder=Your
                    name...}}
Links             : {}
ParsedHtml        : mshtml.HTMLDocumentClass
RawContentLength  : 12566

```

# II. cloud-init

🌞 Tester cloud-init

```sh
PS C:\Users\gusta> az vm create --resource-group B2_CScloud --name azuretp --image Ubuntu2404 --size Standard_B1s --location francecentral --public-ip-sku Standard --custom-data cloud-init.txt --ssh-key-values "$env:USERPROFILE\.ssh\id_ed25519.pub" --admin-username gusta --output table
The default value of '--size' will be changed to 'Standard_D2s_v5' from 'Standard_DS1_v2' in a future release.
Selecting "northeurope" may reduce your costs. The region you've selected may cost more for the same services. You can disable this message in the future with the command "az config set core.display_region_identified=false". Learn more at https://go.microsoft.com/fwlink/?linkid=222571


ResourceGroup    PowerState    PublicIpAddress    Fqdns    PrivateIpAddress    MacAddress         Location
---------------  ------------  -----------------  -------  ------------------  -----------------  -------------
B2_CScloud       VM running    4.233.71.128                10.0.0.10           7C-ED-8D-83-D8-71  francecentral
```

🌞 Vérifier que cloud-init a bien fonctionné

```sh

-connexion ssh
PS C:\Users\gusta> ssh gusta@4.233.71.128
The authenticity of host '4.233.71.128 (4.233.71.128)' can't be established.
ED25519 key fingerprint is SHA256:0ug6dP9t3CdjQ6gdQbaubTXps1eF4JT2+CoDYPfn2iw.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '4.233.71.128' (ED25519) to the list of known hosts.
Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.14.0-1012-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Fri Oct 31 01:00:03 UTC 2025

  System load:  0.1               Processes:             115
  Usage of /:   5.6% of 28.02GB   Users logged in:       0
  Memory usage: 28%               IPv4 address for eth0: 10.0.0.10
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

gusta@azuretp:~$


-status du service cloud-init

gusta@azuretp:~$ sudo systemctl status cloud-init
● cloud-init.service - Cloud-init: Network Stage
     Loaded: loaded (/usr/lib/systemd/system/cloud-init.service; enabled; preset: enabled)
     Active: active (exited) since Fri 2025-10-31 00:55:13 UTC; 5min ago
   Main PID: 707 (code=exited, status=0/SUCCESS)
        CPU: 1.324s

Oct 31 00:55:12 azuretp cloud-init[711]: |            B    |
Oct 31 00:55:12 azuretp cloud-init[711]: |           * = . |
Oct 31 00:55:12 azuretp cloud-init[711]: |      oo.   = o .|
Oct 31 00:55:12 azuretp cloud-init[711]: |     .ooS. . + ..|
Oct 31 00:55:12 azuretp cloud-init[711]: |    ..... . = * .|
Oct 31 00:55:12 azuretp cloud-init[711]: |   . ... . O B ..|
Oct 31 00:55:12 azuretp cloud-init[711]: |    ..  . E+O O o|
Oct 31 00:55:12 azuretp cloud-init[711]: |    ..   .oB+..O |
Oct 31 00:55:12 azuretp cloud-init[711]: +----[SHA256]-----+
Oct 31 00:55:13 azuretp systemd[1]: Finished cloud-init.service - Cloud-init: Network Stage.

gusta@azuretp:~$ cloud-init status
status: done

status: done
gusta@azuretp:~$ ls -al /var/log/cloud-init*
-rw-r----- 1 root   adm   4415 Oct 31 00:55 /var/log/cloud-init-output.log
-rw-r----- 1 syslog adm 139404 Oct 31 00:55 /var/log/cloud-init.log
pas d'erreus de logs tout est caréééééééééééé
```

## 3. Write your own

🌞 Utilisez cloud-init pour préconfigurer une VM comme azure2.tp2
Voir ficher conf cloud-init

🌞 Testez que ça fonctionne

- Deploiement
```sh
PS C:\Users\gusta> az vm create --resource-group B2_CScloud --name azure2.tp2 --image Ubuntu2404 --size Standard_B1s --location francecentral --public-ip-sku Standard  --custom-data cloud-init.txt --ssh-key-values "$env:USERPROFILE\.ssh\cloud_tp.pub" --admin-username gustanth --output table
The default value of '--size' will be changed to 'Standard_D2s_v5' from 'Standard_DS1_v2' in a future release.
Selecting "northeurope" may reduce your costs. The region you've selected may cost more for the same services. You can disable this message in the future with the command "az config set core.display_region_identified=false". Learn more at https://go.microsoft.com/fwlink/?linkid=222571

ResourceGroup    PowerState    PublicIpAddress    Fqdns    PrivateIpAddress    MacAddress         Location
---------------  ------------  -----------------  -------  ------------------  -----------------  -------------
B2_CScloud       VM running    52.143.179.100              10.0.0.11           00-0D-3A-E7-A7-72  francecentral
```

- Connexion ssh

  ```sh
  PS C:\Users\gusta> ssh gustanth@52.143.179.100
  The authenticity of host '52.143.179.100 (52.143.179.100)' can't be established. ED25519 key fingerprint is SHA256:8M+PHgzsIMRyMJ2BhL62b9tL72wsx7GbLDDB/K1YFJM.        This key is not known by any other names.                                             Are you sure you want to continue connecting (yes/no/[fingerprint])? yes            Warning: Permanently added '52.143.179.100' (ED25519) to the list of known hosts. Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.14.0-1012-azure x86_64)
  * Documentation:  https://help.ubuntu.com
  * Management:     https://landscape.canonical.com
  * Support:        https://ubuntu.com/pro

  System information as of Fri Oct 31 01:47:08 UTC 2025

  System load:  0.15              Processes:             115
  Usage of /:   5.6% of 28.02GB   Users logged in:       0
  Memory usage: 28%               IPv4 address for eth0: 10.0.0.11
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

  gustanth@azure2:~$

- Connexion serveur de db
  
```sh
gustanth@azure2:~$ mysql --version
mysql  Ver 8.0.43-0ubuntu0.24.04.2 for Linux on x86_64 ((Ubuntu))
gustanth@azure2:~$ sudo mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 8.0.43-0ubuntu0.24.04.2 (Ubuntu)

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

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
5 rows in set (0.01 sec)

mysql> SELECT User, Host FROM mysql.user;
+------------------+-----------+
| User             | Host      |
+------------------+-----------+
| meow             | %         |
| debian-sys-maint | localhost |
| mysql.infoschema | localhost |
| mysql.session    | localhost |
| mysql.sys        | localhost |
| root             | localhost |
+------------------+-----------+
6 rows in set (0.00 sec)
```

# III. Gestion de secrets¶


## 1. Un premier secret

🌞 Récupérer votre secret depuis la VM

- Connexion ssh 
```sh
PS C:\Users\gusta> ssh az1
Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.14.0-1012-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Thu Oct 30 19:01:42 UTC 2025

  System load:  0.0               Processes:             116
  Usage of /:   7.2% of 28.02GB   Users logged in:       0
  Memory usage: 39%               IPv4 address for eth0: 10.0.0.5
  Swap usage:   0%

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

Expanded Security Maintenance for Applications is not enabled.

34 updates can be applied immediately.
19 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


Last login: Thu Oct 30 19:01:42 2025 from 46.193.67.99
gusta@azure1:~$
```

- CLI download

```sh
gusta@azure1:~$ curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
Hit:1 http://azure.archive.ubuntu.com/ubuntu noble InRelease
Hit:2 http://azure.archive.ubuntu.com/ubuntu noble-updates InRelease
Hit:3 http://azure.archive.ubuntu.com/ubuntu noble-backports InRelease
Hit:4 http://azure.archive.ubuntu.com/ubuntu noble-security InRelease
Reading package lists... Done
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
ca-certificates is already the newest version (20240203).
ca-certificates set to manually installed.
curl is already the newest version (8.5.0-2ubuntu10.6).
curl set to manually installed.
gnupg is already the newest version (2.4.4-2ubuntu17.3).
gnupg set to manually installed.
lsb-release is already the newest version (12.0-2).
lsb-release set to manually installed.
The following NEW packages will be installed:
  apt-transport-https
0 upgraded, 1 newly installed, 0 to remove and 26 not upgraded.
Need to get 3970 B of archives.
After this operation, 36.9 kB of additional disk space will be used.
Get:1 http://azure.archive.ubuntu.com/ubuntu noble-updates/universe amd64 apt-transport-https all 2.8.3 [3970 B]
Fetched 3970 B in 0s (172 kB/s)
Selecting previously unselected package apt-transport-https.
(Reading database ... 68436 files and directories currently installed.)
Preparing to unpack .../apt-transport-https_2.8.3_all.deb ...
Unpacking apt-transport-https (2.8.3) ...
Setting up apt-transport-https (2.8.3) ...
Scanning processes...
Scanning linux images...

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: noble
Components: main
Architectures: amd64
Signed-by: /etc/apt/keyrings/microsoft.gpg
Hit:1 http://azure.archive.ubuntu.com/ubuntu noble InRelease
Hit:2 http://azure.archive.ubuntu.com/ubuntu noble-updates InRelease
Hit:3 http://azure.archive.ubuntu.com/ubuntu noble-backports InRelease
Hit:4 http://azure.archive.ubuntu.com/ubuntu noble-security InRelease
Get:5 https://packages.microsoft.com/repos/azure-cli noble InRelease [3564 B]
Get:6 https://packages.microsoft.com/repos/azure-cli noble/main amd64 Packages [1629 B]
Fetched 5193 B in 1s (5984 B/s)
Reading package lists... Done
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following NEW packages will be installed:
  azure-cli
0 upgraded, 1 newly installed, 0 to remove and 26 not upgraded.
Need to get 53.7 MB of archives.
After this operation, 600 MB of additional disk space will be used.
Get:1 https://packages.microsoft.com/repos/azure-cli noble/main amd64 azure-cli amd64 2.78.0-1~noble [53.7 MB]
Fetched 53.7 MB in 0s (115 MB/s)
Selecting previously unselected package azure-cli.
(Reading database ... 68440 files and directories currently installed.)
Preparing to unpack .../azure-cli_2.78.0-1~noble_amd64.deb ...
Unpacking azure-cli (2.78.0-1~noble) ...
Setting up azure-cli (2.78.0-1~noble) ...
Scanning processes...
Scanning linux images...

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
```

- Recuperation du secret

   ```sh
  gusta@azure1:~$ az login --identity --allow-no-subscriptions
  [  {
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
  gusta@azure1:~$ az keyvault secret show \
  > --vault-name secrettVaultt \
  > --name testsecret
  {
  "attributes": {
    "created": "2025-10-31T05:01:51+00:00",
    "enabled": true,
    "expires": "2027-10-31T04:58:41+00:00",
    "notBefore": null,
    "recoverableDays": 90,
    "recoveryLevel": "Recoverable+Purgeable",
    "updated": "2025-10-31T05:01:51+00:00"
  },
  "contentType": null,
  "id": "https://secrettvaultt.vault.azure.net/secrets/testsecret/6d04e64162304aeaaf152e3847dd96bd",
  "kid": null,
  "managed": null,
  "name": "testsecret",
  "tags": {},
  "value": "ancaraaaa"
  }
   ```
 


## 2. Gérer les secrets de l'application

### A. Script pour récupérer les secrets

🌞 Coder un ptit script bash : get_secrets.sh

```sh

#!/bin/bash

#Az authentification
az login --identity --allow-no-subscriptions


# Name description

KeyVaultName="secrettVaultt"
SecretName="testsecret"

#Recovery of secrecy

SECRET_VALUE=$(az keyvault secret show --vault-name "$KeyVaultName" --name "$SecretName" --query val>


#Replacement in the .env file
sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=$SECRET_VALUE/" /opt/meow/.env

echo " DB_PASSWORD mis à jour dans env"

```

🌞 Environnement du script get_secrets.sh

```sh
gusta@azure1:~$ sudo mv /opt/meow/get_secrets.sh /usr/local/bin/get_secrets.sh
gusta@azure1:~$ sudo chown webapp:webapp /usr/local/bin/get_secrets.sh
gusta@azure1:~$ sudo chmod 700 /usr/local/bin/get_secrets.sh
```


# B. Exécution automatique


🌞 Ajouter le script en ExecStartPre= dans webapp.service

```sh
[Unit]
Description=Super Webapp MEOW

[Service]
User=webapp
WorkingDirectory=/opt/meow
ExecStartPre=/usr/local/bin/get_secrets.sh
ExecStart=/opt/meow/bin/python app.py
EnvironmentFile=/opt/meow/.env

[Install]
WantedBy=multi-user.target

```

🌞 Prouvez que la ligne en ExecStartPre= a bien été exécutée

```sh
gusta@azure1:~$ sudo systemctl status webapp
● webapp.service - Super Webapp MEOW
     Loaded: loaded (/etc/systemd/system/webapp.service; disabled; preset: enabled)
     Active: active (running) since Fri 2025-10-31 07:52:26 UTC; 37s ago
    Process: 9781 ExecStartPre=/usr/local/bin/get_secrets.sh (code=exited, status=0/SUCCESS)
   Main PID: 9829 (python)
      Tasks: 1 (limit: 993)
     Memory: 41.6M (peak: 56.5M)
        CPU: 2.673s
     CGroup: /system.slice/webapp.service
             └─9829 /opt/meow/bin/python app.py
```

-- Ficher .env
  
  ```sh
# Flask Configuration
FLASK_SECRET_KEY=ewnFw95H7qBeGiVvkQl9YmnJohW6NCMMqR0arxfnWYASeCDvzwQwzLxMCboAOi3e
FLASK_DEBUG=False
FLASK_HOST=0.0.0.0
FLASK_PORT=8000

# Database Configuration
DB_HOST=10.0.0.8
DB_PORT=3306
DB_NAME=meow_database
DB_USER=meow
DB_PASSWORD=ancaraaaa
gusta@azure1:~$ sudo cat /opt/meow/.env | grep DB_PASSWORD
DB_PASSWORD=meow
```

*Apres modif
```sh
gusta@azure1:~$ sudo cat /opt/meow/.env | grep DB_PASSWORD
DB_PASSWORD=meow
```


# C. Secret Flask

🌞 Intégrez la gestion du secret Flask dans votre script get_secrets.sh

```sh
gusta@azure1:~$ az keyvault secret set --vault-name secrettVaultt --name flasksecrett --value "yzbDbWJRHT7RX9yC9AXmjri9p6DQ7ONiyc+l8r1ytd0="
{
  "attributes": {
    "created": "2025-10-31T15:38:57+00:00",
    "enabled": true,
    "expires": null,
    "notBefore": null,
    "recoverableDays": 90,
    "recoveryLevel": "Recoverable+Purgeable",
    "updated": "2025-10-31T15:38:57+00:00"
  },
  "contentType": null,
  "id": "https://secrettvaultt.vault.azure.net/secrets/flasksecrett/ca0421a0afdc4db793bb3f9bb1da43c2",
  "kid": null,
  "managed": null,
  "name": "flasksecrett",
  "tags": {
    "file-encoding": "utf-8"
  },
  "value": "yzbDbWJRHT7RX9yC9AXmjri9p6DQ7ONiyc+l8r1ytd0="
}
```

🌞 Redémarrer le service
```sh
gusta@azure1:~$ sudo systemctl status webapp
● webapp.service - Super Webapp MEOW
     Loaded: loaded (/etc/systemd/system/webapp.service; disabled; preset: enabled)
     Active: active (running) since Fri 2025-10-31 15:31:01 UTC; 7s ago
    Process: 15601 ExecStartPre=/usr/local/bin/get_secrets.sh (code=exited, status=0/SUCCESS)
   Main PID: 15676 (python)
      Tasks: 1 (limit: 993)
     Memory: 41.0M (peak: 56.9M)
        CPU: 3.762s
     CGroup: /system.slice/webapp.service
             └─15676 /opt/meow/bin/python app.py

Oct 31 15:30:58 azure1 get_secrets.sh[15605]:     }
Oct 31 15:30:58 azure1 get_secrets.sh[15605]:   }
Oct 31 15:30:58 azure1 get_secrets.sh[15605]: ]
Oct 31 15:31:00 azure1 get_secrets.sh[15601]:  DB_PASSWORD updated in .env
Oct 31 15:31:00 azure1 get_secrets.sh[15649]: info: No menu item 'Simple flask secret recovery.....'>
Oct 31 15:31:01 azure1 get_secrets.sh[15601]: Good ! Lauching the injection of flask secret inside .>
Oct 31 15:31:01 azure1 get_secrets.sh[15601]: Good ! Ready to start the web server.....
Oct 31 15:31:01 azure1 systemd[1]: webapp.service: Found left-over process 15673 (python3) in contro>
Oct 31 15:31:01 azure1 systemd[1]: webapp.service: This usually indicates unclean termination of a p>
Oct 31 15:31:01 azure1 systemd[1]: Started webapp.service - Super Webapp MEOW.
```

-Avant test
```sh
# Flask Configuration
FLASK_SECRET_KEY=kailoo
FLASK_DEBUG=False
FLASK_HOST=0.0.0.0
FLASK_PORT=8000

# Database Configuration
DB_HOST=10.0.0.8
DB_PORT=3306
DB_NAME=meow_database
DB_USER=meow
DB_PASSWORD=meow

```

-Après le restart

```sh
# Flask Configuration
FLASK_SECRET_KEY=yzbDbWJRHT7RX9yC9AXmjri9p6DQ7ONiyc+l8r1ytd0=
FLASK_DEBUG=False
FLASK_HOST=0.0.0.0
FLASK_PORT=8000

# Database Configuration
DB_HOST=10.0.0.8
DB_PORT=3306
DB_NAME=meow_database
DB_USER=meow
DB_PASSWORD=meow
```


# IV. Blob Storage

## 1. Un premier ptit blobz

🌞 Upload un fichier dans le Blob Container depuis azure2.tp2

- CO SSH

  ```sh  
PS C:\Users\gusta> ssh gustanth@4.178.189.251
Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.14.0-1012-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Mon Nov  3 17:45:52 UTC 2025

  System load:  0.0                Processes:             115
  Usage of /:   11.6% of 28.02GB   Users logged in:       0
  Memory usage: 74%                IPv4 address for eth0: 10.0.0.11
  Swap usage:   0%

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

Expanded Security Maintenance for Applications is not enabled.

17 updates can be applied immediately.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status

*** Sy
stem restart required ***
Last login: Mon Nov  3 18:01:24 2025 from 37.166.163.91
gustanth@azure2:~$
```


- CLI
  
 ```sh
gustanth@azure2:~$ $ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://azcliprod.blob.core.windows.net/msi/azure-cli-2.51.0.msi -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; Remove-Item .\AzureCLI.msi
=: command not found
Invoke-WebRequest: command not found
Start-Process: command not found
Remove-Item: command not found
gustanth@azure2:~$ sudo tdnf install ca-certificates
sudo: tdnf: command not found
gustanth@azure2:~$ sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
Hit:1 http://azure.archive.ubuntu.com/ubuntu noble InRelease
Hit:2 http://azure.archive.ubuntu.com/ubuntu noble-updates InRelease
Hit:3 http://azure.archive.ubuntu.com/ubuntu noble-backports InRelease
Get:4 http://azure.archive.ubuntu.com/ubuntu noble-security InRelease [126 kB]
Hit:5 https://packages.microsoft.com/repos/azure-cli noble InRelease
Get:6 http://azure.archive.ubuntu.com/ubuntu noble-security/main amd64 Packages [1298 kB]
Get:7 http://azure.archive.ubuntu.com/ubuntu noble-security/main Translation-en [213 kB]
Get:8 http://azure.archive.ubuntu.com/ubuntu noble-security/universe amd64 Packages [906 kB]
Get:9 http://azure.archive.ubuntu.com/ubuntu noble-security/universe Translation-en [203 kB]
Get:10 http://azure.archive.ubuntu.com/ubuntu noble-security/restricted amd64 Packages [2131 kB]
Get:11 http://azure.archive.ubuntu.com/ubuntu noble-security/restricted Translation-en [483 kB]
Fetched 5361 kB in 2s (2581 kB/s)
Reading package lists... Done
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
apt-transport-https is already the newest version (2.8.3).
ca-certificates is already the newest version (20240203).
curl is already the newest version (8.5.0-2ubuntu10.6).
gnupg is already the newest version (2.4.4-2ubuntu17.3).
lsb-release is already the newest version (12.0-2).
0 upgraded, 0 newly installed, 0 to remove and 17 not upgraded.
gustanth@azure2:~$ sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
  gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
gustanth@azure2:~$ AZ_DIST=$(lsb_release -cs)
echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources
Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: noble
Components: main
Architectures: amd64
Signed-by: /etc/apt/keyrings/microsoft.gpg
gustanth@azure2:~$ sudo apt-get update
sudo apt-get install azure-cli
Hit:1 http://azure.archive.ubuntu.com/ubuntu noble InRelease
Hit:2 http://azure.archive.ubuntu.com/ubuntu noble-updates InRelease
Hit:3 http://azure.archive.ubuntu.com/ubuntu noble-backports InRelease
Hit:4 http://azure.archive.ubuntu.com/ubuntu noble-security InRelease
Hit:5 https://packages.microsoft.com/repos/azure-cli noble InRelease
Reading package lists... Done
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
azure-cli is already the newest version (2.78.0-1~noble).
0 upgraded, 0 newly installed, 0 to remove and 17 not upgraded.
```

-  AZ LOGIN 

```sh
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

gustanth@azure2:~$ echo "meow" > /tmp/meow.txt
gustanth@azure2:~$ az storage blob upload \
  --account-name gustabstorage \
  --container-name bobby \
  --name meow.txt \
  --file /tmp/meow.txt \
  --auth-mode login
Finished[#############################################################]  100.0000%
{
  "client_request_id": "f3911fcb-b8ea-11f0-b9b8-6045bd6ba23b",
  "content_md5": "rWBtaiSi3smCvCmTqq+RYA==",
  "date": "2025-11-03T19:26:10+00:00",
  "encryption_key_sha256": null,
  "encryption_scope": null,
  "etag": "\"0x8DE1B0ED896ABF7\"",
  "lastModified": "2025-11-03T19:26:11+00:00",
  "request_id": "bdbf9205-001e-0055-5ef7-4cd366000000",
  "request_server_encrypted": true,
  "version": "2022-11-02",
  "version_id": null
}
```

🌞 Download un fichier du Blob Container


- az login
```sh
 PS C:\Users\gusta> az login
Select the account you want to log in with. For more information on login with Azure CLI, see https://go.microsoft.com/fwlink/?linkid=2271136

Retrieving tenants and subscriptions for the selection...

[Tenant and subscription selection]

No     Subscription name    Subscription ID                       Tenant
-----  -------------------  ------------------------------------  --------
[1] *  Azure for Students   eee3936d-aca0-4fc8-bdd6-13976fa23a67  Efrei

The default is marked with an *; the default tenant is 'Efrei' and subscription is 'Azure for Students' (eee3936d-aca0-4fc8-bdd6-13976fa23a67).

Select a subscription and tenant (Type a number or Enter for no changes):

Tenant: Efrei
Subscription: Azure for Students (eee3936d-aca0-4fc8-bdd6-13976fa23a67)

[Announcements]
With the new Azure CLI login experience, you can select the subscription you want to use more easily. Learn more about it and its configuration at https://go.microsoft.com/fwlink/?linkid=2271236

If you encounter any problem, please open an issue at https://aka.ms/azclibug

[Warning] The login output has been updated. Please be aware that it no longer displays the full list of available subscriptions by default.

PS C:\Users\gusta>
```

- Cmd az

```sh
PS C:\Users\gusta> az storage blob download --account-name gustabstorage  --container-name bobby --name meow.txt --file .\meow.txt --account-key (az storage account keys list --account-name gustabstorage --resource-group B2_CScloud --query "[0].value" -o tsv)
Finished[#############################################################]  100.0000%
{
  "container": "bobby",
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
    "creationTime": "2025-11-03T19:26:11+00:00",
    "deletedTime": null,
    "etag": "\"0x8DE1B0ED896ABF7\"",
    "lastModified": "2025-11-03T19:26:11+00:00",
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
PS C:\Users\gusta> Get-Content .\meow.txt
meow
PS C:\Users\gusta>
```
























  









