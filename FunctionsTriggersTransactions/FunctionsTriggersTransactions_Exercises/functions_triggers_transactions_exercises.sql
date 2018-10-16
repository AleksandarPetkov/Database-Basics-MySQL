/*1.	Count Employees by Town
Write a function ufn_count_employees_by_town(town_name) that accepts town_name as parameter and returns the count of
employees who live in that town. Submit your queries using the “MySQL Run Skeleton, run queries and check DB” strategy.
*/

DELIMITER $$
CREATE FUNCTION
  ufn_count_employees_by_town(town_name VARCHAR(20))
  RETURNS INTEGER
  BEGIN
    DECLARE e_count INTEGER;
    SET e_count :=(SELECT count(employee_id)FROM employees e
                  JOIN addresses a ON e.address_id = a.address_id
                  JOIN towns t ON t.town_id = a.town_id
                  WHERE t.name = town_name);
    RETURN e_count;
  END$$

SELECT ufn_count_employees_by_town('Sofia');

/*2.	Employees Promotion
Write a stored procedure usp_raise_salaries(department_name) to raise the salary of all employees in given
department as parameter by 5%. Submit your queries using the “MySQL Run Skeleton, run queries and check DB” strategy.
*/

DELIMITER $$

CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
  BEGIN UPDATE employees
  SET salary = salary * 1.05
    WHERE department_id = (SELECT department_id FROM departments
                          WHERE name = department_name);
    END $$

CALL usp_raise_salaries('Finance');

/*3.	Employees Promotion By ID
Write a stored procedure usp_raise_salary_by_id(id) that raises a given employee’s salary (by id as parameter) by 5%.
Consider that you cannot promote an employee that doesn’t exist – if that happens, no changes to the database should
be made. Submit your queries using the “MySQL Run Skeleton, run queries and check DB” strategy.
*/

DELIMITER $$
CREATE PROCEDURE usp_raise_salary_by_id(id INT)
  BEGIN
    UPDATE employees e
    SET e.salary = e.salary * 1.05
    WHERE e.employee_id = id;
  END $$

/*4.	Triggered
Create a table deleted_employees(employee_id PK, first_name,last_name,middle_name,job_title,deparment_id,salary)
that will hold information about fired(deleted) employees from the employees table.
Add a trigger to employees table that inserts the corresponding information in deleted_employees.
Submit your queries using the “MySQL Run Skeleton, run queries and check DB” strategy.
*/

CREATE TABLE deleted_employees(
  employee_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(50) NOT NULL ,
  last_name VARCHAR(50)NOT NULL ,
  middle_name VARCHAR(50),
  job_title VARCHAR(50),
  department_id INT(10),
  salary DECIMAL(19,4));

CREATE TRIGGER tr_deleted_employees
  AFTER DELETE
  ON employees
  FOR EACH ROW
  BEGIN
    INSERT INTO deleted_employees(first_name, last_name, middle_name, job_title, department_id, salary)
    VALUES (OLD.first_name,OLD.last_name,OLD.middle_name,OLD.job_title,OLD.department_id,OLD.salary);
  END $$

#Exercises: Functions, Triggers and Transactions


/*1.	Employees with Salary Above 35000
Create stored procedure usp_get_employees_salary_above_35000 that returns all employees’ first and last names for
whose salary is above 35000. The result should be sorted by first_name then by last_name alphabetically, and id ascending.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
  BEGIN
    SELECT e.first_name, e.last_name FROM employees e
        WHERE e.salary > 35000
    ORDER BY e.first_name,e.last_name,e.employee_id;
  END $$

CALL usp_get_employees_salary_above_35000();

/*2.	Employees with Salary Above Number
Create stored procedure usp_get_employees_salary_above that accept a number as parameter and return all employees’
first and last names whose salary is above or equal to the given number. The result should be sorted by first_name
then by last_name alphabetically and id ascending. Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

CREATE PROCEDURE usp_get_employees_salary_above(number DOUBLE)
  BEGIN
    SELECT e.first_name,e.last_name FROM employees e
        WHERE e.salary >= number
    ORDER BY e.first_name,e.last_name,e.employee_id;
  END $$

CALL usp_get_employees_salary_above(30000);

/*3.	Town Names Starting With
Write a stored procedure usp_get_towns_starting_with that accept string as parameter and returns all town names
starting with that string. The result should be sorted by town_name alphabetically. Submit your query statement as
Run skeleton, run queries & check DB in Judge.
*/

CREATE PROCEDURE usp_get_towns_starting_with (string VARCHAR(10))
  BEGIN
    SELECT t.name FROM towns t
        WHERE left(t.name,char_length(string))= string
    ORDER BY t.name;
  END $$

CALL usp_get_towns_starting_with('s');

/*4.	Employees from Town
Write a stored procedure usp_get_employees_from_town that accepts town_name as parameter and return the employees’
first and last name that live in the given town. The result should be sorted by first_name then by last_name
alphabetically and id ascending. Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

CREATE PROCEDURE usp_get_employees_from_town (town_name VARCHAR(50))
  BEGIN
    SELECT e.first_name, e.last_name FROM employees e
    JOIN addresses a ON e.address_id = a.address_id
    JOIN towns t ON t.town_id = a.town_id
    WHERE t.name = town_name
    ORDER BY e.first_name,e.last_name,e.employee_id;
  END $$

/*5.	Salary Level Function
Write a function ufn_get_salary_level that receives salary of an employee and returns the level of the salary.
•	If salary is < 30000 return “Low”
•	If salary is between 30000 and 50000 (inclusive) return “Average”
•	If salary is > 50000 return “High”
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

CREATE FUNCTION ufn_get_salary_level(salary_amount DOUBLE)
  RETURNS VARCHAR(10)
  BEGIN
    DECLARE result VARCHAR(10);
    SET result:= CASE WHEN salary_amount < 30000 THEN 'Low'
      WHEN salary_amount BETWEEN 30000 AND 50000 THEN 'Average'
      ELSE 'High'
        END;
      RETURN result;
  END $$

SELECT ufn_get_salary_level(20);

/*6.	Employees by Salary Level
Write a stored procedure usp_get_employees_by_salary_level that receive as parameter level of salary
(low, average or high) and print the names of all employees that have given level of salary.
The result should be sorted by first_name then by last_name both in descending order.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/


CREATE PROCEDURE usp_get_employees_by_salary_level(level_salary VARCHAR(10))
  BEGIN
    SELECT e.first_name, e.last_name FROM  employees e
        WHERE ufn_get_salary_level(e.salary) = level_salary
    ORDER BY first_name DESC ,last_name DESC;
  END $$

CALL usp_get_employees_by_salary_level('low');

/*7.	Define Function
Define a function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))  that returns true or false
depending on that if the word is a comprised of the given set of letters.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
  RETURNS BIT
  BEGIN
    DECLARE result BIT;
    DECLARE current_index INT;
    DECLARE rotations INT;

    SET result := 1;
    SET current_index :=1;
    SET rotations := char_length(word);

    WHILE (current_index <= rotations)DO
        IF (set_of_letters NOT LIKE (concat('%',substring(word,current_index,1),'%')))
        THEN SET result := 0;
        END IF ;

      SET current_index := current_index + 1;
      END WHILE;

    RETURN result;
  END $$

/*
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
  RETURNS BIT
  BEGIN
    RETURN word REGEXP (concat('^[', set_of_letters, ']+$'));
  END;
  solution of 7th task with regex
*/

/*8.	Find Full Name
You are given a database schema with tables:
•	account_holders(id (PK), first_name, last_name, ssn)
and
•	accounts(id (PK), account_holder_id (FK), balance).
Write a stored procedure usp_get_holders_full_name that selects the full names of all people. . The result should be
sorted by full_name alphabetically and id ascending. Submit your query statement as Run skeleton, run queries & check DB in Judge
*/

CREATE PROCEDURE usp_get_holders_full_name()
  BEGIN
    SELECT concat(first_name,' ', last_name) as `full_name` FROM account_holders
        ORDER BY full_name;
  END $$

/*9.	People with Balance Higher Than
Your task is to create a stored procedure usp_get_holders_with_balance_higher_than that accepts a number as a parameter
and returns all people who have more money in total of all their accounts than the supplied number.
The result should be sorted by first_name then by last_name alphabetically and account id ascending.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

CREATE PROCEDURE usp_get_holders_with_balance_higher_than(number DOUBLE)
BEGIN
  SELECT a_c.first_name, a_c.last_name FROM account_holders a_c
  JOIN accounts a ON a_c.id = a.account_holder_id
  GROUP BY a_c.id HAVING sum(a.balance)> number
  ORDER BY a.id, a_c.first_name, a_c.last_name;
END $$

CALL usp_get_holders_with_balance_higher_than(7000);

/*10. Future Value Function
Your task is to create a function ufn_calculate_future_value that accepts as parameters – sum,
yearly interest rate and number of years. It should calculate and return the future value of the initial sum.
Using the following formula:
FV=I×(〖(1+R)〗^T)
	I – Initial sum
	R – Yearly interest rate
	T – Number of years
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

CREATE FUNCTION ufn_calculate_future_value(initial_sum DECIMAL(20,4), interest_rate DECIMAL(20,4), number_of_years int)
  RETURNS DECIMAL(20,4)
  BEGIN
    DECLARE result DECIMAL(20,4);
    SET result := initial_sum * ( pow((1+interest_rate) ,number_of_years));
    RETURN result;
  END $$

SELECT ufn_calculate_future_value(123.1200,0.1,5);

/*11.	Calculating Interest
Your task is to create a stored procedure usp_calculate_future_value_for_account that uses the function from the
previous problem to give an interest to a person's account for 5 years, along with information about his/her account
id, first name, last name and current balance as it is shown in the example below. It should take the account_id
and the interest_rate as parameters. Interest rate should have precision up to 0.0001, same as the calculated balance
after 5 years. Be extremely careful to achieve the desired precision!
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

CREATE PROCEDURE usp_calculate_future_value_for_account(account_id INT, interest_rate DECIMAL(20,4))
  BEGIN
    SELECT a.id, h.first_name, h.last_name, a.balance AS 'current_balance',
    ufn_calculate_future_value(a.balance,interest_rate,5) AS 'balance_in_5_years'
    FROM accounts a
    JOIN account_holders h ON h.id = a.account_holder_id
    WHERE a.id = account_id;
  END $$

CALL usp_calculate_future_value_for_account(1,0.1);

/*12.	Deposit Money
Add stored procedure usp_deposit_money(account_id, money_amount) that operate in transactions.
Make sure to guarantee valid positive money_amount with precision up to fourth sign after decimal point.
The procedure should produce exact results working with the specified precision.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(20,4))
  BEGIN
    START TRANSACTION;
    CASE WHEN money_amount <= 0 OR account_id < 1
      THEN ROLLBACK;
    ELSE
        UPDATE accounts a
        SET a.balance = a.balance + money_amount
        WHERE a.id = account_id;
    END CASE ;
    COMMIT;
  END $$

CALL usp_deposit_money(2,10.0001);

/*13.	Withdraw Money
Add stored procedures usp_withdraw_money(account_id, money_amount) that operate in transactions.
Make sure to guarantee withdraw is done only when balance is enough and money_amount is valid positive number.
Work with precision up to fourth sign after decimal point. The procedure should produce exact results working with
the specified precision.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(20,4))
  BEGIN
    START TRANSACTION ;
    CASE WHEN money_amount < 0 OR money_amount > (SELECT balance FROM accounts a WHERE a.id = account_id )
      THEN ROLLBACK;
    ELSE UPDATE accounts a
    SET a.balance = a.balance - money_amount
      WHERE a.id = account_id;
      END CASE ;
    COMMIT ;
  END $$

CALL usp_withdraw_money (1, 10);
select * from accounts
WHERE id = 1;

/*14.	Money Transfer
Write stored procedure usp_transfer_money(from_account_id, to_account_id, amount) that transfers money
from one account to another. Consider cases when one of the account_ids is not valid, the amount of money is negative
number, outgoing balance is enough or transferring from/to one and the same account. Make sure that the whole
procedure passes without errors and if error occurs make no change in the database.
Make sure to guarantee exact results working with precision up to fourth sign after decimal point.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(20,4))
  BEGIN
    START TRANSACTION;
    CASE WHEN from_account_id < 1
              OR  to_account_id < 1
              OR amount > (SELECT a.balance FROM  accounts a WHERE a.id = from_account_id)
              OR from_account_id = to_account_id
              OR amount < 0
    THEN ROLLBACK ;
    ELSE UPDATE accounts a
      SET a.balance = a.balance - amount
      WHERE a.id = from_account_id;
        UPDATE accounts a
      SET a.balance = a.balance + amount
      where a.id  = to_account_id;
    END CASE ;
    COMMIT ;
  END $$

/*15.	Log Accounts Trigger
Create another table – logs(log_id, account_id, old_sum, new_sum). Add a trigger to the accounts table that enters a
new entry into the logs table every time the sum on an account changes.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

CREATE TABLE logs(
  log_id INT PRIMARY KEY AUTO_INCREMENT,
  account_id INT,
  old_sum DECIMAL(19,4),
  new_sum DECIMAL(19,4));

CREATE TRIGGER tr_logs
  AFTER UPDATE
  ON accounts
  FOR EACH ROW
  BEGIN
  INSERT INTO logs(account_id, old_sum, new_sum)
  VALUES (OLD.id, OLD.balance, NEW.balance);
  END $$
/*16.	Emails Trigger
Create another table – notification_emails(id, recipient, subject, body). Add a trigger to logs table to create new
email whenever new record is inserted in logs table. The following data is required to be filled for each email:
•	recipient – account_id
•	subject – “Balance change for account: {account_id}”
•	body - “On {date (current date)} your balance was changed from {old} to {new}.”
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

CREATE TABLE notification_emails(
  id INT PRIMARY KEY AUTO_INCREMENT,
  recipient INT,
  subject VARCHAR(50),
  body TEXT);

CREATE TRIGGER tr_create_notification_email
  AFTER INSERT
  ON logs
  FOR EACH ROW
  BEGIN
    INSERT INTO notification_emails (recipient, subject, body)
    VALUES (NEW.account_id,concat('Balance change for account: ', NEW.account_id),concat('On ', DATE_FORMAT(NOW(), '%b %d %Y'), ' at ', DATE_FORMAT(NOW(), '%r'),' your balance was changed from ',
                                                                                       New.old_sum, ' to ',
New.new_sum,'.'));
 END;