


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

