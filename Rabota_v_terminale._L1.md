# Домашнее задание к занятию "Работа в терминале. Лекция 1"

### Цель задания

В результате выполнения этого задания вы:
1. Научитесь работать с базовым функционалом инструмента VirtualBox, который помогает с быстрой разверткой виртуальных машин.
2. Научитесь работать с документацией в формате man, чтобы ориентироваться в этом полезном и мощном инструменте документации.
3. Ознакомитесь с функциями Bash (PATH, HISTORY, batch/at), которые помогут комфортно работать с оболочкой командной строки (шеллом) и понять некоторые его ограничения.


### Инструкция к заданию

1. Установите средство виртуализации [Oracle VirtualBox](https://www.virtualbox.org/).

1. Установите средство автоматизации [Hashicorp Vagrant](https://hashicorp-releases.yandexcloud.net/vagrant/).

1. В вашем основном окружении подготовьте удобный для дальнейшей работы терминал. Можно предложить:

	* iTerm2 в Mac OS X
	* Windows Terminal в Windows
	* выбрать цветовую схему, размер окна, шрифтов и т.д.
	* почитать о кастомизации PS1/применить при желании.

	Несколько популярных проблем:
	* Добавьте Vagrant в правила исключения перехватывающих трафик для анализа антивирусов, таких как Kaspersky, если у вас возникают связанные с SSL/TLS ошибки,
	* MobaXterm может конфликтовать с Vagrant в Windows,
	* Vagrant плохо работает с директориями с кириллицей (может быть вашей домашней директорией), тогда можно либо изменить [VAGRANT_HOME](https://www.vagrantup.com/docs/other/environmental-variables#vagrant_home), либо создать в системе профиль пользователя с английским именем,
	* VirtualBox конфликтует с Windows Hyper-V и его необходимо [отключить](https://www.vagrantup.com/docs/installation#windows-virtualbox-and-hyper-v),
	* [WSL2](https://docs.microsoft.com/ru-ru/windows/wsl/wsl2-faq#does-wsl-2-use-hyper-v-will-it-be-available-on-windows-10-home) использует Hyper-V, поэтому с ним VirtualBox также несовместим,
	* аппаратная виртуализация (Intel VT-x, AMD-V) должна быть активна в BIOS,
	* в Linux при установке [VirtualBox](https://www.virtualbox.org/wiki/Linux_Downloads) может дополнительно потребоваться пакет `linux-headers-generic` (debian-based) / `kernel-devel` (rhel-based).


### Инструменты/ дополнительные материалы, которые пригодятся для выполнения задания

1. [Конфигурация VirtualBox через Vagrant](https://www.vagrantup.com/docs/providers/virtualbox/configuration.html)
2. [Использование условий в Bash](https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html)

------

## Задание

1. С помощью базового файла конфигурации запустите Ubuntu 20.04 в VirtualBox посредством Vagrant:

	* Создайте директорию, в которой будут храниться конфигурационные файлы Vagrant. В ней выполните `vagrant init`. Замените содержимое Vagrantfile по умолчанию следующим:

		```bash
		Vagrant.configure("2") do |config|
			config.vm.box = "bento/ubuntu-20.04"
		end
		```

	* Выполнение в этой директории `vagrant up` установит провайдер VirtualBox для Vagrant, скачает необходимый образ и запустит виртуальную машину.

	* `vagrant suspend` выключит виртуальную машину с сохранением ее состояния (т.е., при следующем `vagrant up` будут запущены все процессы внутри, которые работали на момент вызова suspend), `vagrant halt` выключит виртуальную машину штатным образом.

**Решение:**
Установил VirtualBox, скачал через VPN  Vagrant  и установил. Создал каталог, в нем конфигфайл, на основе которого закачался образ виртуальной машины Ubuntu.

2. Ознакомьтесь с графическим интерфейсом VirtualBox, посмотрите как выглядит виртуальная машина, которую создал для вас Vagrant, какие аппаратные ресурсы ей выделены. Какие ресурсы выделены по-умолчанию?

**Решение:**
По умолчанию виртуальной машине Ubuntu выделены: оперативная память 1024 Mb, 2 процессора, жесткий диск, оптический привод, видеоадаптер 4 Mb, сеть Nat.
![VirtualBox](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/3.1-1.jpg)


3. Ознакомьтесь с возможностями конфигурации VirtualBox через Vagrantfile: [документация](https://www.vagrantup.com/docs/providers/virtualbox/configuration.html). Как добавить оперативной памяти или ресурсов процессора виртуальной машине?

**Решение:**
Чтобы добавить оперативной памяти и дополнительных виртуальных процессоров нужно внести изменения в Vagrantfile:

```bash
Vagrant.configure("2") do |config|
        config.vm.box = "bento/ubuntu-20.04"
        config.vm.provider "virtualbox" do |vbox|
        vbox.memory = "1280"
        vbox.cpus = "3"
        end
 end
```
![VirtualBox](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/3.1-2.jpg)

4. Команда `vagrant ssh` из директории, в которой содержится Vagrantfile, позволит вам оказаться внутри виртуальной машины без каких-либо дополнительных настроек. Попрактикуйтесь в выполнении обсуждаемых команд в терминале Ubuntu.

**Решение:**
С помощью команды `vagrant ssh` подключился к консоли. В консоле выполнил несколько команд:

```bash
users-MacBook-Pro:netology_project user$ vagrant ssh
Welcome to Ubuntu 20.04.5 LTS (GNU/Linux 5.4.0-135-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Mon 20 Feb 2023 10:10:58 PM UTC

  System load:  0.93               Processes:             116
  Usage of /:   11.6% of 30.34GB   Users logged in:       0
  Memory usage: 16%                IPv4 address for eth0: 10.0.2.15
  Swap usage:   0%

This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Mon Feb 20 22:07:23 2023 from 10.0.2.2
vagrant@vagrant:~$  who
vagrant  pts/0        2023-02-20 22:10 (10.0.2.2)
vagrant@vagrant:~$ df -h
Filesystem                         Size  Used Avail Use% Mounted on
udev                               570M     0  570M   0% /dev
tmpfs                              123M  972K  122M   1% /run
/dev/mapper/ubuntu--vg-ubuntu--lv   31G  3.6G   26G  13% /
tmpfs                              614M     0  614M   0% /dev/shm
tmpfs                              5.0M     0  5.0M   0% /run/lock
tmpfs                              614M     0  614M   0% /sys/fs/cgroup
/dev/loop1                          62M   62M     0 100% /snap/core20/1611
/dev/loop0                          68M   68M     0 100% /snap/lxd/22753
/dev/loop2                          47M   47M     0 100% /snap/snapd/16292
/dev/sda2                          2.0G  106M  1.7G   6% /boot
vagrant                            234G   81G  154G  35% /vagrant
tmpfs                              123M     0  123M   0% /run/user/1000
vagrant@vagrant:~$ ls -lah
total 40K
drwxr-xr-x 4 vagrant vagrant 4.0K Feb 20 22:10 .
drwxr-xr-x 3 root    root    4.0K Dec 11 06:31 ..
-rw------- 1 vagrant vagrant   55 Feb 20 22:10 .bash_history
-rw-r--r-- 1 vagrant vagrant  220 Feb 25  2020 .bash_logout
-rw-r--r-- 1 vagrant vagrant 3.7K Feb 25  2020 .bashrc
drwx------ 2 vagrant vagrant 4.0K Dec 11 06:32 .cache
-rw-r--r-- 1 vagrant vagrant  807 Feb 25  2020 .profile
drwx------ 2 vagrant vagrant 4.0K Feb 19 21:13 .ssh
-rw-r--r-- 1 vagrant vagrant    0 Dec 11 06:32 .sudo_as_admin_successful
-rw-r--r-- 1 vagrant vagrant    6 Dec 11 06:32 .vbox_version
-rw-r--r-- 1 root    root     180 Dec 11 06:35 .wget-hsts
vagrant@vagrant:~$ sudo apt install mc
```

5. Ознакомьтесь с разделами `man bash`, почитайте о настройках самого bash:
    * какой переменной можно задать длину журнала `history`, и на какой строчке manual это описывается?
    * что делает директива `ignoreboth` в bash?

**Решение:**
Количество команд, хранимых в `history`  определяет параметр `HISTSIZE`, описанный в строке 1040 руководства `man`. Директива `ignoreboth` не сохраняет строки, начинающиеся с пробела и строки, совпадающие с последней командой, т.е. объединяет 2 директивы  `ignorespace` и `ignoredups` параметра `HISTCONTROL`.

6. В каких сценариях использования применимы скобки `{}` и на какой строчке `man bash` это описано?

**Решение:**
Фигурные скобки {} позволяют облегчить использование однотипных команд. Например команда `rm {1..10}` удалит 10 файлов сразу, а не удаляет их по отдельности командами `rm 1`, `rm 2` и т.д.

7. С учётом ответа на предыдущий вопрос, как создать однократным вызовом `touch` 100000 файлов? Получится ли аналогичным образом создать 300000? Если нет, то почему?

**Решение:**
Команда `touch {1..100000}` позволяет создать 100000 файлов, но уже аналогичная команда, но с большим значением `touch {1..300000}` выдаст сообщение `-bash: /usr/bin/touch: Argument list too long`, из-за того, что файлов указано больше, чем допустимый лимит.

8. В man bash поищите по `/\[\[`. Что делает конструкция `[[ -d /tmp ]]`

**Решение:**
Конструкция в квадратных скобках  `[[ -d /tmp ]]` содержит команду проверки существования директории `/tmp`. Для проверки выполнения можно выполнить команду `echo $?` и результатом будет 0 (истина). 
Например можно выполнить команду `[[ -d /tmp123 ]]` и после проверить `echo $?` – результатом будет 1 (ложь), что означает, что каталога `/tmp123` не существует.

9. Сделайте так, чтобы в выводе команды `type -a bash` первым стояла запись с нестандартным путем, например bash is ... 
Используйте знания о просмотре существующих и создании новых переменных окружения, обратите внимание на переменную окружения PATH 

	```bash
	bash is /tmp/new_path_directory/bash
	bash is /usr/local/bin/bash
	bash is /bin/bash
	```

	(прочие строки могут отличаться содержимым и порядком)
    В качестве ответа приведите команды, которые позволили вам добиться указанного вывода или соответствующие скриншоты.
    
**Решение:**

Мои команды:

```bash
vagrant@vagrant:~$ type -a bash
bash is /usr/bin/bash
bash is /bin/bash
vagrant@vagrant:~$ sudo mkdir /var/testbash
vagrant@vagrant:~$ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
vagrant@vagrant:~$ export PATH="/var/testbash:$PATH"
vagrant@vagrant:~$ echo $PATH
/var/testbash:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
vagrant@vagrant:~$ type -a bash
bash is /usr/bin/bash
bash is /bin/bash
vagrant@vagrant:~$ sudo cp /usr/bin/bash /var/testbash/bash
vagrant@vagrant:~$ type -a bash
bash is /var/testbash/bash
bash is /usr/bin/bash
bash is /bin/bash
```

10. Чем отличается планирование команд с помощью `batch` и `at`?

**Решение:**
Команда `batch`  не планирует задачи на определенное время как `at`, а добавляет задания в очередь и выполняет их, когда средняя загрузка системы ниже 1,5.
Загрузку можно посмотреть командой `htop` или `top`.


11. Завершите работу виртуальной машины чтобы не расходовать ресурсы компьютера и/или батарею ноутбука.

**Решение:**
Командой `vagrant halt` выключил виртуальную машину

*В качестве решения дайте ответы на вопросы свободной форме* 

---

### Правила приема домашнего задания

- В личном кабинете отправлена ссылка на .md файл в вашем репозитории.

### Критерии оценки

Зачет - выполнены все задания, ответы даны в развернутой форме, приложены соответствующие скриншоты и файлы проекта, в выполненных заданиях нет противоречий и нарушения логики.

На доработку - задание выполнено частично или не выполнено, в логике выполнения заданий есть противоречия, существенные недостатки. 
