CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;
CREATE TABLE superstore (
    Ship_Mode VARCHAR(50),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(100),
    State VARCHAR(100),
    Postal_Code INT,
    Region VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(4,2),
    Profit DECIMAL(10,2)
);
SELECT 
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM cleaned_samplesuperstore;
SELECT 
    Category,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM cleaned_samplesuperstore
GROUP BY Category
ORDER BY Total_Sales DESC;

SELECT
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM cleaned_samplesuperstore
GROUP BY `Sub-Category`
ORDER BY Total_Sales DESC
LIMIT 10;

SELECT
    `Sub-Category`,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM cleaned_samplesuperstore
GROUP BY `Sub-Category`
HAVING Total_Profit < 0
ORDER BY Total_Profit;

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM cleaned_samplesuperstore
GROUP BY Region
ORDER BY Total_Sales DESC;

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM cleaned_samplesuperstore
GROUP BY Category;

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(
        SUM(Sales) * 100 / SUM(SUM(Sales)) OVER (),
        2
    ) AS Sales_Contribution_Percentage
FROM cleaned_samplesuperstore
GROUP BY Region
ORDER BY Total_Sales DESC;

SELECT *
FROM (
    SELECT
        Category,
        `Sub-Category`,
        ROUND(SUM(Sales),2) AS Total_Sales,
        DENSE_RANK() OVER (
            PARTITION BY Category
            ORDER BY SUM(Sales) DESC
        ) AS Category_Rank
    FROM cleaned_samplesuperstore
    GROUP BY Category, `Sub-Category`
) ranked
WHERE Category_Rank <= 3;

SELECT
    Discount,
    ROUND(AVG(Profit),2) AS Avg_Profit,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM cleaned_samplesuperstore
GROUP BY Discount
ORDER BY Discount;

SELECT
    `Ship Mode`,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM cleaned_samplesuperstore
GROUP BY `Ship Mode`
ORDER BY Total_Profit DESC;


