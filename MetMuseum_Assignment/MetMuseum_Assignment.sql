CREATE TABLE  met(
ID INT PRIMARY KEY,
Department varchar(100),
Category varchar(100),
Title varchar(100),
Artist varchar(100),
Date varchar(100),
Medium varchar(100),
Country varchar(100));

SELECT *
FROM met;

-- Select the top 10 rows in the met table.

SELECT *
FROM met
limit 10;

-- How many pieces are in the American Metropolitan Art collection? [count(*)]

SELECT count(*)
FROM met
WHERE Department = 'American Metropolitan Art';

-- Count the number of pieces where the category includes ‘celery’.

SELECT count(category)
FROM met
WHERE Category like '%celery%';

-- Find the title and medium of the oldest piece(s) in the collection.

SELECT Title,Medium,date
FROM met
ORDER BY date ASC
limit 1;

-- Find the top 10 countries with the most pieces in the collection.

SELECT country,count(country)
FROM met
GROUP BY country
ORDER BY count(country) DESC
limit 10;

-- Find the categories which have more than 100 pieces.

SELECT Category,count(Category)
FROM met
GROUP BY Category
having count(Category) > 100;

-- Count the number of pieces where the medium contains ‘gold’ or ‘silver’ and sort in descending order.

SELECT Medium,count(Medium)
FROM met
WHERE Medium in ('gold','silver')
GROUP BY Medium
ORDER BY count(Medium) DESC;