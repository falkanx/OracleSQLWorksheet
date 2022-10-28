SELECT employee_id, last_name, salary FROM hr.employees WHERE salary > (SELECT AVG(salary) FROM hr.employees) ORDER BY salary;

SELECT last_name FROM hr.employees WHERE salary > (SELECT MIN(salary) FROM hr.employees WHERE department_id = 60);

SELECT last_name, salary FROM hr.employees WHERE manager_id IN (SELECT employee_id FROM hr.employees WHERE last_name = 'King');

SELECT
	emp.last_name,
	emp.department_id,
	emp.job_id
FROM
	hr.employees emp,
	hr.departments dept,
	hr.locations loc
WHERE
	emp.department_id = dept.department_id
	AND dept.location_id = loc.location_id
	AND loc.location_id = 1700;

SELECT employee_id, last_name FROM hr.employees WHERE department_id IN (SELECT department_id FROM hr.employees WHERE last_name LIKE '%u%');

SELECT last_name FROM hr.employees WHERE department_id in
	(SELECT department_id FROM hr.departments WHERE location_id in
		(SELECT location_id FROM hr.locations WHERE country_id in
			(SELECT country_id FROM hr.countries WHERE region_id=
				(SELECT region_id FROM hr.regions WHERE region_name='Europe')
			)
		)
	)