-- 1. For all the questions in this practice set, you will be using the Salary by Job Range Table. 
-- This is a single table titled: salary_range_by_job_classification. This table contains the following columns:
-- SetID, Job_Code, Eff_Date, Sal_End_Date, Salary_setID, Sal_Plan, Grade, Step, Biweekly_High_Rate, 
-- Biweekly_Low_Rate, Union_Code, Extended_Step, Pay_Type.

-- 2. Find the distinct values for the extended step.
SELECT DISTINCT Extended_Step
FROM salary_range_by_job_classification;

-- 3. Excluding $0.00, what is the minimum bi-weekly high rate of pay (please include the dollar sign and decimal point in your answer)?
SELECT MIN(Biweekly_High_Rate) AS min_Biweekly_High_Rate
FROM salary_range_by_job_classification
WHERE Biweekly_High_Rate > 0.00;  -- Assuming Biweekly_High_Rate is a numeric type

-- 4. What is the maximum biweekly high rate of pay (please include the dollar sign and decimal point in your answer)?
SELECT MAX(Biweekly_High_Rate) AS max_Biweekly_High_Rate
FROM salary_range_by_job_classification;  -- Added alias for clarity

-- 5. What is the pay type for all the job codes that start with '03'?
SELECT Job_Code,
       Pay_Type
FROM salary_range_by_job_classification
WHERE Job_Code LIKE '03%';

-- 6. Find the Effective Date (Eff_Date) or Salary End Date (Sal_End_Date) for grade Q90H0.
SELECT Eff_Date,
       Sal_End_Date
FROM salary_range_by_job_classification
WHERE Grade = 'Q90H0';

-- 7. Sort the Biweekly low rate in ascending order.
SELECT Biweekly_Low_Rate
FROM salary_range_by_job_classification
ORDER BY Biweekly_Low_Rate ASC;

-- 8. What Step are Job Codes 0110-0400?
SELECT Job_Code, 
       Step
FROM salary_range_by_job_classification
WHERE Job_Code BETWEEN '0110' AND '0400';

-- 9. What is the Biweekly High Rate minus the Biweekly Low Rate for job Code 0170?
SELECT Job_Code, 
       Biweekly_High_Rate,
       Biweekly_Low_Rate,
       (Biweekly_High_Rate - Biweekly_Low_Rate) AS High_Minus_Low
FROM salary_range_by_job_classification
WHERE Job_Code = '0170';

-- 10. What is the Extended Step for Pay Types M, H, and D?
SELECT Extended_Step,
       Pay_Type
FROM salary_range_by_job_classification
WHERE Pay_Type IN ('M', 'H', 'D');

-- 11. What is the step for Union Code 990 and a Set ID of SFMTA or COMMN?
SELECT SetID, 
       Step, 
       Union_Code
FROM salary_range_by_job_classification
WHERE (SetID = 'SFMTA' OR SetID = 'COMMN')
AND Union_Code = '990';
