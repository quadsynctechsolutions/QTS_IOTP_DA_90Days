-- QuadSync Tech Solutions | Data Analyst Capstone | STUDENT FILE
-- Run the setup first, then write your own query under each task.

-- ---------------------------------------------------------------------
-- SETUP (run once): create the database and the 4 staging tables
-- ---------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS amazon_capstone CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE amazon_capstone;

-- Every column is VARCHAR because the raw files are dirty (mixed dates, symbols in prices).
DROP TABLE IF EXISTS stg_customers;
CREATE TABLE stg_customers (customer_id VARCHAR(30), customer_name VARCHAR(100), email VARCHAR(150), phone VARCHAR(30),
                            gender VARCHAR(20), signup_date VARCHAR(30), city VARCHAR(60), state VARCHAR(60), membership VARCHAR(20));
DROP TABLE IF EXISTS stg_products;
CREATE TABLE stg_products (product_id VARCHAR(30), product_name VARCHAR(200), category VARCHAR(60), sub_category VARCHAR(60),
                           brand VARCHAR(60), mrp VARCHAR(30), rating VARCHAR(10), stock_qty VARCHAR(10));
DROP TABLE IF EXISTS stg_orders;
CREATE TABLE stg_orders (order_id VARCHAR(30), order_date VARCHAR(30), ship_date VARCHAR(30), customer_id VARCHAR(30),
                         product_id VARCHAR(30), quantity VARCHAR(15), unit_price VARCHAR(30), discount_pct VARCHAR(15),
                         order_total VARCHAR(30), payment_method VARCHAR(30), shipping_mode VARCHAR(30),
                         order_status VARCHAR(30), delivery_rating VARCHAR(10));
DROP TABLE IF EXISTS stg_returns;
CREATE TABLE stg_returns (return_id VARCHAR(30), order_id VARCHAR(30), return_date VARCHAR(30), return_reason VARCHAR(60),
                          refund_amount VARCHAR(30), refund_status VARCHAR(30));

-- Load the CSV files. Change C:/capstone/data/ to the folder where you unzipped the data.
-- If LOAD DATA is blocked: SET GLOBAL local_infile = 1; and add OPT_LOCAL_INFILE=1 in the
-- Workbench connection (Advanced tab), or use the Table Data Import Wizard instead.
LOAD DATA LOCAL INFILE 'C:/capstone/data/customers.csv' INTO TABLE stg_customers CHARACTER SET utf8mb4
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE 'C:/capstone/data/products.csv'  INTO TABLE stg_products  CHARACTER SET utf8mb4
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE 'C:/capstone/data/orders.csv'    INTO TABLE stg_orders    CHARACTER SET utf8mb4
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE 'C:/capstone/data/returns.csv'   INTO TABLE stg_returns   CHARACTER SET utf8mb4
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;


-- ##### STAGE 1: UNDERSTAND, LOAD AND EXPLORE #####

-- Q1. Row counts and a first look
-- TASK: Check that all four tables loaded and look at a few rows.
-- Write your query below:



-- Q2. Find blank values
-- TASK: Count how many blank values each important column has.
-- Write your query below:



-- Q3. Find duplicate rows
-- TASK: Find how many duplicate records each table has.
-- Write your query below:



-- Q4. Find inconsistent labels
-- TASK: List the different values of payment method, order status and gender and spot the ones that mean the same thing.
-- Write your query below:



-- Q5. Find wrong formats and impossible values
-- TASK: Find prices with a currency symbol, dates in different formats, and negative or zero quantities.
-- Write your query below:



-- ##### STAGE 2A: CLEAN THE DATA #####

-- Q6. Remove duplicate rows
-- TASK: Create a copy of every table that has no duplicate rows.
-- Write your query below:



-- Q7. Standardise text (TRIM, UPPER, CASE)
-- TASK: Make every payment method, status, shipping mode, gender, city and category use one spelling.
-- Write your query below:



-- Q8. Clean customers and products (fix data types)
-- TASK: Create customers_clean and products_clean with real dates, numbers and no symbols.
-- Write your query below:



-- Q9. Clean the orders table (main table)
-- TASK: Create orders_clean with real dates, numeric prices, a 0 to 100 discount and impossible values replaced by NULL.
-- Write your query below:



-- Q10. Clean the returns table
-- TASK: Create returns_clean with real dates, numeric refunds and standard reasons.
-- Write your query below:



-- Q11. Validate the cleaning (before and after)
-- TASK: Prove that the cleaning worked: compare row counts, check for orphan keys and count the values that remain for Python.
-- Write your query below:



-- ##### STAGE 2B: BUSINESS ANALYSIS #####

-- Q12. Create a reusable sales view and yearly KPIs
-- TASK: Join orders, customers and products once in a view, then calculate revenue, orders, customers and average order value for each year.
-- Write your query below:



-- Q13. Top 10 products by revenue
-- TASK: Which 10 products earn the most?
-- Write your query below:



-- Q14. Revenue by category and its share
-- TASK: How much does each category earn, and what percent of total revenue is that?
-- Write your query below:



-- Q15. Monthly revenue trend
-- TASK: What is the revenue for each month?
-- Write your query below:



-- Q16. Top 10 cities by revenue
-- TASK: Which cities bring the most revenue?
-- Write your query below:



-- Q17. Payment methods and cancellation rate
-- TASK: Which payment methods are used most, and how often are those orders cancelled?
-- Write your query below:



-- Q18. Top 10 customers and repeat customers
-- TASK: Who are the 10 highest-spending customers, and how many customers bought more than once?
-- Write your query below:



-- Q19. Return rate by category and return reasons
-- TASK: Which categories have the highest return rate, and why do customers return products?
-- Write your query below:


