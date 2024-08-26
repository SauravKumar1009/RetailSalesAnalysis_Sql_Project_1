# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.



### 3. Data Analysis & Findings
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
		    

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Zero Analyst

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:

- **YouTube**: [Subscribe to my channel for tutorials and insights](https://www.youtube.com/@zero_analyst)
- **Instagram**: [Follow me for daily tips and updates](https://www.instagram.com/zero_analyst/)
- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/najirr)
- **Discord**: [Join our community to learn and grow together](https://discord.gg/36h5f2Z5PK)

Thank you for your support, and I look forward to connecting with you!
