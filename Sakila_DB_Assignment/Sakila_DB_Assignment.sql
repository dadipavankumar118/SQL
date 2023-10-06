/*1. Fetch the list of the first name, last name,
and email of each of our customers.*/
SELECT first_name,last_name,email
FROM customer;

/*2. Fetch the records of films and see if there are 
rental durations and how many unique durations are there.*/
SELECT count(DISTINCT(rental_duration)) as No_of_unique_rental_duration
FROM film;

-- 3. Fetch records of customers whose first name is Mary.
SELECT *
FROM customer
WHERE first_name = 'MARY';


/*4. Fetch payment records of the first 100 customers where the amount
is greater than 5 and payments that are done after 6th January 2006.*/
SELECT *
FROM payment
WHERE amount > 5 and payment_date > '2006-01-06'
limit 100;

-- 5. Fetch the list of films that include a Behind the Scenes special feature.
SELECT title,special_features
FROM film
WHERE special_features like '%Behind the Scenes%';

-- 6. Fetch the count of titles sliced by rental duration.
SELECT rental_duration,count(title) as No_of_titles
FROM film
GROUP BY rental_duration;

/*7. Fetch the count of films, along with the average, min, and max
rental rate, grouped by replacement cost.*/
SELECT replacement_cost,
count(title) as No_of_title,
avg(rental_rate) as avg_rental_rate,
min(rental_rate) as min_rental_rate,
max(rental_rate) as max_rental_rate
FROM film
GROUP BY replacement_cost;

-- 8. Fetch the list of customer_ids with less than 15 rentals all-time.
SELECT customer_id,count(rental_id) as No_of_rentals
FROM rental 
GROUP BY customer_id
having No_of_rentals < 15;

/*9. Fetch the list of all fil titles along with their lengths and
rental rates, and sort them from longest to shortest.*/
SELECT title,length,rental_rate
FROM film
ORDER BY length DESC;

/*10. list of first and last names of all customers, and label them as either
‘store 1 active’, ‘store 1 inactive’, ‘store 2 active’, or ‘store 2 inactive’.
Eg : store_id =1 and active=0 it is "store 1 inactive” and store_id =1
and active=1 then "store 1 active" and so on….*/
SELECT first_name,last_name,
CASE
WHEN store_id = 1 and active = 0 then 'store 1 inactive'
WHEN store_id = 1 and active = 1 then 'store 1 active'
WHEN store_id = 2 and active = 0 then 'store 2 inactive'
WHEN store_id = 2 and active = 1 then 'store 2 active'
END as Active_status
FROM customer;

-- 11.Display info dividing the length of the film providing the length.
/*Eg : Using conditions like if length<60 create bucket 'UNDER 1 HR', if length
BETWEEN 60 AND 90 create it as bucket '1 - 1.5 and when length>90 Then
'OVER 1.5 HRS'*/
SELECT length,
CASE
WHEN length < 60 then 'UNDER 1 HR'
WHEN length BETWEEN 60 and 90 then '1 - 1.5 HRS'
WHEN length > 90 then 'OVER 1.5 HRS'
END as length_bucket
FROM film
ORDER BY length DESC;

/*12. Display a table to count the number of customers broken down by
store_id (in rows), and active status (in columns).
Eg : when active =0 under active column put active else null same for the active 1 column.*/
SELECT store_id,
sum(CASE WHEN active = 0 then 1 else 0 END) as inactive_count,
sum(CASE WHEN active = 1 then 1 else 0 END) as active_count
FROM customer
GROUP BY store_id;