
# Домашнее задание к занятию 1.  «Введение в виртуализацию. Типы и функции гипервизоров. Обзор рынка вендоров и областей применения»


## Как сдавать задания

Обязательны к выполнению задачи без звёздочки. Их нужно выполнить, чтобы получить зачёт и диплом о профессиональной переподготовке.

Задачи со звёздочкой (*) — это дополнительные задачи и/или задачи повышенной сложности. Их выполнять не обязательно, но они помогут вам глубже понять тему.

Домашнее задание выполняйте в файле readme.md в GitHub-репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Любые вопросы по решению задач задавайте в чате учебной группы.

---

## Важно

Перед отправкой работы на проверку удаляйте неиспользуемые ресурсы.
Это нужно, чтобы не расходовать средства, полученные в результате использования промокода.

Подробные рекомендации [здесь](https://github.com/netology-code/virt-homeworks/blob/virt-11/r/README.md).

---

## Задача 1

Опишите кратко, в чём основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.

**Решение:**

Полная (аппаратная) виртуализация позволяет полностью виртуализировать всё аппаратное обеспечение при сохранении гостевой операционной системы в неизменном виде. Такой подход позволяет эмулировать различные аппаратные архитектуры.

При применении паравиртуализации нет необходимости симулировать аппаратное обеспечение, однако, вместо этого используется специальный программный интерфейс (API) для взаимодействия с гостевой операционной системой. Такой подход требует модификации кода гостевой системы. Системы для паравиртуализации также имеют свой гипервизор, а API-вызовы к гостевой системе, называются гипервызовы.

Виртуализация на уровне ОС позволяет виртуализовывать физические серверы на уровне ядра операционной системы. Слой виртуализации ОС обеспечивает изоляцию и безопасность ресурсов между различными контейнерами. Слой виртуализации делает каждый контейнер похожим на физический сервер. Каждый контейнер обслуживает приложения в нем и рабочую нагрузку.

## Задача 2

Выберите один из вариантов использования организации физических серверов в зависимости от условий использования.

Организация серверов:

- физические сервера,
- паравиртуализация,
- виртуализация уровня ОС.

Условия использования:

- высоконагруженная база данных, чувствительная к отказу;
- различные web-приложения;
- Windows-системы для использования бухгалтерским отделом;
- системы, выполняющие высокопроизводительные расчёты на GPU.

Опишите, почему вы выбрали к каждому целевому использованию такую организацию.


**Решение:**


## Задача 3

Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

Сценарии:

1. 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based-инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
2. Требуется наиболее производительное бесплатное open source-решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.
3. Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows-инфраструктуры.
4. Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.

**Решение:**
1. Для данного сценария я бы использовал VMware, т.к. данное решение является наиболее сбалансированным и универсальным продуктом.
2. Для данного сценария я бы использовал бесплатное решение на основе KVM - Proxmox. Данное решение имеет возможность создания резервных копий, объединять сервера в кластеры, удобное управление виртуальными машинами через веб-интерфейс или командную строку.
3. Для данного сценария я бы использовал инструмент MS Hyper-V, который является выбором defacto для окружений с преобладанием технологий Microsoft.
4. Для тестирования программного продукта на нескольких дистрибутивах Linux вполне подойдет любое решение для виртуализации, но оптимальнее наверное бы использовать виртуализацию на основе контейнеров LXD.

## Задача 4

Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.

**Решение:**

На текущем рабочем месте у нас как раp используется несколько виртуальных сред. Это MS Hyper-V, Proxmox, Oracle VM. И сложность возникает, если нужно перенести одну виртуальную машину из одной среды в другую, т.к. разный формат дисков, конфигураций. И даже конвертация не всегда помогает. Если бы у меня был выбор, то я бы не использовал гетерогенную среду из-за проблем описанных выше, а также времени на поиск и устранения проблем уходит значительно больше. В текущих условиях лучшим вариантом было бы перевести все виртуальные системы на единую кластерную виртуализацию, основанную на Linux.