-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
ALTER TABLE products ADD CONSTRAINT chk_products_unit_price CHECK (unit_price >= 0)

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
ALTER TABLE products ADD CONSTRAINT chk_products_discontinued CHECK (discontinued IN (0,1))

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
SELECT * INTO discontinued_products FROM products
WHERE discontinued = 1


-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key.
--Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.

-- Решение с удалением связи
-- Удаляем связь
ALTER TABLE order_details DROP CONSTRAINT fk_order_details_products
-- Удаляем снятые с продажи продукты из таблицы продуктов
DELETE FROM products WHERE discontinued = 1


-- Решение без удаления связи
-- Копируем заказы, в которых участвуют снятые с продажи продукты, чтобы не терять данные
SELECT * INTO orders_with_discontinued_products FROM order_details
WHERE product_id IN (SELECT product_id FROM discontinued_products)

-- Удлаляем заказы, в которых участвуют снятые с продажи продукты
DELETE FROM order_details
WHERE product_id IN (SELECT product_id FROM discontinued_products)

-- Удаляем снятые с продажи продукты из таблицы продуктов
DELETE FROM products WHERE discontinued = 1

--Теперь можно добавить связей, чтобы новые таблицы были связаны друг с другом, но я добавил только часть, потом лень стало)
ALTER TABLE order_details_with_discontinued_products
ADD CONSTRAINT pk_order_details_with_discontinued_products PRIMARY KEY(order_id, product_id)

ALTER TABLE order_details_with_discontinued_products
ADD CONSTRAINT fk_order_details_with_discontinued_products_orders FOREIGN KEY(order_id) REFERENCES orders(order_id)

ALTER TABLE discontinued_products
ADD CONSTRAINT pk_discontinued_products PRIMARY KEY(product_id)

ALTER TABLE order_details_with_discontinued_products
ADD CONSTRAINT fk_order_details_with_discontinued_products_products FOREIGN KEY(product_id) REFERENCES discontinued_products(product_id)

