/* ======================================================================
   SQL PROJECT : E-COMMERCE SALES ANALYSIS
   Total Questions : 40
     - 10 Easy
     - 10 Medium
     - 10 Intermediate to Difficult
     - 10 Scenario-Based
   ----------------------------------------------------------------------
   TABLES
   1. customers     (customer_id, customer_name, gender, age, city,
                     state, registration_date)
   2. products      (product_id, product_name, category, brand, price)
   3. orders        (order_id, customer_id, order_date, payment_method,
                     order_status)
   4. order_details (order_detail_id, order_id, product_id, quantity,
                     unit_price, discount)

   DATA NOTES
   - order_date and registration_date are TEXT in DD-MM-YYYY format.
     Convert them to DATE before using date functions.
   - NULLs exist in: age, city, quantity, unit_price, discount.
   - discount is a PERCENTAGE (0 to 25).
   - order_status : Delivered, Shipped, Processing, Cancelled, Returned
   - payment_method : UPI, Credit Card, Debit Card, Net Banking,
                      Cash on Delivery, Wallet
   - Customer names repeat, so always use customer_id to identify a
     customer.
   - Revenue formula : quantity * unit_price * (1 - discount / 100)
   ====================================================================== */


/* ======================================================================
   SECTION A : EASY QUESTIONS (1 - 10)
   ====================================================================== */

-- Q1. Display all records from the customers table.


-- Q2. List the distinct product categories available in the products table.


-- Q3. Find the total number of customers, orders and products.


-- Q4. List all customers who live in Pune.


-- Q5. Show all products with a price greater than 50,000, sorted by price
--     from high to low.


-- Q6. Count the number of orders for each order_status.


-- Q7. Find the number of customers in each state.


-- Q8. Show the top 10 most expensive products with their brand and category.


-- Q9. List all orders that were paid using UPI.


-- Q10. Find all customers whose age or city is missing (NULL).



/* ======================================================================
   SECTION B : MEDIUM QUESTIONS (11 - 20)
   ====================================================================== */

-- Q11. Calculate the total number of orders for each payment method,
--      sorted from highest to lowest.


-- Q12. Find the average product price in each category.


-- Q13. Display each order with the customer name and city
--      (join orders and customers).


-- Q14. Show each order detail with the product name, category and quantity
--      (join order_details and products).


-- Q15. Find the total quantity sold for each product category.


-- Q16. Calculate the total revenue per order, using
--      quantity * unit_price less the discount percentage.


-- Q17. Find the number of orders placed in each year (2024 vs 2025).


-- Q18. List the customers who have never placed any order.


-- Q19. Find the brands that have more than 3 products.


-- Q20. Find the average customer age by gender.



/* ======================================================================
   SECTION C : INTERMEDIATE TO DIFFICULT QUESTIONS (21 - 30)
   ====================================================================== */

-- Q21. Find the top 10 customers by total spending.


-- Q22. Find the top 5 best-selling products by quantity, with their category.


-- Q23. Calculate monthly revenue for 2024 and 2025
--      (convert the text dates to DATE first).


-- Q24. Find the total revenue by product category, excluding Cancelled
--      and Returned orders.


-- Q25. Rank products by revenue within each category using RANK() or
--      DENSE_RANK().


-- Q26. Find customers who placed more than 5 orders and spent above the
--      overall average spend per customer.


-- Q27. Calculate each state's share of total revenue as a percentage.


-- Q28. Find the return rate (% of orders Returned) for each product category.


-- Q29. Calculate the month-over-month revenue growth using LAG().


-- Q30. Find the products that were never sold, and the products priced
--      differently in order_details than in the products table.



/* ======================================================================
   SECTION D : SCENARIO-BASED QUESTIONS (31 - 40)
   ====================================================================== */

-- Q31. DATA CLEANING
--      The business wants a clean sales report. Replace NULL quantity with 1,
--      NULL discount with 0, and NULL unit_price with the product's catalog
--      price. Show the cleaned revenue total.


-- Q32. LOYALTY PROGRAMME
--      Identify the "VIP" customers who placed 8 or more Delivered orders.
--      Also tag each customer as Gold, Silver or Bronze based on total spend.


-- Q33. CHURN ANALYSIS
--      Find the customers who ordered in 2024 but did not order at all
--      in 2025.


-- Q34. MARKETING CAMPAIGN
--      The team wants to target Maharashtra customers aged 25 to 40 who
--      bought Electronics. List them with their total Electronics spend.


-- Q35. CANCELLATION PROBLEM
--      Management suspects some payment methods have high cancellation
--      rates. Find the cancellation percentage per payment method and flag
--      any above the overall average.


-- Q36. DISCOUNT STRATEGY
--      Analyse whether higher discounts lead to more quantity. Show average
--      quantity and total revenue for each discount slab
--      (0, 5, 10, 15, 20, 25).


-- Q37. CROSS-SELL
--      Find which pairs of product categories are most often bought together
--      in the same order.


-- Q38. CUSTOMER LIFETIME VALUE
--      For each customer, calculate registration date, first order date,
--      last order date, number of orders and total spend. Show how many
--      days passed between registration and first order.


-- Q39. INVENTORY PLANNING
--      For each category, find the top-selling brand and the lowest-selling
--      brand by quantity, and suggest which brand to promote.


-- Q40. EXECUTIVE DASHBOARD
--      Build a single summary query showing total revenue, total orders,
--      average order value, delivery success %, cancellation %, return %
--      and the best city by revenue.


/* ======================================================================
   END OF PROJECT FILE
   ====================================================================== */