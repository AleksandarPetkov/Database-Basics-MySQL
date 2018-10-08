#01. Managers #
SELECT e.employee_id , CONCAT(e.first_name, ' ', e.last_name) AS `full Name`,
d.department_id, `name` FROM employees AS e
RIGHT JOIN departments AS d
ON d.department_id = e.employee_id
ORDER BY e.employee_id
LIMIT 5;

#02. Towns and Addresses #
SELECT t.town_id, `name`, address_text FROM towns AS t
LEFT JOIN addresses AS a
ON t.town_id = a.town_id
WHERE t.`name` = 'San Francisco'
OR `name` = 'Sofia'
OR `name` = 'Carnation'
ORDER BY t.town_id, a.address_id;

#03. Employees Without Managers#
SELECT employee_id, `first_name`, last_name, department_id, salary FROM employees AS e
WHERE manager_id IS NULL;

#04. High Salary#
SELECT count(*) AS 'count' FROM employees AS e
WHERE e.salary > (SELECT avg(emp.salary) FROM employees AS emp)