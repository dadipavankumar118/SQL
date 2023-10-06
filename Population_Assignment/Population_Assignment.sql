-- 1.	What years are covered by the dataset? 
SELECT DISTINCT(year)
FROM population;

-- 2.	What is the largest population size for Gabon in this dataset?
SELECT max(population)
FROM population
WHERE country = 'Gabon';

-- 3.	What were the 10 lowest population countries in 2005?
SELECT country
FROM population
WHERE year = 2005
ORDER BY population
LIMIT 10;

-- 4.	What are all the distinct countries with a population of over 100 million in the year 2010?
SELECT DISTINCT(country)
FROM population
WHERE year = 2010 AND population > 100;

-- 5.	How many countries in this dataset have the word “Islands” in their name?
SELECT count(DISTINCT(country)) as countries
FROM population
WHERE country LIKE '%Islands%';

-- 6.	What is the difference in population between 2000 and 2010 in Indonesia?
SELECT max(population) - min(population) AS population_diff
FROM population
WHERE country = 'Indonesia' AND year IN (2000,2010);