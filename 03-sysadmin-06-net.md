
# Домашнее задание к занятию «Компьютерные сети. Лекция 1»

### Цель задания

В результате выполнения задания вы: 

* научитесь работать с HTTP-запросами, чтобы увидеть, как клиенты взаимодействуют с серверами по этому протоколу;
* поработаете с сетевыми утилитами, чтобы разобраться, как их можно использовать для отладки сетевых запросов, соединений.

### Чеклист готовности к домашнему заданию

1. Убедитесь, что у вас установлены необходимые сетевые утилиты — dig, traceroute, mtr, telnet.
2. Используйте `apt install` для установки пакетов.


### Инструкция к заданию

1. Создайте .md-файл для ответов на вопросы задания в своём репозитории, после выполнения прикрепите ссылку на него в личном кабинете.
2. Любые вопросы по выполнению заданий задавайте в чате учебной группы или в разделе «Вопросы по заданию» в личном кабинете.


### Дополнительные материалы для выполнения задания

1. Полезным дополнением к обозначенным выше утилитам будет пакет net-tools. Установить его можно с помощью команды `apt install net-tools`.
2. RFC протокола HTTP/1.0, в частности [страница с кодами ответа](https://www.rfc-editor.org/rfc/rfc1945#page-32).
3. [Ссылки на другие RFC для HTTP](https://blog.cloudflare.com/cloudflare-view-http3-usage/).

------

## Задание

**Шаг 1.** Работа c HTTP через telnet.

- Подключитесь утилитой telnet к сайту stackoverflow.com:

`telnet stackoverflow.com 80`
 
- Отправьте HTTP-запрос:

```bash
GET /questions HTTP/1.0
HOST: stackoverflow.com
[press enter]
[press enter]
```
*В ответе укажите полученный HTTP-код и поясните, что он означает.*


**Решение:**

Подключаюсь утилитой `telnet`:
```bash
ivan@ubuntupc:~$ telnet stackoverflow.com 80
Trying 151.101.1.69...
Connected to stackoverflow.com.
Escape character is '^]'.
GET /questions HTTP/1.0
HOST: stackoverflow.com
```

Получаю следующий http-код:
```html
HTTP/1.1 403 Forbidden
Connection: close
Content-Length: 1920
Server: Varnish
Retry-After: 0
Content-Type: text/html
Accept-Ranges: bytes
Date: Mon, 27 Mar 2023 17:28:14 GMT
Via: 1.1 varnish
X-Served-By: cache-fra-eddf8230049-FRA
X-Cache: MISS
X-Cache-Hits: 0
X-Timer: S1679938094.248379,VS0,VE1
X-DNS-Prefetch-Control: off

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Forbidden - Stack Exchange</title>
    <style type="text/css">
                body
                {
                        color: #333;
                        font-family: 'Helvetica Neue', Arial, sans-serif;
                        font-size: 14px;
                        background: #fff url('img/bg-noise.png') repeat left top;
                        line-height: 1.4;
                }
                h1
                {
                        font-size: 170%;
                        line-height: 34px;
                        font-weight: normal;
                }
                a { color: #366fb3; }
                a:visited { color: #12457c; }
                .wrapper {
                        width:960px;
                        margin: 100px auto;
                        text-align:left;
                }
                .msg {
                        float: left;
                        width: 700px;
                        padding-top: 18px;
                        margin-left: 18px;
                }
    </style>
</head>
<body>
    <div class="wrapper">
                <div style="float: left;">
                        <img src="https://cdn.sstatic.net/stackexchange/img/apple-touch-icon.png" alt="Stack Exchange" />
                </div>
                <div class="msg">
                        <h1>Access Denied</h1>
                        <p>This IP address (46.242.13.237) has been blocked from access to our services. If you believe this to be in error, please contact us at <a href="mailto:team@stackexchange.com?Subject=Blocked%2046.242.13.237%20(Request%20ID%3A%201481482719-FRA)">team@stackexchange.com</a>.</p>
                        <p>When contacting us, please include the following information in the email:</p>
                        <p>Method: block</p>
                        <p>XID: 1481482719-FRA</p>
                        <p>IP: 46.242.13.237</p>
                        <p>X-Forwarded-For: </p>
                        <p>User-Agent: </p>

                        <p>Time: Mon, 27 Mar 2023 17:28:14 GMT</p>
                        <p>URL: stackoverflow.com/questions</p>
                        <p>Browser Location: <span id="jslocation">(not loaded)</span></p>
                </div>
        </div>
        <script>document.getElementById('jslocation').innerHTML = window.location.href;</script>
</body>
</html>Connection closed by foreign host.
```

Получаю ошибку `403 Forbidden`, которая означает, что с моего адреса доступ к сайту заблокирован через телнет.


**Шаг 2.** Повторите задание 1 в браузере, используя консоль разработчика F12:

 - откройте вкладку `Network`;
 - отправьте запрос [http://stackoverflow.com](http://stackoverflow.com);
 - найдите первый ответ HTTP-сервера, откройте вкладку `Headers`;
 - укажите в ответе полученный HTTP-код;
 - проверьте время загрузки страницы и определите, какой запрос обрабатывался дольше всего;
 - приложите скриншот консоли браузера в ответ.


**Решение:**

Получаю статус 200, означающий что всё хорошо:
![site](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/03-sysadmin-06-net-site.jpg)

Чтобы проверить время загрузки страницы нужно сортировать значения в столбце Time:
![site2](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/03-sysadmin-06-net-site2.jpg)

**Шаг 3.** Какой IP-адрес у вас в интернете?


**Решение:**

Можно зайти на https://2ip.ru или выполнить команду в Linux:
```bash
ivan@ubuntupc:~$ curl 2ip.ru
46.242.13.237
```

**Шаг 4.** Какому провайдеру принадлежит ваш IP-адрес? Какой автономной системе AS? Воспользуйтесь утилитой `whois`.


**Решение:**

Для этого использую команду:

```bash
ivan@ubuntupc:~$ whois 46.242.13.237 | grep -E '(netname|origin)'
netname:        NCN-BBCUST
origin:         AS42610
```

**Шаг 5.** Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой `traceroute`.


**Решение:**

Выполняю команду `traceroute` с ключом `-A`:

```bash
ivan@ubuntupc:~$ traceroute -A 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  _gateway (192.168.7.1) [*]  7.234 ms  7.182 ms  7.159 ms
 2  10.76.0.3 (10.76.0.3) [*]  11.882 ms  11.868 ms  11.843 ms
 3  192.168.126.210 (192.168.126.210) [*]  11.828 ms  11.811 ms  11.800 ms
 4  77.37.250.229 (77.37.250.229) [AS42610]  11.785 ms  11.773 ms  11.797 ms
 5  77.37.250.249 (77.37.250.249) [AS42610]  13.889 ms  13.878 ms  13.864 ms
 6  72.14.209.81 (72.14.209.81) [AS15169]  12.771 ms  6.679 ms  6.637 ms
 7  * * *
 8  108.170.250.129 (108.170.250.129) [AS15169]  6.587 ms 108.170.226.172 (108.1                                                                                                             70.226.172) [AS15169]  6.358 ms 108.170.227.90 (108.170.227.90) [AS15169]  6.208                                                                                                              ms
 9  108.170.250.66 (108.170.250.66) [AS15169]  6.152 ms 108.170.250.51 (108.170.                                                                                                             250.51) [AS15169]  6.105 ms *
10  172.253.66.116 (172.253.66.116) [AS15169]  23.249 ms  22.871 ms 209.85.249.1                                                                                                             58 (209.85.249.158) [AS15169]  22.817 ms
11  142.251.238.66 (142.251.238.66) [AS15169]  23.083 ms 142.250.235.74 (142.250                                                                                                             .235.74) [AS15169]  23.048 ms 172.253.66.108 (172.253.66.108) [AS15169]  22.366                                                                                                              ms
12  108.170.233.163 (108.170.233.163) [AS15169]  18.671 ms 142.250.56.219 (142.2                                                                                                             50.56.219) [AS15169]  22.821 ms 216.239.40.61 (216.239.40.61) [AS15169]  25.805                                                                                                              ms
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  dns.google (8.8.8.8) [AS15169/AS263411]  33.362 ms * *
```

Пакет проходит через AS42610 и AS15169.

**Шаг 6.** Повторите задание 5 в утилите `mtr`. На каком участке наибольшая задержка — delay?


**Решение:**

Аналогичный вывод командой `mtr`:
```bash
ivan@ubuntupc:~$ mtr -znr 8.8.8.8
Start: 2023-03-27T22:43:47+0300
HOST: ubuntupc                    Loss%   Snt   Last   Avg  Best  Wrst StDev
  1. AS???    192.168.7.1          0.0%    10    2.7   3.1   2.7   3.9   0.4
  2. AS???    10.76.0.3            0.0%    10    4.7   5.1   4.6   5.8   0.4
  3. AS???    192.168.126.210     10.0%    10    5.5 121.2   5.0 452.0 178.8
  4. AS42610  77.37.250.229       80.0%    10    5.0   5.1   5.0   5.1   0.0
  5. AS42610  77.37.250.249        0.0%    10    6.4   6.2   5.6   8.0   0.7
  6. AS15169  72.14.209.81         0.0%    10    7.3   7.6   7.3   8.3   0.3
  7. AS15169  108.170.250.33       0.0%    10    7.6   7.5   6.8   8.9   0.5
  8. AS15169  108.170.250.51       0.0%    10    7.4  13.8   6.5  56.2  15.2
  9. AS15169  72.14.234.20         0.0%    10   24.3  27.5  21.9  48.9   7.9
 10. AS15169  72.14.232.76         0.0%    10   31.0  25.6  18.3  37.8   7.4
 11. AS15169  108.170.233.163      0.0%    10   20.4  19.4  18.9  20.4   0.6
 12. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
 13. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
 14. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
 15. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
 16. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
 17. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
 18. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
 19. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
 20. AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
 21. AS15169  8.8.8.8              0.0%    10   20.3  20.7  20.2  21.9   0.5
```

Наибольшая задержка и потеря идет при отправке через первый AS42610.

**Шаг 7.** Какие DNS-сервера отвечают за доменное имя dns.google? Какие A-записи? Воспользуйтесь утилитой `dig`.


**Решение:**

```bash
ivan@ubuntupc:~$ dig dns.google

; <<>> DiG 9.18.1-1ubuntu1.1-Ubuntu <<>> dns.google
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 5543
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;dns.google.                    IN      A

;; ANSWER SECTION:
dns.google.             421     IN      A       8.8.8.8
dns.google.             421     IN      A       8.8.4.4

;; Query time: 8 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Mon Mar 27 20:37:27 MSK 2023
;; MSG SIZE  rcvd: 71
```

В результате вывода отображаются А-записи:

```bash
dns.google.             0       IN      A       8.8.4.4
dns.google.             0       IN      A       8.8.8.8
```

**Шаг 8.** Проверьте PTR записи для IP-адресов из задания 7. Какое доменное имя привязано к IP? Воспользуйтесь утилитой `dig`.


**Решение:**

Выполняю команду для первого ip-адреса 8.8.4.4:
```bash
ivan@ubuntupc:~$ dig -x 8.8.4.4

; <<>> DiG 9.18.1-1ubuntu1.1-Ubuntu <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 49964
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.   11239   IN      PTR     dns.google.

;; Query time: 8 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Mon Mar 27 20:38:30 MSK 2023
;; MSG SIZE  rcvd: 73
```

И выполняю команду для второго ip-адреса 8.8.8.8:

```bash
ivan@ubuntupc:~$ dig -x 8.8.8.8

; <<>> DiG 9.18.1-1ubuntu1.1-Ubuntu <<>> -x 8.8.8.8
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 5506
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;8.8.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
8.8.8.8.in-addr.arpa.   9571    IN      PTR     dns.google.

;; Query time: 8 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Mon Mar 27 20:38:56 MSK 2023
;; MSG SIZE  rcvd: 73
```

Привязано доменно имя: dns.google

*В качестве ответов на вопросы приложите лог выполнения команд в консоли или скриншот полученных результатов.*

----

### Правила приёма домашнего задания

В личном кабинете отправлена ссылка на .md-файл в вашем репозитории.


### Критерии оценки

Зачёт:

* выполнены все задания;
* ответы даны в развёрнутой форме;
* приложены соответствующие скриншоты и файлы проекта;
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку:

* задание выполнено частично или не выполнено вообще;
* в логике выполнения заданий есть противоречия и существенные недостатки. 
