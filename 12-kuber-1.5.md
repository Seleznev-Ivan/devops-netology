# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 2»

### Цель задания

В тестовой среде Kubernetes необходимо обеспечить доступ к двум приложениям снаружи кластера по разным путям.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключённым Git-репозиторием.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Инструкция](https://microk8s.io/docs/getting-started) по установке MicroK8S.
2. [Описание](https://kubernetes.io/docs/concepts/services-networking/service/) Service.
3. [Описание](https://kubernetes.io/docs/concepts/services-networking/ingress/) Ingress.
4. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool.

------

### Задание 1. Создать Deployment приложений backend и frontend

1. Создать Deployment приложения _frontend_ из образа nginx с количеством реплик 3 шт.
2. Создать Deployment приложения _backend_ из образа multitool. 
3. Добавить Service, которые обеспечат доступ к обоим приложениям внутри кластера. 
4. Продемонстрировать, что приложения видят друг друга с помощью Service.
5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.

## Решение

Создаю файл конфигурации Deployment приложения frontend:

![Kubernetes-deployment-frontend-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.5-Kubernetes-1-netology-dep-frontend-conf.jpg)

Создаю файл конфигурации Deployment приложения backend:

![Kubernetes-deployment-backend-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.5-Kubernetes-1-netology-dep-backend-conf.jpg)

Запускаю и проверяю список Deployment:

![Kubernetes-deployment-get](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.5-Kubernetes-1-netology-dep-get.jpg)

Создаю файл конфигурации Service приложения frontend:

![Kubernetes-svc-frontend-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.5-Kubernetes-1-netology-svc-frontend-conf.jpg)

Создаю файл конфигурации Service приложения backend:

![Kubernetes-svc-backend-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.5-Kubernetes-1-netology-svc-backend-conf.jpg)

Запускаю и проверяю список Service:

![Kubernetes-svc-get](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.5-Kubernetes-1-netology-svc-get.jpg)

Запускаю и проверяю список Pod:

![Kubernetes-pods-get](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.5-Kubernetes-1-netology-pods-get.jpg)

Проверяю доступность приложений с помощью Service:

![Kubernetes-exec](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.5-Kubernetes-1-netology-exec.jpg)

------

### Задание 2. Создать Ingress и обеспечить доступ к приложениям снаружи кластера

1. Включить Ingress-controller в MicroK8S.
2. Создать Ingress, обеспечивающий доступ снаружи по IP-адресу кластера MicroK8S так, чтобы при запросе только по адресу открывался _frontend_ а при добавлении /api - _backend_.
3. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.
4. Предоставить манифесты и скриншоты или вывод команды п.2.

## Решение

Включаю Ingress-controller в MicroK8S:

![Kubernetes-ingress-enb](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.5-Kubernetes-2-netology-ingress-enb.jpg)

Создаю файл конфигурации Ingress:

![Kubernetes-ingress-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.5-Kubernetes-2-netology-ingress-conf.jpg)

Запускаю и проверяю список Ingress:

![Kubernetes-ingress-get](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.5-Kubernetes-2-netology-ingress-get.jpg)

Чтобы обращаться к Ingress-controllerу по имени добавляю запись в host-файл:

![Kubernetes-hosts](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.5-Kubernetes-2-netology-hosts.jpg)

Проверяю доступность приложений:

![Kubernetes-ingress-curl](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.5-Kubernetes-2-netology-ingress-curl.jpg)

------

### Правила приема работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl` и скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

------
