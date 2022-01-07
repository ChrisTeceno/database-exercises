-- Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson. DONE

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;
-- Irena Reutenauer is the first
-- Vidya Simmen is the last

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;
-- Irena Acton first
-- Vidya Zweizig last

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;
-- Irena Acton first
-- Maya Zyda last

-- Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
Select *
FROM employees
WHERE last_name LIKE 'E%' and last_name LIKE '%E'
ORDER BY emp_no;
-- 899 results
-- 10021 Ramzi Erde
-- 499648 Tadahiro Erde

-- Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.
Select *
FROM employees
WHERE last_name LIKE 'E%' and last_name LIKE '%E'
ORDER BY hire_date DESC;
-- 899 results
-- Teiji Eldridge newest
-- Sergi Erde oldest

-- Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.
SELECT *
FROM employees
WHERE hire_date between "1990-01-01" and "1999-12-31"
AND birth_date like "%-12-25"
ORDER BY birth_date, hire_date DESC;
-- 362 results
-- Khun Berni
-- Douadi Pettis