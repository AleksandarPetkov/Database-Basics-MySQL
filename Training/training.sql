USE soft_uni;
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

CREATE VIEW v_employees_hired_after_2000 AS
SELECT first_name, last_name
FROM employees
WHERE YEAR(hire_date) >= 2000;

SELECT first_name, last_name FROM employees
WHERE length(last_name) = 5;

USE geography;

SELECT iso_code, country_name FROM countries
WHERE country_name LIKE('%a%a%a%')
ORDER BY iso_code;

SELECT p.peak_name, r.river_name,
LOWER(CONCAT(SUBSTRING(p.peak_name,1,CHAR_LENGTH(peak_name) - 1), r.river_name)) AS 'mix'
FROM peaks AS p, rivers AS r
WHERE RIGHT(p.peak_name, 1) = LEFT(r.river_name, 1)
ORDER BY mix;

use gringotts;

SELECT COUNT(*) FROM wizzard_deposits;

SELECT MAX(wd.magic_wand_size) AS 'longest_magic_size' FROM wizzard_deposits AS wd;

SELECT deposit_group, MAX(wd.magic_wand_size) AS 'longest_magic_size' 
FROM wizzard_deposits AS wd
GROUP BY deposit_group
ORDER BY MAX(wd.magic_wand_size) 
, deposit_group;

SELECT deposit_group FROM wizzard_deposits AS wd
GROUP BY deposit_group
ORDER BY AVG(wd.magic_wand_size)
LIMIT 1;

SELECT wd.deposit_group, SUM(wd.deposit_amount) AS 'total_sum'
FROM wizzard_deposits AS wd
GROUP BY deposit_group
ORDER BY SUM(wd.deposit_amount);

SELECT wd.deposit_group, SUM(wd.deposit_amount) AS 'total_sum'
FROM wizzard_deposits AS wd
WHERE wd.magic_wand_creator = 'Ollivander family'
GROUP BY  wd.deposit_group
HAVING SUM(wd.deposit_amount)  < 150000
ORDER BY total_sum DESC;

SELECT deposit_group, magic_wand_creator FROM wizzard_deposits
GROUP BY deposit_group, magic_wand_creator;

#   JOINS  #
SELECT e.employee_id, e.job_title, a.address_id, a.address_text FROM employees AS e
JOIN addresses AS a
ON e.address_id = a.address_id
ORDER BY  a.address_id
LIMIT 5;

SELECT e.employee_id, e.first_name FROM employees AS e
LEFT JOIN employees_projects AS ep
ON e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL
ORDER BY employee_id DESC
LIMIT 3