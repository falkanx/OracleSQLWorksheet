SELECT last_name || ', ' || job_id as "Employee and Title" FROM HR.EMPLOYEES;

SELECT last_name, salary FROM HR.EMPLOYEES where salary>12000;

SELECT last_name, department_id FROM HR.EMPLOYEES WHERE department_id IN (20,50) ORDER BY last_name asc;

SELECT last_name, hire_date FROM HR.EMPLOYEES WHERE HIRE_DATE LIKE '%00';

SELECT last_name FROM HR.EMPLOYEES WHERE last_name LIKE '__a%';

SELECT last_name FROM HR.EMPLOYEES WHERE instr(last_name, 'a')>0 AND instr(last_name, 'e')>0;

SELECT last_name, job_id, salary FROM HR.EMPLOYEES WHERE job_id='SA_REP' OR job_id='ST_CLERK' AND salary<>2500 AND salary<>3500 and salary<>7000;

SELECT last_name soyad, lpad (salary, 15,'$') AS maas FROM HR.EMPLOYEES;

SELECT last_name soyad, rpad(' ', salary/1000,'*') as EMPLOYYEE_AND_THEIR_SALARIES FROM hr.employees ORDER BY salary DESC;

SELECT last_name || ' earns' || to_char(salary, '$99,999.99') || ' monthly but wants' || to_char(salary*3, '$99,999.99') as "Dream Salaries" FROM hr.employees ORDER BY salary DESC;

SELECT last_name, hire_date, to_char(next_day(add_months(hire_date,6),'Monday'), 'fmDay,"the" Ddspth "of" Month. yyyy') as REVIEW FROM hr.employees ORDER BY hire_date ASC;

SELECT job_id AS "MESLEGI", CASE job_id WHEN 'AD_PRES' THEN 'A' WHEN 'ST_MAN' THEN 'B' WHEN 'IT_PROG' THEN 'C' WHEN 'SA_REP' THEN 'D' WHEN 'ST_CLERK' THEN 'E' ELSE '0' END AS "GRADE" FROM hr.employees;

