# Домашнее задание к занятию «Компьютерные сети. Лекция 3»

### Цель задания

В результате выполнения задания вы:

* на практике познакомитесь с маршрутизацией в сетях, что позволит понять устройство больших корпоративных сетей и интернета;
* проверите TCP/UDP соединения на хосте — это обычный этап отладки сетевых проблем;
* построите сетевую диаграмму.

### Чеклист готовности к домашнему заданию

1. Убедитесь, что у вас установлен `telnet`.
2. Воспользуйтесь пакетным менеджером apt для установки.


### Инструкция к заданию

1. Создайте .md-файл для ответов на задания в своём репозитории, после выполнения прикрепите ссылку на него в личном кабинете.
2. Любые вопросы по выполнению заданий задавайте в чате учебной группы или в разделе «Вопросы по заданию» в личном кабинете.


### Дополнительные материалы для выполнения задания

1. [Зачем нужны dummy-интерфейсы](https://tldp.org/LDP/nag/node72.html).

------

## Задание

1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP.

 ```
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
```


**Решение:**

Подключаюсь к публичному маршрутизатору:
```bash
[root@centos7test ~]# telnet route-views.routeviews.org
Trying 128.223.51.103...
Connected to route-views.routeviews.org.
Escape character is '^]'.
C
**********************************************************************

                    RouteViews BGP Route Viewer
                    route-views.routeviews.org

 route views data is archived on http://archive.routeviews.org

 This hardware is part of a grant by the NSF.
 Please contact help@routeviews.org if you have questions, or
 if you wish to contribute your view.

 This router has views of full routing tables from several ASes.
 The list of peers is located at http://www.routeviews.org/peers
 in route-views.oregon-ix.net.txt

 NOTE: The hardware was upgraded in August 2014.  If you are seeing
 the error message, "no default Kerberos realm", you may want to
 in Mac OS X add "default unset autologin" to your ~/.telnetrc

 To login, use the username "rviews".

 **********************************************************************

User Access Verification

Username: rviews
```

Проверяю маршрут к моему публичному IP:
```bash
route-views>show ip route 31.41.246.2
Routing entry for 31.41.246.0/24
  Known via "bgp 6447", distance 20, metric 0
  Tag 3267, type external
  Last update from 194.85.40.15 2d10h ago
  Routing Descriptor Blocks:
  * 194.85.40.15, from 194.85.40.15, 2d10h ago
      Route metric is 0, traffic share count is 1
      AS Hops 5
      Route tag 3267
      MPLS label: none
```
Проверяю bgp:
```bash
route-views>show bgp 31.41.246.2
BGP routing table entry for 31.41.246.0/24, version 2771189247
Paths: (20 available, best #5, table default)
  Not advertised to any peer
  Refresh Epoch 1
  20912 6939 35598 39153 39153 39153 39153 39153 39153 39153 39153 39153 39153 8905 42132 41162
    212.66.96.126 from 212.66.96.126 (212.66.96.126)
      Origin IGP, localpref 100, valid, external
      Community: 20912:65016
      path 7FE186E7CCD8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  8283 28917 28917 28917 8905 8905 42132 41162
    94.142.247.3 from 94.142.247.3 (94.142.247.3)
      Origin incomplete, metric 0, localpref 100, valid, external
      Community: 0:6939 0:31500 8283:1 8283:101 8905:2001 28917:2000 28917:5112 28917:5202 28917:5302 28917:5350 31133:20002 31133:25002 31133:26142
      unknown transitive attribute: flag 0xE0 type 0x20 length 0x24
        value 0000 205B 0000 0000 0000 0001 0000 205B
              0000 0005 0000 0001 0000 205B 0000 0008
              0000 0DB8
      path 7FE0F960FEE8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3549 3356 12389 21418 41162 41162 41162 41162 41162 41162
    208.51.134.254 from 208.51.134.254 (67.16.168.191)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3356:2 3356:22 3356:100 3356:123 3356:501 3356:903 3356:2065 3549:2581 3549:30840
      path 7FE0BC01C860 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3356 12389 21418 41162 41162 41162 41162 41162 41162
    4.68.4.46 from 4.68.4.46 (4.69.184.201)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3356:2 3356:22 3356:100 3356:123 3356:501 3356:903 3356:2065
      path 7FE0DF4E7E78 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3267 39153 8905 42132 41162
    194.85.40.15 from 194.85.40.15 (185.141.126.1)
      Origin incomplete, metric 0, localpref 100, valid, external, best
      path 7FE00F217240 RPKI State not found
      rx pathid: 0, tx pathid: 0x0
  Refresh Epoch 1
 --More--
```

2. Создайте dummy-интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.


**Решение:**

Включаю модуль ядра dummy:
```bash
ivan@ubuntutest:~$ sudo modprobe dummy
```
Проверяю загружен ли модуль:
```bash
ivan@ubuntutest:~$ lsmod | grep dummy
dummy                  16384  0
```
Добавляю новый виртуальный интерфейс dummy0:
```bash
ivan@ubuntutest:~$ sudo ip link add dummy0 type dummy
```
Проверяю, что он появился в списке интерфейсов:
```bash
ivan@ubuntutest:~$ ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 00:15:5d:d0:0e:0a brd ff:ff:ff:ff:ff:ff
3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:15:5d:d0:0e:0b brd ff:ff:ff:ff:ff:ff
4: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 32:d4:d5:06:ab:b0 brd ff:ff:ff:ff:ff:ff
```
Добавляю ip-адрес для интерфейса dummy0:
```bash
ivan@ubuntutest:~$ sudo ip addr add 192.168.9.7/24 dev dummy0
```
Активирую интерфейс:
```bash
ivan@ubuntutest:~$ sudo ip link set dev dummy0 up
```
И проверяю, что адрес присвоился:
```bash
ivan@ubuntutest:~$ ip a | grep dummy
5: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 192.168.9.7/24 scope global dummy0
```
Проверяю таблицу маршрутизации:
```bash
ivan@ubuntutest:~$ ip route show
default via 172.30.240.1 dev eth0 proto dhcp src 172.30.251.35 metric 100
172.30.240.0/20 dev eth0 proto kernel scope link src 172.30.251.35 metric 100
172.30.240.1 dev eth0 proto dhcp scope link src 172.30.251.35 metric 100
192.168.9.0/24 dev dummy0 proto kernel scope link src 192.168.9.7
```
Добавляю 2 статических маршрута:
```bash
ivan@ubuntutest:~$ sudo ip route add 192.168.100.0/24 via 172.30.240.1
ivan@ubuntutest:~$ sudo ip route add 192.168.101.0/24 via 172.30.240.1
```
И снова проверяю таблицу маршрутизации:
```bash
ivan@ubuntutest:~$ ip route show
default via 172.30.240.1 dev eth0 proto dhcp src 172.30.251.35 metric 100
172.30.240.0/20 dev eth0 proto kernel scope link src 172.30.251.35 metric 100
172.30.240.1 dev eth0 proto dhcp scope link src 172.30.251.35 metric 100
192.168.9.0/24 dev dummy0 proto kernel scope link src 192.168.9.7
192.168.100.0/24 via 172.30.240.1 dev eth0
192.168.101.0/24 via 172.30.240.1 dev eth0
```

3. Проверьте открытые TCP-порты в Ubuntu. Какие протоколы и приложения используют эти порты? Приведите несколько примеров.


**Решение:**

Чтобы вывести список TCP и UDP-портов использую команду:
```bash
ivan@ubuntutest:~$ sudo ss -ltpn
State                           Recv-Q                          Send-Q                                                    Local Address:Port                                                      Peer Address:Port                          Process
LISTEN                          0                               4096                                                            0.0.0.0:10050                                                          0.0.0.0:*                              users:(("zabbix_agentd",pid=1416,fd=4),("zabbix_agentd",pid=1415,fd=4),("zabbix_agentd",pid=1414,fd=4),("zabbix_agentd",pid=1413,fd=4),("zabbix_agentd",pid=1412,fd=4),("zabbix_agentd",pid=1411,fd=4))
LISTEN                          0                               4096                                                      127.0.0.53%lo:53                                                             0.0.0.0:*                              users:(("systemd-resolve",pid=731,fd=14))
LISTEN                          0                               128                                                             0.0.0.0:22                                                             0.0.0.0:*                              users:(("sshd",pid=762,fd=3))
LISTEN                          0                               4096                                                               [::]:10050                                                             [::]:*                              users:(("zabbix_agentd",pid=1416,fd=5),("zabbix_agentd",pid=1415,fd=5),("zabbix_agentd",pid=1414,fd=5),("zabbix_agentd",pid=1413,fd=5),("zabbix_agentd",pid=1412,fd=5),("zabbix_agentd",pid=1411,fd=5))
LISTEN                          0                               128                                                                [::]:22                                                                [::]:*                              users:(("sshd",pid=762,fd=4))
```

tcp-порт 22 - это порт для SSH

tcp-порт 10050 - это порт агента Zabbix

tcp/udp порт 53 - это служба доменных имен DNS 

4. Проверьте используемые UDP-сокеты в Ubuntu. Какие протоколы и приложения используют эти порты?


**Решение:**
```bash
Чтобы вывести список только UDP-портов использую команду:
ivan@ubuntutest:~$ ss -ulpn
State       Recv-Q      Send-Q                Local Address:Port            Peer Address:Port      Process
UNCONN      0           0                     127.0.0.53%lo:53                   0.0.0.0:*
UNCONN      0           0                172.30.251.35%eth0:68                   0.0.0.0:*
```

udp порт 53 - это служба доменных имен DNS 

udp порт 68 - это порт bootpc

5. Используя diagrams.net, создайте L3-диаграмму вашей домашней сети или любой другой сети, с которой вы работали. 


**Решение:**

![HomeLAN](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/03-sysadmin-08-net-lan.jpg)


*В качестве решения пришлите ответы на вопросы, опишите, как они были получены, и приложите скриншоты при необходимости.*

 ---
 
## Задание со звёздочкой* 

Это самостоятельное задание, его выполнение необязательно.

6. Установите Nginx, настройте в режиме балансировщика TCP или UDP.

7. Установите bird2, настройте динамический протокол маршрутизации RIP.

8. Установите Netbox, создайте несколько IP-префиксов, и, используя curl, проверьте работу API.

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
