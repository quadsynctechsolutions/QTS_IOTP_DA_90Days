CREATE TABLE inventory(
    itemID INT AUTO_INCREMENT PRIMARY KEY,
    itemName VARCHAR(50),
    department VARCHAR(50),
    unitPrice DECIMAL(10,2),
    stock INT,
    entryDate DATE,
    offer DECIMAL(5,2)
);

INSERT INTO inventory(itemName, department, unitPrice, stock, entryDate, offer) VALUES
('Air Conditioner', 'Appliances', 42000.00, 6, '2024-01-10', 12.00),
('Refrigerator', 'Appliances', 38000.50, 8, '2024-02-05', 10.00),
('Washing Machine', 'Appliances', 29000.00, 5, '2023-12-15', 15.00),
('Study Table', 'Furniture', 6500.00, 12, '2023-11-20', 18.00),
('Sofa Set', 'Furniture', 55000.00, 3, '2024-01-25', 20.00),
('Ceiling Fan', 'Electrical', 3200.75, 20, '2024-03-01', 8.00),
('LED Bulb', 'Electrical', 450.00, 100, '2024-03-12', 5.00),
('Mixer Grinder', 'Kitchen', 4800.00, 10, '2024-02-18', 10.00),
('Microwave Oven', 'Kitchen', 15000.00, 4, '2024-01-30', 7.50),
('Water Purifier', 'Appliances', 22000.00, 7, '2024-02-22', 9.00);

SELECT * FROM inventory;


-- =========================================================
-- Aggregation Functions
-- =========================================================

--SUM
SELECT SUM(stock) AS totalStock
FROM inventory;

--SUM with condition
SELECT SUM(stock) AS applianceStock
FROM inventory
WHERE department = 'Appliances';

SELECT SUM(stock) AS applianceStock
FROM inventory
WHERE department = 'Appliances'
AND unitPrice > 20000;

--COUNT
SELECT COUNT(*) AS totalItems
FROM inventory;

SELECT COUNT(*) AS totalFans
FROM inventory
WHERE itemName LIKE '%Fan%';

--AVG
SELECT AVG(unitPrice) AS avgUnitPrice
FROM inventory;

SELECT AVG(unitPrice) AS avgFurniturePrice
FROM inventory
WHERE department = 'Furniture'
OR entryDate > '2024-02-01';

--MAX & MIN
SELECT MAX(unitPrice) AS highestPrice,
       MIN(unitPrice) AS lowestPrice
FROM inventory;

--Second highest price
SELECT MAX(unitPrice) AS secondHighest
FROM inventory
WHERE unitPrice < (SELECT MAX(unitPrice) FROM inventory);


-- =========================================================
-- String functions
-- =========================================================

--UPPER & LOWER
SELECT UPPER(department) AS upperDepartment
FROM inventory;

SELECT LOWER(department) AS lowerDepartment
FROM inventory;

--CONCAT
SELECT CONCAT(itemName,' - ',department) AS itemDetails
FROM inventory;

--SUBSTRING
SELECT SUBSTRING(itemName,1,5) AS shortName
FROM inventory;

--LENGTH
SELECT itemName,
       LENGTH(itemName) AS nameLength
FROM inventory;

--TRIM
SELECT LENGTH('   Inventory   ') AS beforeTrim;

SELECT TRIM('   Inventory   ') AS afterTrim;

SELECT LENGTH(TRIM('   Inventory   ')) AS lengthAfterTrim;

--REPLACE
SELECT REPLACE(itemName,'Oven','Heater') AS replacedName
FROM inventory;

--LEFT & RIGHT
SELECT LEFT(itemName,4) AS leftPart
FROM inventory;

SELECT RIGHT(itemName,3) AS rightPart
FROM inventory;


-- =========================================================
-- DATE & TIME FUNCTIONS
-- =========================================================

--Current Date & Time
SELECT NOW() AS currentDateTime;

SELECT CURRENT_DATE() AS todayDate;

SELECT CURRENT_TIME() AS currentTime;

--Date Difference
SELECT DATEDIFF(CURRENT_DATE(), entryDate) AS daysSinceEntry
FROM inventory;


--TIMESTAMPDIFF 
SELECT itemName,
       TIMESTAMPDIFF(YEAR, entryDate, CURRENT_DATE()) AS ageInYears,
       TIMESTAMPDIFF(MONTH, entryDate, CURRENT_DATE()) AS ageInMonths,
       TIMESTAMPDIFF(DAY, entryDate, CURRENT_DATE()) AS ageInDays
FROM inventory;

--DATE_FORMAT
SELECT itemName,
       DATE_FORMAT(entryDate,'%d-%b-%Y') AS formattedDate
FROM inventory;

--DATE PART FUNCTIONS
SELECT itemName,
       entryDate,
       DAYOFWEEK(entryDate) AS dayOfWeek,
       YEAR(entryDate) AS year,
       MONTH(entryDate) AS month,
       WEEK(entryDate) AS week,
       DAY(entryDate) AS day
FROM inventory;

--INTERVAL
SELECT itemName,
       entryDate,
       entryDate + INTERVAL 3 MONTH AS extendedDate
FROM inventory;

--STR_TO_DATE
SELECT STR_TO_DATE('15-Feb-2025','%d-%b-%Y') AS stringToDate;