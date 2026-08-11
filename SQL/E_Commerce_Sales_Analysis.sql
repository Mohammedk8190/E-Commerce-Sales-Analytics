-- =====================================================
-- E-COMMERCE SALES ANALYTICS
-- SQL ANALYSIS
-- =====================================================

-- Database/Table
-- Table: ecommerce_analytics


-- =====================================================
-- 1. BASIC DATA EXPLORATION
-- =====================================================

-- 1. Display all records
SELECT *
FROM ecommerce_analytics;


-- 2. Total records
SELECT COUNT(*) AS Total_Records
FROM ecommerce_analytics;


-- 3. Unique customers
SELECT COUNT(DISTINCT [Customer ID]) AS Unique_Customers
FROM ecommerce_analytics;


-- =====================================================
-- 2. KPI ANALYSIS
-- =====================================================

-- 4. Total Revenue
SELECT SUM(Revenue) AS Total_Revenue
FROM ecommerce_analytics;


-- 5. Total Orders
SELECT COUNT(*) AS Total_Orders
FROM ecommerce_analytics;


-- 6. Return Rate
SELECT
    CAST(
        SUM(CASE
            WHEN [Returned Flag] = 1 THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Return_Rate
FROM ecommerce_analytics;


-- =====================================================
-- 3. CATEGORY ANALYSIS
-- =====================================================

-- 7. Revenue by Category
SELECT
    Category,
    SUM(Revenue) AS Total_Revenue
FROM ecommerce_analytics
GROUP BY Category
ORDER BY Total_Revenue DESC;


-- =====================================================
-- 4. REGION ANALYSIS
-- =====================================================

-- 8. Revenue by Region
SELECT
    Region,
    SUM(Revenue) AS Total_Revenue
FROM ecommerce_analytics
GROUP BY Region
ORDER BY Total_Revenue DESC;


-- =====================================================
-- 5. PRODUCT ANALYSIS
-- =====================================================

-- 9. Top 10 Products by Revenue
SELECT TOP 10
    [Product Name],
    SUM(Revenue) AS Total_Revenue
FROM ecommerce_analytics
GROUP BY [Product Name]
ORDER BY Total_Revenue DESC;


-- =====================================================
-- 6. SHIPPING ANALYSIS
-- =====================================================

-- 10. Orders by Shipping Status
SELECT
    [Shipping Status],
    COUNT(*) AS Total_Orders
FROM ecommerce_analytics
GROUP BY [Shipping Status]
ORDER BY Total_Orders DESC;


-- =====================================================
-- 7. TIME ANALYSIS
-- =====================================================

-- 11. Monthly Revenue
SELECT
    YEAR([Order Date]) AS Order_Year,
    MONTH([Order Date]) AS Order_Month,
    SUM(Revenue) AS Monthly_Revenue
FROM ecommerce_analytics
GROUP BY
    YEAR([Order Date]),
    MONTH([Order Date])
ORDER BY
    Order_Year,
    Order_Month;


-- =====================================================
-- 8. ADVANCED ANALYSIS
-- =====================================================

-- 12. Revenue Ranking by Product
SELECT
    [Product Name],
    SUM(Revenue) AS Total_Revenue,
    RANK() OVER (
        ORDER BY SUM(Revenue) DESC
    ) AS Revenue_Rank
FROM ecommerce_analytics
GROUP BY [Product Name];


-- 13. Revenue Contribution by Category
SELECT
    Category,
    SUM(Revenue) AS Total_Revenue,
    CAST(
        SUM(Revenue) * 100.0 /
        SUM(SUM(Revenue)) OVER()
        AS DECIMAL(10,2)
    ) AS Revenue_Percentage
FROM ecommerce_analytics
GROUP BY Category
ORDER BY Total_Revenue DESC;
