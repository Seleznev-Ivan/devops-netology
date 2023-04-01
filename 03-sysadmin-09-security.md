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
