-- Create a file named case_exercises.sql and craft queries to return the results for the following criteria:

-- WRITE a QUERY that RETURNS ALL employees (emp_no), their department number, their START DATE, their END DATE, AND a NEW COLUMN 'is_current_employee' that IS a 1 IF the employee IS still WITH the company AND 0 IF not.
SELECT emp_no, min(from_date) AS start_date, max(to_date) AS end_date, 
IF (max(to_date)= '9999-01-01', TRUE, FALSE) AS is_current_employee
FROM dept_emp
GROUP BY emp_no;

-- WRITE a QUERY that RETURNS ALL employee NAMES (previous AND current), AND a NEW COLUMN 'alpha_group' that RETURNS 'A-H', 'I-Q', OR 'R-Z' depending ON the FIRST letter of their LAST name.
SELECT first_name, last_name,
	CASE
		WHEN SUBSTR(last_name,1,1) BETWEEN 'a' AND 'h' THEN 'A-H'
		WHEN SUBSTR(last_name,1,1) BETWEEN 'i' AND 'q' THEN 'I-Q'
		WHEN SUBSTR(last_name,1,1) BETWEEN 'r' AND 'z' THEN 'R-Z'
           ELSE 'Others'
           END AS alpha_group
           FROM employees;
           

-- How many employees (current OR previous) were born IN EACH decade?
SELECT 
		COUNT(CASE WHEN SUBSTR(birth_date,3,1) = '5' THEN birth_date ELSE NULL END) AS '1950s',
		COUNT(CASE WHEN SUBSTR(birth_date,3,1) = '6' THEN birth_date ELSE NULL END) AS '1960s',
		COUNT(CASE WHEN SUBSTR(birth_date,3,1) NOT IN ('5', '6') THEN birth_date ELSE NULL END) AS 'other'
           FROM employees;

-- BONUS

-- What IS the current average salary FOR EACH of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT CASE 
           WHEN dept_name IN ('research', 'development') THEN 'R&D'
           WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
           WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
           		WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
           ELSE dept_name
           END AS dept_group,
           ROUND(AVG(s.salary)) AS average_salary
FROM dept_emp AS de
JOIN departments AS d
  ON d.dept_no = de.dept_no
JOIN salaries as s
  ON s.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01' and s.to_date = '9999-01-01'
GROUP BY dept_group
ORDER BY dept_group;
/* 
+-------------------+-----------------+
| dept_group        | avg_salary      |
+-------------------+-----------------+
| Customer Service  | 67285           |
| Finance & HR      | 71108           |
| Sales & Marketing | 86369           |
| Prod & QM         | 67328           |
| R&D               | 67709           |
+-------------------+-----------------+ */
