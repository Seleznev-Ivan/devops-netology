# Домашнее задание к занятию «Конфигурация приложений»

### Цель задания

В тестовой среде Kubernetes необходимо создать конфигурацию и продемонстрировать работу приложения.

------

### Чеклист готовности к домашнему заданию

1. Установленное K8s-решение (например, MicroK8s).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключённым GitHub-репозиторием.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/concepts/configuration/secret/) Secret.
2. [Описание](https://kubernetes.io/docs/concepts/configuration/configmap/) ConfigMap.
3. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool.

------

### Задание 1. Создать Deployment приложения и решить возникшую проблему с помощью ConfigMap. Добавить веб-страницу

1. Создать Deployment приложения, состоящего из контейнеров nginx и multitool.
2. Решить возникшую проблему с помощью ConfigMap.
3. Продемонстрировать, что pod стартовал и оба конейнера работают.
4. Сделать простую веб-страницу и подключить её к Nginx с помощью ConfigMap. Подключить Service и показать вывод curl или в браузере.
5. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

## Решение

Конфигурационный файл Deployment приложения:

![Kubernetes-deployment-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.3-Kubernetes-1-netology-deployment-conf.jpg)

Конфигурационный файл ConfigMap:

![Kubernetes-configmap-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.3-Kubernetes-1-netology-configmap-conf.jpg)

Pod стартовал и оба конейнера работают:

![Kubernetes-netology-pods](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.3-Kubernetes-1-netology-pods.jpg)

Конфигурационный файл Service:

![Kubernetes-netology-svc-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.3-Kubernetes-1-netology-svc-conf.jpg)

Вывод страницы при помощи curl:

![Kubernetes-netology-curl](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.3-Kubernetes-1-netology-curl.jpg)
------

### Задание 2. Создать приложение с вашей веб-страницей, доступной по HTTPS 

1. Создать Deployment приложения, состоящего из Nginx.
2. Создать собственную веб-страницу и подключить её как ConfigMap к приложению.
3. Выпустить самоподписной сертификат SSL. Создать Secret для использования сертификата.
4. Создать Ingress и необходимый Service, подключить к нему SSL в вид. Продемонстировать доступ к приложению по HTTPS. 
4. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

## Решение

Конфигурационный файл Deployment приложения Nginx:

![Kubernetes-deployment2-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.3-Kubernetes-2-netology-deployment2-conf.jpg)

Конфигурационный файл ConfigMap:

![Kubernetes-configmap2-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.3-Kubernetes-2-netology-configmap2-conf.jpg)

Выпускаю самоподписной сертификат SSL:

![Kubernetes-netology-certf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.3-Kubernetes-2-netology-certf.jpg)

Создаю Secret для использования сертификата:

![Kubernetes-secret](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.3-Kubernetes-2-netology-secret.jpg)

Конфигурационный файл Ingress:

![Kubernetes-ingress-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.3-Kubernetes-2-netology-ingress-conf.jpg)

Конфигурационный файл Service:

![Kubernetes-svc2-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.3-Kubernetes-2-netology-svc2-conf.jpg)

Список запущенных Service:

![Kubernetes-svc2-get](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.3-Kubernetes-2-netology-svc2-get.jpg)

Проверяю вывод страницы при помощи curl. Но появляется ошибка, что не удалось проверить легитимность сервера, т.к. используется самоподписанный сертификат. Но с параметром `-k` можно отключите строгую проверку сертификатов:

![Kubernetes-curl](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.3-Kubernetes-2-netology-curl.jpg)
------

### Правила приёма работы

1. Домашняя работа оформляется в своём GitHub-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

------
