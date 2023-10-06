CREATE TABLE friends(
id int,
Name varchar(30),
DOB date);

-- 1.	Add a record name john doe whose birthday 1996-08-30
INSERT INTO friends
values(1,"john doe","1996-08-30");

-- 2.	view the table using select.
SELECT *
FROM friendS;

-- 3.	Now add two of your friends you like.
INSERT INTO friends
values(2,"Pavankumar","2001-05-04"),
(3,"Bhargav","2001-07-12"),
(4,"Murali","2001-06-26");

-- 4.	change the name of the first friend called 'john doe' to 'Luis Johnson'
UPDATE friends
SET Name = "Luis Johnson"
WHERE Name= "john doe";

-- 5.	add a new column called email.
ALTER TABLE friends
ADD(email varchar(30));

-- 6.	Update the email address for Luis in your table.
   -- Luis email is luis@gmail.com
UPDATE friends
SET email = "luis@gmail.com"
WHERE Name= "Luis Johnson";

-- 7.	remove Luis from friends.
DELETE FROM friends
WHERE Name="Luis Johnson";

-- 8.	view complete table using select.
SELECT *
FROM friends;