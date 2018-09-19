#CREATE DATABASE car_rental#
CREATE DATABASE car_rental;
USE car_rental;

CREATE TABLE categories(
  id INT PRIMARY KEY AUTO_INCREMENT, 
  category VARCHAR(30) NOT NULL,
  daily_rate DOUBLE NOT NULL,
  weekly_rate DOUBLE NOT NULL,
  monthly_rate DOUBLE NOT NULL,
  weekend_rate DOUBLE NOT NULL
);

CREATE TABLE cars(
  id INT PRIMARY KEY AUTO_INCREMENT, 
  plate_number VARCHAR(20) NOT NULL,
  make VARCHAR(20) NOT NULL,
  model VARCHAR(20) NOT NULL,
  car_year YEAR NOT NULL,
  category_id INT NOT NULL,
  doors INT,
  picture BLOB,
  car_condition VARCHAR(100),
  available VARCHAR(10) NOT NULL
);


CREATE TABLE employees(
   id INT PRIMARY KEY AUTO_INCREMENT,
   first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	title VARCHAR(50) NOT NULL,
	notes TEXT
);

CREATE TABLE customers(
   id INT PRIMARY KEY AUTO_INCREMENT,
   driver_licence_number VARCHAR(50) NOT NULL,
	full_name VARCHAR(80) NOT NULL,
	address VARCHAR(80) NOT NULL,
	city VARCHAR(30) NOT NULL,
	zip_code VARCHAR(30) NOT NULL,
	notes TEXT
);

CREATE TABLE rental_orders(
   id INT PRIMARY KEY AUTO_INCREMENT,
   employee_id INT,
	customer_id INT,
	car_id INT,
	car_condition VARCHAR(100),
	tank_level VARCHAR(100) NOT NULL,
   kilometrage_start INT NOT NULL,
	kilometrage_end INT NOT NULL,
	total_kilometrage INT NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
   total_days INT NOT NULL,
	rate_applied INT NOT NULL,
	tax_rate DOUBLE NOT NULL,
	order_status VARCHAR(100),
	notes TEXT
);

INSERT INTO categories(category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
VALUES('taxi', 35.0, 150.0, 300.0, 42.0),
('tank', 35.0, 150.0, 300.0, 42.0),
('karuca', 35.0, 150.0, 300.0, 42.0);

INSERT INTO cars(plate_number, make, model, car_year, category_id, car_condition, available)
VALUES('PB4444CB', 'trabant', 'DOG', '1950', 2, 'BROKEN', 'OYees'),
('1313', 'traba313nt', 'DOG', '1950', 2, 'BROKEN', 'OYees'),
('sss', 'traba313nt', 'DOG', '1950', 2, 'BROKEN', 'OYees');


INSERT INTO employees(first_name, last_name, title)
VALUES('goro', 'mro', 'driver'),
('goro', 'mro', 'driver'),
('goro', 'mro', 'driver');

INSERT INTO customers(driver_licence_number, full_name, address, city, zip_code)
VALUES('323KJH2312', 'ICO TIGURA', 'KOTEL', 'Whatley22', 'SW209C'),
('323KJH2312', 'ICO TIGURA', 'KOTEL', 'Whatley22', 'SW209C'),
('323KJH2312', 'ICO TIGURA', 'KOTEL', 'Whatley22', 'SW209C');


INSERT INTO rental_orders(tank_level,
kilometrage_start, kilometrage_end, total_kilometrage, start_date, end_date,
total_days, rate_applied, tax_rate )
VALUES('low', 10000, 11000, 1000, '2018:11:10', '2018:12:10' , 2, 11, 120.0),
('low', 10000, 11000, 1000, '2018:11:10', '2018:12:10' , 2, 11, 120.0),
('low', 10000, 11000, 1000, '2018:11:10', '2018:12:10' , 2, 11, 120.0);