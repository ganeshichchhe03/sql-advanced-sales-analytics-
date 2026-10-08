/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- Which 5 products generates the highest revenue?
-- Simple Ranking 
SELECT TOP 5 -- FOR MYSQL WE USE LIMIT 5 AFTER ORDER BY DESC
p.product_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Complex but Flexibly Ranking Using Window Functions
-- Which 5 products generates the highest revenue?
SELECT * 
FROM (
SELECT
p.product_name,
SUM(f.sales_amount) AS total_revenue,
RANK() OVER(ORDER BY SUM(f.sales_amount) DESC) AS rank_products
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
) AS ranked_products
WHERE rank_products <= 5;
-- Note-> RANK() assign a rank to each row based on the specified ordering.
-- If two rows have same value, they recive the same rank
-- & the next rank is skipped 

-- What are the 5 worst-performing products in terms of sales?
SELECT * 
FROM (
SELECT
p.product_name,
SUM(f.sales_amount) AS total_revenue,
RANK() OVER(ORDER BY SUM(f.sales_amount) ASC) AS rank_products
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
) AS ranked_products
WHERE rank_products <= 5;


-- What are the 5 worst-performing products in terms of sales?
-- BY BOTTOM 5
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC;

-- Find the top 10 customers who have generated the highest revenue
SELECT TOP 10
c.customer_key,
c.customer_id,
c.first_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.customer_id,c.first_name
ORDER BY total_revenue DESC;

-- The 3 customers with the fewest orders placed
SELECT TOP 3
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT order_number)  AS total_orders 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY c.customer_key,c.first_name, c.last_name
ORDER BY total_orders ASC;
