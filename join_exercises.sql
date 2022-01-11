-- Create a file named join_exercises.sql to do your work in.

-- Join Example Database
-- Use the join_example_db. Select all the records from both the users and roles tables.

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
USE join_example_db;
SELECT users.name AS user_name, roles.name AS role_name
FROM users
JOIN roles 
ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles 
ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles 
ON users.role_id = roles.id;


-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
USE join_example_db;

SELECT roles.name, COUNT(roles.name) AS n_users
FROM users
RIGHT JOIN roles ON users.role_id = roles.id
GROUP BY roles.name;

/* Employees Database
Use the employees database. */
USE employees;

-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01';

/*
  Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  Finance            | Isamu Legleitner
  Human Resources    | Karsten Sigstam
  Marketing          | Vishwani Minakawa
  Production         | Oscar Ghazalie
  Quality Management | Dung Pesch
  Research           | Hilary Kambil
  Sales              | Hauke Zhang
  */
  
-- Find the name of all departments currently managed by women.
SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01' AND e.gender = 'F';

/*Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil
*/


-- Find the current titles of employees currently working in the Customer Service department.

-- formatted with emp_name
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, t.title, d.dept_name
FROM employees as e
JOIN titles AS t
  ON t.emp_no = e.emp_no
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' AND de.dept_no = 'd009' and t.to_date = '9999-01-01';

-- formatted as example
SELECT t.title, COUNT(*)
FROM employees as e
JOIN titles AS t
  ON t.emp_no = e.emp_no
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' AND de.dept_no = 'd009' and t.to_date = '9999-01-01'
GROUP BY t.title
ORDER BY t.title;

/*Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241
*/

-- Find the current salary of all current managers.
SELECT d.dept_name AS 'Department Name', CONCAT(e.first_name, ' ', e.last_name) AS Name, s.salary AS Salary
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
Join salaries AS s
  ON e.emp_no = s.emp_no	
WHERE dm.to_date = '9999-01-01' and s.to_date = '9999-01-01';

/* Department Name    | Name              | Salary
-------------------+-------------------+-------
Customer Service   | Yuchang Weedman   |  58745
Development        | Leon DasSarma     |  74510
Finance            | Isamu Legleitner  |  83457
Human Resources    | Karsten Sigstam   |  65400
Marketing          | Vishwani Minakawa | 106491
Production         | Oscar Ghazalie    |  56654
Quality Management | Dung Pesch        |  72876
Research           | Hilary Kambil     |  79393
Sales              | Hauke Zhang       | 101987
*/


-- Find the number of current employees in each department.

SELECT d.dept_no, d.dept_name, COUNT(de.emp_no)
FROM dept_emp AS de
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01'
GROUP BY d.dept_no
ORDER BY d.dept_no;


/*
+---------+--------------------+---------------+
| dept_no | dept_name          | num_employees |
+---------+--------------------+---------------+
| d001    | Marketing          | 14842         |
| d002    | Finance            | 12437         |
| d003    | Human Resources    | 12898         |
| d004    | Production         | 53304         |
| d005    | Development        | 61386         |
| d006    | Quality Management | 14546         |
| d007    | Sales              | 37701         |
| d008    | Research           | 15441         |
| d009    | Customer Service   | 17569         |
+---------+--------------------+---------------+*/

-- Which department has the highest average salary? Hint: Use current not historic information.
SELECT d.dept_name, AVG(s.salary) as average_salary
FROM dept_emp AS de
JOIN departments AS d
  ON d.dept_no = de.dept_no
JOIN salaries as s
  ON s.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01' and s.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY average_salary DESC;

/*
+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+
*/

-- Who is the highest paid employee in the Marketing department? */
SELECT e.first_name, e.last_name, s.salary, d.dept_name
FROM dept_emp AS de
JOIN departments AS d
  ON d.dept_no = de.dept_no
JOIN salaries as s
  ON s.emp_no = de.emp_no
JOIN employees as e
  ON e.emp_no = s.emp_no  
WHERE de.to_date = '9999-01-01' and s.to_date = '9999-01-01' and d.dept_name = 'Marketing'
ORDER BY s.salary DESC
LIMIT 1;

/*
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+*/

-- Which current department manager has the highest salary? 
SELECT e.first_name, e.last_name, s.salary, d.dept_name
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
Join salaries AS s
  ON e.emp_no = s.emp_no	
WHERE dm.to_date = '9999-01-01' and s.to_date = '9999-01-01'
ORDER BY s.salary DESC
LIMIT 1;

/*
+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+*/

-- Determine the average salary for each department. Use all salary information and round your results.
SELECT d.dept_name, ROUND(AVG(s.salary)) as average_salary
FROM dept_emp AS de
JOIN departments AS d
  ON d.dept_no = de.dept_no
JOIN salaries as s
  ON s.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01' and s.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY average_salary DESC;


/* THIS CHART APPEARS OFF AND CONFLICTS WITH PREVIOUS EXAMPLE
+--------------------+----------------+
| dept_name          | average_salary | 
+--------------------+----------------+
| Sales              | 80668          | 
+--------------------+----------------+
| Marketing          | 71913          |
+--------------------+----------------+
| Finance            | 70489          |
+--------------------+----------------+
| Research           | 59665          |
+--------------------+----------------+
| Production         | 59605          |
+--------------------+----------------+
| Development        | 59479          |
+--------------------+----------------+
| Customer Service   | 58770          |
+--------------------+----------------+
| Quality Management | 57251          |
+--------------------+----------------+
| Human Resources    | 55575          |
+--------------------+----------------+*/

-- Bonus Find the names of all current employees, their department name, and their current manager's name. 

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name', d.dept_name AS 'Department Name', t.manager AS 'Manager Name'
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
Join salaries AS s
  ON e.emp_no = s.emp_no	
JOIN(
SELECT dm.dept_no, e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS manager
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01') as t
  ON d.dept_no = t.dept_no
-- WHERE dm.to_date = '9999-01-01'
GROUP BY e.emp_no;

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name', d.dept_name AS 'Department Name', CONCAT(m.first_name, ' ', m.last_name) AS 'Manager Name'
FROM employees AS m
JOIN dept_manager AS dm
  ON dm.emp_no = m.emp_no
JOIN departments AS d
  ON d.dept_no = dm.dept_no
JOIN dept_emp AS de
  ON de.dept_no = d.dept_no
JOIN employees AS e
  ON de.emp_no = e.emp_no
WHERE de.to_date = '9999-01-01' and dm.to_date = '9999-01-01';
/*
240,124 Rows

Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman

 ..... */
 
-- Bonus Who is the highest paid employee within each department. 



SELECT d.dept_name AS 'department',
	CONCAT(e.first_name, ' ', e.last_name) AS 'employee',
	s.salary AS 'salary'
FROM departments AS d
JOIN dept_emp AS de
  ON d.dept_no = de.dept_no
JOIN employees AS e
  ON de.emp_no = e.emp_no
JOIN salaries AS s
  ON e.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'
AND (s.salary, d.dept_name)
IN
(
SELECT d.dept_name, MAX(s.salary)
FROM departments AS d
JOIN dept_emp AS de
  ON d.dept_no = de.dept_no
JOIN employees AS e
  ON de.emp_no = e.emp_no
JOIN salaries AS s
  ON e.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'
GROUP BY d.dept_name
);

