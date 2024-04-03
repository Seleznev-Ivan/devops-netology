# Домашнее задание к занятию «Хранение в K8s. Часть 2»

### Цель задания

В тестовой среде Kubernetes нужно создать PV и продемострировать запись и хранение файлов.

------

### Чеклист готовности к домашнему заданию

1. Установленное K8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключенным GitHub-репозиторием.

------

### Дополнительные материалы для выполнения задания

1. [Инструкция по установке NFS в MicroK8S](https://microk8s.io/docs/nfs). 
2. [Описание Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/). 
3. [Описание динамического провижининга](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/). 
4. [Описание Multitool](https://github.com/wbitt/Network-MultiTool).

------

### Задание 1

**Что нужно сделать**

Создать Deployment приложения, использующего локальный PV, созданный вручную.

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
2. Создать PV и PVC для подключения папки на локальной ноде, которая будет использована в поде.
3. Продемонстрировать, что multitool может читать файл, в который busybox пишет каждые пять секунд в общей директории. 
4. Удалить Deployment и PVC. Продемонстрировать, что после этого произошло с PV. Пояснить, почему.
5. Продемонстрировать, что файл сохранился на локальном диске ноды. Удалить PV.  Продемонстрировать что произошло с файлом после удаления PV. Пояснить, почему.
5. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

## Решение

Конфигурационный файл Deployment приложения:
   
![Kubernetes-deployment-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.2-Kubernetes-1-netology-deployment-conf.jpg)

Конфигурационный файл PV:

![Kubernetes-pv-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.2-Kubernetes-1-netology-pv-conf.jpg)

Конфигурационный файл PVC:

![Kubernetes-pvc-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.2-Kubernetes-1-netology-pvc-conf.jpg)

Демонстрация чтения файла:

![Kubernetes-multitool](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.2-Kubernetes-1-netology-multitool.jpg)

Удаляю Deployment и PVC. После удаления PVC у PV меняется статус с Bound (когда он был связан с PV) на статус Released (свободный, не связанный ни с каким PVC).

![Kubernetes-del-pvc-dep](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.2-Kubernetes-1-netology-del-pvc-dep.jpg)

Конфигурационный файл PV содержит параметр persistentVolumeReclaimPolicy: Retain, который означает, что после удаления PV ресурсы из внешних провайдеров автоматически не удаляются.

![Kubernetes-share](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.2-Kubernetes-1-netology-share.jpg)

![Kubernetes-del-pv](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.2-Kubernetes-1-netology-del-pv.jpg)

------

### Задание 2

**Что нужно сделать**

Создать Deployment приложения, которое может хранить файлы на NFS с динамическим созданием PV.

1. Включить и настроить NFS-сервер на MicroK8S.
2. Создать Deployment приложения состоящего из multitool, и подключить к нему PV, созданный автоматически на сервере NFS.
3. Продемонстрировать возможность чтения и записи файла изнутри пода. 
4. Предоставить манифесты, а также скриншоты или вывод необходимых команд.

## Решение
 
Установил NFS

![Kubernetes-nfs](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.2-Kubernetes-2-netology-nfs.jpg)

Конфигурационный файл Deployment приложения:

![Kubernetes-dep-nfs-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.2-Kubernetes-2-netology-dep-nfs-conf.jpg)

Конфигурационный файл NFS:

![Kubernetes-nfs-conf](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.2-Kubernetes-2-netology-nfs-conf.jpg)

Демонстрация работы с NFS:

![Kubernetes-nfs-show](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.2-Kubernetes-2-netology-nfs-show.jpg)

------

### Правила приёма работы

1. Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.
