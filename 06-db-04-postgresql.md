# Домашнее задание к занятию 4. «PostgreSQL»

## Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL, используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:

- вывода списка БД,
- подключения к БД,
- вывода списка таблиц,
- вывода описания содержимого таблиц,
- выхода из psql.

## Решение
Вывод списка баз данных:
```bash
pgdb13=# \l
                             List of databases
   Name    | Owner | Encoding |  Collate   |   Ctype    | Access privileges
-----------+-------+----------+------------+------------+-------------------
 pgdb13    | pgadm | UTF8     | en_US.utf8 | en_US.utf8 |
 postgres  | pgadm | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | pgadm | UTF8     | en_US.utf8 | en_US.utf8 | =c/pgadm         +
           |       |          |            |            | pgadm=CTc/pgadm
 template1 | pgadm | UTF8     | en_US.utf8 | en_US.utf8 | =c/pgadm         +
           |       |          |            |            | pgadm=CTc/pgadm
(4 rows)
```
Подключение к БД:
```bash
pgdb13=# \c pgdb13
You are now connected to database "pgdb13" as user "pgadm".
```
Вывод списка таблиц:
```bash
pgdb13=# \dtS
                  List of relations
   Schema   |          Name           | Type  | Owner
------------+-------------------------+-------+-------
 pg_catalog | pg_aggregate            | table | pgadm
 pg_catalog | pg_am                   | table | pgadm
 pg_catalog | pg_amop                 | table | pgadm
 pg_catalog | pg_amproc               | table | pgadm
 pg_catalog | pg_attrdef              | table | pgadm
 pg_catalog | pg_attribute            | table | pgadm
 pg_catalog | pg_auth_members         | table | pgadm
 pg_catalog | pg_authid               | table | pgadm
 pg_catalog | pg_cast                 | table | pgadm
 pg_catalog | pg_class                | table | pgadm
 pg_catalog | pg_collation            | table | pgadm
 pg_catalog | pg_constraint           | table | pgadm
 pg_catalog | pg_conversion           | table | pgadm
 pg_catalog | pg_database             | table | pgadm
 pg_catalog | pg_db_role_setting      | table | pgadm
............
```
Вывод описания содержимого таблицы:
```bash
pgdb13=# \dS pg_am
               Table "pg_catalog.pg_am"
  Column   |  Type   | Collation | Nullable | Default
-----------+---------+-----------+----------+---------
 oid       | oid     |           | not null |
 amname    | name    |           | not null |
 amhandler | regproc |           | not null |
 amtype    | "char"  |           | not null |
Indexes:
    "pg_am_name_index" UNIQUE, btree (amname)
    "pg_am_oid_index" UNIQUE, btree (oid)
```
Выход из psql:
```bash
pgdb13=# \q
```



## Задача 2

Используя `psql`, создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления, и полученный результат.

## Решение
```sql
SELECT attname, avg_width FROM pg_stats WHERE tablename='orders';
 attname | avg_width
---------+-----------
 id      |         4
 title   |        16
 price   |         4
(3 rows)
```


## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам как успешному выпускнику курсов DevOps в Нетологии предложили
провести разбиение таблицы на 2: шардировать на orders_1 - price>499 и orders_2 - price<=499.

Предложите SQL-транзакцию для проведения этой операции.

Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?

## Решение

Да, можно было бы избежать, если бы изначально спроектировать таблицу как секционарованную, т.е разбив одну большую таблицу на несколько меньших физических.

## Задача 4

Используя утилиту `pg_dump`, создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?


## Решение

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

