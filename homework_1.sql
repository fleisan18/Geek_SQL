USE homework_1;
SELECT * FROM mobile_phones;

-- 2. Выведите название, производителя и цену для товаров, количество которых превышает 2
SELECT product_name, manufacturer, price
FROM mobile_phones
WHERE product_count > 2;

-- 3. Выведите весь ассортимент товаров марки “Samsung”
SELECT *
FROM mobile_phones
WHERE manufacturer = 'Samsung';

-- 4. Выведите информацию о телефонах, где суммарный чек больше 100 000 и меньше 145 000
SELECT *
FROM mobile_phones
WHERE price * product_count > 100000 and price * product_count < 145000;

-- 4.*** С помощью регулярных выражений найти (можно использовать операторы “LIKE”, “RLIKE для 4.3” ):
-- 4.1. Товары, в которых есть упоминание "Iphone"
SELECT *
FROM mobile_phones
WHERE product_name LIKE '%iPhone%';

-- 4.2. "Galaxy"
SELECT *
FROM mobile_phones
WHERE product_name LIKE '%Galaxy%';

-- 4.3. Товары, в которых есть ЦИФРЫ
SELECT *
FROM mobile_phones
WHERE product_name RLIKE '[0-9]';

-- 4.4. Товары, в которых есть ЦИФРА "8"
SELECT *
FROM mobile_phones
WHERE product_name LIKE '%8%';
