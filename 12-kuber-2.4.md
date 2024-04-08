# Домашнее задание к занятию «Управление доступом»

### Цель задания

В тестовой среде Kubernetes нужно предоставить ограниченный доступ пользователю.

------

### Чеклист готовности к домашнему заданию

1. Установлено k8s-решение, например MicroK8S.
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключённым github-репозиторием.

------

### Инструменты / дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) RBAC.
2. [Пользователи и авторизация RBAC в Kubernetes](https://habr.com/ru/company/flant/blog/470503/).
3. [RBAC with Kubernetes in Minikube](https://medium.com/@HoussemDellai/rbac-with-kubernetes-in-minikube-4deed658ea7b).

------

### Задание 1. Создайте конфигурацию для подключения пользователя

1. Создайте и подпишите SSL-сертификат для подключения к кластеру.
2. Настройте конфигурационный файл kubectl для подключения.
3. Создайте роли и все необходимые настройки для пользователя.
4. Предусмотрите права пользователя. Пользователь может просматривать логи подов и их конфигурацию (`kubectl logs pod <pod_id>`, `kubectl describe pod <pod_id>`).
5. Предоставьте манифесты и скриншоты и/или вывод необходимых команд.

## Решение

Создаю закрытый ключ:
```bash
ivan@netology-microk8s:~$ openssl genrsa -out ivan.key 2048
```
Создаю запрос на подпись сертификата:
```bash
ivan@netology-microk8s:~$ openssl req -new -key ivan.key \
 -out ivan.csr \
 -subj "/CN=ivan/O=group"
```
Подписываю CSR в Kubernetes CA. Для этого использую сертификат CA и ключ, которые находятся в /var/snap/microk8s/6541/certs. Сертификат будет действителен в течение 365 дней:
```bash
ivan@netology-microk8s:~$ openssl x509 -req -in ivan.csr \ 
 -CA /var/snap/microk8s/6541/certs/ca.crt \
 -CAkey /var/snap/microk8s/6541/certs/ca.key \
 -CAcreateserial \ 
 -out ivan.crt -days 365
```
Создаю каталог .certs. В нем будет храниться открытый и закрытый ключи, для этого перемещаю их:
```bash
ivan@netology-microk8s:~$  mkdir .certs && mv ivan.crt ivan.key .certs
```

Создаю пользователя внутри Kubernetes:
```bash
ivan@netology-microk8s:~$ kubectl config set-credentials ivan \
--client-certificate=/home/ivan/.certs/ivan.crt \
--client-key=/home/ivan/.certs/ivan.key
```

Задаю контекст для пользователя:
```bash
ivan@netology-microk8s:~$ kubectl config set-context ivan-context \
--cluster=microk8s-cluster --user=ivan
```
После этого можно просмотреть файл конфигурации:
```bash
ivan@netology-microk8s:~$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://127.0.0.1:16443
  name: microk8s-cluster
contexts:
- context:
    cluster: microk8s-cluster
    user: ivan
  name: ivan-context
- context:
    cluster: microk8s-cluster
    user: admin
  name: microk8s
current-context: microk8s
kind: Config
preferences: {}
users:
- name: admin
  user:
    client-certificate-data: DATA+OMITTED
    client-key-data: DATA+OMITTED
- name: ivan
  user:
    client-certificate: /home/ivan/.certs/ivan.crt
    client-key: /home/ivan/.certs/ivan.key
```
Теперь создаю Role:

![Kubernetes-netology-role](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.4-Kubernetes-1-netology-role.jpg)

И RoleBinding:

![Kubernetes-netology-rolebinding](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.4-Kubernetes-1-netology-rolebinding.jpg)

Переключаюсь на созданный контекст

```bash
ivan@netology-microk8s:~$ kubectl config use-context ivan-context
```
От предущего задания остались поды:

![Kubernetes-netology-pod-get](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.4-Kubernetes-1-netology-pod-get.jpg)

Проверяю logs:

![Kubernetes-netology-logs](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.4-Kubernetes-1-netology-logs.jpg)

А теперь describe pod:

![Kubernetes-netology-describe](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/12-kuber-2.4-Kubernetes-1-netology-describe.jpg)

------

### Правила приёма работы

1. Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

------

