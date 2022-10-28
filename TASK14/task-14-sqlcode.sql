CREATE TABLE MY_EMPLOYEE (
ID number (4) not null,
last_name varchar2(25),
first_name varchar2(25),
userid varchar2(8),
salary number(9,2)
)

DESC MY_EMPLOYEE;

INSERT INTO MY_EMPLOYEE VALUES (1, 'Patel', 'Ralph', 'rpatel', 895);
INSERT INTO MY_EMPLOYEE VALUES (2, 'Dancs', 'Betty', 'bdancs', 860);
INSERT INTO MY_EMPLOYEE VALUES (3, 'Biri', 'Ben', 'bbiri', 1100);
INSERT INTO MY_EMPLOYEE VALUES (4, 'Newman', 'Chad', 'cnewman', 750);
INSERT INTO MY_EMPLOYEE VALUES (5, 'Ropeburn', 'Audrey', 'aropebur', 1550);

COMMIT

SELECT * FROM MY_EMPLOYEE;

DELETE FROM MY_EMPLOYEE WHERE ID=5;

UPDATE MY_EMPLOYEE SET SALARY=1000 where SALARY<900;

DELETE FROM MY_EMPLOYEE WHERE ID=2;

INSERT INTO MY_EMPLOYEE VALUES (5, 'Ropeburn', 'Audrey', 'aropebur', 1550);

SAVEPOINT TASK;

DELETE FROM MY_EMPLOYEE;

rollback to savepoint TASK;

CREATE TABLE DEPT (
ID number (7) NOT NULL PRIMARY KEY,
name varchar2 (25)
)

desc DEPT

CREATE TABLE EMP (
ID number(7),
last_name varchar2(25),
first_name varchar2(25),
dept_id number(7)
)

ALTER TABLE EMP ADD CONSTRAINT DEPT_FK FOREIGN KEY ("DEPT_ID") REFERENCES "DEPT" ("ID");

desc EMP

ALTER TABLE EMP ADD (COMMISSION number(2, 2))

desc EMP

ALTER TABLE EMP MODIFY (LAST_NAME varchar2(50))

desc EMP

ALTER TABLE EMP DROP COLUMN FIRST_NAME

desc EMP

ALTER TABLE EMP SET UNUSED (DEPT_ID)

desc EMP

ALTER TABLE EMP DROP UNUSED COLUMNS

desc EMP

CREATE TABLE employees2 (
	emp_id NUMBER (6),
	first_name VARCHAR2(20),
	last_name VARCHAR2 (25) NOT NULL,
	salary NUMBER(8, 2),
	dept_id NUMBER(4)
	)

desc EMPLOYEES2

ALTER TABLE EMPLOYEES2 READ ONLY

ALTER TABLE EMPLOYEES2 ADD (JOB_ID varchar2(9))

desc EMPLOYEES2

ALTER TABLE EMPLOYEES2 DROP COLUMN JOB_ID

DROP TABLE EMP;

DROP TABLE DEPT;

DROP TABLE EMPLOYEES2;



