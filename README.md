# MySQL_retail_sales_Practice_project_P1

**Retail Sales Analysis MySQL Project**

Project Overview
Project Title: Retail Sales Analysis
Database: project_001

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyse retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

**Objectives**
1. **Set up a retail sales database:** Create and populate a retail sales database with the provided sales data.   
2. **Data Cleaning:** Identify and remove any records with missing or null values.   
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.   
4.	**Business Analysis:** Use MySQL to answer specific business questions and derive insights from the sales data.   

**Project Structure**

1. **Database Setup**

    •	**Database Creation:** The project starts by creating a database named project_001   
    •	**Table Creation:** Correcting the datatype of each column and updating the table retail_sales.     

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

2. **Data Exploration & Cleaning**
   
•	**Record Count:** Determine the total number of records in the dataset.   
•	**Customer Count:** Find out how many unique customers are in the dataset.   
•	**Category Count:** Identify all unique product categories in the dataset.   
•	**Null Value Check:** Check for any null values in the dataset and delete records with missing data.   

      SELECT COUNT(*) FROM retail_sales
      WHERE total_sale IS NULL;
      
      DELETE FROM retail_sales
      WHERE total_sale IS NULL;
      
      SELECT COUNT(*) FROM retail_sales;

3. **Data Analysis & Findings**   
The following MySQL queries were developed to answer specific business questions:   

   1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05:**

           SELECT * FROM retail_sales
           WHERE sale_date = '2022-11-05' ;
      
   2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than OR equal to 4 in the month of Nov-2022:**

          SELECT * FROM retail_sales
          WHERE category= 'Clothing' AND 
          	  quantiy >= 4 AND
              MONTH(sale_date) = 11 AND YEAR(sale_date) = 2022;

   3. **Write a SQL query to calculate the total sales (total_sale) for each category.:**

            SELECT category, SUM(total_sale), COUNT(*) as Total_Orders
            FROM retail_sales
            GROUP BY category
            ORDER BY Total_Orders DESC;

     4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:**

            SELECT category, CAST(AVG(age) AS DECIMAL(10,2)) as Average_Age
            FROM retail_sales
            where category = 'Beauty' AND age is NOT NULL;  
  
     5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.:**
  
            SELECT * FROM retail_sales
            WHERE total_sale > 1000; 
  
     6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:**

            SELECT category, gender, count(transactions_id) as transactions 
            FROM retail_sales
            GROUP BY category, gender
            ORDER BY category;
  
  
     7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:**
  
              SELECT YEAR_OF_SALE, MONTH_OF_SALE, average_sale FROM 
            	(
            	SELECT YEAR(sale_date) AS YEAR_OF_SALE, MONTH(sale_date) MONTH_OF_SALE, ROUND(AVG(total_sale), 2) as average_sale, 
            	RANK() OVER(partition by YEAR(sale_date) ORDER BY ROUND(AVG(total_sale), 2) DESC) as rank_of_sale
            	FROM retail_sales
            	GROUP BY YEAR_OF_SALE, MONTH_OF_SALE
            	ORDER BY YEAR_OF_SALE
            	) as t1
              where rank_of_sale = 1;  
  
  
     8. **Write a SQL query to find the top 5 customers based on the highest total sales**
  
            SELECT customer_id,  SUM(total_sale) AS total_sales FROM retail_sales
            GROUP BY customer_id
            ORDER BY total_sales DESC
            LIMIT 5;  
  
     9. **Write a SQL query to find the number of unique customers who purchased items from each category.:**
  
            SELECT category, COUNT(DISTINCT(customer_id))
            FROM retail_sales
            GROUP BY category;  
  
     10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):**   

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

**Findings**   

  •	**Customer Demographics:** The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.  
  •	**High-Value Transactions:** Several transactions had a total sale amount greater than 1000, indicating premium purchases.   
  •	**Sales Trends:** Monthly analysis shows variations in sales, helping identify peak seasons.    
  •	**Customer Insights:** The analysis identifies the top-spending customers and the most popular product categories.    


**Reports**   
•	**Sales Summary:** A detailed report summarizing total sales, customer demographics, and category performance.    
•	**Trend Analysis:** Insights into sales trends across different months and shifts.    
•	**Customer Insights:** Reports on top customers and unique customer counts per category.   

**Conclusion**   
    This project serves as a comprehensive introduction to MySQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


