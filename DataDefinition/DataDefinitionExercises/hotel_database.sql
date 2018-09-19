#CREATE DATABASE hotel#/

CREATE DATABASE hotel;
USE hotel;

CREATE TABLE employees(
   id INT PRIMARY KEY AUTO_INCREMENT,
   first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	title VARCHAR(50) NOT NULL,
	notes TEXT
);
INSERT INTO employees(first_name, last_name, title)
VALUES('goro', 'mro', 'driver'),
('goro', 'mro', 'driver'),
('goro', 'mro', 'driver');

CREATE TABLE customers(
  account_number INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  phone_number VARCHAR(30) NOT NULL,
  emergency_name VARCHAR(30),
  emergency_number VARCHAR(30),
  notes TEXT
  
);

CREATE TABLE room_status(
  room_status VARCHAR(50) NOT NULL,
  notes TEXT
);

CREATE TABLE room_types(
  room_type VARCHAR(50) NOT NULL,
  notes TEXT
);

CREATE TABLE bed_types(
  bed_type VARCHAR(50) NOT NULL,
  notes TEXT
);

CREATE TABLE rooms(
  room_number INT PRIMARY KEY,
  room_type VARCHAR(50),
  bed_type VARCHAR(50),
  rate DOUBLE NOT NULL,
  room_status VARCHAR(50),
  notes TEXT
);

CREATE TABLE payments(
  id INT PRIMARY KEY AUTO_INCREMENT,
  employee_id INT,
  payment_date DATE NOT NULL,
  account_number INT,
  first_date_occupied DATE NOT NULL,
  last_date_occupied DATE NOT NULL,
  total_days INT NOT NULL,
  amount_charged DOUBLE NOT NULL,
  tax_rate DOUBLE NOT NULL,
  tax_amount DOUBLE NOT NULL,
  payment_total DOUBLE NOT NULL,
  notes TEXT
);

CREATE TABLE occupancies(
   id INT PRIMARY KEY AUTO_INCREMENT,
   employee_id INT NOT NULL,
   date_occupied DATE NOT NULL,
   account_number INT NOT NULL,
   room_number INT NOT NULL,
   rate_applied DOUBLE NOT NULL,
   phone_charge DOUBLE NOT NULL,
	notes TEXT
);

INSERT INTO occupancies(date_occupied, rate_applied, phone_charge,employee_id, 
account_number, room_number)
VALUES('1991:11:21', 22.2, 5.2, 1, 1, 1),
('1991:11:21', 22.2, 5.2, 2, 2, 2),
('1991:11:21', 22.2, 5.2, 3, 3, 3);

INSERT INTO customers(first_name, last_name, phone_number)
VALUES('goro', 'mro', '0987313131'),
('goro', 'mro', '0987313131'),
('goro', 'mro', '0987313131');

INSERT INTO room_status(`room_status`)
VALUES('Emty'), ('Emty'),('Emty');

INSERT INTO room_types(`room_type`)
VALUES('Apartment'), ('Apartment'),('Apartment');

INSERT INTO bed_types(`bed_type`)
VALUES('Double'), ('Single'),('Single');

INSERT INTO rooms(room_number, rate)
VALUES(112, 50.0), (111, 50.0), (123, 50.0);

INSERT INTO payments(payment_date, first_date_occupied,
last_date_occupied, total_days, amount_charged, tax_rate, tax_amount, payment_total)
VALUES('2018:12:11', '2018:12:11', '2018:12:11', 4, 20.0, 10.0, 210.0, 12.0),
('2018:12:11', '2018:12:11', '2018:12:11', 4, 20.0, 10.0, 210.0, 12.0),
('2018:12:11', '2018:12:11', '2018:12:11', 4, 20.0, 10.0, 210.0, 12.0);

#Decrease Tax Rate#
UPDATE payments
SET tax_rate = tax_rate - tax_rate * 0.03;
SELECT tax_rate FROM payments;