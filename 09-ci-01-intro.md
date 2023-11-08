# Домашнее задание к занятию 7 «Жизненный цикл ПО»

## Подготовка к выполнению

1. Получить бесплатную версию Jira - https://www.atlassian.com/ru/software/jira/work-management/free (скопируйте ссылку в адресную строку).
2. Настроить её для своей команды разработки.
3. Создать доски Kanban и Scrum.
4. [Дополнительные инструкции от разработчика Jira](https://support.atlassian.com/jira-cloud-administration/docs/import-and-export-issue-workflows/).

## Основная часть

Необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить жизненный цикл:

1. Open -> On reproduce.
2. On reproduce -> Open, Done reproduce.
3. Done reproduce -> On fix.
4. On fix -> On reproduce, Done fix.
5. Done fix -> On test.
6. On test -> On fix, Done.
7. Done -> Closed, Open.

![bug_workflow](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-01-intro-bug_workflow.jpg)

Остальные задачи должны проходить по упрощённому workflow:

1. Open -> On develop.
2. On develop -> Open, Done develop.
3. Done develop -> On test.
4. On test -> On develop, Done.
5. Done -> Closed, Open.

![other_workflow](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-01-intro-other_workflow.jpg)

**Что нужно сделать**

1. Создайте задачу с типом bug, попытайтесь провести его по всему workflow до Done.

![bug_history](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-01-intro-bug_history.jpg)
  
2. Создайте задачу с типом epic, к ней привяжите несколько задач с типом task, проведите их по всему workflow до Done. 
3. При проведении обеих задач по статусам используйте kanban.

![kanban](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-01-intro-kanban.jpg)
   
4. Верните задачи в статус Open.

![kanban-open](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-01-intro-kanban-open.jpg)
   
5. Перейдите в Scrum, запланируйте новый спринт, состоящий из задач эпика и одного бага, стартуйте спринт, проведите задачи до состояния Closed. Закройте спринт.

![scrum](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-01-intro-scrum.jpg)

![scrum_sprint](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-01-intro-scrum_sprint.jpg)

![scrum_sprint_complete](https://github.com/Seleznev-Ivan/devops-netology/blob/main/img/09-ci-01-intro-scrum_sprint_complete.jpg)

   
6. Если всё отработалось в рамках ожидания — выгрузите схемы workflow для импорта в XML. Файлы с workflow и скриншоты workflow приложите к решению задания.

[bug_workflow](https://github.com/Seleznev-Ivan/devops-netology/blob/main/files/seleznev_bug_workflow_netology.xml)

[other_workflow](https://github.com/Seleznev-Ivan/devops-netology/blob/main/files/seleznev_other_workflow_netology.xml)

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
