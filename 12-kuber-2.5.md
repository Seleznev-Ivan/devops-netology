# Домашнее задание к занятию «Helm»

### Цель задания

В тестовой среде Kubernetes необходимо установить и обновить приложения с помощью Helm.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение, например, MicroK8S.
2. Установленный локальный kubectl.
3. Установленный локальный Helm.
4. Редактор YAML-файлов с подключенным репозиторием GitHub.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Инструкция](https://helm.sh/docs/intro/install/) по установке Helm. [Helm completion](https://helm.sh/docs/helm/helm_completion/).

------

### Задание 1. Подготовить Helm-чарт для приложения

1. Необходимо упаковать приложение в чарт для деплоя в разные окружения. 
2. Каждый компонент приложения деплоится отдельным deployment’ом или statefulset’ом.
3. В переменных чарта измените образ приложения для изменения версии.


## Решение

Создаю чарт app-netology:

![Kubernetes-helm-create](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.5-Kubernetes-1-helm-create.jpg)

Helm создаст новую директорию app-netology со структурой:

![Kubernetes-helm-chart](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.5-Kubernetes-1-helm-chart.jpg)

Устанавливаю чарт:

![Kubernetes-helm-install](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.5-Kubernetes-1-helm-install.jpg)

В переменных меняю версию образа приложения:

![Kubernetes-helm-chart-ver](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.5-Kubernetes-1-helm-chart-ver.jpg)

Обновляю чарт и проверяю, что версия поменялась:

![Kubernetes-helm-install-upg](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.5-Kubernetes-1-helm-install-upg.jpg)

Также убираю предупреждение Kubernetes, поправив права на конфиг:

![Kubernetes-helm-install-upg2](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.5-Kubernetes-1-helm-install-upg2.jpg)

------
### Задание 2. Запустить две версии в разных неймспейсах

1. Подготовив чарт, необходимо его проверить. Запуститe несколько копий приложения.
2. Одну версию в namespace=app1, вторую версию в том же неймспейсе, третью версию в namespace=app2.
3. Продемонстрируйте результат.


## Решение

Создаю namespace=app1 и устанавливаю приложение:

![Kubernetes-helm-app1](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.5-Kubernetes-2-helm-app1.jpg)

В этом же namespace устанавливаю приложение с другой версией:

![Kubernetes-helm-app2](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.5-Kubernetes-2-helm-app2.jpg)

Создаю namespace=app2 и устанавливаю приложение с ещё одной версией:

![Kubernetes-helm-app3](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.5-Kubernetes-2-helm-app3.jpg)

Проверяю список всех запущенных приложений с версиями:

![Kubernetes-helm-list](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.5-Kubernetes-2-helm-list.jpg)

### Правила приёма работы

1. Домашняя работа оформляется в своём Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, `helm`, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.
