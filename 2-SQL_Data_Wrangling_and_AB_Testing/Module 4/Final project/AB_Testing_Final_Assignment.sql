-- AB Testing Final Assignment
-- We are running an experiment at an item-level, which means all users who visit 
-- will see the same page, but the layout of different item pages may differ.

-- 1-Compare this table to the assignment events we captured for user_level_testing.
-- Does this table have everything you need to compute metrics like 30-day view-binary?
-- Answer is No. The created_at date is needed.

SELECT * 
FROM dsv1069.final_assignments_qa;

--2- Write a query and table creation statement to make final_assignments_qa 
-- look like the final_assignments table. If you discovered something missing 
-- in part 1, you may fill in the value with a place holder of the appropriate 
-- data type.

SELECT 
item_id,
test_a AS test_assignment, 
'test_a' AS test_number, 
'2020-01-01' AS test_start_date
FROM 
  dsv1069.final_assignments_qa

-- 3- Use the final_assignments table to calculate the order binary for the
-- 30 day window after the test assignment for item_test_2 (You may include
-- the day the test started)

SELECT
test_assignment,
COUNT(item_id) as items,
SUM(order_binary_30d) AS ordered_items_30d
FROM
(SELECT 
fa.test_assignment,
fa.item_id, 
MAX(CASE 
WHEN orders.created_at > fa.test_start_date THEN 1 ELSE 0 END)  AS order_binary_30d
  FROM 
    dsv1069.final_assignments fa
LEFT OUTER JOIN
 dsv1069.orders
ON 
    fa.item_id = orders.item_id 
AND 
   orders.created_at >= fa.test_start_date
  AND 
    DATE_PART('day', orders.created_at - fa.test_start_date ) <= 30
  WHERE 
    fa.test_number= 'item_test_2'
  GROUP BY
    fa.test_assignment,
    fa.item_id
) item_level
GROUP BY test_assignment
---------------------------------------------3a)
SELECT 
fa.test_assignment,
fa.item_id, 
MAX(CASE 
WHEN orders.created_at > fa.test_start_date THEN 1 ELSE 0 END)  AS order_binary_30d
  FROM 
    dsv1069.final_assignments fa
LEFT OUTER JOIN
    dsv1069.orders
ON 
    fa.item_id = orders.item_id 
AND 
    orders.created_at >= fa.test_start_date
AND 
    DATE_PART('day', orders.created_at - fa.test_start_date ) <= 30
WHERE 
    fa.test_number= 'item_test_2'
GROUP BY
    fa.test_assignment,
    fa.item_id

-- 4- Use the final_assignments table to calculate the view binary, and
-- average views for the 30 day window after the test assignment for
-- item_test_2. (You may include the day the test started)

SELECT
    test_assignment,
    COUNT(item_id) AS items,
    SUM(view_binary_30d) AS viewed_items,
    CAST(100*SUM(view_binary_30d)/COUNT(item_id) AS FLOAT) AS viewed_percent,
    SUM(views) AS views,
    SUM(views)/COUNT(item_id) AS average_views_per_item
FROM 
(SELECT 
    fa.test_assignment,
    fa.item_id, 
    MAX(CASE WHEN views.event_time > fa.test_start_date THEN 1 ELSE 0 END)  AS view_binary_30d,
    COUNT(views.event_id) AS views
FROM 
    dsv1069.final_assignments fa   
LEFT OUTER JOIN 
(SELECT 
    event_time,
    event_id,
CAST(parameter_value AS INT) AS item_id
FROM 
    dsv1069.events 
WHERE 
    event_name = 'view_item'
AND parameter_name = 'item_id'
) views
ON fa.item_id = views.item_id
AND views.event_time >= fa.test_start_date
AND DATE_PART('day', views.event_time - fa.test_start_date ) <= 30
WHERE fa.test_number= 'item_test_2'
GROUP BY
    fa.test_assignment,
    fa.item_id
) item_level
GROUP BY 
    test_assignment

-- 5- Use the https://thumbtack.github.io/abba/demo/abba.html
-- to compute the lifts in metrics and the p-values for the binary
-- metrics (30 day order binary and 30 day view binary) using a
-- interval 95% confidence.

SELECT
    test_assignment,
    COUNT(item_id) AS items,
    SUM(view_binary_30d) AS viewed_items
FROM 
(SELECT 
    fa.test_assignment,
    fa.item_id, 
MAX(CASE 
WHEN views.event_time > fa.test_start_date THEN 1 ELSE 0 END) AS view_binary_30d
FROM 
    dsv1069.final_assignments fa
LEFT OUTER JOIN 
(SELECT 
    event_time, 
    CAST(parameter_value AS INT) AS item_id
FROM 
    dsv1069.events 
WHERE 
    event_name = 'view_item'
AND 
    parameter_name = 'item_id'
) views
ON fa.item_id = views.item_id
AND views.event_time >= fa.test_start_date
AND DATE_PART('day', views.event_time - fa.test_start_date ) <= 30
WHERE 
    fa.test_number= 'item_test_2'
GROUP BY
    fa.test_assignment,
    fa.item_id
    ) item_level
GROUP BY 
    test_assignment

