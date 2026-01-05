use project_001;

SELECT * FROM retail_sales;

ALTER TABLE retail_sales
RENAME COLUMN ï»¿transactions_id TO transactions_id;

SELECT * FROM retail_sales
WHERE age = '';

UPDATE retail_sales
SET age =  NULL
WHERE age = '';

SELECT * FROM retail_sales
WHERE quantiy = '' AND price_per_unit = '' AND cogs = '' AND total_sale ='';

UPDATE retail_sales
SET quantiy =  NULL,
	price_per_unit = NULL,
    cogs = NULL,
    total_sale = NULL
WHERE quantiy = '' AND price_per_unit = '' AND cogs = '' AND total_sale ='';


DESCRIBE retail_sales;

ALTER TABLE retail_sales
MODIFY COLUMN transactions_id INT PRIMARY KEY,
MODIFY COLUMN sale_date DATE,
MODIFY COLUMN sale_time TIME,
MODIFY COLUMN customer_id INT,
MODIFY COLUMN gender VARCHAR(15),
MODIFY COLUMN age INT NULL,
MODIFY COLUMN category VARCHAR(15),
MODIFY COLUMN quantiy INT,
MODIFY COLUMN price_per_unit FLOAT,
MODIFY COLUMN cogs FLOAT,
MODIFY COLUMN total_sale FLOAT;

DESCRIBE retail_sales;

--

SELECT COUNT(*) FROM retail_sales
WHERE total_sale IS NULL;

DELETE FROM retail_sales
WHERE total_sale IS NULL;

SELECT COUNT(*) FROM retail_sales;

-- DATA Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;


-- How many unique customers we have?
SELECT COUNT(distinct(customer_id)) as total_customers FROM retail_sales;

-- How many unique category we have?
SELECT distinct(category) FROM retail_sales;

-- Data Analysis and Business key problems and Answers

-- Analysis and Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05' ;

--  Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than OR equal to 4 in the month of Nov-2022:
SELECT * FROM retail_sales
WHERE category= 'Clothing' AND 
	  quantiy >= 4 AND
      MONTH(sale_date) = 11 AND YEAR(sale_date) = 2022;
      
      
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT category, SUM(total_sale), COUNT(*) as Total_Orders
FROM retail_sales
GROUP BY category
ORDER BY Total_Orders DESC;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT category, CAST(AVG(age) AS DECIMAL(10,2)) as Average_Age
FROM retail_sales
where category = 'Beauty' AND age is NOT NULL;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT category, gender, count(transactions_id) as transactions 
FROM retail_sales
GROUP BY category, gender
ORDER BY category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT YEAR_OF_SALE, MONTH_OF_SALE, average_sale FROM 
	(
	SELECT YEAR(sale_date) AS YEAR_OF_SALE, MONTH(sale_date) MONTH_OF_SALE, ROUND(AVG(total_sale), 2) as average_sale, 
	RANK() OVER(partition by YEAR(sale_date) ORDER BY ROUND(AVG(total_sale), 2) DESC) as rank_of_sale
	FROM retail_sales
	GROUP BY YEAR_OF_SALE, MONTH_OF_SALE
	ORDER BY YEAR_OF_SALE
	) as t1
where rank_of_sale = 1;


-- 	Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id,  SUM(total_sale) AS total_sales FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.:

SELECT category, COUNT(DISTINCT(customer_id))
FROM retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

WITH HOURLY_SALE AS 
(
	SELECT *,
		CASE 
			WHEN HOUR(sale_time) < 12 THEN 'Morning'
			WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END AS shift
	FROM retail_sales
)
SELECT shift, count(transactions_id) as No_of_Orders 
FROM HOURLY_SALE
GROUP BY shift;

-- end of project