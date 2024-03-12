"""Скрипт для заполнения данными таблиц в БД Postgres."""
import csv
import psycopg2

# Подключаемся
conn =  psycopg2.connect(
        host='localhost',
        database='north',
        user='postgres',
        password='12345'
)

# Делаем через try чтобы гарантированно закрыть подключение
try:
    with conn:
        with conn.cursor() as cur:

            # Заполняем данными таблицу customers
            with open('north_data\\customers_data.csv', newline='', encoding='windows-1251') as csvfile:
                reader = csv.DictReader(csvfile)
                for row in reader:
                    cur.execute("INSERT into customers VALUES (%s, %s, %s)",
                                (f"{row['customer_id']}",
                                 f"{row['company_name']}",
                                 f"{row['contact_name']}"))

            # Заполняем данными таблицу employees
            with open('north_data\\employees_data.csv', newline='', encoding='windows-1251') as csvfile:
                reader = csv.DictReader(csvfile)
                for row in reader:
                    cur.execute("INSERT into employees VALUES (%s, %s, %s, %s, %s, %s)",
                                (f"{row['employee_id']}",
                                 f"{row['first_name']}",
                                 f"{row['last_name']}",
                                 f"{row['title']}",
                                 f"{row['birth_date']}",
                                 f"{row['notes']}"))

            # Заполняем данными таблицу orders
            with open('north_data\\orders_data.csv', newline='', encoding='windows-1251') as csvfile:
                reader = csv.DictReader(csvfile)
                for row in reader:
                    cur.execute("INSERT into orders VALUES (%s, %s, %s, %s, %s)",
                                (f"{row['order_id']}",
                                 f"{row['customer_id']}",
                                 f"{row['employee_id']}",
                                 f"{row['order_date']}",
                                 f"{row['ship_city']}"))
finally:
    # Закрываем соединение
    conn.close()


# SELECT * from customers;
# SELECT * from employees;
# SELECT * from orders;
#
# INSERT into customers VALUES ('ALFKI', 'Alfreds Futterkiste', 'Maria Anders');
#
# DELETE FROM orders *;
# DELETE FROM customers *;
# DELETE FROM employees *;