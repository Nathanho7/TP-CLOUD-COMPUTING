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
gusta@azure1:~/b2-pano-cloud-2025/docs/tp/1/app$ sudo mv * /opt/meow/
mv: target '/opt/meow/': No such file or directory
gusta@azure1:~/b2-pano-cloud-2025/docs/tp/1/app$ cd ..
gusta@azure1:~/b2-pano-cloud-2025/docs/tp/1$ cd
gusta@azure1:~$
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
gusta@azure1:/opt/meow$ cd
gusta@azure1:~$
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











