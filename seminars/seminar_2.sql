USE seminar_2;

CREATE TABLE movies
(
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE, #bigint unsigned not null auto_increment unique - serial
title VARCHAR(50) NOT NULL,
title_eng VARCHAR(50),
year_move YEAR NOT NULL,
count_min INT NOT NULL,
story_line TEXT
);

INSERT INTO movies (title, title_eng, year_move, count_min, story_line)
VALUES 
('Игры разума', 'A Beautiful Mind', 2001, 135, 'От всемирной известности до греховных глубин — все это познал
на своей шкуре Джон Форбс Нэш-младший. Математический гений,
он на заре своей карьеры сделал титаническую работу в области
теории игр, которая перевернула этот раздел математики и
практически принесла ему международную известность. Однако
буквально в то же время заносчивый и пользующийся успехом у
женщин Нэш получает удар судьбы, который переворачивает уже
его собственную жизнь.'),
('Форрест Гамп', 'Forrest Gump', 1994, 142, 'Сидя на автобусной остановке, Форрест Гамп — не очень умный, но
добрый и открытый парень — рассказывает случайным встречным
историю своей необыкновенной жизни. С самого малолетства
парень страдал от заболевания ног, соседские мальчишки дразнили
его, но в один прекрасный день Форрест открыл в себе невероятные
способности к бегу. Подруга детства Дженни всегда его
поддерживала и защищала, но вскоре дороги их разошлись'),
('Иван Васильевич меняет профессию', NULL, 1998, 128, 'Инженер-изобретатель Тимофеев сконструировал машину времени,
которая соединила его квартиру с далеким шестнадцатым веком -
точнее, с палатами государя Ивана Грозного. Туда-то и попадают
тезка царя пенсионер-общественник Иван Васильевич Бунша и
квартирный вор Жорж Милославский. На их место в двадцатом веке
«переселяется» великий государь. Поломка машины приводит ко
множеству неожиданных и забавных событий...'),
('Назад в будущее', 'Back to the Future', 1985, 116, 'Подросток Марти с помощью машины времени, сооружённой его
другом-профессором доком Брауном, попадает из 80-х в далекие
50-е. Там он встречается со своими будущими родителями, ещё
подростками, и другом-профессором, совсем молодым.'),
('Криминальное чтиво', 'Pulp Fiction', 1994, 154, NULL);

SELECT * FROM movies;

RENAME TABLE movies TO cinema;

ALTER TABLE cinema
ADD COLUMN status_active BIT DEFAULT b'1',
ADD genre_id INT UNSIGNED AFTER title_eng;

ALTER TABLE cinema
DROP status_active;

DROP TABLE IF EXISTS genres;

CREATE TABLE genres (
id SERIAL PRIMARY KEY,
name varchar(100) NOT NULL);

DROP TABLE IF EXISTS actors;

CREATE TABLE actors (
id SERIAL PRIMARY KEY,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) COMMENT 'Фамилия');

DROP TABLE IF EXISTS actors;

/*ALTER TABLE cinema
ADD CONSTRAINT FK_cinema_genres FOREIGN KEY (genre_id) REFERENCES genres (id)
-- ON UPDATE CASCADE ON DELETE SET NULL;*/

SELECT id, title,
CASE id
WHEN 1 THEN 'Подростковая'
WHEN 4 THEN 'Детская'
WHEN 5 THEN 'Взрослая'
ELSE 'Не указана'
END AS category
FROM cinema;

UPDATE cinema
SET count_min = 88 WHERE id = 2;

UPDATE cinema
SET count_min = NULL WHERE id = 3;

UPDATE cinema
SET count_min = 34 WHERE id = 4;

SELECT id AS 'Номер фильма', title AS 'Название фильма', count_min,
CASE 
WHEN count_min < 50 THEN 'Короткометражный фильм'
WHEN count_min BETWEEN 50 AND 100 THEN 'Среднеметражный фильм'
WHEN count_min > 100 THEN 'Полнометражный фильм'
ELSE 'Не определено'
END 'Тип'
FROM cinema;

SELECT id AS 'Номер фильма', title AS 'Название фильма', count_min,
IF (count_min < 50, 'Короткометражный фильм', IF(count_min BETWEEN 50 AND 100, 'Среднеметражный фильм', IF (count_min > 100, 'Полнометражный фильм', 'Не определено'))) AS 'Тип'
FROM cinema;

