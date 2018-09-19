CREATE DATABASE people;
USE people;

CREATE TABLE people (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(200) NOT NULL,
  `picture` blob,
  `height` float (2),
  `weight` float (2), 
  `gender` enum('m', 'f'),  
  `birthdate` datetime, 
  `biography` text (65635) 
);

INSERT INTO people (`name`, `picture`, `height`, `weight`, `gender`, `birthdate`, `biography`)
VALUE ('Ivan', '/home/Pictures', '1.90', '90.50', 'm', '1988-09-12', 'using MySQL' );

INSERT INTO people (`name`, `picture`, `height`, `weight`, `gender`, `birthdate`, `biography`)
VALUE ('Dragan', '/home/Pictures', '1.90', '90.50', 'm', '1988-09-12', 'using MySQL' );

INSERT INTO people (`name`, `picture`, `height`, `weight`, `gender`, `birthdate`, `biography`)
VALUE ('Petkan', '/home/Pictures', '1.90', '90.50', 'm', '1988-09-12', 'using MySQL' );

INSERT INTO people (`name`, `picture`, `height`, `weight`, `gender`, `birthdate`, `biography`)
VALUE ('Avram', '/home/Pictures', '1.90', '90.50', 'm', '1988-09-12', 'using MySQL' );

INSERT INTO people (`name`, `picture`, `height`, `weight`, `gender`, `birthdate`, `biography`)
VALUE ('Hasan', '/home/Pictures', '1.90', '90.50', 'm', '1988-09-12', 'using MySQL' );

INSERT INTO people (`name`, `picture`, `height`, `weight`, `gender`, `birthdate`, `biography`)
VALUE ('Ivan', '/home/Pictures', '1.90', '90.50', 'm', '1988-09-12', 'using MySQL' );
