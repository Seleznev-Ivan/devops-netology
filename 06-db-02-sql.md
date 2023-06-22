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
    
## Решение
Заполняю таблицу orders:
```sql
INSERT INTO orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
```
```bash
INSERT 0 5
```
```sql
SELECT * FROM orders;
```
```bash
id |                    наименование                    | цена
----+----------------------------------------------------+------
  1 | Шоколад                                            |   10
  2 | Принтер                                            | 3000
  3 | Книга                                              |  500
  4 | Монитор                                            | 7000
  5 | Гитара                                             | 4000
(5 rows)
```
Вычисляю количество записей в таблице orders:
```sql
SELECT count(*) FROM orders;
```
```bash
 count
-------
     5
(1 row)
```
Заполняю таблицу clients:
```sql
INSERT INTO clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
```
```bash
INSERT 0 5
```
```sql
SELECT * FROM clients;
```
```bash
 id |       фамилия        | страна проживания | заказ 
----+----------------------+-------------------+-------
  1 | Иванов Иван Иванович | USA               |      
  2 | Петров Петр Петрович | Canada            |      
  3 | Иоганн Себастьян Бах | Japan             |      
  4 | Ронни Джеймс Дио     | Russia            |      
  5 | Ritchie Blackmore    | Russia            |      
(5 rows)
```
Вычисляю количество записей в таблице clients:
```sql
SELECT count(*) FROM clients;
```
```bash
 count 
-------
     5
(1 row)
```

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


## Решение
```sql
UPDATE clients SET заказ=(select id from orders where наименование='Книга') WHERE фамилия='Иванов Иван Иванович';
UPDATE 1
UPDATE clients SET заказ=(select id from orders where наименование='Монитор') WHERE фамилия='Петров Петр Петрович';
UPDATE 1
UPDATE clients SET заказ=(select id from orders where наименование='Гитара') WHERE фамилия='Иоганн Себастьян Бах';
UPDATE 1
```
Запрос всех пользователей, которые совершили заказ:
 ```sql
 SELECT* FROM clients WHERE заказ IS NOT NULL;
 ```
 ```bash
 id |                      фамилия                       |                 страна проживания                  | заказ
----+----------------------------------------------------+----------------------------------------------------+-------
  1 | Иванов Иван Иванович                               | USA                                                |     3
  2 | Петров Петр Петрович                               | Canada                                             |     4
  3 | Иоганн Себастьян Бах                               | Japan                                              |     5
(3 rows)
```

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
