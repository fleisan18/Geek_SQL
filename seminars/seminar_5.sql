USE seminar_5;

DROP TABLE IF EXISTS academic_record;
CREATE TABLE academic_record (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(45),
	quartal  VARCHAR(45),
    subject VARCHAR(45),
	grade INT
);

INSERT INTO academic_record (name, quartal, subject, grade)
values
	('Александр','1 четверть', 'математика', 4),
	('Александр','2 четверть', 'русский', 4),
	('Александр', '3 четверть','физика', 5),
	('Александр', '4 четверть','история', 4),
	('Антон', '1 четверть','математика', 4),
	('Антон', '2 четверть','русский', 3),
	('Антон', '3 четверть','физика', 5),
	('Антон', '4 четверть','история', 3),
    ('Петя', '1 четверть', 'физика', 4),
	('Петя', '2 четверть', 'физика', 3),
	('Петя', '3 четверть', 'физика', 4),
	('Петя', '2 четверть', 'математика', 3),
	('Петя', '3 четверть', 'математика', 4),
	('Петя', '4 четверть', 'физика', 5);

-- Задача 1. Получить с помощью оконных функции:
-- • средний балл ученика
-- • наименьшую оценку ученика
-- • наибольшую оценку ученика
-- • сумму всех оценок
-- • количество всех оценок

SELECT name, AVG (grade) OVER w AS avg_grade,
MIN(grade) OVER w AS min_grade,
MAX(grade) OVER w AS max_grade,
SUM(grade) OVER w AS sum_grade,
COUNT(grade) OVER w AS count_grade
FROM academic_record
WINDOW w AS (PARTITION BY name);

-- Задача 2. Получить информацию об оценках
-- Пети по физике по четвертям:
-- • текущая успеваемость
-- • оценка в следующей четверти
-- • оценка в предыдущей четверти

SELECT quartal, grade AS 'текущая успеваемость', 
LAG(grade) OVER w AS 'предыдущая_четверть',
LEAD(grade) OVER w AS 'следующая_четверть'
FROM academic_record
WHERE name = 'Петя'
AND subject = 'физика'
WINDOW w AS (ORDER BY quartal);

USE seminar_4; 

-- Задача 3. Для базы lesson_4 решите:
-- 1. создайте представление, в котором будут выводится
-- все сообщения, в которых принимал участие
-- пользователь с id = 1;

CREATE VIEW messages_1 AS (SELECT id, body
FROM messages
WHERE from_user_id = 1 OR to_user_id = 1);
SELECT * FROM messages_1;

-- 2. найдите друзей у друзей пользователя с id = 1 и
-- поместите выборку в представление;
-- (решение задачи с помощью CTE)

CREATE OR REPLACE VIEW friends AS (
WITH friends_1 AS (
	SELECT initiator_user_id AS friend_id FROM friend_requests
	WHERE (initiator_user_id = 1 OR target_user_id = 1) AND status = 'approved'
	UNION
	SELECT target_user_id AS friend_id FROM friend_requests
	WHERE (initiator_user_id = 1 OR target_user_id = 1) AND status = 'approved')
SELECT initiator_user_id FROM friend_requests
WHERE (initiator_user_id IN (
	SELECT * FROM friends_1
	WHERE friend_id != 1)
OR target_user_id IN (
	SELECT * FROM friends_1
	WHERE friend_id != 1))
AND status = 'approved'
UNION 
SELECT target_user_id FROM friend_requests
WHERE (initiator_user_id IN (
	SELECT * FROM friends_1
	WHERE friend_id != 1)
OR target_user_id IN (
	SELECT * FROM friends_1
	WHERE friend_id != 1))
AND status = 'approved');

SELECT * FROM friends;

-- correct_solution
CREATE OR REPLACE VIEW v_friends_friends AS
WITH friends AS (
	SELECT initiator_user_id AS id
    FROM seminar_4.friend_requests
    WHERE status = 'approved' AND target_user_id = 1 
    UNION
    SELECT target_user_id AS id
    FROM seminar_4.friend_requests
    WHERE status = 'approved' AND initiator_user_id = 1 
)
SELECT fr.initiator_user_id AS friend_id
FROM friends f
JOIN seminar_4.friend_requests fr ON fr.target_user_id = f.id
WHERE fr.initiator_user_id != 1  AND fr.status = 'approved'
UNION
SELECT fr.target_user_id
FROM  friends f
JOIN  seminar_4.friend_requests fr ON fr.initiator_user_id = f.id 
WHERE fr.target_user_id != 1  AND status = 'approved';

SELECT friend_id FROM v_friends_friends;
