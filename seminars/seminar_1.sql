USE seminar_1;

SELECT * FROM student;

SELECT * FROM student
WHERE name = 'Sergey';

SELECT name, course_name
FROM student;
/* */

SELECT *
FROM student
WHERE name LIKE 'S%';

SELECT *
FROM student
WHERE scholarship > 6000;

SELECT *
FROM student
WHERE name != 'Sergey';

SELECT *
FROM student
WHERE scholarship > 6000;
