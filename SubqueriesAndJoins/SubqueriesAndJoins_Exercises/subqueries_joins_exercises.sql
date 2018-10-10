#1. Employee Address#
SELECT e.employee_id ,e.job_title ,e.address_id ,a.address_text
FROM employees AS e
JOIN addresses AS a
ON e.address_id = a.address_id
ORDER BY e.address_id
LIMIT 5;

#2. Addresses with Towns#
SELECT e.first_name, e.last_name, t.name ,a.address_text
FROM employees AS e
JOIN addresses AS a
ON e.address_id = a.address_id
    
JOIN towns AS t
ON a.town_id = t.town_id
ORDER BY e.first_name, e.last_name
LIMIT 5;

#03. Sales Employee#
SELECT e.employee_id, e.first_name, e.last_name, d.name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE d.name = 'Sales'
ORDER BY e.employee_id DESC

#04. Employee Departments#
SELECT e.employee_id, e.first_name, e.salary, d.name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE e.salary > 15000
ORDER BY d.department_id DESC
LIMIT 5

#5. Employees Without Project#
SELECT e.employee_id, e.first_name FROM employees AS e
LEFT JOIN employees_projects AS ep
ON e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL
ORDER BY employee_id DESC
LIMIT 3

#06.  Employees Hired After#
SELECT e.first_name, e.last_name, e.hire_date, d.name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE e.hire_date >= '1999-01-02' AND
d.name IN('Sales', 'Finance')
ORDER BY hire_date ASC;

#07.  Employees with Project#
SELECT e.employee_id, e.first_name, p.name FROM employees AS e
JOIN employees_projects AS ep
ON e.employee_id = ep.employee_id

JOIN projects AS p
ON p.project_id = ep.project_id

WHERE p.start_date >= '2002-08-14' AND p.end_date IS NULL
ORDER BY e.first_name, p.name
LIMIT 5

#08.  Employee 24#
SELECT e.employee_id, e.first_name,
       CASE
         WHEN p.start_date >= '2005-01-01' THEN  NULL
         ELSE p.name
         END AS `project_name`

FROM employees AS e
JOIN employees_projects AS ep
ON e.employee_id = ep.employee_id

JOIN projects AS p
ON p.project_id = ep.project_id

WHERE e.employee_id = 24
ORDER BY project_name ASC

#09.  Employee Manager#
SELECT e.employee_id, e.first_name, e.manager_id, m.first_name
FROM employees AS e
JOIN employees AS m
ON e.manager_id = m.employee_id
WHERE e.manager_id IN (3,7)
ORDER BY e.first_name ASC

#10.  Employee Summary#
SELECT e.employee_id,
       CONCAT(e.first_name, ' ' , e.last_name) AS employee_name,
       CONCAT(e1.first_name, ' ', e1.last_name) as manager_name,
       d.name AS department_name
FROM employees AS e
       JOIN employees AS e1
       ON e.manager_id = e1.employee_id

       JOIN departments AS d
       ON d.department_id = e.department_id
WHERE e.manager_id IS NOT NULL
ORDER BY e.employee_id 
LIMIT 5;


#11.  Min Average Salary#
SELECT avg(salary) FROM employees
GROUP BY department_id
ORDER BY salary ASC
LIMIT 1

#12. Highest Peaks in Bulgaria #
SELECT c.country_code, m.mountain_range, p.peak_name, p.elevation
FROM countries AS c
JOIN mountains_countries AS mc
ON mc.country_code = c.country_code

JOIN mountains AS m
ON m.id = mc.mountain_id

JOIN peaks AS p
ON p.mountain_id = m.id

WHERE c.country_code = 'BG' AND p.elevation > 2835
ORDER BY p.elevation DESC

#13. Count Mountain Ranges#
SELECT country_code, count(mountain_id) AS `mountain_range`
FROM mountains_countries
WHERE country_code IN('BG', 'RU', 'US')
GROUP BY country_code
ORDER BY mountain_range DESC

#14. Countries with Rivers#
SELECT c.country_name, r.river_name
FROM countries AS c
LEFT JOIN countries_rivers AS cr
ON c.country_code = cr.country_code

LEFT JOIN rivers r
ON cr.river_id = r.id
WHERE c.continent_code = 'AF'
ORDER BY c.country_name ASC
LIMIT 5

#16. Countries without any Mountains #
SELECT count(c.continent_code) AS `country_count`
FROM countries AS c
LEFT JOIN mountains_countries mc
ON c.country_code = mc.country_code
WHERE mc.mountain_id IS NULL

#17. Highest Peak and Longest River by Country #
SELECT c.country_name, max(p.elevation) AS `highest_peak_elevation`, max(r.length) AS `longest_river_length`
FROM countries AS c
JOIN mountains_countries mc
ON c.country_code = mc.country_code

JOIN peaks AS p
ON p.mountain_id = mc.mountain_id

JOIN countries_rivers AS cr
ON c.country_code = cr.country_code

JOIN rivers r
ON cr.river_id = r.id
GROUP BY c.country_name
ORDER BY highest_peak_elevation DESC, longest_river_length DESC
LIMIT 5

