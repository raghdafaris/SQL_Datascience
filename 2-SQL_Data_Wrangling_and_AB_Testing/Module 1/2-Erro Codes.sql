--Exercise 1:
--Goal: Here we use users table to pull a list of user email addresses. Edit the query to pull email
--addresses, but only for non-deleted users

--Error Code1
--SELECT *
--FROM dsv1069.users

--Corrected Code 
SELECT 
  id AS user_id, 
  email_address
FROM dsv1069.users
WHERE deleted_at IS NULL 


--Exercise 2:
--Goal: Use the items table to count the number of items for sale in each category
SELECT 
  category, 
  COUNT(id) AS item_count
FROM 
  dsv1069.items
GROUP BY 
  category
ORDER BY 
  item_count DESC

--NOTE: 
 -- Every time you use an aggregate function 
 -- like COUNT you must add a Group BY 
 -- The group by should come before the 
 -- order by  

--Exercise 3:
--Select all of the columns 
--from the result when you JOIN the 
--users table to the orders
--table

--Error Code1
--SELECT *
--FROM dsv1069.orders
--JOIN dsv1069.users
--ON orders. user_id = users.user_id;

--there is no user_id in the dsv1069.users the name is id
-- also in the  items table the item_id is is referred to as id 

SELECT *
FROM dsv1069.orders
JOIN dsv1069.users
ON orders. user_id = users. id;

--Exercise 4:
--Goal: Check out the query below. 
--This is not the right way to count the number of viewed_item
--events. Determine what is wrong and correct the error.

--Error Code:
--SELECT
--COUNT(event_id) AS events
--FROM dsv1069.events
--WHERE event_name = ‘view_item’

--NOTE the code runs but it doesnt give the right 
--answer why ? 

--Corrected Code 
SELECT  
  COUNT(DISTINCT event_id) AS events
FROM 
  dsv1069.events
WHERE 
  event_name = 'view_item'

--In the event id there are multiple raws for each id
-- so we need to count the number of DISTINCT id 

--Exercise 5:
--Goal:Compute the number of items in the items table which have been ordered. The query
--below runs, but it isn’t right. Determine what is wrong and correct the error or start from scratch.
--Starter Code:
--SELECT  
-- COUNT(orders.item_id) AS item_count
--FROM 
--  dsv1069.orders 
--JOIN
  dsv1069.items
--ON 
--item_id= orders.item_id 

--NOTE the answer from this code is wrong 
--because the number of items we have 
--is less than 2000 but the code results 
-- shows over 10000 its too big

-- Corrected Code 
SELECT  
  COUNT(DISTINCT item_id) AS item_count
FROM 
  dsv1069.orders;

-- we get the the anser from the order table 
-- without the need to join anything 
-- Include the Join if you want more info 
--about the items that they were saved in the 
-- item table. 

--Exercise 6:
--Goal: For each user figure out IF a user has 
--ordered something, and when their first purchase
--was. The query below doesn’t return info for any 
--of the users who haven’t ordered anything.


--Wrong Code
SELECT
  users.id AS user_id,
  MIN(orders.paid_at) AS min_paid_at
FROM 
  dsv1069.orders
INNER JOIN
  dsv1069.users
ON 
  orders.user_id = users.id
GROUP BY
  users.id;
-- the code runs but cant find the any users 
--who have not ordered anything (Window shoppers)
-- So to fix this we should join the small tabele
-- to the bigger table to include all users 
-- user table bigger so it should be first then 
-- the orders tabel. 

--Correct Code
SELECT
  users.id AS user_id,
  MIN(orders.paid_at) AS min_paid_at
FROM 
  dsv1069.users
LEFT OUTER JOIN
  dsv1069.orders
ON 
  orders.user_id = users.id
GROUP BY
  users.id;

--Exercise 7:
--Goal: Figure out what percent of users have 
--ever viewed the user profile page, but this 
--query isn’t right. Check to make sure the
 --number of users adds up, and if not, fix the query.

--Wrong Code:
SELECT 
  (CASE WHEN first_view IS NULL THEN false
  ELSE true END) AS has_viewed_profile_page, 
COUNT (user_id) as users 
FROM 
  ( SELECT 
      users.id AS user_id, 
      MIN(event_time)as first_view
FROM 
  dsv1069.users
LEFT OUTER JOIN 
  dsv1069.events
ON 
  events.user_id= users.id 
AND
   events.user_id=users.id
WHERE
  event_name= 'view_user_profile'
GROUP BY  
  users.id )
  first_profile_views
GROUP BY 
  (CASE WHEN first_view IS NULL THEN false ELSE true END) 

--1 check the join / the users come first
-- 2 the where code is not letting the null raws show 
-- if you add a where code to a lest join you change it 
-- to inner join So a butter way is to change it to 
--AND

--Corrected code 
SELECT 
  (CASE WHEN first_view IS NULL THEN false
  ELSE true END) AS has_viewed_profile_page, 
COUNT (user_id) as users 
FROM 
  ( SELECT 
      users.id AS user_id, 
      MIN(event_time)as first_view
FROM 
  dsv1069.users
LEFT OUTER JOIN 
  dsv1069.events
ON 
  events.user_id= users.id 
AND
  events.event_name= 'view_user_profile'
GROUP BY 
  users.id )
  first_profile_views
GROUP BY 
  (CASE WHEN first_view IS NULL THEN false ELSE true END)




