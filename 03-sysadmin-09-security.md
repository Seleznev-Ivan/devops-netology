# Домашнее задание к занятию «Элементы безопасности информационных систем»


### Цель задания

В результате выполнения задания вы: 

* настроите парольный менеджер, что позволит не использовать один и тот же пароль на все ресурсы и удобно работать со множеством паролей;
* настроите веб-сервер на работу с HTTPS. Сегодня HTTPS является стандартом в интернете. Понимание сути работы центра сертификации, цепочки сертификатов позволит сконфигурировать SSH-клиент на работу с разными серверами по-разному, что даёт большую гибкость SSH-соединений. Например, к некоторым серверам мы можем обращаться по SSH через приложения, где недоступен ввод пароля;
* поработаете со сбором и анализом трафика, которые необходимы для отладки сетевых проблем.


### Инструкция к заданию

1. Создайте .md-файл для ответов на задания в своём репозитории, после выполнения прикрепите ссылку на него в личном кабинете.
2. Любые вопросы по выполнению заданий задавайте в чате учебной группы или в разделе «Вопросы по заданию» в личном кабинете.

### Дополнительные материалы для выполнения задания

1. [SSL + Apache2](https://digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-20-04).

------

## Задание

1. Установите плагин Bitwarden для браузера. Зарегестрируйтесь и сохраните несколько паролей.

**Решение:**
![bitwarden](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/03-sysadmin-09-security-bitwarden.jpg)

2. Установите Google Authenticator на мобильный телефон. Настройте вход в Bitwarden-акаунт через Google Authenticator OTP.

**Решение:**
![bitwarden_auth](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/03-sysadmin-09-security-bitwarden_auth.jpg)

3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.

**Решение:**
![apache](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/03-sysadmin-09-security-apache.jpg)

4. Проверьте на TLS-уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК и т. п.).

**Решение:**

Для сканирования SSL/TLS сайта можно использовать различные инструменты. Я использую инструмент `SSLyze` — это библиотека на Python и инструмент командной строки, которая используется в операционной системе Kali Linux. Но я предварительно установил ее на Ubuntu.

И ниже результат выполнения тестирования уязвимостей на сайте:
```bash
ivan@ubuntutest:~$ python3 -m sslyze citilink.ru

 CHECKING CONNECTIVITY TO SERVER(S)
 ----------------------------------

   citilink.ru:443           => 178.248.234.66


 SCAN RESULTS FOR CITILINK.RU:443 - 178.248.234.66
 -------------------------------------------------

 * Certificates Information:
       Hostname sent for SNI:             citilink.ru
       Number of certificates detected:   1


     Certificate #0 ( _RSAPublicKey )
       SHA1 Fingerprint:                  53cc6a4e5f8f62a92772447fd385fc2c111ddc6f
       Common Name:                       *.citilink.ru
       Issuer:                            GlobalSign GCC R3 DV TLS CA 2020
       Serial Number:                     13659460238730275900826734340
       Not Before:                        2023-02-08
       Not After:                         2024-03-11
       Public Key Algorithm:              _RSAPublicKey
       Signature Algorithm:               sha256
       Key Size:                          4096
       Exponent:                          65537
       SubjAltName - DNS Names:           ['*.citilink.ru', 'citilink.ru']

     Certificate #0 - Trust
       Hostname Validation:               OK - Certificate matches server hostname
       Android CA Store (13.0.0_r9):      OK - Certificate is trusted
       Apple CA Store (iOS 16, iPadOS 16, macOS 13, tvOS 16, and watchOS 9):OK - Certificate is trusted
       Java CA Store (jdk-13.0.2):        OK - Certificate is trusted
       Mozilla CA Store (2022-12-11):     OK - Certificate is trusted
       Windows CA Store (2023-02-19):     OK - Certificate is trusted
       Symantec 2018 Deprecation:         OK - Not a Symantec-issued certificate
       Received Chain:                    *.citilink.ru --> GlobalSign GCC R3 DV TLS CA 2020
       Verified Chain:                    *.citilink.ru --> GlobalSign GCC R3 DV TLS CA 2020 --> GlobalSign
       Received Chain Contains Anchor:    OK - Anchor certificate not sent
       Received Chain Order:              OK - Order is valid
       Verified Chain contains SHA1:      OK - No SHA1-signed certificate in the verified certificate chain

     Certificate #0 - Extensions
       OCSP Must-Staple:                  NOT SUPPORTED - Extension not found
       Certificate Transparency:          OK - 3 SCTs included

     Certificate #0 - OCSP Stapling
                                          NOT SUPPORTED - Server did not send back an OCSP response

 * SSL 2.0 Cipher Suites:
     Attempted to connect using 7 cipher suites; the server rejected all cipher suites.

 * SSL 3.0 Cipher Suites:
     Attempted to connect using 80 cipher suites; the server rejected all cipher suites.

 * TLS 1.0 Cipher Suites:
     Attempted to connect using 80 cipher suites; the server rejected all cipher suites.

 * TLS 1.1 Cipher Suites:
     Attempted to connect using 80 cipher suites; the server rejected all cipher suites.

 * TLS 1.2 Cipher Suites:
     Attempted to connect using 156 cipher suites.

     The server accepted the following 5 cipher suites:
        TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256       256       ECDH: X25519 (253 bits)
        TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384             256       ECDH: prime256v1 (256 bits)
        TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256             128       ECDH: prime256v1 (256 bits)
        TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256             128       ECDH: prime256v1 (256 bits)
        TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA                128       ECDH: prime256v1 (256 bits)

     The group of cipher suites supported by the server has the following properties:
       Forward Secrecy                    OK - Supported
       Legacy RC4 Algorithm               OK - Not Supported


 * TLS 1.3 Cipher Suites:
     Attempted to connect using 5 cipher suites.

     The server accepted the following 3 cipher suites:
        TLS_CHACHA20_POLY1305_SHA256                      256       ECDH: X25519 (253 bits)
        TLS_AES_256_GCM_SHA384                            256       ECDH: X25519 (253 bits)
        TLS_AES_128_GCM_SHA256                            128       ECDH: X25519 (253 bits)


 * Deflate Compression:
                                          OK - Compression disabled

 * OpenSSL CCS Injection:
                                          OK - Not vulnerable to OpenSSL CCS injection

 * OpenSSL Heartbleed:
                                          OK - Not vulnerable to Heartbleed

 * ROBOT Attack:
                                          OK - Not vulnerable, RSA cipher suites not supported.

 * Session Renegotiation:
       Client Renegotiation DoS Attack:   OK - Not vulnerable
       Secure Renegotiation:              OK - Supported

 * Elliptic Curve Key Exchange:
       Supported curves:                  X25519, prime256v1
       Rejected curves:                   X448, prime192v1, secp160k1, secp160r1, secp160r2, secp192k1, secp224k1, secp224r1, secp256k1, secp384r1, secp521r1, sect163k1, sect163r1, sect163r2, sect193r1, sect193r2, sect233k1, sect233r1, sect239k1, sect283k1, sect283r1, sect409k1, sect409r1, sect571k1, sect571r1

 SCANS COMPLETED IN 5.127336 S
 -----------------------------

 COMPLIANCE AGAINST MOZILLA TLS CONFIGURATION
 --------------------------------------------

    Checking results against Mozilla's "intermediate" configuration. See https://ssl-config.mozilla.org/ for more details.

    citilink.ru:443: FAILED - Not compliant.
        * maximum_certificate_lifespan: Certificate life span is 396 days, should be less than 366.
        * ciphers: Cipher suites {'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA', 'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256'} are supported, but should be rejected.
```

5. Установите на Ubuntu SSH-сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.
 
**Решение:**

Генерирую ключи: 
```bash
[ivan@centos-vm0 ~]$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/ivan/.ssh/id_rsa):
Created directory '/home/ivan/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/ivan/.ssh/id_rsa.
Your public key has been saved in /home/ivan/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:Uk0jRcbd/4/7hOHnIcQAzcyLGyD7+MIKTUrFUGSiqt0 ivan@centos-vm0
The key's randomart image is:
+---[RSA 2048]----+
| oo+    .=@. .   |
|. =  . . =o*. .  |
|.  o  o o o..  . |
|. .  . . o .o   .|
|.. .  + S o  o. .|
|o.+. . o .  .. o.|
|.o..E .      .oo+|
|  .  o .      o+o|
|   .. .       .oo|
+----[SHA256]-----+
```
Копирую ключ на другой сервер:
```bash
[ivan@centos-vm0 ~]$ ssh-copy-id ivan@192.168.8.11
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/ivan/.ssh/id_rsa.pub"
The authenticity of host '192.168.8.11 (192.168.8.11)' can't be established.
ECDSA key fingerprint is SHA256:tkkgW09SP4ZJP96MPpSCfwHtZXG5g3ADsZMjfv+27s4.
ECDSA key fingerprint is MD5:66:e4:42:36:68:7a:95:f7:fb:89:2f:7e:ab:50:23:f4.
Are you sure you want to continue connecting (yes/no)? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
ivan@192.168.8.11's password:
Number of key(s) added: 1
Now try logging into the machine, with:   "ssh 'ivan@192.168.8.11'"
and check to make sure that only the key(s) you wanted were added.
```
Подключаюсь к другому серверу:
```bash
[ivan@centos-vm0 ~]$ ssh ivan@192.168.8.11
Enter passphrase for key '/home/ivan/.ssh/id_rsa':
Last login: Sun Apr  2 00:28:33 2023 from gateway
```
Успешное подключение на другой сервер:
```bash
[ivan@centos-vm1 ~]$
```

6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH-клиента так, чтобы вход на удалённый сервер осуществлялся по имени сервера.

**Решение:**

Переименовываю ключи на сервере:
```bash
[ivan@centos-vm0 ~]$ mv ~/.ssh/id_rsa ~/.ssh/mykey
[ivan@centos-vm0 ~]$ mv ~/.ssh/id_rsa.pub ~/.ssh/mykey.pub
```
Создаю файл конфигурации, чтобы указать имя сервера для подключения вместо логина и адреса:
```bash
[ivan@centos-vm0 ~]$ nano ~/.ssh/config
```
Содержимое файла конфигурации:
```bash
Host centos-vm1
    HostName 192.168.8.11
    User ivan
    Port 22
    IdentityFile ~/.ssh/mykey
```
Настраиваю права на файл. Этот файл должен быть доступен для чтения и записи только пользователю и не должен быть доступен для других::
```bash
[ivan@centos-vm0 ~]$ sudo chmod 600 ~/.ssh/config
```
Проверяю подключение к другому серверу:
```bash
[ivan@centos-vm0 ~]$ ssh centos-vm1
Enter passphrase for key '/home/ivan/.ssh/mykey':
Last login: Sun Apr  2 00:37:20 2023 from 192.168.8.10
[ivan@centos-vm1 ~]$
```

7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.

**Решение:**

```bash
ivan@ubuntutest:~$ sudo tcpdump -c 100 -w ~/mydump.pcap
tcpdump: listening on eth0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
100 packets captured
106 packets received by filter
0 packets dropped by kernel
```
![wireshark](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/03-sysadmin-09-security-wireshark.jpg)

*В качестве решения приложите: скриншоты, выполняемые команды, комментарии (при необходимости).*

 ---
 
## Задание со звёздочкой* 

Это самостоятельное задание, его выполнение необязательно.

8. Просканируйте хост scanme.nmap.org. Какие сервисы запущены?

**Решение:**

Устанавливаю сканер сети nmap:
```bash
[ivan@centos-vm0 ~]$ sudo yum install nmap
```
Запускаю проверку сайта:
```bash
[ivan@centos-vm0 ~]$ nmap scanme.nmap.org
Starting Nmap 6.40 ( http://nmap.org ) at 2023-04-02 01:05 MSK
Nmap scan report for scanme.nmap.org (45.33.32.156)
Host is up (0.18s latency).
Not shown: 996 closed ports
PORT      STATE SERVICE
22/tcp    open  ssh
80/tcp    open  http
9929/tcp  open  nping-echo
31337/tcp open  Elite

Nmap done: 1 IP address (1 host up) scanned in 4.91 seconds
```
Запущены сервисы: ssh, http, nping-echo и Elite.



9. Установите и настройте фаервол UFW на веб-сервер из задания 3. Откройте доступ снаружи только к портам 22, 80, 443.

**Решение:**

Устанавливаю ufw:
```bash
ivan@ubuntutest:~$ sudo apt install ufw
```

Проверяю статус запуска ufw:
```bash
ivan@ubuntutest:~$ sudo ufw status
Status: inactive
```

Открываю доступ к порту 22 (ssh):
```bash
ivan@ubuntutest:~$ sudo ufw allow ssh
Rules updated
Rules updated (v6)
```
Открываю доступ к порту 80 (http):
```bash
ivan@ubuntutest:~$ sudo ufw allow http
Rules updated
Rules updated (v6)
```
Открываю доступ к порту 443 (https):
```bash
ivan@ubuntutest:~$ sudo ufw allow https
Rules updated
Rules updated (v6)
```
Включаю ufw:
```bash
ivan@ubuntutest:~$ sudo ufw enable
Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
Firewall is active and enabled on system startup
```
Проверяю статус и разрешенные порты:
```bash
ivan@ubuntutest:~$ sudo ufw status
Status: active

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       Anywhere
80/tcp                     ALLOW       Anywhere
443                        ALLOW       Anywhere
22/tcp (v6)                ALLOW       Anywhere (v6)
80/tcp (v6)                ALLOW       Anywhere (v6)
443 (v6)                   ALLOW       Anywhere (v6)
```
----

### Правила приёма домашнего задания

В личном кабинете отправлена ссылка на .md-файл в вашем репозитории.

-----

### Критерии оценки

Зачёт:

* выполнены все задания;
* ответы даны в развёрнутой форме;
* приложены соответствующие скриншоты и файлы проекта;
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку:

* задание выполнено частично или не выполнено вообще;
* в логике выполнения заданий есть противоречия и существенные недостатки.  
 
Обязательными являются задачи без звёздочки. Их выполнение необходимо для получения зачёта и диплома о профессиональной переподготовке.

Задачи со звёздочкой (*) являются дополнительными или задачами повышенной сложности. Они необязательные, но их выполнение поможет лучше разобраться в теме.
