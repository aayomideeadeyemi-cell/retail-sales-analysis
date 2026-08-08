SET GLOBAL local_infile = 1;

USE retail_sales;

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Customer_ID VARCHAR(20),
    Customer_Segment VARCHAR(30),
    Region VARCHAR(20),
    Product_Category VARCHAR(30),
    Product_Name VARCHAR(50),
    Quantity_Sold INT,
    Unit_Price DECIMAL(10,2),
    Discount_Pct INT,
    Sales DECIMAL(10,2),
    Cost DECIMAL(10,2),
    Profit DECIMAL(10,2),
    Payment_Method VARCHAR(30),
    Sales_Representative VARCHAR(30)
);

LOAD DATA LOCAL INFILE 'C:\\Users\\DELL\\Downloads\\retail_sales_clean.csv'
INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM sales;
SELECT * FROM sales LIMIT 10;
SELECT 
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    COUNT(*) AS Order_Count,
    ROUND(AVG(Discount_Pct), 2) AS Avg_Discount
FROM sales
GROUP BY Region
ORDER BY Total_Sales DESC;
SELECT 
    Product_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    COUNT(*) AS Order_Count,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin_Pct
FROM sales
GROUP BY Product_Category
ORDER BY Total_Sales DESC;
SELECT 
    Customer_Segment,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin_Pct
FROM sales
WHERE Customer_Segment != 'Unknown'
GROUP BY Customer_Segment
ORDER BY Total_Profit DESC;
SELECT 
    MONTH(Order_Date) AS Month_Num,
    MONTHNAME(Order_Date) AS Month_Name,
    SUM(Sales) AS Total_Sales,
    COUNT(*) AS Order_Count
FROM sales
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY Month_Num;
SELECT 
    Product_Name,
    Product_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales
GROUP BY Product_Name, Product_Category
ORDER BY Total_Profit DESC
LIMIT 5;
