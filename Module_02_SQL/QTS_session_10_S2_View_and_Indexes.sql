-- =========================================================
-- MYSQL SCRIPT FOR VIEW AND INDEX PRACTICE
-- Note:
-- 1. A VIEW is a virtual table based on the result of a SELECT query.
-- 2. An INDEX is a database object that speeds up data retrieval
--    on a table at the cost of extra storage and slower writes.
-- =========================================================

-- =========================================================
-- CREATE DATABASE
-- =========================================================
CREATE DATABASE IF NOT EXISTS view_index_demo_db;
USE view_index_demo_db;

-- =========================================================
-- DROP TABLES IF EXISTS
-- =========================================================
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

-- =========================================================
-- TABLE 1: CUSTOMERS
-- =========================================================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO customers (customer_id, customer_name, city, email) VALUES
(1, 'Rahul Sharma',  'Nagpur',   'rahul@example.com'),
(2, 'Priya Verma',   'Pune',     'priya@example.com'),
(3, 'Aman Gupta',    'Mumbai',   'aman@example.com'),
(4, 'Sanya Kapoor',  'Nagpur',   'sanya@example.com'),
(5, 'Vikram Singh',  'Delhi',    'vikram@example.com'),
(6, 'Ritu Malhotra', 'Pune',     'ritu@example.com');

-- =========================================================
-- TABLE 2: PRODUCTS
-- =========================================================
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_qty INT
);

INSERT INTO products (product_id, product_name, category, price, stock_qty) VALUES
(101, 'Laptop',      'Electronics', 55000, 20),
(102, 'Mobile',       'Electronics', 20000, 50),
(103, 'Tablet',       'Electronics', 18000, 30),
(104, 'Office Chair', 'Furniture',   4500,  15),
(105, 'Study Table',  'Furniture',   6000,  10),
(106, 'Water Bottle',  'Accessories', 300,  100);

-- =========================================================
-- TABLE 3: ORDERS
-- =========================================================
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (order_id, customer_id, order_date) VALUES
(1001, 1, '2025-01-05'),
(1002, 2, '2025-01-12'),
(1003, 1, '2025-02-03'),
(1004, 3, '2025-02-18'),
(1005, 4, '2025-03-01'),
(1006, 5, '2025-03-10'),
(1007, 2, '2025-03-22'),
(1008, 6, '2025-04-02');

-- =========================================================
-- TABLE 4: ORDER_ITEMS
-- =========================================================
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES
(1, 1001, 101, 1),
(2, 1001, 106, 2),
(3, 1002, 102, 1),
(4, 1003, 103, 2),
(5, 1004, 104, 1),
(6, 1004, 105, 1),
(7, 1005, 101, 1),
(8, 1006, 102, 3),
(9, 1007, 106, 5),
(10, 1008, 103, 1);


-- =========================================================
-- =========================================================
-- PART A: VIEWS
-- =========================================================
-- =========================================================

-- =========================================================
-- SHORT NOTES: VIEW
-- =========================================================
-- Definition:
-- A VIEW is a virtual table stored as a saved SELECT query.
-- It does not store data itself (in most cases); it pulls
-- live data from the underlying base table(s) every time
-- it is queried.
--
-- Syntax:
-- CREATE VIEW view_name AS
-- SELECT columns FROM table WHERE condition;
--
-- Why use views:
-- 1. Simplify complex/repeated queries
-- 2. Restrict access to specific columns/rows (security)
-- 3. Present data in a customized, readable format
-- 4. Provide a stable interface even if base tables change
--
-- Types of Views:
-- 1. Simple View     -> Based on a single table, no GROUP BY/joins
-- 2. Complex View    -> Based on multiple tables (joins) or
--                       contains GROUP BY, aggregate functions
-- 3. Updatable View  -> Simple view that allows INSERT/UPDATE/DELETE
--                       to reflect back on the base table
-- 4. Read-Only View  -> Contains joins/aggregates/DISTINCT, so it
--                       cannot be used to modify base table data
-- 5. WITH CHECK OPTION View -> Prevents INSERT/UPDATE that would
--                       make a row disappear from the view's WHERE filter
-- =========================================================

-- =========================================================
-- VIEW EXERCISE 1
-- Problem:
-- Create a simple view that shows only customers from Nagpur.
-- Type:
-- Simple View (single table)
-- =========================================================
CREATE OR REPLACE VIEW vw_nagpur_customers AS
SELECT customer_id, customer_name, email
FROM customers
WHERE city = 'Nagpur';

-- Usage:
SELECT * FROM vw_nagpur_customers;

-- =========================================================
-- VIEW EXERCISE 2
-- Problem:
-- Create a simple view that hides the price column and shows
-- only product_name, category and stock_qty (column-level security).
-- Type:
-- Simple View (restricting columns)
-- =========================================================
CREATE OR REPLACE VIEW vw_product_stock AS
SELECT product_name, category, stock_qty
FROM products;

-- Usage:
SELECT * FROM vw_product_stock;

-- =========================================================
-- VIEW EXERCISE 3
-- Problem:
-- Create a view showing each order along with the customer name
-- and city who placed it.
-- Type:
-- Complex View (JOIN across two tables)
-- =========================================================
CREATE OR REPLACE VIEW vw_order_customer_details AS
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    c.city
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- Usage:
SELECT * FROM vw_order_customer_details;

-- =========================================================
-- VIEW EXERCISE 4
-- Problem:
-- Create a view showing total quantity and total amount for
-- every order (order_id, total_quantity, total_amount).
-- Type:
-- Complex View (JOIN + GROUP BY + Aggregate functions)
-- =========================================================
CREATE OR REPLACE VIEW vw_order_totals AS
SELECT
    oi.order_id,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * p.price) AS total_amount
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY oi.order_id;

-- Usage:
SELECT * FROM vw_order_totals;

-- =========================================================
-- VIEW EXERCISE 5
-- Problem:
-- Create a view listing products that are low on stock (qty < 20),
-- for the inventory team to monitor.
-- Type:
-- Simple View (filtered)
-- =========================================================
CREATE OR REPLACE VIEW vw_low_stock_products AS
SELECT product_id, product_name, stock_qty
FROM products
WHERE stock_qty < 20;

-- Usage:
SELECT * FROM vw_low_stock_products;

-- =========================================================
-- VIEW EXERCISE 6
-- Problem:
-- Create an updatable view for Furniture category products only,
-- and demonstrate updating data through the view.
-- Type:
-- Updatable View
-- =========================================================
CREATE OR REPLACE VIEW vw_furniture_products AS
SELECT product_id, product_name, price, stock_qty
FROM products
WHERE category = 'Furniture';

-- Usage: updating through the view updates the base table
UPDATE vw_furniture_products
SET stock_qty = stock_qty + 5
WHERE product_id = 104;

SELECT * FROM products WHERE category = 'Furniture';

-- =========================================================
-- VIEW EXERCISE 7
-- Problem:
-- Create a view with WITH CHECK OPTION so that no one can insert
-- or update a row through the view in a way that removes it from
-- the view's own filter condition (Furniture only).
-- Type:
-- WITH CHECK OPTION View
-- =========================================================
CREATE OR REPLACE VIEW vw_furniture_only AS
SELECT product_id, product_name, category, price, stock_qty
FROM products
WHERE category = 'Furniture'
WITH CHECK OPTION;

-- This works (still Furniture):
UPDATE vw_furniture_only SET price = 4700 WHERE product_id = 104;

-- This FAILS (would move the row out of the view's filter):
-- UPDATE vw_furniture_only SET category = 'Electronics' WHERE product_id = 104;

-- =========================================================
-- VIEW EXERCISE 8
-- Problem:
-- Create a read-only style view (uses DISTINCT + JOIN) showing
-- the list of cities that have placed at least one order.
-- Type:
-- Read-Only View (cannot be used for INSERT/UPDATE/DELETE)
-- =========================================================
CREATE OR REPLACE VIEW vw_cities_with_orders AS
SELECT DISTINCT c.city
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- Usage:
SELECT * FROM vw_cities_with_orders;

-- =========================================================
-- VIEW EXERCISE 9
-- Problem:
-- Drop a view (cleanup command students should also learn).
-- Type:
-- View Maintenance
-- =========================================================
-- DROP VIEW IF EXISTS vw_cities_with_orders;

-- =========================================================
-- VIEW EXERCISE 10
-- Problem:
-- List all views that exist in the current database.
-- Type:
-- View Metadata
-- =========================================================
SHOW FULL TABLES IN view_index_demo_db WHERE TABLE_TYPE = 'VIEW';


-- =========================================================
-- =========================================================
-- PART B: INDEXES
-- =========================================================
-- =========================================================

-- =========================================================
-- SHORT NOTES: INDEX
-- =========================================================
-- Definition:
-- An INDEX is a database object created on one or more columns
-- of a table that allows MySQL to find rows faster, without
-- scanning the entire table (similar to an index at the back
-- of a book).
--
-- Trade-off:
-- Indexes speed up SELECT/WHERE/JOIN/ORDER BY, but slow down
-- INSERT/UPDATE/DELETE slightly and use extra disk space,
-- because the index must be updated too.
--
-- Types of Indexes:
-- 1. Primary Key Index -> Created automatically on PRIMARY KEY,
--                          unique + not null
-- 2. Unique Index       -> Ensures all values in the column(s)
--                          are distinct
-- 3. Simple/Single-Column Index -> Index on one column
-- 4. Composite (Multi-Column) Index -> Index on 2+ columns,
--                          column order matters
-- 5. Full-Text Index    -> Used for fast text/word searching
--                          in VARCHAR/TEXT columns (MATCH ... AGAINST)
-- 6. Implicit Index (Foreign Key) -> MySQL/InnoDB usually creates
--                          an index automatically on FK columns
-- =========================================================

-- =========================================================
-- INDEX EXERCISE 1
-- Problem:
-- Create a simple index on the city column of customers, since
-- students often filter/search customers by city.
-- Type:
-- Simple (Single-Column) Index
-- =========================================================
CREATE INDEX idx_customers_city ON customers(city);

-- Query that benefits from this index:
SELECT * FROM customers WHERE city = 'Pune';

-- =========================================================
-- INDEX EXERCISE 2
-- Problem:
-- Create a unique index on the customers' email column so that
-- no two customers can share the same email address.
-- Type:
-- Unique Index
-- =========================================================
CREATE UNIQUE INDEX idx_customers_email ON customers(email);

-- This will now FAIL because it violates uniqueness:
-- INSERT INTO customers VALUES (7, 'Fake User', 'Nagpur', 'rahul@example.com');

-- =========================================================
-- INDEX EXERCISE 3
-- Problem:
-- Create a composite index on products(category, price) to speed
-- up queries that filter by category and then sort/filter by price.
-- Type:
-- Composite (Multi-Column) Index
-- =========================================================
CREATE INDEX idx_products_category_price ON products(category, price);

-- Query that benefits from this index (uses leftmost column first):
SELECT * FROM products
WHERE category = 'Electronics'
ORDER BY price;

-- =========================================================
-- INDEX EXERCISE 4
-- Problem:
-- Create an index on orders(order_date) to speed up date-range
-- reports (e.g. monthly sales reports).
-- Type:
-- Simple Index on a date column
-- =========================================================
CREATE INDEX idx_orders_orderdate ON orders(order_date);

-- Query that benefits from this index:
SELECT * FROM orders
WHERE order_date BETWEEN '2025-01-01' AND '2025-02-28';

-- =========================================================
-- INDEX EXERCISE 5
-- Problem:
-- Create a composite index on order_items(order_id, product_id)
-- to speed up joins/lookups that use both columns together.
-- Type:
-- Composite Index (join optimization)
-- =========================================================
CREATE INDEX idx_orderitems_order_product ON order_items(order_id, product_id);

-- =========================================================
-- INDEX EXERCISE 6
-- Problem:
-- Add a full-text index on products.product_name so students can
-- search products by keyword instead of only exact match.
-- Type:
-- Full-Text Index
-- =========================================================
ALTER TABLE products ADD FULLTEXT INDEX idx_products_fulltext (product_name);

-- Query that uses the full-text index:
SELECT product_name, category
FROM products
WHERE MATCH(product_name) AGAINST('Table' IN NATURAL LANGUAGE MODE);

-- =========================================================
-- INDEX EXERCISE 7
-- Problem:
-- Show all indexes that currently exist on the products table
-- (so students can see PRIMARY, UNIQUE, composite and fulltext
-- indexes together).
-- Type:
-- Index Metadata
-- =========================================================
SHOW INDEX FROM products;

-- =========================================================
-- INDEX EXERCISE 8
-- Problem:
-- Use EXPLAIN to show students how MySQL decides whether to use
-- the idx_products_category_price index for a query.
-- Type:
-- Index Usage Analysis
-- =========================================================
EXPLAIN
SELECT * FROM products
WHERE category = 'Electronics'
ORDER BY price;

-- =========================================================
-- INDEX EXERCISE 9
-- Problem:
-- Drop an index that is no longer needed (index maintenance).
-- Type:
-- Index Maintenance
-- =========================================================
-- DROP INDEX idx_customers_city ON customers;

-- =========================================================
-- INDEX EXERCISE 10
-- Problem:
-- Compare a query's performance conceptually: run the same WHERE
-- clause on an indexed column vs a non-indexed column, and use
-- EXPLAIN on both to observe the difference in the "key" and
-- "rows" columns.
-- Type:
-- Indexed vs Non-Indexed Comparison
-- =========================================================
-- Indexed column (order_date has an index):
EXPLAIN SELECT * FROM orders WHERE order_date = '2025-03-01';

-- Non-indexed column (customer_id on order_items has no direct index here
-- other than what InnoDB auto-creates for the FK):
EXPLAIN SELECT * FROM order_items WHERE quantity = 1;