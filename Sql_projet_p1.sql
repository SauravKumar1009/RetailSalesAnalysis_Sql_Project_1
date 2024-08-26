USE RETAIL_SALES;
SELECT NAME FROM sys.tables;

SELECT TOP 10 * FROM RetailSalesData;
-- cogs is the purchasing cost --
  
-- DATA CLEANING 
     -- Check nulls
   SELECT * FROM RetailSalesData
   WHERE transactions_id IS NULL;

   SELECT * FROM RetailSalesData
   WHERE sale_date IS NULL;

   SELECT * FROM RetailSalesData
   WHERE sale_time IS NULL;

   SELECT * FROM RetailSalesData
   WHERE customer_id IS NULL;

   -- OR

   SELECT * FROM RetailSalesData
   WHERE 
        transactions_id IS NULL 
		OR
		sale_date IS NULL
		OR
		sale_time IS NULL
		OR
		customer_id IS NULL
		OR 
		gender IS NULL
		OR 
		age IS NULL
		OR
		category IS NULL
		OR 
		quantiy IS NULL
		OR 
		price_per_unit IS NULL
		OR 
		cogs IS NULL
		OR 
		total_sale IS NULL ;

		DELETE FROM RetailSalesData
        WHERE 
        transactions_id IS NULL 
		OR
		sale_date IS NULL
		OR
		sale_time IS NULL
		OR
		customer_id IS NULL
		OR 
		gender IS NULL
		OR 
		age IS NULL
		OR
		category IS NULL
		OR 
		quantiy IS NULL
		OR 
		price_per_unit IS NULL
		OR 
		cogs IS NULL
		OR 
		total_sale IS NULL ;

-- EDA 
   -- To count the total number of rows in the dataset
      SELECT COUNT(*) FROM RetailSalesData; 
   -- How many unique customers we have
      SELECT COUNT(DISTINCT customer_id) FROM RetailSalesData;
   -- How many categories we have
      SELECT DISTINCT CATEGORY FROM RetailSalesData;

-- DATA ANALYSIS
SELECT  TOP 5 * FROM RetailSalesData;

--Q1.Write a SQL query to retrieve all columns for sales mode on '2022-11-05'
SELECT 
     * 
FROM RetailSalesData
WHERE sale_date = '2022-11-05';

--Q2.Write an SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is 4 in the monthof Nov-2022   
SELECT 
     * 
FROM RetailSalesData
WHERE category = 'clothing' 
AND quantiy = 4
AND MONTH(sale_date) = 11
AND YEAR(sale_date) = 2022;
 
--Q3.Write a SQL query to calculate the total sales for each category.
SELECT 
	 category,
	 SUM(total_sale) Sales,
	 COUNT(*) AS 'Total Orders'
FROM RetailSalesData
GROUP BY category
ORDER BY Sales DESC;

--Q4.Write the SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT  
	AVG(age) AS AverageAge
FROM RetailSalesData
WHERE category = 'Beauty' ;

--Q5.Write a SQL query to find all the transactions where total sales is greater than 1000.
SELECT 
	 * 
FROM RetailSalesData
WHERE total_sale > 1000;

--Q6.Write a SQL query to find total number of transactions (transaction_id) made by each gender in each category.
SELECT 
	 category,
	 gender,
	 COUNT(transactions_id) AS 'No of Transactions'
FROM RetailSalesData
GROUP BY category,gender ;

--Q7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT 
	 TOP 2
	 MONTH(sale_date) AS 'Month',
	 YEAR(sale_date) AS 'Year',
	 AVG(total_sale) AS 'Avg Sales'   
FROM RetailSalesData
GROUP BY MONTH(sale_date),YEAR(sale_date)
ORDER BY 'Avg Sales' DESC;

--Q8.Write a SQL query to find the top 5 customers based on highest total sales.
SELECT 
	 TOP 5
	 customer_id,
	 SUM(total_sale) AS 'Sales'
FROM RetailSalesData
GROUP BY customer_id
ORDER BY 'Sales' DESC;

--Q9.Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT
	 category,
	 COUNT(DISTINCT customer_id) AS 'No Of Customers'
FROM RetailSalesData
GROUP BY category;

--10.Write a SQL query to create each shift and number of orders (Eg Morning <=12 o'clock, Afternoon Between 12 & 17, Evening >17)
	       
WITH CTE AS
(
SELECT *,
		 CASE 
		     WHEN DATEPART(HOUR,sale_time) > 12 THEN 'Morning'
			 WHEN DATEPART(HOUR,sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			 ELSE 'Evening'
		 END AS 'Shift'
FROM RetailSalesData
)
SELECT 
	 Shift,
	 COUNT(transactions_id) AS 'No of Orders'
FROM CTE
GROUP BY Shift;

-- END OF PROJECT 
		    














	 


