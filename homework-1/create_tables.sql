-- SQL-команды для создания таблиц

--Сначала как в консоли действуем, чтобы создать таблицу
--psql -U postgres
--CREATE DATABASE north;


--Создаю в PG Admin таблицу employees
CREATE TABLE public.employees
(
    employee_id serial PRIMARY KEY NOT NULL,
    first_name varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL,
    title varchar(100) NOT NULL,
    birth_date date NOT NULL,
    notes text
);

--Создаю в PG Admin таблицу customers
CREATE TABLE public.customers
(
    customer_id varchar(100) PRIMARY KEY NOT NULL,
    company_name varchar(100) NOT NULL,
    contact_name varchar(100) NOT NULL
);


--Создаю в PG Admin таблицу orders
CREATE TABLE public.orders
(
    order_id int PRIMARY KEY NOT NULL,
    customer_id varchar(100) REFERENCES customers(customer_id) NOT NULL,
    employee_id int REFERENCES employees(employee_id) NOT NULL,
	order_date date NOT NULL,
	ship_city varchar(100) NOT NULL
);
