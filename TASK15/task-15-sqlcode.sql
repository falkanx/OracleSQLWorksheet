CREATE TABLE dept (
		id number(7) primary key,
		name varchar2(25)
		)

desc dept

CREATE SEQUENCE DEPT_ID_SEQ
START WITH 200
INCREMENT BY 10
MAXVALUE 1000

INSERT INTO DEPT VALUES (DEPT_ID_SEQ.NEXTVAL, 'Education');
INSERT INTO DEPT VALUES (DEPT_ID_SEQ.NEXTVAL, 'Administration')

SELECT * FROM DEPT

SELECT
	sequence_name,
	max_value,
	increment_by,
	last_number
FROM
	user_sequences

CREATE SYNONYM EMP1 FOR EMPLOYEES

SELECT * FROM user_synonyms

CREATE VIEW employees_vu AS
SELECT
	employee_id,
	last_name employee,
	department_id
FROM
	employees

SELECT * FROM EMPLOYEES_VU

SELECT employee, department_id FROM EMPLOYEES_VU

CREATE VIEW dept80 AS
SELECT
	employee_id empno,
	last_name employee,
	department_id deptno
FROM
	employees
	WHERE
		department_id = 80
WITH CHECK OPTION

DESC dept80

SELECT * FROM dept80

UPDATE dept80
SET
	deptno = 60
WHERE
	employee = 'Fox'

SELECT
	view_name,
	text
FROM
	user_views
