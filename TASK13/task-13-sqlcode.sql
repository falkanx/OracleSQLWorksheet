SELECT
	last_name,
	department_id,
	salary
	FROM
		hr.employees emp
		WHERE
		salary> (SELECT round(AVG(salary))
		FROM hr.employees empl
		WHERE emp.department_id = empl.department_id
		GROUP BY department_id
	);
