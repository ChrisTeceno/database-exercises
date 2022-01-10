-- 1. Create a new file named group_by_exercises.sql DONE

-- 2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT COUNT(DISTINCT title)
FROM titles;

-- or
SELECT DISTINCT title
FROM titles;

-- 7 results 

-- 3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;
-- 5 results

-- 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY first_name, last_name;
-- 846 results

-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT last_name
FROM employees
WHERE last_name LIKE '%Q%' AND last_name NOT LIKE "%QU%"
GROUP BY last_name;
-- 3 results

-- 6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
SELECT last_name, COUNT(last_name)
FROM employees
WHERE last_name LIKE '%Q%' AND last_name NOT LIKE "%QU%"
GROUP BY last_name;
-- Chleq 189, Lindqvist 190, Qiwen 168

-- 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
SELECT first_name, gender, COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;
/**
Vidya	M	151	151
Vidya	F	81	81
Maya	M	146	146
Maya	F	90	90
Irena	M	144	144
Irena	F	97	97
**/

-- 8. Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?

SELECT LOWER(CONCAT(SUBSTR(first_name,1,1), SUBSTR(last_name,1,4),'_', SUBSTR(birth_date,6,2), SUBSTR(birth_date,3,2))) as username, 
COUNT(*) AS n_same_username
FROM employees
GROUP BY username
HAVING n_same_username > 1;
-- 13251 usernames duplicated

-- 9. More practice with aggregate functions:

-- a. Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
SELECT emp_no,  AVG(salary) AS average_salary
FROM salaries
GROUP BY emp_no;

-- b. Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
SELECT COUNT(dept_no) AS n_employees, dept_no
FROM dept_emp
GROUP BY dept_no;

-- c. Determine how many different salaries each employee has had. This includes both historic and current.
SELECT emp_no, COUNT(*) AS n_salaries
FROM salaries
GROUP BY emp_no;
-- d. Find the maximum salary for each employee.
SELECT emp_no, MAX(salary) AS max_salaries
FROM salaries
GROUP BY emp_no;

-- e. Find the minimum salary for each employee.
SELECT emp_no, MIN(salary) AS min_salaries
FROM salaries
GROUP BY emp_no;

-- f. Find the standard deviation of salaries for each employee.
SELECT emp_no, STD(salary) AS std_salaries
FROM salaries
GROUP BY emp_no;

-- g. Now find the max salary for each employee where that max salary is greater than $150,000.
SELECT emp_no, MAX(salary) AS max_salaries
FROM salaries
GROUP BY emp_no
HAVING max_salaries >150000;

-- h. Find the average salary for each employee where that average salary is between $80k and $90k.
SELECT emp_no,  AVG(salary) AS average_salary
FROM salaries
GROUP BY emp_no
HAVING average_salary BETWEEN 80000 and 90000;
