-- Active: 1692991137235@@127.0.0.1@3306@project
CREATE DATABASE PROJECT;

use project;
select * from mobile;
-- Q1 --
select Phone_name, price from mobile;
-- Q2 -- List of top 5 phones with price and all feature
select * 
from mobile
order by price desc
limit 5;
-- Q3 -- List of cheapest 5 phones with price and all feature
 select * 
from mobile
order by price asc
limit 5;
-- Q4 -- List of top 5 Samsung phones with price and all feature
select *
from mobile
Where Brands = "Samsung"
order by price desc
limit 5;
-- Q5 -- List of top 5 androids phones with price and all feature
select *
from mobile
Where Operating_System_Type = "Android"
order by price desc
limit 5;
-- Q6 --
select *
from mobile
Where Operating_System_Type = "Android"
order by price asc
limit 5;
-- Q7 --
select *
from mobile
Where Operating_System_Type = "IOS"
order by price desc
limit 5;
-- Q8 --
select *
from mobile
Where Operating_System_Type = "IOS"
order by price asc
limit 5;
-- Q9 --
select *
from mobile
where 5G_Availability = "Yes"
order by price desc
limit 5;
-- Q10 --
select brands, sum(price) 
from mobile
group by brands;
