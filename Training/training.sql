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