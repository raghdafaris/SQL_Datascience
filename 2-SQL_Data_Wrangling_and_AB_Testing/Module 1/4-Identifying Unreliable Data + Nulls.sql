-- Identifying Unreliable Data + Nulls
-- Exercise 1: Using any methods you like
-- determine if you can 
-- you trust this events table.



SELECT 
    date(event_time) AS date,
    COUNT(*)
FROM 
    dsv1069.events_201701
GROUP BY 
    date(event_time);

--Answer there is 32 rows returned from on spesific
-- time period so the answer is NO i cant trust it.

  

-- Exercise 2:
-- Using any methods you like, determine if you 
--can you trust this 
-- events table. (HINT: When did we 
--start recording events on mobile)

  
SELECT 
    DATE(event_time) AS date,
    platform,
    COUNT(*)
FROM 
    dsv1069.events_ex2
GROUP BY 
    DATE(event_time),
    platform

--Answer : looking at the chart we can see that 
-- the platform was not at the same time as the 
--other data. 
  
-- Exercise 3: Imagine that you need to count item views by day. You found this table
-- item_views_by_category_temp - should you use it to answer your questiuon?

SELECT 
    SUM(view_events) AS event_count
FROM 
    dsv1069.item_views_by_category_temp
-- Compair it with the original table 
SELECT 
    COUNT(DISTINCT event_id) AS event_count
FROM 
    dsv1069.events
WHERE 
    event_name = 'view_item';
-- Answer it is not a good idea to use this 
--table as it has less events than the original. 

-- Exercise 4: 
-- Using any methods you like, decide if
-- this table is ready to be 
-- used as a source of truth.

  
SELECT 
   date(event_time) AS date,
    platform,
    COUNT(user_id) AS users
FROM 
    dsv1069.events
GROUP BY 
     date(event_time),
     platform;

--Answer the user id is NULL for some of the 
--early dates on the data we noticed that by 
--chart 

-- Exercise 5: 
-- Is this the right way to join orders to users? Is this the right way this join.


SELECT 
    COUNT(*)
FROM 
    dsv1069.orders
JOIN 
    dsv1069.users
ON
    orders.user_id = COALESCE(users.parent_user_id, user_id)
