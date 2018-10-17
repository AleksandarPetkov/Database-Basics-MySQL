CREATE DATABASE airport_management_system;
USE airport_management_system;


#01. Table Design#
CREATE TABLE towns(
  town_id INT PRIMARY KEY AUTO_INCREMENT,
  town_name VARCHAR(30) NOT NULL
);

CREATE TABLE airports(
  airport_id INT PRIMARY KEY AUTO_INCREMENT,
  airport_name VARCHAR(50) NOT NULL,
  town_id INT,
  CONSTRAINT fk_town_id
  FOREIGN KEY (town_id) REFERENCES towns(town_id)
);

CREATE TABLE airlines(
  airline_id INT PRIMARY KEY AUTO_INCREMENT,
  airline_name VARCHAR(30) NOT NULL,
  nationality VARCHAR(30) NOT NULL,
  rating INT DEFAULT 0 NOT NULL
);

CREATE TABLE customers(
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  date_of_birth DATE NOT NULL,
  gender VARCHAR(1) NOT NULL,
  home_town_id INT NOT NULL,
  CONSTRAINT fk_home_town
  FOREIGN KEY (home_town_id) REFERENCES airports(airport_id)
);

CREATE TABLE flights(
  flight_id INT PRIMARY KEY AUTO_INCREMENT,
  departure_time DATETIME NOT NULL,
  arrival_time DATETIME NOT NULL,
  status VARCHAR(9) NOT NULL,
  origin_airport_id INT,
  CONSTRAINT fk_origin_airport_id
  FOREIGN KEY (origin_airport_id) REFERENCES airports(airport_id),

  destination_airport_id INT,
  CONSTRAINT fk_destination_id
  FOREIGN KEY (destination_airport_id) REFERENCES airports(airport_id),

  airline_id INT,
  CONSTRAINT fk_airline_id
  FOREIGN KEY (airline_id) REFERENCES airlines(airline_id)
);

CREATE TABLE tickets(
  ticket_id INT PRIMARY KEY AUTO_INCREMENT,
  price DECIMAL(8,2) NOT NULL,
  class VARCHAR(6) NOT NULL,
  seat VARCHAR(5) NOT NULL,
  customer_id INT,
  CONSTRAINT fk_customer_id
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),

  flight_id INT,
  CONSTRAINT fk_flight_id
  FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);


#02. Insert#
INSERT INTO flights(departure_time, arrival_time, status, origin_airport_id, destination_airport_id, airline_id)
SELECT '2017-06-19 14:00:00' AS departure_time,
       '2017-06-21 11:00:00' AS arrival_time,
       (CASE
          WHEN airline_id % 4 = 0 THEN 'Departing'
          WHEN airline_id % 4 = 1 THEN 'Delayed'
          WHEN airline_id % 4 = 2 THEN 'Arrived'
          WHEN airline_id % 4 = 3 THEN 'Canceled'
           END) AS status,
       ceil(sqrt(char_length(airline_name))) AS origin_airport_id,
       ceil(sqrt(char_length(nationality))) AS destination_airport_id,
       airline_id AS airline_id
FROM airlines AS a
WHERE airline_id BETWEEN 1 AND 10;

#03. Update Flights#
UPDATE flights
SET airline_id = 1
WHERE flights.status = 'Arrived';

#04. Update Tickets #
UPDATE tickets AS t
JOIN flights f ON t.flight_id = f.flight_id
JOIN airlines a ON f.airline_id = a.airline_id
SET price = price * 1.5
WHERE rating = (SELECT max(rating) FROM airlines);

#05. Tickets#
SELECT t.ticket_id, t.price, t.class, t.seat
FROM tickets AS t
ORDER BY
         ticket_id;

#06.	Customers#
SELECT c.customer_id, concat(c.first_name, ' ', c.last_name) AS `full_name`, c.gender
FROM customers AS c
ORDER BY
         full_name , customer_id;

#07. Flights#
SELECT s.flight_id, s.departure_time, s.arrival_time
FROM flights AS s
WHERE s.status = 'Delayed'
ORDER BY flight_id;

#08. Top 5 Airlines#
SELECT a.airline_id,a.airline_name, a.nationality, a.rating
FROM airlines AS a
ORDER BY a.rating DESC, airline_id
LIMIT 5;

#09. First Class Tickets#
SELECT t.ticket_id, a.airport_name, concat(c.first_name, ' ', c.last_name) AS `customer_name`
FROM tickets AS t
       JOIN flights f ON t.flight_id = f.flight_id
       JOIN airports a ON f.destination_airport_id = a.airport_id
       JOIN customers c ON t.customer_id = c.customer_id
WHERE t.price < 5000 AND t.class = 'First'
ORDER BY t.ticket_id;

#10. Home Town Customers #
SELECT DISTINCT c.customer_id, concat(c.first_name, ' ', c.last_name) AS `full_name`, t.town_name
FROM customers AS c
       JOIN towns AS t
         ON c.home_town_id = t.town_id

       JOIN tickets AS tc
         ON c.customer_id = tc.customer_id

       JOIN flights f ON
        tc.flight_id = f.flight_id

       JOIN airports a
         ON f.origin_airport_id = a.airport_id  AND a.town_id = c.home_town_id

WHERE f.status = 'Departing'
ORDER BY c.customer_id ASC;


#11.	Flying Customers #
SELECT DISTINCT c.customer_id, concat(c.first_name, ' ', c.last_name) AS `full_name`,
                timestampdiff(YEAR, date_of_birth, '2016-12-31') AS `age`
FROM customers AS c
       LEFT JOIN tickets t on c.customer_id = t.customer_id

       JOIN flights f on t.flight_id = f.flight_id
WHERE f.status = 'Departing'
ORDER BY age, c.customer_id;


#12.	Delayed Customers #
SELECT c.customer_id, concat(c.first_name, ' ', c.last_name) AS `full_name`,
       t.price, a.airport_name
FROM customers AS c
       JOIN tickets AS t
         ON c.customer_id = t.customer_id

       JOIN flights AS f
         ON t.flight_id = f.flight_id

       JOIN airports AS a
         ON f.destination_airport_id = a.airport_id
WHERE f.status = 'Delayed'
ORDER BY t.price DESC
LIMIT 3;

#13. Last Departing Flights#
SELECT fly.flight_id, d_time, a_time, a.airport_name, a1.airport_name
          FROM(
              SELECT f.flight_id,
                      (departure_time) AS `d_time`,
                      (f.arrival_time) AS `a_time`,
                      f.origin_airport_id AS `origin`,
                      f.destination_airport_id AS `dest`
               FROM flights AS f
               WHERE f.status = 'Departing'
               ORDER BY f.departure_time DESC
               LIMIT 5
              ) AS fly
JOIN airports AS a
ON fly.origin = a.airport_id
JOIN airports AS a1
ON fly.dest = a1.airport_id
ORDER BY fly.d_time, fly.flight_id;

#14. Flying Children#
SELECT DISTINCT c.customer_id, concat(c.first_name, ' ', c.last_name), timestampdiff(YEAR, c.date_of_birth, '2016-12-31') AS `age`
FROM customers AS c
JOIN tickets AS t
ON c.customer_id = t.customer_id

JOIN flights AS f
ON t.flight_id = f.flight_id
WHERE timestampdiff(YEAR, c.date_of_birth, '2016-12-31') < 21
AND f.status = 'Arrived'
ORDER BY age DESC , c.customer_id;



#Section: Programmability#
#16. Submit Review#
CREATE TABLE customer_reviews(
  review_id INT PRIMARY KEY,
  review_content VARCHAR(255) NOT NULL,
  review_grade INT,
  airline_id INT,
  CONSTRAINT fk_airline_id_airline
  FOREIGN KEY (airline_id) REFERENCES airlines(airline_id),
  customer_id INT,
  CONSTRAINT fk_customer_id_customer
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE customer_bank_accounts(
  account_id INT PRIMARY KEY,
  account_number VARCHAR(10) UNIQUE NOT NULL,
  balance DECIMAL(10, 2) NOT NULL,
  customer_id INT,
  CONSTRAINT fk_customer_bank_acc_customer
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE PROCEDURE udp_submit_review(customer_id INT, review_content VARCHAR(255),
  	             review_grade INT, airline_name VARCHAR(30))
  BEGIN
    DECLARE currnet_airline VARCHAR(30);
    SET currnet_airline := (
                           (SELECT a.airline_name FROM airlines AS a
                            WHERE a.airline_name = airline_name)
                           );
    IF(currnet_airline <> airline_name) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Airline does not exist.';
    ELSE
      INSERT INTO customer_reviews(customer_id, review_content, review_grade )
      VALUES (customer_id,review_content, review_grade );
    END IF;
  END;


#17. Ticket Purchase #
CREATE PROCEDURE udp_purchase_ticket(customer_id INT,	flight_id INT, ticket_price DECIMAL(10, 2),
  class VARCHAR(6), seat VARCHAR(5))
  BEGIN
    DECLARE customer_balance DECIMAL;
    SET customer_balance :=(
                       SELECT cba.balance FROM customer_bank_accounts AS cba
                       WHERE cba.customer_id = customer_id
                       );
      IF (ticket_price > customer_balance) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient bank account balance for ticket purchase.';

      ELSE
       UPDATE customer_bank_accounts AS cb
       SET cb.balance = cb.balance - ticket_price;

    INSERT INTO tickets(price, customer_id,	flight_id, class, seat)
    VALUES (ticket_price, customer_id,	flight_id, class, seat);
    END IF;
  END;
