-- =====================================================================
-- QuadSync Tech Solutions | Data Analyst Capstone (Intermediate)
-- Script 01: create the database and load the raw CSV files
-- Tool: MySQL Workbench 8.x
-- =====================================================================
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
