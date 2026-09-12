-- =========================================================
-- MYSQL SET OPERATIONS - CLASSROOM FRIENDLY SCRIPT
-- CURRENT MYSQL 8.x VERSION
--
-- Topics Covered:
-- 1. UNION
-- 2. UNION ALL
-- 3. INTERSECT
-- 4. INTERSECT using IN
-- 5. INTERSECT using EXISTS
-- 6. EXCEPT
-- 7. EXCEPT using NOT IN
-- 8. EXCEPT using NOT EXISTS
--
-- IMPORTANT:
-- MySQL 8.0.31+ supports:
--     INTERSECT
--     EXCEPT
-- =========================================================


-- =========================================================
-- STEP 1: CREATE DATABASE
-- =========================================================

CREATE DATABASE IF NOT EXISTS set_operations_practice;

USE set_operations_practice;


-- =========================================================
-- STEP 2: DROP TABLES IF THEY ALREADY EXIST
-- =========================================================

DROP TABLE IF EXISTS employees_branch_a;
DROP TABLE IF EXISTS employees_branch_b;


-- =========================================================
-- STEP 3: CREATE TABLES
--
-- Both tables have:
-- Same number of columns
-- Same column order
-- Compatible data types
--
-- This is required for UNION / INTERSECT / EXCEPT.
-- =========================================================

CREATE TABLE employees_branch_a (
    emp_id INT,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    city VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE employees_branch_b (
    emp_id INT,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    city VARCHAR(50),
    salary DECIMAL(10,2)
);


-- =========================================================
-- STEP 4: INSERT DATA INTO BRANCH A
-- =========================================================

INSERT INTO employees_branch_a
(emp_id, emp_name, department, city, salary)
VALUES
(101, 'Amit Sharma',    'IT',      'Pune',      55000.00),
(102, 'Neha Verma',     'HR',      'Mumbai',    48000.00),
(103, 'Rohit Mehta',    'Sales',   'Nagpur',    45000.00),
(104, 'Priya Nair',     'Finance', 'Bangalore', 62000.00),
(105, 'Karan Singh',    'IT',      'Delhi',     58000.00),
(106, 'Sneha Joshi',    'Support', 'Pune',      39000.00),
(107, 'Arjun Patel',    'Sales',   'Ahmedabad', 47000.00),
(108, 'Pooja Desai',    'HR',      'Surat',     50000.00),
(109, 'Vikas Rao',      'Finance', 'Chennai',   61000.00),
(110, 'Anjali Gupta',   'IT',      'Hyderabad', 57000.00),
(111, 'Rahul Yadav',    'Support', 'Indore',    40000.00),
(112, 'Meera Iyer',     'Sales',   'Kolkata',   46000.00);


-- =========================================================
-- STEP 5: INSERT DATA INTO BRANCH B
--
-- 108, 109 and 110 are exactly common in both tables.
-- Other employees are unique to Branch B.
-- =========================================================

INSERT INTO employees_branch_b
(emp_id, emp_name, department, city, salary)
VALUES
(108, 'Pooja Desai',     'HR',      'Surat',     50000.00),
(109, 'Vikas Rao',       'Finance', 'Chennai',   61000.00),
(110, 'Anjali Gupta',    'IT',      'Hyderabad', 57000.00),
(113, 'Sanjay Kulkarni', 'IT',      'Pune',      56000.00),
(114, 'Ritika Sen',      'HR',      'Delhi',     49000.00),
(115, 'Manoj Das',       'Sales',   'Nagpur',    45000.00),
(116, 'Kavita Roy',      'Finance', 'Mumbai',    64000.00),
(117, 'Deepak Jain',     'Support', 'Jaipur',    41000.00),
(118, 'Nisha Kapoor',    'IT',      'Noida',     59000.00),
(119, 'Harsh Vardhan',   'Sales',   'Lucknow',   47000.00),
(120, 'Swati Mishra',    'Support', 'Bhopal',    39500.00),
(121, 'Gaurav Sinha',    'Finance', 'Patna',     60500.00);


-- =========================================================
-- OPTIONAL: VIEW TABLE DATA
-- =========================================================

SELECT * FROM employees_branch_a;

SELECT * FROM employees_branch_b;


-- =========================================================
-- EXERCISE 1
-- =========================================================
-- Problem:
-- Show all employees from both branches without duplicates.
--
-- Concept:
-- UNION removes duplicate rows.
-- =========================================================

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_a

UNION

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_b;


-- =========================================================
-- EXERCISE 2
-- =========================================================
-- Problem:
-- Show all employees from both branches including duplicates.
--
-- Concept:
-- UNION ALL keeps duplicate rows.
-- =========================================================

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_a

UNION ALL

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_b;


-- =========================================================
-- EXERCISE 3
-- =========================================================
-- Problem:
-- Show only employee names from both branches without duplicates.
-- =========================================================

SELECT emp_name
FROM employees_branch_a

UNION

SELECT emp_name
FROM employees_branch_b;


-- =========================================================
-- EXERCISE 4
-- =========================================================
-- Problem:
-- Show only department names from both branches including duplicates.
-- =========================================================

SELECT department
FROM employees_branch_a

UNION ALL

SELECT department
FROM employees_branch_b;


-- =========================================================
-- EXERCISE 5
-- =========================================================
-- Problem:
-- Show unique cities across both branches.
-- =========================================================

SELECT city
FROM employees_branch_a

UNION

SELECT city
FROM employees_branch_b;


-- =========================================================
-- EXERCISE 6
-- =========================================================
-- Problem:
-- Show all salaries from both branches including duplicates.
-- =========================================================

SELECT salary
FROM employees_branch_a

UNION ALL

SELECT salary
FROM employees_branch_b;


-- =========================================================
-- EXERCISE 7
-- =========================================================
-- Problem:
-- Show all IT employees from both branches without duplicates.
-- =========================================================

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_a
WHERE department = 'IT'

UNION

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_b
WHERE department = 'IT';


-- =========================================================
-- EXERCISE 8
-- =========================================================
-- Problem:
-- Show all Sales employees from both branches including duplicates.
-- =========================================================

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_a
WHERE department = 'Sales'

UNION ALL

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_b
WHERE department = 'Sales';


-- =========================================================
-- EXERCISE 9
-- =========================================================
-- Problem:
-- Show employee IDs from both branches without duplicates
-- in ascending order.
-- =========================================================

SELECT emp_id
FROM employees_branch_a

UNION

SELECT emp_id
FROM employees_branch_b

ORDER BY emp_id ASC;


-- =========================================================
-- EXERCISE 10
-- =========================================================
-- Problem:
-- Show employee names from both branches including duplicates,
-- sorted alphabetically.
-- =========================================================

SELECT emp_name
FROM employees_branch_a

UNION ALL

SELECT emp_name
FROM employees_branch_b

ORDER BY emp_name ASC;


-- =========================================================
-- EXERCISE 11
-- =========================================================
-- Problem:
-- Show all employees from Pune and Nagpur from both branches
-- without duplicates.
-- =========================================================

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_a
WHERE city IN ('Pune', 'Nagpur')

UNION

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_b
WHERE city IN ('Pune', 'Nagpur');


-- =========================================================
-- EXERCISE 12
-- =========================================================
-- Problem:
-- Show all employees whose salary is greater than 50000
-- from both branches including duplicates.
-- =========================================================

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_a
WHERE salary > 50000

UNION ALL

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_b
WHERE salary > 50000;


-- =========================================================
-- EXERCISE 13
-- =========================================================
-- Problem:
-- Show unique department and city combinations
-- across both branches.
-- =========================================================

SELECT department, city
FROM employees_branch_a

UNION

SELECT department, city
FROM employees_branch_b;


-- =========================================================
-- EXERCISE 14
-- =========================================================
-- Problem:
-- Show department and city combinations across both branches
-- including duplicates.
-- =========================================================

SELECT department, city
FROM employees_branch_a

UNION ALL

SELECT department, city
FROM employees_branch_b;


-- =========================================================
-- EXERCISE 15 - INTERSECT
-- =========================================================
-- Problem:
-- Show employees who are exactly common in both branches.
--
-- INTERSECT returns rows that exist in BOTH result sets.
--
-- MySQL 8.0.31+ supports INTERSECT.
-- =========================================================

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_a

INTERSECT

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_b;


-- =========================================================
-- EXERCISE 16 - INTERSECT USING IN
-- =========================================================
-- Problem:
-- Show employees from Branch A whose employee ID
-- also exists in Branch B.
--
-- Concept:
-- IN checks whether a value exists in another result.
-- =========================================================

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_a
WHERE emp_id IN (
    SELECT emp_id
    FROM employees_branch_b
);


-- =========================================================
-- EXERCISE 17 - INTERSECT USING EXISTS
-- =========================================================
-- Problem:
-- Show employees from Branch A whose matching employee
-- exists in Branch B.
--
-- Concept:
-- EXISTS checks whether at least one matching row exists.
--
-- No JOIN is used.
-- =========================================================

SELECT a.emp_id, a.emp_name, a.department, a.city, a.salary
FROM employees_branch_a a
WHERE EXISTS (
    SELECT 1
    FROM employees_branch_b b
    WHERE b.emp_id = a.emp_id
      AND b.emp_name = a.emp_name
      AND b.department = a.department
      AND b.city = a.city
      AND b.salary = a.salary
);


-- =========================================================
-- EXERCISE 18 - EXCEPT
-- =========================================================
-- Problem:
-- Show employees present in Branch A
-- but not present in Branch B.
--
-- EXCEPT returns rows from the first query
-- that are not present in the second query.
--
-- MySQL 8.0.31+ supports EXCEPT.
-- =========================================================

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_a

EXCEPT

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_b;


-- =========================================================
-- EXERCISE 19 - EXCEPT USING NOT IN
-- =========================================================
-- Problem:
-- Show employees from Branch A whose employee ID
-- does NOT exist in Branch B.
--
-- Concept:
-- NOT IN checks that a value does not exist
-- in another result.
-- =========================================================

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_a
WHERE emp_id NOT IN (
    SELECT emp_id
    FROM employees_branch_b
);


-- =========================================================
-- EXERCISE 20 - EXCEPT USING NOT EXISTS
-- =========================================================
-- Problem:
-- Show complete employee rows from Branch A
-- that do not have an exactly matching row in Branch B.
--
-- Concept:
-- NOT EXISTS checks that no matching row exists.
--
-- No JOIN is used.
-- =========================================================

SELECT a.emp_id, a.emp_name, a.department, a.city, a.salary
FROM employees_branch_a a
WHERE NOT EXISTS (
    SELECT 1
    FROM employees_branch_b b
    WHERE b.emp_id = a.emp_id
      AND b.emp_name = a.emp_name
      AND b.department = a.department
      AND b.city = a.city
      AND b.salary = a.salary
);


-- =========================================================
-- EXERCISE 21
-- =========================================================
-- Problem:
-- Show employees present in Branch B
-- but not present in Branch A.
--
-- EXCEPT in reverse direction.
-- =========================================================

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_b

EXCEPT

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_a;


-- =========================================================
-- EXERCISE 22
-- =========================================================
-- Problem:
-- Show departments common in both branches.
--
-- INTERSECT on a single column.
-- =========================================================

SELECT department
FROM employees_branch_a

INTERSECT

SELECT department
FROM employees_branch_b;


-- =========================================================
-- EXERCISE 23
-- =========================================================
-- Problem:
-- Show cities common in both branches.
--
-- INTERSECT on a single column.
-- =========================================================

SELECT city
FROM employees_branch_a

INTERSECT

SELECT city
FROM employees_branch_b;


-- =========================================================
-- EXERCISE 24
-- =========================================================
-- Problem:
-- Show department and city combinations present in Branch A
-- but not in Branch B.
--
-- EXCEPT on multiple columns.
-- =========================================================

SELECT department, city
FROM employees_branch_a

EXCEPT

SELECT department, city
FROM employees_branch_b;


-- =========================================================
-- EXERCISE 25
-- =========================================================
-- Problem:
-- Show salaries that are common in both branches.
--
-- INTERSECT automatically removes duplicate values.
-- =========================================================

SELECT salary
FROM employees_branch_a

INTERSECT

SELECT salary
FROM employees_branch_b;


-- =========================================================
-- EXERCISE 26 - INTERSECT USING IN
-- =========================================================
-- Problem:
-- Show department names from Branch A
-- that are also present in Branch B.
-- =========================================================

SELECT DISTINCT department
FROM employees_branch_a
WHERE department IN (
    SELECT department
    FROM employees_branch_b
);


-- =========================================================
-- EXERCISE 27 - INTERSECT USING EXISTS
-- =========================================================
-- Problem:
-- Show cities from Branch A
-- that also exist in Branch B.
-- =========================================================

SELECT DISTINCT a.city
FROM employees_branch_a a
WHERE EXISTS (
    SELECT 1
    FROM employees_branch_b b
    WHERE b.city = a.city
);


-- =========================================================
-- EXERCISE 28 - EXCEPT USING NOT IN
-- =========================================================
-- Problem:
-- Show department names that exist in Branch A
-- but do not exist in Branch B.
-- =========================================================

SELECT DISTINCT department
FROM employees_branch_a
WHERE department NOT IN (
    SELECT department
    FROM employees_branch_b
);


-- =========================================================
-- EXERCISE 29 - EXCEPT USING NOT EXISTS
-- =========================================================
-- Problem:
-- Show cities that exist in Branch A
-- but do not exist in Branch B.
-- =========================================================

SELECT DISTINCT a.city
FROM employees_branch_a a
WHERE NOT EXISTS (
    SELECT 1
    FROM employees_branch_b b
    WHERE b.city = a.city
);


-- =========================================================
-- EXERCISE 30 - INTERSECT USING IN
-- =========================================================
-- Problem:
-- Show employees from Branch A whose salary
-- is also present in Branch B.
-- =========================================================

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_a
WHERE salary IN (
    SELECT salary
    FROM employees_branch_b
);


-- =========================================================
-- EXERCISE 31 - INTERSECT USING EXISTS
-- =========================================================
-- Problem:
-- Show employees from Branch A whose salary
-- is also present in Branch B.
-- =========================================================

SELECT a.emp_id, a.emp_name, a.department, a.city, a.salary
FROM employees_branch_a a
WHERE EXISTS (
    SELECT 1
    FROM employees_branch_b b
    WHERE b.salary = a.salary
);


-- =========================================================
-- EXERCISE 32 - EXCEPT USING NOT IN
-- =========================================================
-- Problem:
-- Show employee IDs that exist in Branch A
-- but do not exist in Branch B.
-- =========================================================

SELECT emp_id
FROM employees_branch_a
WHERE emp_id NOT IN (
    SELECT emp_id
    FROM employees_branch_b
);


-- =========================================================
-- EXERCISE 33 - EXCEPT USING NOT EXISTS
-- =========================================================
-- Problem:
-- Show employee IDs that exist in Branch A
-- but do not exist in Branch B.
-- =========================================================

SELECT a.emp_id
FROM employees_branch_a a
WHERE NOT EXISTS (
    SELECT 1
    FROM employees_branch_b b
    WHERE b.emp_id = a.emp_id
);


-- =========================================================
-- EXERCISE 34 - SORT INTERSECT RESULT
-- =========================================================
-- Problem:
-- Show common employees sorted by employee ID.
--
-- ORDER BY is applied after the complete INTERSECT result.
-- =========================================================

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_a

INTERSECT

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_b

ORDER BY emp_id ASC;


-- =========================================================
-- EXERCISE 35 - SORT EXCEPT RESULT
-- =========================================================
-- Problem:
-- Show employees present only in Branch A,
-- sorted by employee ID.
-- =========================================================

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_a

EXCEPT

SELECT emp_id, emp_name, department, city, salary
FROM employees_branch_b

ORDER BY emp_id ASC;


-- =========================================================
-- IMPORTANT CLASSROOM NOTES
-- =========================================================

-- UNION
-- Combines two result sets and removes duplicate rows.

-- UNION ALL
-- Combines two result sets and keeps duplicate rows.

-- INTERSECT
-- Returns rows that exist in BOTH result sets.

-- IN
-- Checks whether a value exists in another query result.

-- EXISTS
-- Checks whether at least one matching row exists.

-- EXCEPT
-- Returns rows from the FIRST result set
-- that are NOT present in the SECOND result set.

-- NOT IN
-- Checks whether a value does NOT exist
-- in another query result.

-- NOT EXISTS
-- Checks whether NO matching row exists.
