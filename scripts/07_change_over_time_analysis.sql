/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.
    - To identify the seasonality of our data.

SQL Functions Used:
    - Date Functions: DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- Analyse sales performance over time
-- Quick Date Functions
SELECT
    YEAR(order_date) AS order_year, -- Year shows order year only
    MONTH(order_date) AS order_month,-- Month shows order month only
    SUM(sales_amount) AS total_sales,-- total revenue for that moth, year
    COUNT(DISTINCT customer_key) AS total_customers,-- it show the number of customers 
    SUM(quantity) AS total_quantity -- it shows total quantity of products
FROM gold.fact_sales
WHERE order_date IS NOT NULL -- it ensure rows in order_date column must be not empty
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);
-- it will show you year and month wise total sales, total customers, total quantity 


-- DATETRUNC('month', order_date) → 2026-10-01 00:00:00
SELECT
    DATETRUNC(month, order_date) AS order_date,
    SUM(sales_amount) AS total_sales,-- total revenue for that month
    COUNT(DISTINCT customer_key) AS total_customers, -- unique customers that placed an order
    SUM(quantity) AS total_quantity -- total item sold that month
FROM gold.fact_sales
WHERE order_date IS NOT NULL-- it ensure that the order_date is must be not null
GROUP BY DATETRUNC(month, order_date) 
ORDER BY DATETRUNC(month, order_date);
-- it will show you year and month wise total sales, total customers, total quantity 

-- FORMAT()- it will convert 2010-01-01(yyyy-MMM)-> 2010-Jan
SELECT
    FORMAT(order_date, 'yyyy-MMM') AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM');
