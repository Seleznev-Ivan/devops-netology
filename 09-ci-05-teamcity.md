# Домашнее задание к занятию 11 «Teamcity»

## Подготовка к выполнению

1. В Yandex Cloud создайте новый инстанс (4CPU4RAM) на основе образа `jetbrains/teamcity-server`.
2. Дождитесь запуска teamcity, выполните первоначальную настройку.
3. Создайте ещё один инстанс (2CPU4RAM) на основе образа `jetbrains/teamcity-agent`. Пропишите к нему переменную окружения `SERVER_URL: "http://<teamcity_url>:8111"`.
4. Авторизуйте агент.
5. Сделайте fork [репозитория](https://github.com/aragastmatb/example-teamcity).
6. Создайте VM (2CPU4RAM) и запустите [playbook](./infrastructure).

![teamcity00](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-00.jpg)

## Основная часть

1. Создайте новый проект в teamcity на основе fork.
![teamcity01](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-01.jpg)
2. Сделайте autodetect конфигурации.
![teamcity02](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-02.jpg)
3. Сохраните необходимые шаги, запустите первую сборку master.
4. Поменяйте условия сборки: если сборка по ветке `master`, то должен происходит `mvn clean deploy`, иначе `mvn clean test`.
![teamcity04](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-04.jpg)
5. Для deploy будет необходимо загрузить [settings.xml](./teamcity/settings.xml) в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus.
![teamcity05](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-05.jpg)
6. В pom.xml необходимо поменять ссылки на репозиторий и nexus.
![teamcity06](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-06.jpg)
7. Запустите сборку по master, убедитесь, что всё прошло успешно и артефакт появился в nexus.

При запуске сборки возникает ошибка «400 Repository does not allow updating assets: maven-releases». Для устранения проблемы необходимо в настройках репозитория в nexus включить разрешение повторного развертывания.
![teamcity07](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-07.jpg)
После этого сборка выполняется успешно.
![teamcity071](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-071.jpg)
8. Мигрируйте `build configuration` в репозиторий.
![teamcity08](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-08.jpg)
9. Создайте отдельную ветку `feature/add_reply` в репозитории.
![teamcity09](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-09.jpg)
10. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`.
![teamcity10](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-10.jpg)
11. Дополните тест для нового метода на поиск слова `hunter` в новой реплике.
![teamcity11](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-11.jpg)
12. Сделайте push всех изменений в новую ветку репозитория.
13. Убедитесь, что сборка самостоятельно запустилась, тесты прошли успешно.
![teamcity13](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-13.jpg)
14. Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`.
![teamcity14](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-14.jpg)
15. Убедитесь, что нет собранного артефакта в сборке по ветке `master`.
![teamcity15](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-15.jpg)
16. Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки.
![teamcity16](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-16.jpg)
17. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны.
![teamcity17](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-17.jpg)
18. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity.
![teamcity18](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-05-teamcity-18.jpg)
19. В ответе пришлите ссылку на репозиторий.

[Ссылка на репозиторий](https://github.com/Seleznev-Ivan/example-teamcity)
---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
