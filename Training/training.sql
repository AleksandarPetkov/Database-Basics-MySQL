USE osft_uni;
#   Basic CRUD   #

SELECT * FROM departments
ORDER BY department_id;

SELECT name FROM departments
ORDER BY department_id;

SELECT first_name, last_name, salary FROM employees 
ORDER BY employee_id;

SELECT CONCAT(first_name, '.' , last_name, '@softuni.bg') AS 'full_ email_address' FROM employees;

SELECT e.salary FROM employees AS e
WHERE 
salary = 12500.00 OR
salary = 13500.00  OR
salary = 43300.00
ORDER BY employee_id;

SELECT e.first_name, e.last_name, e.job_title FROM employees AS e
WHERE e.salary BETWEEN 20000 AND 30000
ORDER BY e.employee_id;

UPDATE employees
SET salary = salary * 1.12
WHERE department_id IN(1,2,4,11);

CREATE VIEW `v_employees_job_titles` AS
SELECT concat(first_name, ' ',
 (CASE WHEN middle_name IS NULL THEN ''
ELSE middle_name
END)
 ,' ', last_name) AS `full_name`, job_title
FROM employees;

# Build In Function #

SELECT first_name, last_name FROM employees
WHERE first_name LIKE 'sa%'
ORDER BY employee_id;

SELECT first_name, last_name FROM employees
WHERE last_name LIKE '%ei%'
ORDER BY employee_id;

SELECT first_name FROM employees
WHERE department_id IN (3, 10)
AND YEAR (hire_date) BETWEEN 1995 AND 2005
ORDER BY employee_id;

SELECT first_name, last_name FROM employees
WHERE job_title NOT LIKE '%engineer%'
ORDER BY employee_id;

SELECT name FROM towns
WHERE length(name) BETWEEN 5 AND 6
ORDER BY name;

SELECT town_id, name FROM towns
WHERE name LIKE 'M%'
OR name LIKE 'K%'
OR name LIKE 'B%'
OR name LIKE 'E%'
ORDER BY name;

SELECT town_id, name FROM towns
WHERE NOT (
`name` LIKE('R%') OR
`name` LIKE('B%') OR
`name` LIKE('D%')
)
ORDER BY `name`;
