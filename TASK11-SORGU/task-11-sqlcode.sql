SELECT max(salary) "Maximum", min(salary) "Minimum", sum(salary) "Sum", round(avg(salary)) AS "Average" FROM hr.employees;

SELECT job_id, max(salary) "Maximum", min(salary) "Minimum", sum(salary) "Sum", round(avg(salary)) AS "Average" FROM
hr.employees GROUP BY job_id ORDER BY sum(salary) DESC;
SELECT job id, count(*) FROM hr.employees WHERE job_id LIKE 'IT%' GROUP BY job_id;

SELECT job_id, count(*) FROM hr.employees GROUP BY job_id ORDER BY count(*) DESC;

SELECT manager_id, count(manager_id) AS "Number Of Managers" FROM hr.employees WHERE manager_id IS NOT NULL GROUP BY manager_id;

SELECT count(count(manager_id)) AS "Number Of Managers" FROM hr.employees WHERE manager_id IS NOT NULL GROUP BY manager_id;

SELECT max(salary) "MAX", min(salary) "MIN", (max(salary)-min(salary)) AS "DIFFERENCE" FROM hr. employees;

SELECT COUNT(*) total,
SUM(decode(to_char(hire_date,'yyyy'),1995,1,0)) "1995",
SUM(decode(to_char(hire_date,'yyyy'),1996,1,0)) "1996",
SUM(decode(to_char(hire_date,'yyyy'),1997,1,0)) "1997",
SUM(decode(to_char(hire_date,'yyyy'),1998,1,0)) "1998"
FROM hr.employees;

SELECT
	emp.last_name,
	emp.department_id,
	dept.department_name
FROM
hr.employees emp,
hr.departments dept
WHERE
emp.department_id dept.department_id;

SELECT
	emp.last_name,
	emp.job_id,
	emp.department_id,
	dept.department_name,
	loc.city
FROM
	hr.employees emp,
	hr.departments dept,
	hr.locations loc
WHERE
	emp.department_id = dept.department_id
	AND dept.location_id = loc.location_id
	AND instr(loc.city, 'Toronto')>0;

SELECT last_name, hire_date FROM hr.employees WHERE hire_date>=(SELECT hire_date FROM hr.employees WHERE last_name='Davies') ORDER BY 2 ASC;
