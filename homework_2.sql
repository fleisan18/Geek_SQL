CREATE SCHEMA homework_2;

USE homework_2;

-- . Используя операторы языка SQL, создайте таблицу “sales”. Заполните ее данными.

CREATE TABLE sales 
(
id SERIAL PRIMARY KEY, 
order_date DATE NOT NULL,
count_product INT NOT NULL
);

INSERT INTO sales (order_date, count_product)
VALUES
('2022-01-01', 156),
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);

SELECT * FROM sales;

/*2. Для данных таблицы “sales” укажите тип
заказа в зависимости от кол-ва :
меньше 100 - Маленький заказ
от 100 до 300 - Средний заказ
больше 300 - Большой заказ*/

SELECT id, 
IF(count_product < 100, 'Маленький заказ', 
	IF(count_product BETWEEN 100 AND 300, 'Средний заказ', 'Большой заказ')) AS 'Тип заказа'
FROM sales;

-- 3. Создайте таблицу “orders”, заполните ее значениями

CREATE TABLE orders 
(
id SERIAL PRIMARY KEY, 
employee_id VARCHAR(20) NOT NULL,
amount FLOAT NOT NULL,
order_status VARCHAR(30) NOT NULL
);

INSERT INTO orders (employee_id, amount, order_status)
VALUES
('e03', 15.00, 'OPEN'),
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 9.50, 'CANCELLED');

SELECT id, 
CASE order_status
WHEN 'OPEN' THEN 'Order is in open state'
WHEN 'CLOSED' THEN 'Order is closed'
ELSE 'Order is cancelled'
END full_order_status
FROM orders;