-- Create a file named where_exercises.sql. Make sure to use the employees database. DONE

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');
-- 709 results

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?
SELECT *
FROM employees
WHERE first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya';
-- 709 results as well


-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
SELECT *
FROM employees
WHERE gender = 'M'
AND 
first_name IN ('Irena', 'Vidya', 'Maya');
-- 441 results

-- Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
SELECT *
FROM employees
WHERE last_name like "E%";
-- 7330 results

-- Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?
SELECT *
FROM employees
WHERE last_name like "E%" or last_name like '%E';
-- 30723 results
SELECT *
FROM employees
WHERE last_name not like "E%" and last_name like '%E';
-- 23393 results


-- Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?
SELECT *
FROM employees
WHERE last_name like "E%" AND last_name like '%E';
-- 899 results

SELECT *
FROM employees
WHERE last_name like '%E';
-- 24292 results

-- Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
SELECT *
FROM employees
WHERE hire_date between "1990-01-01" and "1999-12-31";
-- 135214 results


-- Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
SELECT *
FROM employees
WHERE birth_date like "%-12-25";
-- 842 results

-- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.
SELECT *
FROM employees
WHERE hire_date between "1990-01-01" and "1999-12-31"
AND birth_date like "%-12-25";
-- 362 results


-- Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.
SELECT *
FROM employees
WHERE last_name like "%Q%";
-- 1873 results 

-- Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?

SELECT *
FROM employees
WHERE last_name like "%Q%" and last_name not like "%QU%";
-- 547 results