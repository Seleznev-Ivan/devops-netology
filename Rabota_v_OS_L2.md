
# Домашнее задание к занятию «Операционные системы. Лекция 2»

### Цель задания

В результате выполнения задания вы:

* познакомитесь со средством сбора метрик node_exporter и средством сбора и визуализации метрик NetData. Такие инструменты позволяют выстроить систему мониторинга сервисов для своевременного выявления проблем в их работе;
* построите простой systemd unit-файл для создания долгоживущих процессов, которые стартуют вместе со стартом системы автоматически;
* проанализируете dmesg, а именно часть лога старта виртуальной машины, чтобы понять, какая полезная информация может там находиться;
* поработаете с unshare и nsenter для понимания, как создать отдельный namespace для процесса (частичная контейнеризация).

### Чеклист готовности к домашнему заданию

1. Убедитесь, что у вас установлен [Netdata](https://github.com/netdata/netdata) c ресурса с предподготовленными [пакетами](https://packagecloud.io/netdata/netdata/install) или `sudo apt install -y netdata`.


### Дополнительные материалы для выполнения задания

1. [Документация](https://www.freedesktop.org/software/systemd/man/systemd.service.html) по systemd unit-файлам.
2. [Документация](https://www.kernel.org/doc/Documentation/sysctl/) по параметрам sysctl.

------

## Задание

1. На лекции вы познакомились с [node_exporter](https://github.com/prometheus/node_exporter/releases). В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой [unit-файл](https://www.freedesktop.org/software/systemd/man/systemd.service.html) для node_exporter:

    * поместите его в автозагрузку;
    * предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на `systemctl cat cron`);
    * удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.

**Решение:**

Скачиваю архив `node_exporter` с github:
```bash
vagrant@vagrant:~$ wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
```
Распаковываю:
```bash
vagrant@vagrant:~$ tar -xvf node_exporter-1.5.0.linux-amd64.tar.gz
```
Переношу распакованный каталог в `/usr/local/bin`:
```bash
vagrant@vagrant:~$ sudo mv node_exporter-1.5.0.linux-amd64/node_exporter /usr/local/bin
```
Создаю unit-файл `systemd` для запука `node_exporter`:
```bash
vagrant@vagrant:~$ sudo nano /etc/systemd/system/node_exporter.service
```
Содержимое файла:
```bash
[Unit]
Description=Node_exporter
[Service]
ExecStart=/usr/local/bin/node_exporter $MY_EXT_FILE
[Install]
WantedBy=multi-user.target
```
Указываю опцию логирования:
`MY_EXT_FILE="--log.level=warning"`

Перезагружаю процесс `systemd`:
```bash
vagrant@vagrant:~$ sudo systemctl daemon-reload
```
Добавляю в автозапуск:
```bash
vagrant@vagrant:~$ sudo systemctl enable node_exporter
Created symlink /etc/systemd/system/multi-user.target.wants/node_exporter.service → /etc/systemd/system/node_exporter.service.
```
Теперь запускаю `node_exporter`:
```bash
vagrant@vagrant:~$ sudo systemctl start node_exporter
```
Проверяю состояние сервиса:
```bash
vagrant@vagrant:~$ sudo systemctl status node_exporter
● node_exporter.service - Node_exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2023-03-01 20:25:43 UTC; 4s ago
   Main PID: 1364 (node_exporter)
      Tasks: 4 (limit: 1366)
     Memory: 2.8M
     CGroup: /system.slice/node_exporter.service
             └─1364 /usr/local/bin/node_exporter

Mar 01 20:25:43 vagrant node_exporter[1364]: ts=2023-03-01T20:25:43.489Z caller=node_exporter.go:117 level=info collect>
Mar 01 20:25:43 vagrant node_exporter[1364]: ts=2023-03-01T20:25:43.489Z caller=node_exporter.go:117 level=info collect>
Mar 01 20:25:43 vagrant node_exporter[1364]: ts=2023-03-01T20:25:43.489Z caller=node_exporter.go:117 level=info collect>
...
```
Всё запускается нормально.

2. Изучите опции node_exporter и вывод `/metrics` по умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

**Решение:**

Использую команду:
```bash
vagrant@vagrant:~$ curl localhost:9100/metrics
```

Мои опции:
Процессор:
```bash
node_cpu_seconds_total{cpu="0",mode="idle"} 2444.63
node_cpu_seconds_total{cpu="0",mode="iowait"} 2.93
node_cpu_seconds_total{cpu="0",mode="irq"} 0
node_cpu_seconds_total{cpu="0",mode="softirq"} 1.97
node_cpu_seconds_total{cpu="0",mode="system"} 14.48
```
Память:
```bash
node_memory_MemAvailable_bytes 9.3036544e+08
node_memory_MemFree_bytes 6.89586176e+08
node_memory_MemTotal_bytes 1.28677888e+09
```
Диск:
```bash
node_filesystem_avail_bytes{device="/dev/mapper/ubuntu--vg-ubuntu--lv",fstype="ext4",mountpoint="/"} 2.6855673856e+10
node_filesystem_avail_bytes{device="/dev/sda2",fstype="ext4",mountpoint="/boot"} 1.805344768e+09
node_filesystem_device_error{device="/dev/mapper/ubuntu--vg-ubuntu--lv",fstype="ext4",mountpoint="/"} 0
node_filesystem_device_error{device="/dev/sda2",fstype="ext4",mountpoint="/boot"} 0
```
Сеть:
```bash
node_network_protocol_type{device="eth0"} 1
node_network_mtu_bytes{device="eth0"} 1500
node_network_receive_errs_total{device="eth0"} 0
```

3. Установите в свою виртуальную машину [Netdata](https://github.com/netdata/netdata). Воспользуйтесь [готовыми пакетами](https://packagecloud.io/netdata/netdata/install) для установки (`sudo apt install -y netdata`). 
   
   После успешной установки:
   
    * в конфигурационном файле `/etc/netdata/netdata.conf` в секции [web] замените значение с localhost на `bind to = 0.0.0.0`;
    * добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте `vagrant reload`:

    ```bash
    config.vm.network "forwarded_port", guest: 19999, host: 19999
    ```

    После успешной перезагрузки в браузере на своём ПК (не в виртуальной машине) вы должны суметь зайти на `localhost:19999`. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata, и с комментариями, которые даны к этим метрикам.

**Решение:**

Результат запуска Netdata на localhost:
![Netdata](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/03-sysadmin-04-os-netdata.png)


4. Можно ли по выводу `dmesg` понять, осознаёт ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

**Решение:**

 Да, можно 
```bash
vagrant@vagrant:~$ dmesg | grep Hypervisor
[    0.000000] Hypervisor detected: KVM
```

5. Как настроен sysctl `fs.nr_open` на системе по умолчанию? Определите, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (`ulimit --help`)?

**Решение:**

Команда `sysctl fs.nr_open` выводит значение по-умолчанию:
`fs.nr_open = 1048576`
Этот параметр означает, что любой процесс в системе не сможет открыть более 1048576 файлов.

Проверить ограничения на открытие файлов в Linux:
- жесткое ограничение файлов:
```bash
vagrant@vagrant:~$ ulimit -Hn
1048576
```
- мягкое ограничение файлов:
```bash
vagrant@vagrant:~$ ulimit -Sn
1024
```

6. Запустите любой долгоживущий процесс (не `ls`, который отработает мгновенно, а, например, `sleep 1h`) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через `nsenter`. Для простоты работайте в этом задании под root (`sudo -i`). Под обычным пользователем требуются дополнительные опции (`--map-root-user`) и т. д.

**Решение:**

Логинимся под root:
```bash
vagrant@vagrant:~$ sudo -i
root@vagrant:~#
```

Запускаем sleep 1h через команду unshare
```bash
root@vagrant:~# unshare --fork --pid --mount-proc sleep 1h
```
Смотрим запущенный процесс:
```bash
root@vagrant:~# ps -e | grep sleep
   1482 pts/0    00:00:00 sleep
```
Проверяем:
```bash
root@vagrant:~# nsenter --target 1482 --pid --mount --uts --ipc --net ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0   5476   580 pts/0    S+   07:49   0:00 sleep 1h
root           2  0.0  0.2   8888  3320 pts/0    R+   07:51   0:00 ps aux
```

7. Найдите информацию о том, что такое `:(){ :|:& };:`. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (**это важно, поведение в других ОС не проверялось**). Некоторое время всё будет плохо, после чего (спустя минуты) — ОС должна стабилизироваться. Вызов `dmesg` расскажет, какой механизм помог автоматической стабилизации.  
Как настроен этот механизм по умолчанию, и как изменить число процессов, которое можно создать в сессии?

**Решение:**

`:(){ :|:& };:` это fork-бомба. Эта «команда» при выполнении на компьютере не представляет особой угрозы, но вот ее запуск на сервере может привести к отказу в обслуживании.

В bash допускается использовать в качестве имени функции `:` И в случае выполнения команды `:(){ :|:& };:` именно такую функцию мы и создаем. Внутренне она рекурсивно вызывает сама себя, то есть выполняется бесконечно, а с помощью `&` мы инструктируем процесс выполняться фоново.

Вызов `dmesg` покажет, что выполнился механизм `cgroup`, который помог автоматической стабилизации системы:
```bash
[ 1185.923803] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-3.scope
```

`cgroup` — группа процессов в Linux, для которой механизмами ядра наложена изоляция и установлены ограничения на некоторые вычислительные ресурсы (процессорные, сетевые, ресурсы памяти, ресурсы ввода-вывода).

По умолчанию максимальное количество задач, которые `systemd` разрешит для каждого пользователя, составляет 33% от максимального (параметр `TasksMax`).

Настройки по-умолчанию можно посмотреть в файле  
`vagrant@vagrant:~$ cat /usr/lib/systemd/system/user-.slice.d/10-defaults.conf`
Содержимое файла 

```bash
#  SPDX-License-Identifier: LGPL-2.1+
#
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation; either version 2.1 of the License, or
#  (at your option) any later version.

[Unit]
Description=User Slice of UID %j
Documentation=man:user@.service(5)
After=systemd-user-sessions.service
StopWhenUnneeded=yes

[Slice]
TasksMax=33%
```

Чтобы узнать максимальное число задач, нужно выполнить команду:
```bash
vagrant@vagrant:~$ sudo sysctl kernel.threads-max
kernel.threads-max = 30503
```

*В качестве решения отправьте ответы на вопросы и опишите, как эти ответы были получены.*

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
