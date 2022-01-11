-- Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:

-- Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT emp_no, hire_date, CONCAT(first_name, ' ', last_name) AS employee
FROM employees
WHERE hire_date = (SELECT hire_date FROM employees WHERE emp_no = 101010);

-- Find all the titles ever held by all current employees with the first name Aamod.
SELECT title 
FROM titles t
JOIN employees e
USING (emp_no)
WHERE e.first_name = 'Aamod'
GROUP BY title
ORDER BY title;

-- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
SELECT COUNT(*)
FROM
(
SELECT emp_no, MAX(to_date) != '9999-01-01' AS fired
FROM dept_emp
GROUP BY emp_no
)AS t
WHERE fired = 1;
-- 59900

-- alternative
SELECT COUNT(*)
FROM
(
SELECT emp_no, MAX(to_date) AS last_date
FROM dept_emp
GROUP BY emp_no
)AS t
WHERE last_date != '9999-01-01';
-- 59900 fired, 240124 remain


-- Find all the current department managers that are female. List their names in a comment in your code.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01' AND e.gender = 'F';
/*
Isamu Legleitner
Karsten Sigstam
Leon DasSarma
Hilary Kambil
*/

-- Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT AVG(salary)
FROM salaries;
-- avg is 63810.7448

SELECT CONCAT(t.first_name, ' ', t.last_name), t.salary  
FROM
(
SELECT e.first_name, e.last_name, s.salary
FROM dept_emp AS de
JOIN departments AS d
  ON d.dept_no = de.dept_no
JOIN salaries AS s
  ON s.emp_no = de.emp_no
JOIN employees AS e
  ON e.emp_no = s.emp_no  
WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
ORDER BY s.salary DESC) AS t
WHERE t.salary > (SELECT AVG(salary) FROM salaries);
-- 154543 results


-- How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

-- Hint Number 1 You will likely use a combination of different kinds of subqueries.
-- Hint Number 2 Consider that the following code will produce the z score for current salaries.
-- Returns the historic z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved

/*
SELECT salary, 
    (salary - (SELECT AVG(salary) FROM salaries)) 
    / 
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;
*/

SELECT COUNT(*) AS within_1_std_from_max
FROM salaries 
WHERE to_date = '9999-01-01' 
AND salary >= (SELECT ((MAX(salary))  
							-
		 (STD(salary))) FROM salaries WHERE to_date = '9999-01-01');
-- 83 withing 1 std of max salary



SELECT COUNT(*)/(SELECT COUNT(*) FROM salaries WHERE to_date = '9999-01-01') AS percent_within_1_std_from_max
FROM salaries 
WHERE to_date = '9999-01-01' 
AND salary >= (SELECT ((MAX(salary))  
							-
		 (STD(salary))) FROM salaries WHERE to_date = '9999-01-01');
-- .03% of current salaries within 1 std of max




/* std from average worked out here


SELECT ((MAX(salary))  - (STD(salary)))
FROM salaries; -- 141315.17171199986

SELECT MAX(salary) FROM salaries; -- 158220

SELECT COUNT(*) AS within_1_std
FROM
(
SELECT emp_no, 
    (salary - (SELECT AVG(salary) FROM salaries)) 
    / 
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries
WHERE to_date = '9999-01-01') AS t
WHERE zscore BETWEEN -1 and 1;
-- 163205 within 1 std dev from average


SELECT COUNT(*) AS total_employees
FROM(SELECT emp_no FROM salaries WHERE to_date = '9999-01-01') as t1;
-- total current employees 240124


-- percent of total historical salaries **66.84% that fall within 1 std from historical average
SELECT COUNT(*)/(SELECT COUNT(*) FROM salaries) AS percent_of_total_salaries
FROM
(
SELECT emp_no, 
    (salary - (SELECT AVG(salary) FROM salaries)) 
    / 
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries) AS t
WHERE zscore BETWEEN -1 and 1;

-- percent of current salaries **67.97% that fall within 1 std from historical avera
SELECT COUNT(*)/(SELECT COUNT(*) FROM salaries WHERE to_date = '9999-01-01') AS percent_of_total_salaries
FROM
(
SELECT emp_no, 
    (salary - (SELECT AVG(salary) FROM salaries)) 
    / 
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries
WHERE to_date = '9999-01-01') AS t
WHERE zscore BETWEEN -1 and 1;


SELECT std(salary) FROM salaries;
-- 16904.828..
*/

-- BONUS

-- Find all the department names that currently have female managers.

SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS full_name, e.gender
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01' AND e.gender = 'F';
/*
Finance	Isamu Legleitner	F
Human Resources	Karsten Sigstam	F
Development	Leon DasSarma	F
Research	Hilary Kambil	F
*/

-- Find the first and last name of the employee with the highest salary.

SELECT e.first_name, e.last_name, s.salary, d.dept_name
FROM dept_emp AS de
JOIN departments AS d
  ON d.dept_no = de.dept_no
JOIN salaries AS s
  ON s.emp_no = de.emp_no
JOIN employees AS e
  ON e.emp_no = s.emp_no  
WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01' 
ORDER BY s.salary DESC
LIMIT 1;
-- Tokuyasu	Pesch	158220	Sales


-- Find the department name that the employee with the highest salary works in.

SELECT e.first_name, e.last_name, s.salary, d.dept_name
FROM dept_emp AS de
JOIN departments AS d
  ON d.dept_no = de.dept_no
JOIN salaries AS s
  ON s.emp_no = de.emp_no
JOIN employees AS e
  ON e.emp_no = s.emp_no  
WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01' 
ORDER BY s.salary DESC
LIMIT 1;
-- Tokuyasu	Pesch	158220	Sales