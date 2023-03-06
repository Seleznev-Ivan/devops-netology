# Домашнее задание к занятию «Файловые системы»

### Цель задания

В результате выполнения задания вы: 

* научитесь работать с инструментами разметки жёстких дисков, виртуальных разделов — RAID-массивами и логическими томами, конфигурациями файловых систем. Основная задача — понять, какие слои абстракций могут нас отделять от файловой системы до железа. Обычно инженер инфраструктуры не сталкивается напрямую с настройкой LVM или RAID, но иметь понимание, как это работает, необходимо;
* создадите нештатную ситуацию работы жёстких дисков и поймёте, как система RAID обеспечивает отказоустойчивую работу.


### Чеклист готовности к домашнему заданию

1. Убедитесь, что у вас на новой виртуальной машине  установлены утилиты: `mdadm`, `fdisk`, `sfdisk`, `mkfs`, `lsblk`, `wget` (шаг 3 в задании).  
2. Воспользуйтесь пакетным менеджером apt для установки необходимых инструментов.


### Дополнительные материалы для выполнения задания

1. Разряженные файлы — [sparse](https://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D1%80%D0%B5%D0%B6%D1%91%D0%BD%D0%BD%D1%8B%D0%B9_%D1%84%D0%B0%D0%B9%D0%BB).
2. [Подробный анализ производительности RAID](https://www.baarf.dk/BAARF/0.Millsap1996.08.21-VLDB.pdf), страницы 3–19.
3. [RAID5 write hole](https://www.intel.com/content/www/us/en/support/articles/000057368/memory-and-storage.html).


------

## Задание

1. Узнайте о [sparse-файлах](https://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D1%80%D0%B5%D0%B6%D1%91%D0%BD%D0%BD%D1%8B%D0%B9_%D1%84%D0%B0%D0%B9%D0%BB) (разряженных).

**Решение:**

Разрежённый файл (sparse file) — файл, в котором последовательности нулевых байтов заменены на информацию об этих последовательностях (список дыр).
Дыра (hole) — последовательность нулевых байт внутри файла, не записанная на диск. Информация о дырах (смещение от начала файла в байтах и количество байт) хранится в метаданных ФС.

2. Могут ли файлы, являющиеся жёсткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

**Решение:**

Нет, не могут. В Linux каждый файл имеет уникальный идентификатор - индексный дескриптор (inode). Это число, которое однозначно идентифицирует файл в файловой системе. Жесткая ссылка и файл, для которой она создавалась имеют одинаковые inode. Поэтому жесткая ссылка имеет те же права доступа, владельца и время последней модификации, что и целевой файл. Различаются только имена файлов. Фактически жесткая ссылка это еще одно имя для файла.

3. Сделайте `vagrant destroy` на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:

    ```ruby
    path_to_disk_folder = './disks'

    host_params = {
        'disk_size' => 2560,
        'disks'=>[1, 2],
        'cpus'=>2,
        'memory'=>2048,
        'hostname'=>'sysadm-fs',
        'vm_name'=>'sysadm-fs'
    }
    Vagrant.configure("2") do |config|
        config.vm.box = "bento/ubuntu-20.04"
        config.vm.hostname=host_params['hostname']
        config.vm.provider :virtualbox do |v|

            v.name=host_params['vm_name']
            v.cpus=host_params['cpus']
            v.memory=host_params['memory']

            host_params['disks'].each do |disk|
                file_to_disk=path_to_disk_folder+'/disk'+disk.to_s+'.vdi'
                unless File.exist?(file_to_disk)
                    v.customize ['createmedium', '--filename', file_to_disk, '--size', host_params['disk_size']]
                end
                v.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', disk.to_s, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
            end
        end
        config.vm.network "private_network", type: "dhcp"
    end
    ```

    Эта конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2,5 Гб.

**Решение:**

Командой vagrant destroy удаляем имеющуюся виртуальную машину. На основе предложенной конфигурации создадим новую виртуальную машину (Ubuntu 20.04, 2 CPU, 2 ГБ ОЗУ, 2 диска по 2.5 Гб.

users-MacBook-Pro:netology_project user$ vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...




4. Используя `fdisk`, разбейте первый диск на два раздела: 2 Гб и оставшееся пространство.

**Решение:**

vagrant@sysadm-fs:~$ sudo fdisk /dev/sdb

Welcome to fdisk (util-linux 2.34).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0xdcbe23a8.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-5242879, default 2048):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-5242879, default 5242879):+2G

Created a new partition 1 of type 'Linux' and of size 2 GiB.

Command (m for help): n
Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (2-4, default 2): 2
First sector (4196352-5242879, default 4196352):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242879, default 5242879):

Created a new partition 2 of type 'Linux' and of size 511 MiB.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

vagrant@sysadm-fs:~$ lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
loop0                       7:0    0   62M  1 loop /snap/core20/1611
loop1                       7:1    0 67.8M  1 loop /snap/lxd/22753
loop2                       7:2    0   47M  1 loop /snap/snapd/16292
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0    2G  0 part /boot
└─sda3                      8:3    0   62G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0   31G  0 lvm  /
sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
└─sdb2                      8:18   0  511M  0 part
sdc                         8:32   0  2.5G  0 disk


5. Используя `sfdisk`, перенесите эту таблицу разделов на второй диск.

**Решение:**

Сначала создаю копию данных о разделе с диска sdb, используя команду

vagrant@sysadm-fs:~$ sudo sfdisk -d /dev/sdb > part-sdb.txt

И теперь можно записать таблицу разделов sdb на диск sdc:

vagrant@sysadm-fs:~$ sudo sfdisk /dev/sdc < part-sdb.txt
Checking that no-one is using this disk right now ... OK

Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new DOS disklabel with disk identifier 0xdcbe23a8.
/dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
/dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
/dev/sdc3: Done.

New situation:
Disklabel type: dos
Disk identifier: 0xdcbe23a8

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdc1          2048 4196351 4194304    2G 83 Linux
/dev/sdc2       4196352 5242879 1046528  511M 83 Linux

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.


6. Соберите `mdadm` RAID1 на паре разделов 2 Гб.

**Решение:**

Создаю RAID1:
vagrant@sysadm-fs:~$ sudo mdadm --create --verbose /dev/md0 -l 1 -n 2 /dev/sd{b,c}1
и подтверждаю создание :
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
mdadm: size set to 2094080K
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.

В итоге будет создан RAID1 /dev/md0


7. Соберите `mdadm` RAID0 на второй паре маленьких разделов.

**Решение:**

Аналогично создаю RAID0:
vagrant@sysadm-fs:~$ sudo mdadm --create --verbose /dev/md1 -l 0 -n 2 /dev/sd{b,c}2
mdadm: chunk size defaults to 512K
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md1 started.

Будет создан RAID0 /dev/md1


8. Создайте два независимых PV на получившихся md-устройствах.

**Решение:**

Создаю 2 независимых PV:
vagrant@sysadm-fs:~$ sudo pvcreate /dev/md0
  Physical volume "/dev/md0" successfully created.
vagrant@sysadm-fs:~$ sudo pvcreate /dev/md1
  Physical volume "/dev/md1" successfully created.


9. Создайте общую volume-group на этих двух PV.

**Решение:**

Создаю общую volume-group "MyGroup":
vagrant@sysadm-fs:~$ sudo vgcreate MyGroup /dev/md0 /dev/md1
  Volume group "MyGroup" successfully created


10. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

**Решение:**

Создаю LV на 100 Мб:
vagrant@sysadm-fs:~$ sudo lvcreate -L 100M -n lv100 MyGroup /dev/md1
  Logical volume "lv100" created.


11. Создайте `mkfs.ext4` ФС на получившемся LV.

**Решение:**

Создаю файловую систему ext4 на lv100:
vagrant@sysadm-fs:~$ sudo mkfs.ext4 /dev/MyGroup/lv100
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done


12. Смонтируйте этот раздел в любую директорию, например, `/tmp/new`.

**Решение:**

vagrant@sysadm-fs:~$ mkdir /tmp/new
vagrant@sysadm-fs:~$ sudo mount /dev/MyGroup/lv100 /tmp/new/


13. Поместите туда тестовый файл, например, `wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`.

**Решение:**

vagrant@sysadm-fs:~$ cd /tmp/new/
vagrant@sysadm-fs:/tmp/new$

vagrant@sysadm-fs:/tmp/new$ sudo wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
--2023-03-06 08:37:58--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 24439568 (23M) [application/octet-stream]
Saving to: ‘/tmp/new/test.gz’

/tmp/new/test.gz    100%[===================>]  23.31M  4.81MB/s    in 4.8s

2023-03-06 08:38:03 (4.89 MB/s) - ‘/tmp/new/test.gz’ saved [24439568/24439568]


14. Прикрепите вывод `lsblk`.

**Решение:**

vagrant@sysadm-fs:/tmp/new$ sudo lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0   62M  1 loop  /snap/core20/1611
loop1                       7:1    0 67.8M  1 loop  /snap/lxd/22753
loop2                       7:2    0   47M  1 loop  /snap/snapd/16292
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0    2G  0 part  /boot
└─sda3                      8:3    0   62G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0   31G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
│ └─md0                     9:0    0    2G  0 raid1
└─sdb2                      8:18   0  511M  0 part
  └─md1                     9:1    0 1018M  0 raid0
    └─MyGroup-lv100       253:1    0  100M  0 lvm   /tmp/new
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
│ └─md0                     9:0    0    2G  0 raid1
└─sdc2                      8:34   0  511M  0 part
  └─md1                     9:1    0 1018M  0 raid0
    └─MyGroup-lv100       253:1    0  100M  0 lvm   /tmp/new


15. Протестируйте целостность файла:

    ```bash
    root@vagrant:~# gzip -t /tmp/new/test.gz
    root@vagrant:~# echo $?
    0
    ```

**Решение:**

vagrant@sysadm-fs:/tmp/new$ gzip -t /tmp/new/test.gz
vagrant@sysadm-fs:/tmp/new$ echo $?
0


16. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

**Решение:**

vagrant@sysadm-fs:/tmp/new$ sudo pvmove -n lv100 /dev/md1 /dev/md0
  /dev/md1: Moved: 60.00%
  /dev/md1: Moved: 100.00%


17. Сделайте `--fail` на устройство в вашем RAID1 md.

**Решение:**

vagrant@sysadm-fs:/tmp/new$ sudo mdadm --fail /dev/md0 /dev/sdb1
mdadm: set /dev/sdb1 faulty in /dev/md0


18. Подтвердите выводом `dmesg`, что RAID1 работает в деградированном состоянии.

**Решение:**

vagrant@sysadm-fs:/tmp/new$ sudo dmesg | grep md0
[ 1225.600557] md/raid1:md0: not clean -- starting background reconstruction
[ 1225.600577] md/raid1:md0: active with 2 out of 2 mirrors
[ 1225.600828] md0: detected capacity change from 0 to 2144337920
[ 1225.609778] md: resync of RAID array md0
[ 1236.234101] md: md0: resync done.
[ 2090.196951] md/raid1:md0: Disk failure on sdb1, disabling device.
               md/raid1:md0: Operation continuing on 1 devices.


19. Протестируйте целостность файла — он должен быть доступен несмотря на «сбойный» диск:

    ```bash
    root@vagrant:~# gzip -t /tmp/new/test.gz
    root@vagrant:~# echo $?
    0
    ```

**Решение:**

Повторно выполняю команду тестирования целостности файла:
vagrant@sysadm-fs:/tmp/new$ gzip -t /tmp/new/test.gz
vagrant@sysadm-fs:/tmp/new$ echo $?
0


20. Погасите тестовый хост — `vagrant destroy`.
 
**Решение:**

vagrant@sysadm-fs:/tmp/new$ exit
logout
Connection to 127.0.0.1 closed.
users-MacBook-Pro:netology_project user$ vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...


*В качестве решения пришлите ответы на вопросы и опишите, как они были получены.*

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
