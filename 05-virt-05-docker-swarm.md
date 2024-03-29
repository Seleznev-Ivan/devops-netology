# Домашнее задание к занятию 5. «Оркестрация кластером Docker контейнеров на примере Docker Swarm»

## Как сдавать задания

Обязательны к выполнению задачи без звёздочки. Их нужно выполнить, чтобы получить зачёт и диплом о профессиональной переподготовке.

Задачи со звёдочкой (*) — это дополнительные задачи и/или задачи повышенной сложности. Их выполнять не обязательно, но они помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в GitHub-репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Любые вопросы по решению задач задавайте в чате учебной группы.

---


## Важно

1. Перед отправкой работы на проверку удаляйте неиспользуемые ресурсы.
Это нужно, чтобы не расходовать средства, полученные в результате использования промокода.
Подробные рекомендации [здесь](https://github.com/netology-code/virt-homeworks/blob/virt-11/r/README.md).

2. [Ссылки для установки открытого ПО](https://github.com/netology-code/devops-materials/blob/master/README.md).

---

## Задача 1

Дайте письменые ответы на вопросы:

- В чём отличие режимов работы сервисов в Docker Swarm-кластере: replication и global?
- Какой алгоритм выбора лидера используется в Docker Swarm-кластере?
- Что такое Overlay Network?

## Решение
1) Режим работы `global` - один контейнер запускается на каждом доступном узле в
кластере и заранее заданного количества реплик нет.
Режим работы `replication` - здесь указанное количество реплицируемых контейнеров
распределяются между узлами на основе стратегии планированния
3) В Docker Swarm-кластере применяется алгоритм выбора лидера Raft - это алгоритм поддержания распределенного консенсуса.

4) Overlay Network - это сеть, которая располагается поверх сетей, специфичных для хоста, позволяя подключенным к ней контейнерам (включая служебные контейнеры swarm) безопасно обмениваться данными при включенном шифровании.

## Задача 2

Создайте ваш первый Docker Swarm-кластер в Яндекс Облаке.

Чтобы получить зачёт, предоставьте скриншот из терминала (консоли) с выводом команды:
```
docker node ls
```
## Решение

![service_svr](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/05-virt-05_2.1.0.jpg)
![service_node](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/05-virt-05_2.1.1.jpg)

## Задача 3

Создайте ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.

Чтобы получить зачёт, предоставьте скриншот из терминала (консоли), с выводом команды:
```
docker service ls
```
## Решение

![service_ls](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/05-virt-05_2.2.jpg)

## Задача 4 (*)

Выполните на лидере Docker Swarm-кластера команду, указанную ниже, и дайте письменное описание её функционала — что она делает и зачем нужна:
```
# см.документацию: https://docs.docker.com/engine/swarm/swarm_manager_locking/
docker swarm update --autolock=true
```
## Решение

Команда `docker swarm update --autolock=true` включает автоматическую блокировку существующего swarm.

При перезапуске Docker в память каждого управляющего узла загружаются как ключ TLS, используемый для шифрования связи между узлами swarm, так и ключ, используемый для шифрования и дешифрования журналов Raft на диске. Docker имеет возможность защитить взаимный ключ шифрования TLS и ключ, используемый для шифрования и дешифрования журналов Raft в состоянии покоя, позволяя вам стать владельцем этих ключей и потребовать разблокировки ваших менеджеров вручную. Эта функция называется автоматической блокировкой.
