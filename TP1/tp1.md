# II. Spawn des VMs

🌞 Connection ssh

```sh
PS C:\Users\gusta> ssh AzureVmtest
The authenticity of host '48.220.48.213 (48.220.48.213)' can't be established.
ED25519 key fingerprint is SHA256:EBQwFQzIxoffozYdgpX4ViXXYszBtoEcpB8vMsZ/5JU.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '48.220.48.213' (ED25519) to the list of known hosts.
Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.14.0-1012-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Nov  5 04:21:28 UTC 2025

  System load:  0.08              Processes:             111
  Usage of /:   5.6% of 28.02GB   Users logged in:       0
  Memory usage: 68%               IPv4 address for eth0: 172.17.0.4
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

azureuser@AzureVMtest:~$
```

## 2. az : a programmatic approach

🌞 Création VM azure1.tp1

```sh

Selecting "northeurope" may reduce your costs. The region you've selected may cost more for the same services. You can disable this message in the future with the command "az config set core.display_region_identified=false". Learn more at https://go.microsoft.com/fwlink/?linkid=222571

{
  "fqdns": "",
  "id": "/subscriptions/eee3936d-aca0-4fc8-bdd6-13976fa23a67/resourceGroups/Cloud_B2/providers/Microsoft.Compute/virtualMachines/azure1.tp1",
  "location": "francecentral",
  "macAddress": "60-45-BD-1A-20-E5",
  "powerState": "VM running",
  "privateIpAddress": "172.17.0.5",
  "publicIpAddress": "4.233.57.23",
  "resourceGroup": "Cloud_B2"
}
```


```sh
PS C:\Users\gusta> ssh azure1.tp1
Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.14.0-1012-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Nov  5 04:52:08 UTC 2025

  System load:  0.02              Processes:             113
  Usage of /:   5.7% of 28.02GB   Users logged in:       0
  Memory usage: 32%               IPv4 address for eth0: 172.17.0.5
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update

Last login: Wed Nov  5 04:32:26 2025 from 78.243.1.184
gusta@azure1:~$
```

🌞 Une fois connecté, prouvez la présence... 

 * walinuxagent.service
   
   ```sh
   gusta@azure1:~$ sudo systemctl status walinuxagent.service
   ● walinuxagent.service - Azure Linux Agent
     Loaded: loaded (/usr/lib/systemd/system/walinuxagent.service; enabled; preset: enabled)
    Drop-In: /run/systemd/system.control/walinuxagent.service.d
             └─50-CPUAccounting.conf, 50-MemoryAccounting.conf
     Active: active (running) since Wed 2025-11-05 04:26:44 UTC; 7min ago
   Main PID: 1074 (python3)
      Tasks: 7 (limit: 978)
     Memory: 53.5M (peak: 55.5M)
        CPU: 4.000s
     CGroup: /azure.slice/walinuxagent.service
             ├─1074 /usr/bin/python3 -u /usr/sbin/waagent -daemon
             └─1573 /usr/bin/python3 -u bin/WALinuxAgent-2.15.0.1-py3.12.egg -run-exthandlers

   Nov 05 04:26:56 azure1 python3[1573]: 2025-11-05T04:26:56.926834Z INFO ExtHandler ExtHandler ProcessE>
   Nov 05 04:26:56 azure1 python3[1573]: 2025-11-05T04:26:56.927958Z INFO ExtHandler ExtHandler No exten>
   Nov 05 04:26:56 azure1 python3[1573]: 2025-11-05T04:26:56.928932Z INFO ExtHandler ExtHandler ProcessE>
   Nov 05 04:26:56 azure1 python3[1573]: 2025-11-05T04:26:56.959989Z INFO ExtHandler ExtHandler Looking >
   Nov 05 04:26:56 azure1 python3[1573]: 2025-11-05T04:26:56.964562Z INFO ExtHandler ExtHandler [HEARTBE>
   Nov 05 04:31:56 azure1 python3[1573]: 2025-11-05T04:31:56.784804Z INFO CollectLogsHandler ExtHandler >
   Nov 05 04:31:56 azure1 python3[1573]: 2025-11-05T04:31:56.784983Z INFO CollectLogsHandler ExtHandler >
   Nov 05 04:31:56 azure1 python3[1573]: 2025-11-05T04:31:56.785097Z INFO CollectLogsHandler ExtHandler >
   Nov 05 04:32:14 azure1 python3[1573]: 2025-11-05T04:32:14.361340Z INFO CollectLogsHandler ExtHandler >
   Nov 05 04:32:14 azure1 python3[1573]: 2025-11-05T04:32:14.381464Z INFO CollectLogsHandler ExtHandler >
   lines 1-23/23 (END)
   ```

* service cloud-init.service

  ```sh
  gusta@azure1:~$ sudo systemctl status cloud-init.service
  ● cloud-init.service - Cloud-init: Network Stage
       Loaded: loaded (/usr/lib/systemd/system/cloud-init.service; enabled; preset: enabled)
       Active: active (exited) since Wed 2025-11-05 04:26:44 UTC; 10min ago
     Main PID: 742 (code=exited, status=0/SUCCESS)
          CPU: 1.569s
  
  Nov 05 04:26:43 azure1 cloud-init[746]: |=+o=.oOo* .+o    |
  Nov 05 04:26:43 azure1 cloud-init[746]: |o* ..+.=o + .    |
  Nov 05 04:26:43 azure1 cloud-init[746]: |. +  ..o o E     |
  Nov 05 04:26:43 azure1 cloud-init[746]: | o   .+ S .      |
  Nov 05 04:26:43 azure1 cloud-init[746]: |  . .  . +       |
  Nov 05 04:26:43 azure1 cloud-init[746]: |   .    o .      |
  Nov 05 04:26:43 azure1 cloud-init[746]: |                 |
  Nov 05 04:26:43 azure1 cloud-init[746]: |                 |
  Nov 05 04:26:43 azure1 cloud-init[746]: +----[SHA256]-----+
  Nov 05 04:26:44 azure1 systemd[1]: Finished cloud-init.service - Cloud-init: Network Stage.
  ```

## 3. Spawn moar moar moaaar VMs
### A. Another VM another friend :d

🌞 Creation azure2.tp2

```sh
az>> az vm create --name azure2.tp1 --resource-group Cloud_B --admin-username gusta --size Standard_B1s --image Ubuntu2404 --location francecentral --ssh-key-values .ssh/cloud_tp.pub  --public-ip-address ""

{
  "fqdns": "",
  "id": "/subscriptions/eee3936d-aca0-4fc8-bdd6-13976fa23a67/resourceGroups/Cloud_B2/providers/Microsoft.Compute/virtualMachines/azure2.tp1",
  "location": "francecentral",
  "macAddress": "60-45-BD-6B-F1-B9",
  "powerState": "VM running",
  "privateIpAddress": "172.17.0.6",
  "publicIpAddress": "",
  "resourceGroup": "Cloud_B2"
}
```

🌞 Infos sur mes deux VMs

```sh
az>> az vm list-ip-addresses -g Cloud_B2
[
  {
    "virtualMachine": {
      "name": "azure1.tp1",
      "network": {
        "privateIpAddresses": [
          "172.17.0.5"
        ],
        "publicIpAddresses": [
          {
            "id": "/subscriptions/eee3936d-aca0-4fc8-bdd6-13976fa23a67/resourceGroups/Cloud_B2/providers/Microsoft.Network/publicIPAddresses/azure1.tp1PublicIP",
            "ipAddress": "4.233.57.23",
            "ipAllocationMethod": "Static",
            "name": "azure1.tp1PublicIP",
            "resourceGroup": "Cloud_B2",
            "zone": null
          }
        ]
      },
      "resourceGroup": "Cloud_B2"
    }
  },
  {
    "virtualMachine": {
      "name": "azure2.tp1",
      "network": {
        "privateIpAddresses": [
          "172.17.0.6"
        ],
        "publicIpAddresses": []
      },
      "resourceGroup": "Cloud_B2"
    }
  },
  {
    "virtualMachine": {
      "name": "AzureVMtest",
      "network": {
        "privateIpAddresses": [
          "172.17.0.4"
        ],
        "publicIpAddresses": [
          {
            "id": "/subscriptions/eee3936d-aca0-4fc8-bdd6-13976fa23a67/resourceGroups/Cloud_B2/providers/Microsoft.Network/publicIPAddresses/AzureVMtest-ip",
            "ipAddress": "48.220.48.213",
            "ipAllocationMethod": "Static",
            "name": "AzureVMtest-ip",
            "resourceGroup": "Cloud_B2",
            "zone": "1"
          }
        ]
      },
      "resourceGroup": "Cloud_B2"
    }
  }
]
```

# B. Config SSH client

🌞 Configuration SSH client pour les deux machines
```sh
--> Dispo dans le depot git
```

* Co SSH

   ```sh
  PS C:\Users\gusta> ssh az1
  Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.14.0-1012-azure x86_64)
  
   * Documentation:  https://help.ubuntu.com
   * Management:     https://landscape.canonical.com
   * Support:        https://ubuntu.com/pro
  
   System information as of Wed Nov  5 04:53:36 UTC 2025
  
    System load:  0.0               Processes:             113
    Usage of /:   5.7% of 28.02GB   Users logged in:       0
    Memory usage: 32%               IPv4 address for eth0: 172.17.0.5
    Swap usage:   0%
  
  
  Expanded Security Maintenance for Applications is not enabled.
  
  0 updates can be applied immediately.
  
  Enable ESM Apps to receive additional future security updates.
  See https://ubuntu.com/esm or run: sudo pro status
  
  
  The list of available updates is more than a week old.
  To check for new updates run: sudo apt update
  
  Last login: Wed Nov  5 04:52:09 2025 from 78.243.1.184
  gusta@azure1:~$ exit
  logout
  Connection to 4.233.57.23 closed.
  PS C:\Users\gusta> ssh az2
  The authenticity of host '172.17.0.6 (<no hostip for proxy command>)' can't be established.
  ED25519 key fingerprint is SHA256:EWDGf72r/nRtUqnMEis/L33gmKVuyQQ53o2MbWPPQwA.
  This key is not known by any other names.
  Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
  Warning: Permanently added '172.17.0.6' (ED25519) to the list of known hosts.
  Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.14.0-1012-azure x86_64)
  
   * Documentation:  https://help.ubuntu.com
   * Management:     https://landscape.canonical.com
   * Support:        https://ubuntu.com/pro
  
   System information as of Wed Nov  5 04:53:49 UTC 2025
  
    System load:  0.08              Processes:             113
    Usage of /:   5.6% of 28.02GB   Users logged in:       0
    Memory usage: 29%               IPv4 address for eth0: 172.17.0.6
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
  
  gusta@azure2:~$
  ```


# III. Déployer et configurer un machin

## 1. Machine azure2.tp1¶

🌞 Installer MySQL/MariaDB sur azure2.tp1

```sh
gusta@azure2:~$ sudo apt update
gusta@azure2:~$ sudo apt install mysql-server
```

🌞 Démarrer le service MySQL/MariaDB sur azure2.tp1

```sh 
gusta@azure2:~$ sudo systemctl start mysql.service
gusta@azure2:~$ sudo systemctl status mysql.service
● mysql.service - MySQL Community Server
     Loaded: loaded (/usr/lib/systemd/system/mysql.service; enabled; preset: enabled)
     Active: active (running) since Wed 2025-11-05 04:58:28 UTC; 2min 2s ago
    Process: 2911 ExecStartPre=/usr/share/mysql/mysql-systemd-start pre (code=exited, status=0/SUCCES>
   Main PID: 2920 (mysqld)
     Status: "Server is operational"
      Tasks: 37 (limit: 993)
     Memory: 351.7M (peak: 377.0M)
        CPU: 1.669s
     CGroup: /system.slice/mysql.service
             └─2920 /usr/sbin/mysqld
```

🌞 Ajouter un utilisateur dans la base de données pour que mon app puisse s'y connecter

```sh
gusta@azure2:~$ sudo mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 8
Server version: 8.0.43-0ubuntu0.24.04.2 (Ubuntu)

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE DATABASE meow_database;
Query OK, 1 row affected (0.10 sec)

mysql> CREATE USER 'meow'@'%' IDENTIFIED BY 'meow';
Query OK, 0 rows affected (0.04 sec)

mysql> ALTER USER 'meow' IDENTIFIED BY 'meow';
Query OK, 0 rows affected (0.02 sec)

mysql> GRANT ALL ON meow_database.* TO 'meow'@'%';
Query OK, 0 rows affected (0.02 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.01 sec)
```

🌞 Ouvrez un port firewall si nécessaire

```sh
gusta@azure2:~$ sudo ss -lnpt
State        Recv-Q       Send-Q             Local Address:Port               Peer Address:Port       Process
LISTEN       0            70                     127.0.0.1:33060                   0.0.0.0:*           users:(("mysqld",pid=2920,fd=21))
LISTEN       0            4096                     0.0.0.0:22                      0.0.0.0:*           users:(("sshd",pid=1727,fd=3),("systemd",pid=1,fd=110))
LISTEN       0            4096                  127.0.0.54:53                      0.0.0.0:*           users:(("systemd-resolve",pid=500,fd=17))
LISTEN       0            151                    127.0.0.1:3306                    0.0.0.0:*           users:(("mysqld",pid=2920,fd=25))
LISTEN       0            4096               127.0.0.53%lo:53                      0.0.0.0:*           users:(("systemd-resolve",pid=500,fd=15))
LISTEN       0            4096                        [::]:22                         [::]:*           users:(("sshd",pid=1727,fd=4),("systemd",pid=1,fd=111))
```


```sh
gusta@azure1:~$ nc -vz 172.17.0.6 3306
Connection to 172.17.0.6 3306 port [tcp/mysql] succeeded!
```


# 2. Machine azure1.tp1

## A. Récupération de l'application sur la machine

🌞 Récupération de l'application sur la machine

```sh
gusta@azure1:~$  git clone https://gitlab.com/it4lik/b2-pano-cloud-2025.git
gusta@azure1:~/b2-pano-cloud-2025/docs/tp/1/app$ ls -al
total 28
drwxrwxr-x 3 gusta gusta 4096 Nov  5 05:32 .
drwxrwxr-x 3 gusta gusta 4096 Nov  5 05:32 ..
-rw-rw-r-- 1 gusta gusta  313 Nov  5 05:32 .env
-rw-rw-r-- 1 gusta gusta 3827 Nov  5 05:32 app.py
-rw-rw-r-- 1 gusta gusta  223 Nov  5 05:32 docker-compose.yml
-rw-rw-r-- 1 gusta gusta   58 Nov  5 05:32 requirements.txt
drwxrwxr-x 2 gusta gusta 4096 Nov  5 05:32 templates
gusta@azure1:~$ sudo mkdir -p /opt/meow
gusta@azure1:~$ cd b2-pano-cloud-2025/docs/tp/1/app
gusta@azure1:~/b2-pano-cloud-2025/docs/tp/1/app$ sudo mv * /opt/meow/
gusta@azure1:~/b2-pano-cloud-2025/docs/tp/1/app$ cd /opt/meow
gusta@azure1:/opt/meow$ ls -al
total 24
drwxr-xr-x 3 root  root  4096 Nov  5 05:39 .
drwxr-xr-x 3 root  root  4096 Nov  5 05:39 ..
-rw-rw-r-- 1 gusta gusta 3827 Nov  5 05:32 app.py
-rw-rw-r-- 1 gusta gusta  223 Nov  5 05:32 docker-compose.yml
-rw-rw-r-- 1 gusta gusta   58 Nov  5 05:32 requirements.txt
drwxrwxr-x 2 gusta gusta 4096 Nov  5 05:32 templates
gusta@azure1:~$ cd b2-pano-cloud-2025/docs/tp/1/app
gusta@azure1:~/b2-pano-cloud-2025/docs/tp/1/app$ sudo mv ~/b2-pano-cloud-2025/docs/tp/1/app/.env /opt/meow/
gusta@azure1:~/b2-pano-cloud-2025/docs/tp/1/app$ cd /opt/meow
gusta@azure1:/opt/meow$ ls -al
total 28
drwxr-xr-x 3 root  root  4096 Nov  5 05:42 .
drwxr-xr-x 3 root  root  4096 Nov  5 05:39 ..
-rw-rw-r-- 1 gusta gusta  313 Nov  5 05:32 .env
-rw-rw-r-- 1 gusta gusta 3827 Nov  5 05:32 app.py
-rw-rw-r-- 1 gusta gusta  223 Nov  5 05:32 docker-compose.yml
-rw-rw-r-- 1 gusta gusta   58 Nov  5 05:32 requirements.txt
drwxrwxr-x 2 gusta gusta 4096 Nov  5 05:32 templates
gusta@azure1:/opt/meow$
```

## B. Installation des dépendances de l'application

🌞 Installation des dépendances de l'application

```sh
gusta@azure1:/opt/meow$ sudo apt update
gusta@azure1:/opt/meow$ sudo apt install python3.12-venv
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  python3-pip-whl python3-setuptools-whl
The following NEW packages will be installed:
  python3-pip-whl python3-setuptools-whl python3.12-venv
0 upgraded, 3 newly installed, 0 to remove and 28 not upgraded.
Need to get 2429 kB of archives.
After this operation, 2777 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://azure.archive.ubuntu.com/ubuntu noble-updates/universe amd64 python3-pip-whl all 24.0+dfsg-1ubuntu1.3 [1707 kB]
Get:2 http://azure.archive.ubuntu.com/ubuntu noble-updates/universe amd64 python3-setuptools-whl all 68.1.2-2ubuntu1.2 [716 kB]
Get:3 http://azure.archive.ubuntu.com/ubuntu noble-updates/universe amd64 python3.12-venv amd64 3.12.3-1ubuntu0.8 [5678 B]
Fetched 2429 kB in 0s (12.9 MB/s)
Selecting previously unselected package python3-pip-whl.
(Reading database ... 68419 files and directories currently installed.)
Preparing to unpack .../python3-pip-whl_24.0+dfsg-1ubuntu1.3_all.deb ...
Unpacking python3-pip-whl (24.0+dfsg-1ubuntu1.3) ...
Selecting previously unselected package python3-setuptools-whl.
Preparing to unpack .../python3-setuptools-whl_68.1.2-2ubuntu1.2_all.deb ...
Unpacking python3-setuptools-whl (68.1.2-2ubuntu1.2) ...
Selecting previously unselected package python3.12-venv.
Preparing to unpack .../python3.12-venv_3.12.3-1ubuntu0.8_amd64.deb ...
Unpacking python3.12-venv (3.12.3-1ubuntu0.8) ...
Setting up python3-setuptools-whl (68.1.2-2ubuntu1.2) ...
Setting up python3-pip-whl (24.0+dfsg-1ubuntu1.3) ...
Setting up python3.12-venv (3.12.3-1ubuntu0.8) ...
Scanning processes...
Scanning linux images...

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

gusta@azure1:/opt/meow$ sudo python3 -m venv .
gusta@azure1:/opt/meow$ sudo ./bin/pip install -r requirements.txt
Collecting Flask (from -r requirements.txt (line 1))
  Downloading flask-3.1.2-py3-none-any.whl.metadata (3.2 kB)
Collecting Flask-SQLAlchemy (from -r requirements.txt (line 2))
  Downloading flask_sqlalchemy-3.1.1-py3-none-any.whl.metadata (3.4 kB)
Collecting PyMySQL (from -r requirements.txt (line 3))
  Downloading pymysql-1.1.2-py3-none-any.whl.metadata (4.3 kB)
Collecting python-dotenv (from -r requirements.txt (line 4))
  Downloading python_dotenv-1.2.1-py3-none-any.whl.metadata (25 kB)
Collecting cryptography (from -r requirements.txt (line 5))
  Downloading cryptography-46.0.3-cp311-abi3-manylinux_2_34_x86_64.whl.metadata (5.7 kB)
Collecting blinker>=1.9.0 (from Flask->-r requirements.txt (line 1))
  Downloading blinker-1.9.0-py3-none-any.whl.metadata (1.6 kB)
Collecting click>=8.1.3 (from Flask->-r requirements.txt (line 1))
  Downloading click-8.3.0-py3-none-any.whl.metadata (2.6 kB)
Collecting itsdangerous>=2.2.0 (from Flask->-r requirements.txt (line 1))
  Downloading itsdangerous-2.2.0-py3-none-any.whl.metadata (1.9 kB)
Collecting jinja2>=3.1.2 (from Flask->-r requirements.txt (line 1))
  Downloading jinja2-3.1.6-py3-none-any.whl.metadata (2.9 kB)
Collecting markupsafe>=2.1.1 (from Flask->-r requirements.txt (line 1))
  Downloading markupsafe-3.0.3-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl.metadata (2.7 kB)
Collecting werkzeug>=3.1.0 (from Flask->-r requirements.txt (line 1))
  Downloading werkzeug-3.1.3-py3-none-any.whl.metadata (3.7 kB)
Collecting sqlalchemy>=2.0.16 (from Flask-SQLAlchemy->-r requirements.txt (line 2))
  Downloading sqlalchemy-2.0.44-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (9.5 kB)
Collecting cffi>=2.0.0 (from cryptography->-r requirements.txt (line 5))
  Downloading cffi-2.0.0-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.whl.metadata (2.6 kB)
Collecting pycparser (from cffi>=2.0.0->cryptography->-r requirements.txt (line 5))
  Downloading pycparser-2.23-py3-none-any.whl.metadata (993 bytes)
Collecting greenlet>=1 (from sqlalchemy>=2.0.16->Flask-SQLAlchemy->-r requirements.txt (line 2))
  Downloading greenlet-3.2.4-cp312-cp312-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl.metadata (4.1 kB)
Collecting typing-extensions>=4.6.0 (from sqlalchemy>=2.0.16->Flask-SQLAlchemy->-r requirements.txt (line 2))
  Downloading typing_extensions-4.15.0-py3-none-any.whl.metadata (3.3 kB)
Downloading flask-3.1.2-py3-none-any.whl (103 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 103.3/103.3 kB 3.6 MB/s eta 0:00:00
Downloading flask_sqlalchemy-3.1.1-py3-none-any.whl (25 kB)
Downloading pymysql-1.1.2-py3-none-any.whl (45 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 45.3/45.3 kB 2.3 MB/s eta 0:00:00
Downloading python_dotenv-1.2.1-py3-none-any.whl (21 kB)
Downloading cryptography-46.0.3-cp311-abi3-manylinux_2_34_x86_64.whl (4.5 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 4.5/4.5 MB 55.3 MB/s eta 0:00:00
Downloading blinker-1.9.0-py3-none-any.whl (8.5 kB)
Downloading cffi-2.0.0-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.whl (219 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 219.6/219.6 kB 12.2 MB/s eta 0:00:00
Downloading click-8.3.0-py3-none-any.whl (107 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 107.3/107.3 kB 5.7 MB/s eta 0:00:00
Downloading itsdangerous-2.2.0-py3-none-any.whl (16 kB)
Downloading jinja2-3.1.6-py3-none-any.whl (134 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 134.9/134.9 kB 7.7 MB/s eta 0:00:00
Downloading markupsafe-3.0.3-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl (22 kB)
Downloading sqlalchemy-2.0.44-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (3.3 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 3.3/3.3 MB 55.2 MB/s eta 0:00:00
Downloading werkzeug-3.1.3-py3-none-any.whl (224 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 224.5/224.5 kB 11.8 MB/s eta 0:00:00
Downloading greenlet-3.2.4-cp312-cp312-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl (607 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 607.6/607.6 kB 26.1 MB/s eta 0:00:00
Downloading typing_extensions-4.15.0-py3-none-any.whl (44 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 44.6/44.6 kB 2.5 MB/s eta 0:00:00
Downloading pycparser-2.23-py3-none-any.whl (118 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 118.1/118.1 kB 6.8 MB/s eta 0:00:00
Installing collected packages: typing-extensions, python-dotenv, PyMySQL, pycparser, markupsafe, itsdangerous, greenlet, click, blinker, werkzeug, sqlalchemy, jinja2, cffi, Flask, cryptography, Flask-SQLAlchemy
Successfully installed Flask-3.1.2 Flask-SQLAlchemy-3.1.1 PyMySQL-1.1.2 blinker-1.9.0 cffi-2.0.0 click-8.3.0 cryptography-46.0.3 greenlet-3.2.4 itsdangerous-2.2.0 jinja2-3.1.6 markupsafe-3.0.3 pycparser-2.23 python-dotenv-1.2.1 sqlalchemy-2.0.44 typing-extensions-4.15.0 werkzeug-3.1.3
```


# C. Configuration de l'application¶

🌞 Configuration de l'application

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
DB_PASSWORD=meow
```









