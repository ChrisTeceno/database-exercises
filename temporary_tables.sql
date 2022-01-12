-- CREATE a FILE named temporary_tables.sql TO DO your WORK FOR this exercise.

-- 1. USING the example FROM the lesson, CREATE a TEMPORARY TABLE called employees_with_departments that CONTAINS first_name, last_name, AND dept_name FOR employees currently WITH that department. Be absolutely sure TO CREATE this TABLE ON your own database. IF you see "Access denied for user ...", it means that the QUERY was attempting TO WRITE a NEW TABLE TO a DATABASE that you can only read.
USE employees;

CREATE TEMPORARY TABLE innis_1662.employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
LIMIT 100;

USE innis_1662;
SELECT * FROM employees_with_departments;
DESCRIBE employees_with_departments;

-- ADD a COLUMN named full_name TO this table. It should be a VARCHAR whose length IS the sum of the lengths of the FIRST NAME AND LAST NAME COLUMNS
ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

-- UPDATE the TABLE so that FULL NAME COLUMN CONTAINS the correct DATA
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

-- Remove the first_name AND last_name COLUMNS FROM the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- What IS another way you could have ended up WITH this same TABLE?
-- Create a table with the full name built in during creation and not pull first/last name

-- 2. CREATE a TEMPORARY TABLE based ON the payment TABLE FROM the sakila database.
-- WRITE the SQL necessary TO transform the amount COLUMN such that it IS stored AS an INTEGER representing the number of cents of the payment. FOR example, 1.99 should become 199.
USE sakila;
SELECT * FROM payment LIMIT 2;
DESCRIBE payment;

-- create table
CREATE TEMPORARY TABLE innis_1662.payment_with_int AS
SELECT payment_id, customer_id, staff_id, rental_id, payment_date, last_update, amount
FROM payment
LIMIT 100;

-- move to my db
USE innis_1662;

-- view table
SELECT * FROM payment_with_int;

-- add temp column
ALTER TABLE payment_with_int ADD temp_amount INTEGER;

-- fill temp column
UPDATE payment_with_int
SET temp_amount = amount*100;

-- view table
SELECT * FROM payment_with_int;

-- delete old
ALTER TABLE payment_with_int DROP COLUMN amount;

-- add amount back
ALTER TABLE payment_with_int ADD amount INTEGER;

-- fill amount
UPDATE payment_with_int
SET amount = temp_amount;

-- delete temp
ALTER TABLE payment_with_int DROP COLUMN temp_amount;

-- delete table
DROP TABLE payment_with_int;


-- 3.Find OUT how the current average pay IN EACH department compares TO the overall, historical average pay. IN order TO make the comparison easier, you should USE the Z-score FOR salaries. IN terms of salary, what IS the best department RIGHT now TO WORK FOR? The worst?

-- delete table (if needed)
DROP TABLE department_averages;

USE employees;


-- create temp table for average salary by dept
CREATE TEMPORARY TABLE innis_1662.department_averages AS
SELECT d.dept_name AS department,
		 AVG(s.salary) AS avg_dep_sal
		FROM departments AS d
		JOIN dept_emp AS de
		USING(dept_no)
		JOIN employees AS e
		USING (emp_no)
		JOIN salaries AS s
		USING (emp_no)
		WHERE s.to_date = '9999-01-01'
		GROUP BY d.dept_name;
		
-- view temp table
SELECT * FROM innis_1662.department_averages;
		
-- calc z-scores per department
SELECT department, avg_dep_sal, 
	(avg_dep_sal - (SELECT AVG(salary) FROM salaries)) 
          /        
	(SELECT stddev(salary) FROM salaries) 
       AS zscore
FROM innis_1662.department_averages
ORDER BY zscore DESC;

/* Sales is the best department with a z-score of approx 1.5, HR is the worst and the only department with less salary than average

Sales					88842.1590	1.480725727431701
Marketing				80014.6861	0.9585392402571363
Finance				78644.9069	0.8775103663364036
Research				67932.7147	0.2438338795066598
Production			67841.9487	0.2384646442530589
Development			67665.6241	0.2280342159164893
Customer Service	66971.3536	0.1869648546563796
Quality Management	65382.0637	0.09295089172673808
Human Resources		63795.0217	-0.0009300973588806601 */



