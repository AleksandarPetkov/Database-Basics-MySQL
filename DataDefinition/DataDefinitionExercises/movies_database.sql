USE movies;

CREATE TABLE directors(
   id INT PRIMARY KEY AUTO_INCREMENT,
   director_name VARCHAR(20) NOT NULL,
   notes TEXT
);

CREATE TABLE genres(
   id INT PRIMARY KEY AUTO_INCREMENT,
   genre_name VARCHAR(50) NOT NULL,
   notes TEXT
);

CREATE TABLE categories(
   id INT PRIMARY KEY AUTO_INCREMENT,
   category_name VARCHAR(50) NOT NULL,
   notes TEXT
);

CREATE TABLE movies(
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    director_id INT NOT NULL,
	 copyright_year YEAR NOT NULL,
	`length` TIMESTAMP NOT NULL,
	 genre_id INT NOT NULL,
	 category_id INT NOT NULL,
	 rating INT,
	 notes TEXT
);

INSERT INTO directors(director_name) VALUES('name1'), ('name1'), ('name1'), ('name1'), ('name1');
INSERT INTO genres(genre_name) VALUES('name1'), ('name1'), ('name1'), ('name1'), ('name1');
INSERT INTO categories(category_name) VALUES('action'), ('action'), ('action'), ('action'), ('action');

INSERT INTO movies(title, director_id, copyright_year, `length`, genre_id, category_id)
VALUES('title1', 1, '1991', '1999-01-12 10:45:15', 1, 1),
('title1', 1, '1991', '1999-01-12 10:45:15', 1, 1),
('title1', 1, '1991', '1999-01-12 10:45:15', 1, 1),
('title1', 1, '1991', '1999-01-12 10:45:15', 1, 1),
('title1', 1, '1991', '1999-01-12 10:45:15', 1, 1);