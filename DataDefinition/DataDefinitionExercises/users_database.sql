#Create Table Users#
CREATE TABLE users(
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(30) UNIQUE NOT NULL,
  `password` VARCHAR(26) NOT NULL,
  profile_picture BLOB(900),
  last_login_time DATETIME,
  is_deleted BIT
);

INSERT INTO users(username, `password`, last_login_time)
VALUES('gogo', '123', '1988-09-12');

INSERT INTO users(username, `password`, last_login_time)
VALUES('gogo1', '123', '1988-09-12');



INSERT INTO users(username, `password`, last_login_time)
VALUES('gogo2', '123', '1988-09-12');

INSERT INTO users(username, `password`, last_login_time)
VALUES('gogo3', '123', '1988-09-12');

INSERT INTO users(username, `password`, last_login_time)
VALUES('gogo4', '123', '1988-09-12');

#Change primary Key#
ALTER TABLE users
MODIFY COLUMN id INT;

ALTER TABLE users
DROP PRIMARY KEY;

ALTER TABLE users
ADD PRIMARY KEY(id, username);

#Set Default Value of a Field#
ALTER TABLE users
MODIFY COLUMN last_login_time DATETIME DEFAULT  NOW();

#Set Unique Field#
ALTER TABLE users
MODIFY COLUMN id INT;

ALTER TABLE users
MODIFY COLUMN username VARCHAR(30) UNIQUE;

ALTER TABLE users
DROP PRIMARY KEY;

ALTER TABLE users
ADD PRIMARY KEY(id);
