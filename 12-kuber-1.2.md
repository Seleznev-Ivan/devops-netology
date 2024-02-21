# Домашнее задание к занятию «Базовые объекты K8S»

### Цель задания

В тестовой среде для работы с Kubernetes, установленной в предыдущем ДЗ, необходимо развернуть Pod с приложением и подключиться к нему со своего локального компьютера. 

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключенным Git-репозиторием.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. Описание [Pod](https://kubernetes.io/docs/concepts/workloads/pods/) и примеры манифестов.
2. Описание [Service](https://kubernetes.io/docs/concepts/services-networking/service/).

------

### Задание 1. Создать Pod с именем hello-world

1. Создать манифест (yaml-конфигурацию) Pod.
2. Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Подключиться локально к Pod с помощью `kubectl port-forward` и вывести значение (curl или в браузере).

## Решение

Создаю файл конфигурации Pod:
```bash
ivan@netology-microk8s:~$ nano hello-world.yaml
```
![Kubernetes-conf-Pod](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.2-%20Kubernetes-Pod1.jpg)

Проверяю список Pod:

![Kubernetes-get-Pod](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.2-%20Kubernetes-getPod.jpg)

Подключаюсь локально к Pod:

![Kubernetes-Pod-port-forward](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.2-%20Kubernetes-Pod-port-forward.jpg)

![Kubernetes-Pod-port-forward2](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.2-%20Kubernetes-Pod-port-forward2.jpg)

------

### Задание 2. Создать Service и подключить его к Pod

1. Создать Pod с именем netology-web.
2. Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Создать Service с именем netology-svc и подключить к netology-web.
4. Подключиться локально к Service с помощью `kubectl port-forward` и вывести значение (curl или в браузере).

## Решение

Создаю файл конфигурации Pod:
```bash
ivan@netology-microk8s:~$ nano netology-web.yaml
```
![Kubernetes-conf-PodS](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.2-%20Kubernetes-Pod-conf.jpg)

Запускаю Pod:
```bash
ivan@netology-microk8s:~$ kubectl apply -f netology-web.yaml
pod/netology-web created
```
Проверяю список Pod:

![Kubernetes-get-PodS](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.2-%20Kubernetes-Pod2.jpg)

Создаю файл конфигурации Service:
```bash
ivan@netology-microk8s:~$ nano netology-svc.yaml
```
![Kubernetes-Service-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.2-%20Kubernetes-Service-conf.jpg)

Запускаю Service:
```bash
ivan@netology-microk8s:~$ kubectl apply -f netology-svc.yaml
service/netology-svc created
```
Проверяю список Service:

![Kubernetes-get-Service](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.2-%20Kubernetes-getService.jpg)

Более подробная информация о Service:

![Kubernetes-dec-Service](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.2-%20Kubernetes-decService.jpg)

Подключаюсь локально к Service:

![Kubernetes-Service-port-forward](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.2-%20Kubernetes-Service-port-forward.jpg)
![Kubernetes-Service-port-forward2](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.2-%20Kubernetes-Service-port-forward2.jpg)

------

### Правила приёма работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода команд `kubectl get pods`, а также скриншот результата подключения.
3. Репозиторий должен содержать файлы манифестов и ссылки на них в файле README.md.

------

### Критерии оценки
Зачёт — выполнены все задания, ответы даны в развернутой форме, приложены соответствующие скриншоты и файлы проекта, в выполненных заданиях нет противоречий и нарушения логики.

На доработку — задание выполнено частично или не выполнено, в логике выполнения заданий есть противоречия, существенные недостатки.
