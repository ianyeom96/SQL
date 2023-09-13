-- Active: 1692991137235@@127.0.0.1@3306@pizza
use pizza;
SELECT * FROM pizza_sales;

-- KPI's --
-- total revenue --
SELECT SUM(total_price) AS Total_Revenue from pizza_sales;
-- averager order value --
-- DISTINCT keyword ensures that each unique 'order_id' is counted only once. --
SELECT SUM(total_price) / COUNT(DISTINCT order_id) 
AS Avg_Order_Value 
from pizza_sales;
-- total pizza sold --
SELECT SUM(quantity) as Total_pizza_sold FROM pizza_sales;
-- total # of order
SELECT COUNT(DISTINCT order_id) AS Total_Order_Id FROM pizza_sales;
-- avg pizzas per order --
SELECT SUM(quantity) / COUNT(DISTINCT order_id) 
AS Avg_Pizzas_Per_order from pizza_sales;

-- charts requirements --
-- change the data format from string(d-m-y) to date format(y-m-d)
UPDATE pizza_sales
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');
SELECT order_date FROM pizza_sales;
-- now, 01-01-2015 -> 2015-01-01

-- daily trend for total orders, %W=weekday --
-- DATE_FORMAT = extract the day of the week from the 'order_date' column --
SELECT DATE_FORMAT(order_date, "%W") AS order_day, 
COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATE_FORMAT(order_date, "%W"); 

-- monthly trend for total orders, %M=Month --
SELECT DATE_FORMAT(order_date, "%M") AS order_month, 
COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATE_FORMAT(order_date, "%M"); 

--  the percentage of the total sales for each pizza category --
SELECT pizza_category, SUM(total_price) as total_sales, SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS Ratio
from pizza_sales 
GROUP BY pizza_category;
-- only January --
SELECT pizza_category, SUM(total_price) as total_sales, SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date) = 1) AS Ratio
from pizza_sales 
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

--  the percentage of the total sales for each pizza size --
SELECT pizza_size, CAST (SUM(total_price) as DECIMAL(10,2)) as total_sales, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) as DECIMAL (10,2)) AS Ratio
from pizza_sales 
GROUP BY pizza_size
ORDER BY Ratio DESC;

-- top 5 best sellers --
SELECT pizza_name, SUM(total_price) as Revenue, SUM(quantity) as Total_Quantity, COUNT(DISTINCT order_id) as Total_Order
FROM pizza_sales 
GROUP BY pizza_name
order by Revenue asc
LIMIT 5;
