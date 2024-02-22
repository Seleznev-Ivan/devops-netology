# Домашнее задание к занятию «Запуск приложений в K8S»

### Цель задания

В тестовой среде для работы с Kubernetes, установленной в предыдущем ДЗ, необходимо развернуть Deployment с приложением, состоящим из нескольких контейнеров, и масштабировать его.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключённым git-репозиторием.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) Deployment и примеры манифестов.
2. [Описание](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) Init-контейнеров.
3. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool.

------

### Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod

1. Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.
2. После запуска увеличить количество реплик работающего приложения до 2.
3. Продемонстрировать количество подов до и после масштабирования.
4. Создать Service, который обеспечит доступ до реплик приложений из п.1.
5. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложений из п.1.

## Решение

Создаю файл конфигурации Deployment:
```bash
ivan@netology-microk8s:~$ nano netology-deployment.yaml
```
![Kubernetes-Deployment-conf1](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.3-Kubernetes-1-Deployment-conf1.jpg)

Запускаю Deployment:
```bash
ivan@netology-microk8s:~$ kubectl apply -f netology-deployment.yaml
deployment.apps/netology-deployment created
```
Проверяю список Deployment:
```bash
ivan@netology-microk8s:~$ kubectl get deployments
NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
nginx                 1/1     1            1           46h
netology-deployment   0/1     1            0           65s
```
Deployment не поднялся. Согласно документации multitool поднимает веб-сервер на порту 80 и возникает конфликт. Для устранения проблемы нужно добавить переменную окружения HTTP_PORT в yaml файл:
![Kubernetes-Deployment-conf2](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.3-Kubernetes-1-Deployment-conf2.jpg)

Повторно запускаю Deployment:
```bash
ivan@netology-microk8s:~$ kubectl apply -f netology-deployment.yaml
deployment.apps/netology-deployment configured
```
Проверяю список Deployment и видно, что netology-deployment поднялся:
```bash
ivan@netology-microk8s:~$ kubectl get deployments
NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
nginx                 1/1     1            1           46h
netology-deployment   1/1     1            1           6m
```

Проверяю список подов:

![Kubernetes-Deployment-1repl](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.3-Kubernetes-1-Deployment-1repl.jpg)

Для увеличения количества реплик до 2 нужно поменять параметр spec:
  replicas: 1 на 2 в файле netology-deployment.yaml и запустить заново. Проверяю список  подов:
![Kubernetes-Deployment-2repl](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.3-Kubernetes-1-Deployment-2repl.jpg)

Создаю Service, который обеспечит доступ до реплик приложений nginx и multitool
```bash
ivan@netology-microk8s:~$ nano netology-service.yaml
```
![Kubernetes-Service-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.3-Kubernetes-1-Service-conf.jpg)

Запускаю сервис:

```bash
ivan@netology-microk8s:~$ kubectl apply -f netology-service.yaml
service/netology-svc configured
```
Проверяю список сервисов:

![Kubernetes-ServiceGet](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.3-Kubernetes-1-ServiceGet.jpg)

Создаю отдельный Pod с приложением multitool:

```bash
ivan@netology-microk8s:~$ nano netology-pod.yaml
```
![Kubernetes-Pod-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.3-Kubernetes-1-Pod-conf.jpg)
```bash
ivan@netology-microk8s:~$ kubectl apply -f netology-pod.yaml
```
Проверяю с помощью curl доступность сервиса nginx и multitool:

![Kubernetes-CurlSVC](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.3-Kubernetes-1-CurlSVC.jpg)

------

### Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения.
2. Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox.
3. Создать и запустить Service. Убедиться, что Init запустился.
4. Продемонстрировать состояние пода до и после запуска сервиса.

## Решение

Создаю Deployment приложение:
```bash
ivan@netology-microk8s:~$ nano netology-deployment-init.yaml
```
![Kubernetes-Deploy-init-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.3-Kubernetes-2-deploy-init-conf2.jpg)

Запускаю:
```bash
ivan@netology-microk8s:~$ kubectl apply -f netology-deployment-init.yaml
deployment.apps/netology-deployment-init created
```
Проверяю список подов и netology-deployment-init не стартует:
![Kubernetes-pods-init](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.3-Kubernetes-2-pods-init.jpg)

Создаю сервис:
```bash
ivan@netology-microk8s:~$ nano netology-svc-init.yaml
```
![Kubernetes-svc-init-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.3-Kubernetes-2-svc-init-conf.jpg)


ivan@netology-microk8s:~$ kubectl apply -f netology-svc-init.yaml
![Kubernetes-pods-init2](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-1.3-Kubernetes-2-pods-init2.jpg)

------

### Правила приема работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl` и скриншоты результатов.
3. Репозиторий должен содержать файлы манифестов и ссылки на них в файле README.md.

------
