# Домашнее задание к занятию 2. «SQL»

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/blob/virt-11/additional/README.md).

## Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose-манифест.

## Решение:

```yaml
version: "3.8"
services:
  postgres:
    image: postgres:12
    container_name: pg12
    volumes:
      - pg_data:/var/lib/postgresql/data
      - pg_backup:/backup/postgres
    environment:
      POSTGRES_USER: pgusr
      POSTGRES_PASSWORD: MyPa$$2023
      POSTGRES_DB: pgdb01
volumes:
  pg_data:
  pg_backup:
```

## Задача 2

В БД из задачи 1: 

- создайте пользователя test-admin-user и БД test_db;
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже);
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db;
- создайте пользователя test-simple-user;
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE этих таблиц БД test_db.

Таблица orders:

- id (serial primary key);
- наименование (string);
- цена (integer).

Таблица clients:

- id (serial primary key);
- фамилия (string);
- страна проживания (string, index);
- заказ (foreign key orders).

Приведите:

- итоговый список БД после выполнения пунктов выше;
- описание таблиц (describe);
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db;
- список пользователей с правами над таблицами test_db.

## Решение:

Итоговый список БД:
```bash
test_db=# \l+
                                                               List of databases
   Name    | Owner | Encoding |  Collate   |   Ctype    | Access privileges |  Size   | Tablespace |                Description
-----------+-------+----------+------------+------------+-------------------+---------+------------+--------------------------------------------
 pgdb01    | pgusr | UTF8     | en_US.utf8 | en_US.utf8 |                   | 7977 kB | pg_default |
 postgres  | pgusr | UTF8     | en_US.utf8 | en_US.utf8 |                   | 7977 kB | pg_default | default administrative connection database
 template0 | pgusr | UTF8     | en_US.utf8 | en_US.utf8 | =c/pgusr         +| 7833 kB | pg_default | unmodifiable empty database
           |       |          |            |            | pgusr=CTc/pgusr   |         |            |
 template1 | pgusr | UTF8     | en_US.utf8 | en_US.utf8 | =c/pgusr         +| 7833 kB | pg_default | default template for new databases
           |       |          |            |            | pgusr=CTc/pgusr   |         |            |
 test_db   | pgusr | UTF8     | en_US.utf8 | en_US.utf8 |                   | 8105 kB | pg_default |
(5 rows)
```
Описание таблиц (describe):
```bash
test_db=# \d orders
                                  Table "public.orders"
    Column    |     Type      | Collation | Nullable |              Default
--------------+---------------+-----------+----------+------------------------------------
 id           | integer       |           | not null | nextval('orders_id_seq'::regclass)
 наименование | character(50) |           |          |
 цена         | integer       |           |          |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)

test_db=# \d clients
                                     Table "public.clients"
      Column       |     Type      | Collation | Nullable |               Default
-------------------+---------------+-----------+----------+-------------------------------------
 id                | integer       |           | not null | nextval('clients_id_seq'::regclass)
 фамилия           | character(50) |           |          |
 страна проживания | character(50) |           |          |
 заказ             | integer       |           |          |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "clients_страна проживания_idx" btree ("страна проживания")
Foreign-key constraints:
    "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
```
SQL-запрос для выдачи списка пользователей с правами над таблицами test_db:
```sql
SELECT grantee, table_name, privilege_type FROM information_schema.table_privileges WHERE grantee in ('test-admin-user','test-simple-user') and table_name IN ('orders','clients');
```
Список пользователей с правами над таблицами test_db:
```bash
 grantee      | table_name | privilege_type 
------------------+------------+----------------
 test-admin-user  | orders     | INSERT
 test-admin-user  | orders     | SELECT
 test-admin-user  | orders     | UPDATE
 test-admin-user  | orders     | DELETE
 test-admin-user  | orders     | TRUNCATE
 test-admin-user  | orders     | REFERENCES
 test-admin-user  | orders     | TRIGGER
 test-simple-user | orders     | INSERT
 test-simple-user | orders     | SELECT
 test-simple-user | orders     | UPDATE
 test-simple-user | orders     | DELETE
 test-admin-user  | clients    | INSERT
 test-admin-user  | clients    | SELECT
 test-admin-user  | clients    | UPDATE
 test-admin-user  | clients    | DELETE
 test-admin-user  | clients    | TRUNCATE
 test-admin-user  | clients    | REFERENCES
 test-admin-user  | clients    | TRIGGER
 test-simple-user | clients    | INSERT
 test-simple-user | clients    | SELECT
 test-simple-user | clients    | UPDATE
 test-simple-user | clients    | DELETE
(22 rows)

```

## Задача 3

Используя SQL-синтаксис, наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL-синтаксис:
- вычислите количество записей для каждой таблицы.

Приведите в ответе:

    - запросы,
    - результаты их выполнения.

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys, свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения этих операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод этого запроса.
 
Подсказка: используйте директиву `UPDATE`.

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните, что значат полученные значения.

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. задачу 1).

Остановите контейнер с PostgreSQL, но не удаляйте volumes.

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

