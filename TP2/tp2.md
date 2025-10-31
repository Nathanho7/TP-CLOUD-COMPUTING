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











