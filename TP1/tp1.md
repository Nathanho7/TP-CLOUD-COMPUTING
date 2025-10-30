


 🌞 Configuration SSH client pour les deux machines

 ```sh

PS C:\Users\gusta>
PS C:\Users\gusta> ssh az1
Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.14.0-1012-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Thu Oct 30 07:33:01 UTC 2025

  System load:  0.0               Processes:             115
  Usage of /:   5.7% of 28.02GB   Users logged in:       0
  Memory usage: 32%               IPv4 address for eth0: 10.0.0.5
  Swap usage:   0%

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update

Last login: Wed Oct 29 20:16:16 2025 from 78.245.125.195
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

gusta@azure1:~$ exit
logout
Connection to 20.19.160.221 closed.
PS C:\Users\gusta> ssh az2
channel 0: open failed: connect failed: No route to host
stdio forwarding failed
PS C:\Users\gusta> ssh az2
The authenticity of host '10.0.0.8 (<no hostip for proxy command>)' can't be established.
ED25519 key fingerprint is SHA256:Ogr56knQKfaYlnf5upNHCOxAx+g2xtZ5Pf15HYIEVaI.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '10.0.0.8' (ED25519) to the list of known hosts.
Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.14.0-1012-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Thu Oct 30 07:35:39 UTC 2025

  System load:  0.08              Processes:             114
  Usage of /:   5.6% of 28.02GB   Users logged in:       0
  Memory usage: 31%               IPv4 address for eth0: 10.0.0.8
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

## 1. Machine azure2.tp1

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
     Active: active (running) since Thu 2025-10-30 07:57:40 UTC; 1min 17s ago
    Process: 3082 ExecStartPre=/usr/share/mysql/mysql-systemd-start pre (code=exited, stat>
   Main PID: 3091 (mysqld)
     Status: "Server is operational"
      Tasks: 37 (limit: 993)
     Memory: 351.4M (peak: 374.7M)
        CPU: 1.283s
     CGroup: /system.slice/mysql.service
             └─3091 /usr/sbin/mysqld
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
Query OK, 1 row affected (0.06 sec)

mysql> CREATE USER 'meow'@'%' IDENTIFIED BY 'meow';
Query OK, 0 rows affected (0.05 sec)

mysql> GRANT ALL PRIVILEGES ON meow_database.* TO 'meow'@'%';
Query OK, 0 rows affected (0.02 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.01 sec)

```

🌞 Ouvrez un port firewall si nécessaire

```sh
gusta@azure2:~$ sudo ss -lnpt
State           Recv-Q          Send-Q                   Local Address:Port                    Peer Address:Port          Process
LISTEN          0               70                           127.0.0.1:33060                        0.0.0.0:*              users:(("mysqld",pid=3091,fd=21))
LISTEN          0               4096                     127.0.0.53%lo:53                           0.0.0.0:*              users:(("systemd-resolve",pid=501,fd=15))
LISTEN          0               4096                           0.0.0.0:22                           0.0.0.0:*              users:(("sshd",pid=1789,fd=3),("systemd",pid=1,fd=162))
LISTEN          0               151                          127.0.0.1:3306                         0.0.0.0:*              users:(("mysqld",pid=3091,fd=23))
LISTEN          0               4096                        127.0.0.54:53                           0.0.0.0:*              users:(("systemd-resolve",pid=501,fd=17))
LISTEN          0               4096                              [::]:22                              [::]:*              users:(("sshd",pid=1789,fd=4),("systemd",pid=1,fd=165))
gusta@azure2:~$

gusta@azure1:~$ nc -vz 10.0.0.8 3306
Connection to 10.0.0.8 3306 port [tcp/mysql] succeeded!
```

## 2. Machine azure1.tp1

### A. Récupération de l'application sur la machine

🌞 Récupération de l'application sur la machine
```sh
gusta@azure1:~$ git clone https://gitlab.com/it4lik/b2-pano-cloud-2025.git
Cloning into 'b2-pano-cloud-2025'...
remote: Enumerating objects: 387, done.
remote: Counting objects: 100% (307/307), done.
remote: Compressing objects: 100% (304/304), done.
remote: Total 387 (delta 144), reused 0 (delta 0), pack-reused 80 (from 1)
Receiving objects: 100% (387/387), 14.26 MiB | 27.65 MiB/s, done.
Resolving deltas: 100% (167/167), done.
gusta@azure1:~$ sudo mkdir -p /opt/meow
gusta@azure1:~$ cd ~/b2-pano-cloud-2025/docs/tp/1/app
gusta@azure1:~/b2-pano-cloud-2025/docs/tp/1/app$ sudo mv * /opt/meow/
gusta@azure1:~/b2-pano-cloud-2025/docs/tp/1/app$ sudo mv .env /opt/meow/
gusta@azure1:~/b2-pano-cloud-2025/docs/tp/1/app$ cd /opt/meow
ls -a
.  ..  .env  app.py  docker-compose.yml  requirements.txt  templates

```

# B. Installation des dépendances de l'application

🌞 Installation des dépendances de l'application
```sh
gusta@azure1:/opt/meow$ sudo python3 -m venv .
The virtual environment was not created successfully because ensurepip is not
available.  On Debian/Ubuntu systems, you need to install the python3-venv
package using the following command.

    apt install python3.12-venv

You may need to use sudo with that command.  After installing the python3-venv
package, recreate your virtual environment.

Failing command: /opt/meow/bin/python3

gusta@azure1:/opt/meow$ sudo apt update
gusta@azure1:/opt/meow$ sudo apt install -y python3-venv
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  python3-pip-whl python3-setuptools-whl python3.12-venv
The following NEW packages will be installed:
  python3-pip-whl python3-setuptools-whl python3-venv python3.12-venv
0 upgraded, 4 newly installed, 0 to remove and 26 not upgraded.
Need to get 2430 kB of archives.
After this operation, 2783 kB of additional disk space will be used.
Get:1 http://azure.archive.ubuntu.com/ubuntu noble-updates/universe amd64 python3-pip-whl all 24.0+dfsg-1ubuntu1.3 [1707 kB]
Get:2 http://azure.archive.ubuntu.com/ubuntu noble-updates/universe amd64 python3-setuptools-whl all 68.1.2-2ubuntu1.2 [716 kB]
Get:3 http://azure.archive.ubuntu.com/ubuntu noble-updates/universe amd64 python3.12-venv amd64 3.12.3-1ubuntu0.8 [5678 B]
Get:4 http://azure.archive.ubuntu.com/ubuntu noble-updates/universe amd64 python3-venv amd64 3.12.3-0ubuntu2 [1034 B]
Fetched 2430 kB in 0s (29.7 MB/s)
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
Selecting previously unselected package python3-venv.
Preparing to unpack .../python3-venv_3.12.3-0ubuntu2_amd64.deb ...
Unpacking python3-venv (3.12.3-0ubuntu2) ...
Setting up python3-setuptools-whl (68.1.2-2ubuntu1.2) ...
Setting up python3-pip-whl (24.0+dfsg-1ubuntu1.3) ...
Setting up python3.12-venv (3.12.3-1ubuntu0.8) ...
Setting up python3-venv (3.12.3-0ubuntu2) ...
Scanning processes...
Scanning linux images...

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.

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
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 45.3/45.3 kB 1.7 MB/s eta 0:00:00
Downloading python_dotenv-1.2.1-py3-none-any.whl (21 kB)
Downloading cryptography-46.0.3-cp311-abi3-manylinux_2_34_x86_64.whl (4.5 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 4.5/4.5 MB 50.3 MB/s eta 0:00:00
Downloading blinker-1.9.0-py3-none-any.whl (8.5 kB)
Downloading cffi-2.0.0-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.whl (219 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 219.6/219.6 kB 9.7 MB/s eta 0:00:00
Downloading click-8.3.0-py3-none-any.whl (107 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 107.3/107.3 kB 6.9 MB/s eta 0:00:00
Downloading itsdangerous-2.2.0-py3-none-any.whl (16 kB)
Downloading jinja2-3.1.6-py3-none-any.whl (134 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 134.9/134.9 kB 7.0 MB/s eta 0:00:00
Downloading markupsafe-3.0.3-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl (22 kB)
Downloading sqlalchemy-2.0.44-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (3.3 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 3.3/3.3 MB 66.6 MB/s eta 0:00:00
Downloading werkzeug-3.1.3-py3-none-any.whl (224 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 224.5/224.5 kB 13.6 MB/s eta 0:00:00
Downloading greenlet-3.2.4-cp312-cp312-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl (607 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 607.6/607.6 kB 28.9 MB/s eta 0:00:00
Downloading typing_extensions-4.15.0-py3-none-any.whl (44 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 44.6/44.6 kB 2.1 MB/s eta 0:00:00
Downloading pycparser-2.23-py3-none-any.whl (118 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 118.1/118.1 kB 8.6 MB/s eta 0:00:00
Installing collected packages: typing-extensions, python-dotenv, PyMySQL, pycparser, markupsafe, itsdangerous, greenlet, click, blinker, werkzeug, sqlalchemy, jinja2, cffi, Flask, cryptography, Flask-SQLAlchemy
Successfully installed Flask-3.1.2 Flask-SQLAlchemy-3.1.1 PyMySQL-1.1.2 blinker-1.9.0 cffi-2.0.0 click-8.3.0 cryptography-46.0.3 greenlet-3.2.4 itsdangerous-2.2.0 jinja2-3.1.6 markupsafe-3.0.3 pycparser-2.23 python-dotenv-1.2.1 sqlalchemy-2.0.44 typing-extensions-4.15.0 werkzeug-3.1.3

```

# C. Configuration de l'application





