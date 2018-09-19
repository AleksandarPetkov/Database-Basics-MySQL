#.Create DATA BASE soft_uni.#
CREATE TABLE towns(
   id INT PRIMARY KEY AUTO_INCREMENT,
   `name` VARCHAR(20) NOT NULL
);

CREATE TABLE addresses(
   id INT PRIMARY KEY AUTO_INCREMENT,
   address_text VARCHAR(100) NOT NULL,
   town_id INT NOT NULL,
	CONSTRAINT fk_town_id
   FOREIGN KEY (town_id) REFERENCES towns(id)
);

CREATE TABLE departments(
   id INT PRIMARY KEY AUTO_INCREMENT,
   `name` VARCHAR(20) NOT NULL
);

CREATE TABLE employees(
   id INT PRIMARY KEY AUTO_INCREMENT,
   first_name VARCHAR(20) NOT NULL,
   middle_name VARCHAR(20),
   last_name VARCHAR(20) NOT NULL,
   job_title VARCHAR(50) NOT NULL,
   department_id INT NOT NULL,
	hire_date DATETIME NOT NULL,
   salary DOUBLE NOT NULL, 
   address_id INT NOT NULL,
   CONSTRAINT fk_department_id
   FOREIGN KEY (department_id) REFERENCES departments(id),
   CONSTRAINT fk_address_id
   FOREIGN KEY (address_id) REFERENCES addresses(id)

#.Basic Insert.#
INSERT INTO towns(`name`)
VALUES('Sofia'), ('Plovdiv'),('Varna'),('Burgas');

INSERT INTO departments(`name`)
VALUES('Engineering'), ('Sales'),('Marketing'),('Software Development'), ('Quality Assurance');

INSERT INTO employees(first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
VALUES('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);

#.Basic Select All Fields and Order Them.#
SELECT `name` FROM towns
ORDER BY `name`;
SELECT  `name` FROM departments
ORDER BY `name`;
SELECT first_name, last_name, job_title, salary FROM employees
ORDER BY salary DESC;

#.Increase Employees Salary.#
UPDATE employees
SET salary = salary + salary * 0.1;
SELECT salary FROM employees;
