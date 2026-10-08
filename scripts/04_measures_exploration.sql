/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/


--Find the Total Sales
--SELECT * FROM gold.fact_sales
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales;

-- Find how many items are sold
SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales;

-- Find the average selling price
SELECT AVG(price) AS avg_price FROM gold.fact_sales;

-- Find the Total number of Orders
SELECT COUNT(order_number) AS total_orders FROM gold.fact_sales;
SELECT DISTINCT COUNT(order_number) AS total_orders FROM gold.fact_sales; -- it handles duplicates

-- Find the total number of products (WE NEEED TO USE gold.dim_products Table Now)
--SELECT * FROM gold.dim_products;
SELECT COUNT(product_name) AS total_products FROM gold.dim_products;

-- Find the total number of customers
--SELECT * FROM gold.dim_customers;
SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers;

-- Find the total number of customers that has placed an order
SELECT COUNT(DISTINCT customer_key) AS total_orders FROM gold.dim_customers;

-- Generate a Report that shows all key metrics of the business 
--  Total Sales, Total Quantity, Average Price, Total orders, Total products, Total customers
-- SELECT * FROM gold.fact_sales;
-- SELECT * FROM gold.dim_products;
-- SELECT * FROM gold.dim_customers;

SELECT 'Total sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL 
SELECT 'Total quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total products', COUNT(DISTINCT product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total customes', COUNT(DISTINCT customer_key) FROM gold.dim_customers
