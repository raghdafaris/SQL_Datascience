Dim quizAnswers As String = "
Question 1
Which of the following statements is true regarding subqueries?
Answer:
Subqueries always process the innermost query first and the work outward.

Question 2
If you can accomplish the same outcome with a join or a subquery, which one should you always choose?
Answer:
Joins are usually faster, but subqueries can be more reliable, so it depends on your situation. 

Question 3
The following diagram is a depiction of what type of join?
Answer:
Inner Join

Question 4
Select which of the following statements are true regarding inner joins. (Select all that apply.) 
Answer:
a-Inner joins are one of the most popular types of joins use
b-There is no limit to the number of table you can join with an inner join. 


Question 5
Which of the following is true regarding Aliases? (Select all that apply.)
Answer:
Aliases are often used to make column names more readable
An alias only exists for the duration of the query.
SQL aliases are used to give a table, or a column in a table, a temporary name.


Question 6
What is wrong with the following query?

SELECT Customers.CustomerName,
 Orders.OrderID
FROM LEFT JOIN ON Customers.CustomerID = Orders.CustomerID FROM Orders AND Customers
ORDER BY
CustomerName;
Answer:
The table name comes after the join condition


Question 7
What is the difference between a left join and a right join? 
Answer:
The only difference between a left and right join is the order in which the tables are relating. 


Question 8
If you perform a cartesian join on a table with 10 rows and a table with 20 rows, how many rows will there be in the output table?
Answer:
200

Question 9
Which of the following statements about Unions is true? (Select all that apply.)
Answer:
The columns must also have similar data types
Each SELECT statement within UNION must have the same number of columns
The UNION operator is used to combine the result-set of two or more SELECT statements


Question 10
Data scientists need to use joins in order to: (Select the best answer)
Answer:
Retrieve data from multiple tables. 

"