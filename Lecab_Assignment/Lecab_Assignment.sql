drop database if exists lecab;
create database if not exists lecab;
use lecab;


create table riders(
id INT PRIMARY KEY,
first TEXT,
last TEXT,
username TEXT,
rating INT,
total_trips INT,
referred INT);

create table riders2
like riders;


create table cars(
id INT PRIMARY KEY,
model text,
OS TEXT,
status TEXT,
trips_completed INT);



create table trips(
id INT PRIMARY KEY,
date DATE,
pickup TEXT,
dropoff TEXT,
rider_id INT,
car_id INT,
type varchar(20),
cost DOUBLE,
foreign key (rider_id)
references riders(id),
foreign key (car_id)
references cars(id));


insert into riders(id, first, last, username, rating, total_trips, referred)
values
(101,'Sonny','Li', '@sonnynomnom', 4.66,352, NULL),
(102,'Laura','Breiman',	'@lauracle', 4.99, 687, 101),
(103,'Kassa','Breiman',	'@kassablanca', 4.63, 42, NULL),
(104, 'Yakov','Kagan','@yakovkagan',4.52,1910,103);

insert into riders2(id, first, last, username, rating, total_trips, referred)
values
(105,'Zach','Sims','@zsims', 4.85,787, NULL),
(106,'Eric','Vaught','@posturelol', 4.96, 54, 101),
(107,'Jilly','Beans','@jillikuzmin', 4.7, 32, 101);

insert into cars(id, model, OS, status, trips_completed)
values
(1, 'Ada', 'Ryzac', 'active', 82),
(2, 'Ada', 'Ryzac', 'active', 30),
(3, 'Turing XL', 'Ryzac', 'active', 164),
(4, 'Akira', 'Finux', 'maintenance', 22);

insert into trips(id, date, pickup, dropoff, rider_id, car_id, type, cost)
values
(1001, '2017-12-05', '06:45', '07:10', 102, 1, 'X', 28.66),
(1002, '2017-12-05', '06:45', '07:10', 102, 1, 'X', 28.66),
(1003, '2017-12-05', '06:45', '07:10', 102, 1, 'X', 28.66),
(1004, '2017-12-05', '06:45', '07:10', 102, 1, 'X', 28.66),
(1005, '2017-12-05', '06:45', '07:10', 102, 1, 'X', 28.66),
(1006, '2017-12-05', '06:45', '07:10', 102, 1, 'X', 28.66);

-- 1. First examine all the tables, trips, riders, cars.
SELECT * FROM cars;
SELECT * FROM riders;
SELECT * FROM riders2;
SELECT * FROM trips;

-- 2. check the pk and fk of the tables.
/* Cars - (Primary key - id)
Riders - (Primary key - id)
Riders2 - (Primary key - id)
Trips - (Primary key - id),(Foreign key - rider_id,car_id)*/

-- 3. Do cross join in riders and cars tables.
SELECT *
FROM riders
CROSS JOIN cars;

-- 4. using left join combine trips and riders.
SELECT *
FROM trips
LEFT JOIN riders
ON trips.rider_id = riders.id;

-- 5. use INNER join to combine trips and cars.
SELECT *
FROM trips
INNER JOIN cars
ON trips.car_id = cars.id;

-- 6. Do union on riders and riders2 table.
SELECT * FROM riders
UNION
SELECT * FROM riders2;

-- 7. What is the average cost of a trip? round it in 2 decimals.
SELECT ROUND(AVG(cost),2) as avg_trip_cost
FROM trips;

-- 8. find all the riders who have used lecab less than 500 times.
SELECT id,first,last FROM riders
UNION
SELECT id,first,last FROM riders2
WHERE total_trips < 500;

-- 9. Write a query that finds two cars that have the highest trips_completed.
SELECT model
FROM cars
ORDER BY trips_completed DESC
LIMIT 2;