
# Домашнее задание к занятию 2. «Применение принципов IaaC в работе с виртуальными машинами»

## Как сдавать задания

Обязательны к выполнению задачи без звёздочки. Их нужно выполнить, чтобы получить зачёт и диплом о профессиональной переподготовке.

Задачи со звёздочкой (*) — дополнительные задачи и/или задачи повышенной сложности. Их выполнять не обязательно, но они помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в GitHub-репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Любые вопросы по решению задач задавайте в чате учебной группы.

---


## Важно

Перед отправкой работы на проверку удаляйте неиспользуемые ресурсы.
Это нужно, чтобы не расходовать средства, полученные в результате использования промокода.

Подробные рекомендации [здесь](https://github.com/netology-code/virt-homeworks/blob/virt-11/r/README.md).

---

## Задача 1

- Опишите основные преимущества применения на практике IaaC-паттернов.

```
- Скорость и уменьшение затрат. 
IaaC паттерны позволяют быстрее конфигурировать инфраструктуру и направлены на обеспечение прозрачности, чтобы помочь другим командам работать быстрее и эффективнее. 
Это освобождает дорогостоящие ресурсы для выполнения других важных задач.
- Масштабируемость и стандартизация. 
Развертывания инфраструктуры с помощью IaaC повторяемы и предотвращают проблемы во время выполнения, вызванных дрейфом конфигурации или отсутствием зависимостей. 
IaaC полностью стандартизирует установку инфраструктуры, что снижает вероятность ошибок или отклонений.
- Безопасность и документация. 
Программный код отвечает за провизионирование всех вычислительных, сетевых и служб хранения и  каждый раз будут развертываться одинаково, что означает, 
что стандарты безопасности можно легко и последовательно применять в разных компаниях. Код можно версионировать и  IaaC  позволяет документировать, регистрировать и отслеживать каждое изменение конфигурации требуемого узла.
- Восстановление в аварийных ситуациях. 
IaaC чрезвычайно эффективный способ отслеживания инфраструктуры и повторного развертывания последнего работоспособного состояния после сбоя или поломки любого рода.
```
- Какой из принципов IaaC является основополагающим?

```
Основополагающим принципом IaaC является идемпотентность. 
Это способность возвращать идентичный результат при многократном выполнении одной и той же операции.
```
## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?

```
- Нет необходимости устанавливать клиента (агента) на управляемый узел.
- Написан на Python, который является одним из самых распросраненных языков программирования. 
Также Ansible поддерживает написание модулей на любом языке программирования. 
- Легко настраивается, запускается, не сложен в изучении.
- Большое сообщество, где люди делятся наработками и решениями той или иной задачи.
```

- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный — push или pull?

```
Мне кажется, что более надежный метод push, когда конфигурация отправляется центральным управляющим сервером на целевые узлы.
```

## Задача 3

Установите на личный компьютер:

- [VirtualBox](https://www.virtualbox.org/),
- [Vagrant](https://github.com/netology-code/devops-materials),
- [Terraform](https://github.com/netology-code/devops-materials/blob/master/README.md),
- Ansible.

VirtualBox:
```bash
users-MacBook-Pro:~ user$ virtualbox --help
Oracle VM VirtualBox VM Selector v7.0.6
Copyright (C) 2005-2023 Oracle and/or its affiliates
```
Vagrant:
```bash
users-MacBook-Pro:~ user$ vagrant -v
Vagrant 2.3.6
```
Terraform:
```bash
users-MacBook-Pro:~ user$ terraform -v
Terraform v1.4.6
on darwin_amd64
```
Ansible:
```bash
users-MacBook-Pro:~ user$ ansible --version
ansible [core 2.15.0]
  config file = None
  configured module search path = ['/Users/user/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.11/site-packages/ansible
  ansible collection location = /Users/user/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/local/bin/ansible
  python version = 3.11.3 (main, May 24 2023, 13:34:40) [Clang 12.0.0 (clang-1200.0.32.29)] (/usr/local/opt/python@3.11/bin/python3.11)
  jinja version = 3.1.2
  libyaml = True
  ```


*Приложите вывод команд установленных версий каждой из программ, оформленный в Markdown.*

## Задача 4 

Воспроизведите практическую часть лекции самостоятельно.

- Создайте виртуальную машину.
- Зайдите внутрь ВМ, убедитесь, что Docker установлен с помощью команды
```
docker ps,
```
Vagrantfile из лекции и код ansible находятся в [папке](https://github.com/netology-code/virt-homeworks/tree/virt-11/05-virt-02-iaac/src).

Примечание. Если Vagrant выдаёт ошибку:
```
URL: ["https://vagrantcloud.com/bento/ubuntu-20.04"]     
Error: The requested URL returned error: 404:
```

выполните следующие действия:

1. Скачайте с [сайта](https://app.vagrantup.com/bento/boxes/ubuntu-20.04) файл-образ "bento/ubuntu-20.04".
2. Добавьте его в список образов Vagrant: "vagrant box add bento/ubuntu-20.04 <путь к файлу>".


**Решение:**
```bash
users-MacBook-Pro:~ user$ cd /Users/user/Documents/iaac/vagrant
users-MacBook-Pro:vagrant user$ vagrant ssh
Welcome to Ubuntu 20.04.5 LTS (GNU/Linux 5.4.0-135-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sat 03 Jun 2023 09:01:34 AM UTC

  System load:  0.0                Users logged in:          0
  Usage of /:   13.4% of 30.34GB   IPv4 address for docker0: 172.17.0.1
  Memory usage: 23%                IPv4 address for eth0:    10.0.2.15
  Swap usage:   0%                 IPv4 address for eth1:    192.168.56.11
  Processes:    107


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Sat Jun  3 08:54:27 2023 from 10.0.2.2
vagrant@server1:~$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
vagrant@server1:~$
```
