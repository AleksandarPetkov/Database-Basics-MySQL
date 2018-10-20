#1 Table Design
CREATE TABLE users(
  id INT PRIMARY KEY AUTO_INCREMENT,
  nickname VARCHAR(25) NOT NULL,
  gender CHAR(1) NOT NULL,
  age INT NOT NULL,
  location_id INT NOT NULL,
  credential_id INT NOT NULL UNIQUE
);

CREATE TABLE locations(
  id INT PRIMARY KEY AUTO_INCREMENT,
  latitude FLOAT NOT NULL,
  longitude FLOAT NOT NULL
);

CREATE TABLE credentials(
  id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(30) NOT NULL,
  password VARCHAR(20) NOT NULL
);

CREATE TABLE chats(
  id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(32) NOT NULL,
  start_date DATE NOT NULL,
  is_active BIT NOT NULL
);

CREATE TABLE messages(
  id INT PRIMARY KEY AUTO_INCREMENT,
  content VARCHAR(200) NOT NULL,
  sent_on DATE NOT NULL,
  chat_id INT NOT NULL,
  user_id INT NOT NULL
);

CREATE TABLE users_chats(
  user_id INT ,
  chat_id INT,
  CONSTRAINT pk_user_chats
  PRIMARY KEY(user_id, chat_id),

  CONSTRAINT fk_user_cats_user
  FOREIGN KEY (user_id) REFERENCES users(id),

  CONSTRAINT fk_user_cats_chat
  FOREIGN KEY (chat_id) REFERENCES chats(id)
);

ALTER TABLE users
  ADD CONSTRAINT fk_users_location
FOREIGN KEY (location_id) REFERENCES locations(id),

  ADD CONSTRAINT fk_users_credential
FOREIGN KEY (credential_id) REFERENCES credentials(id);

ALTER TABLE messages
  ADD CONSTRAINT fk_messages_chat
FOREIGN KEY (chat_id) REFERENCES chats(id),

  ADD CONSTRAINT fk_messages_user
FOREIGN KEY (user_id) REFERENCES users(id);





#Section 2: Data Manipulation Language (DML) – 30 pts#

#02. Insert#

#1 First make SELECT QUERY
SELECT
       concat(u.age, '-', u.gender, '-', l.latitude, '-', l.longitude) AS `content`,
       '2016-12-15' AS `sent_on`,
       (CASE
          WHEN u.gender = 'M' THEN round(POW((u.age / 18), 3), 0)
          WHEN u.gender = 'F' THEN round(SQRT(u.age * 2), 0)
          END
       ) AS `chat_id`,
       u.id AS `user_id`
FROM users AS u
JOIN locations AS l
ON u.location_id = l.id
WHERE u.id BETWEEN 10 AND 20;



#2 SECOND INSERT IT
INSERT INTO messages(content, sent_on, chat_id, user_id)

           SELECT
           concat(u.age, '-', u.gender, '-', l.latitude, '-', l.longitude) AS `content`,
           '2016-12-15' AS `sent_on`,
           (CASE
              WHEN u.gender = 'M' THEN round(POW((u.age / 18), 3), 0)
              WHEN u.gender = 'F' THEN round(SQRT(u.age * 2), 0)
               END
               ) AS `chat_id`,
           u.id AS `user_id`
               FROM users AS u
               JOIN locations AS l
               ON u.location_id = l.id
               WHERE u.id BETWEEN 10 AND 20;


#03. Update#
UPDATE chats AS c
JOIN messages m on c.id = m.chat_id AND  m.sent_on < c.start_date
SET c.start_date = m.sent_on;


#04. Delete#
# Good option first make SELECT TO SEE TABLE, after that make DELETE
#1
SELECT l.id
FROM locations AS l
       LEFT JOIN users u on l.id = u.location_id
WHERE u.id IS NULL;
#2
DELETE  l
       FROM locations AS l
       LEFT JOIN users u on l.id = u.location_id
       WHERE u.id IS NULL;



#Section 3: Querying – 100 pts#
#05. Age Range#
SELECT  u.nickname, u.gender, u.age
FROM users AS u
WHERE age BETWEEN 22 AND 37
ORDER BY  u.id;


#06. Messages#
SELECT m.content, m.sent_on
FROM messages AS m
WHERE (m.sent_on > '2014-05-12') AND m.content LIKE '%just%'
ORDER BY m.id DESC;


#07. Chats#
SELECT c.title, c.is_active
FROM chats AS c
WHERE c.is_active = 0 AND
      char_length(c.title) < 5 OR
      substr(c.title, 3,2) = 'tl'
ORDER BY c.title DESC;


#08. Chat Messages#
SELECT c.id, c.title, m.id
FROM chats AS c
JOIN messages m
ON c.id = m.chat_id
WHERE m.sent_on < '2012-03-26' AND c.title LIKE '%x'
ORDER BY c.id, m.id;

#09. Message Count#
SELECT c.id, count(m.chat_id) AS `total_messages`
FROM chats AS c
RIGHT JOIN messages m
ON c.id = m.chat_id
WHERE m.id < 90
GROUP BY c.id
ORDER BY total_messages DESC , c.id
LIMIT 5;

#10. Credentials#
SELECT u.nickname, c.email, c.password
FROM users AS u
JOIN credentials c
ON u.credential_id = c.id
WHERE c.email LIKE '%co.uk'
ORDER BY  c.email ASC;

#11. Locations #
SELECT u.id, u.nickname, u.age
FROM users AS u
WHERE u.location_id IS NULL
ORDER BY u.id;

#12. Left Users#
SELECT m.id, m.chat_id, m.user_id
FROM messages AS m
LEFT JOIN users_chats AS uc
ON m.user_id = uc.user_id AND m.chat_id = uc.chat_id
WHERE uc.user_id IS NULL AND m.chat_id = 17
ORDER BY m.id DESC ;



#13. Users in Bulgaria#
SELECT u.nickname, c.title, l.latitude, l.longitude
FROM users AS u

JOIN users_chats AS chat
ON u.id = chat.user_id

JOIN chats AS c
ON chat.chat_id = c.id

JOIN locations l
ON u.location_id = l.id
WHERE l.latitude BETWEEN 41.139999 AND 44.129999 AND
      l.longitude BETWEEN 22.209999 AND 28.359999
ORDER BY c.title;



#14. Last Chat#
SELECT cr2.title, cr1.content
FROM (SELECT m.id, m.chat_id,  m.content
      FROM messages AS m
      ORDER BY m.sent_on DESC) AS cr1
RIGHT JOIN(SELECT c.id, c.title
     FROM chats AS c
     ORDER BY c.start_date DESC) AS cr2
ON cr1.chat_id = cr2.id
ORDER BY cr1.id ASC
LIMIT 1;

#Section 4: Programmability – 40 pts#
#15. Radians#
CREATE FUNCTION udf_get_radians(degree FLOAT)
  RETURNS FLOAT
  BEGIN
    #The formula should multiply the given degrees by Pi and then divide the result by 180.#
    DECLARE result FLOAT;
    SET result :=
    ((degree * PI()) / 180);
    RETURN result;
  END;

#16. Change Password#
CREATE PROCEDURE udp_change_password(email VARCHAR(30), `password` VARCHAR(20))
  BEGIN
    IF(email NOT IN(SELECT c.email FROM credentials AS c)) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The email does''t exist!';
    ELSE
      UPDATE credentials
      SET credentials.password = password
      WHERE credentials.email = email;
    END IF;
  END;



#17. Send Message#
#user_id, a chat_id and the content of a message
CREATE PROCEDURE udp_send_message(u_id INT, c_id INT, char_msg VARCHAR(200))
  BEGIN
    IF(SELECT user_id FROM users_chats
       WHERE user_id = u_id AND chat_id = c_id) IS NULL THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'There is no chat with that user!';
    ELSE
      INSERT INTO messages(content, sent_on, chat_id, user_id)
      VALUES(char_msg, '2016-12-15', c_id, u_id);
    END IF;
  END;