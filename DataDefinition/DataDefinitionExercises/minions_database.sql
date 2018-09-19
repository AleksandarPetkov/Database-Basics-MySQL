/*.Create Database.*/
CREATE DATABASE minions;
USE minions;

/*.Create Tables.*/
CREATE TABLE minions(
   id INT PRIMARY KEY,
   `name` VARCHAR(15),
   age INT 
);

CREATE TABLE towns(
   id INT PRIMARY KEY,
   `name` VARCHAR(15)
);

/*.Alter Minions Table.*/
ALTER TABLE minions
ADD town_id INT NOT NULL;

ALTER TABLE minions
ADD CONSTRAINT fk_town_id
FOREIGN KEY (town_id) REFERENCES towns(id);

/*.Insert Records in Both Tables.*/
INSERT INTO towns(`id`, `name`) 
VALUES(1, 'Sofia'), (2, 'Plovdiv'), (3, 'Varna');

INSERT INTO minions(`id`, `name`, `age`,town_id) 
VALUES(1, 'Kevin', 22, 1), (2, 'Bob', 15, 3), (3, 'Steward', NULL, 2);

/*.Truncate Table Minions.*/
TRUNCATE TABLE minions;

/*.Drop All Tables.*/
DROP TABLE minions;
DROP TABLE towns;

