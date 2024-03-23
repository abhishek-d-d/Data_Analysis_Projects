use sales;


## 1. Show all customer records

SELECT * FROM customers;


##	2.	Show total number of customers

SELECT count(*) 
FROM customers;


##	3.	Show transactions for Chennai market (market code for chennai is Mark001)
select * 
from transactions;

select * 
from markets;

select *
from transactions
where market_code = "Mark001";


##	4.	Show distrinct product codes that were sold in chennai

select distinct(product_code) as Unique_products
from transactions
where market_code = "Mark001";


##	5.	Show transactions where currency is US dollars

select distinct(currency)
from transactions;

select * 
from transactions
where currency = "USD";


##	6.	Show transactions in 2020 join by date table
select * 
from transactions
INNER JOIN date
ON transactions.order_date = date.date;

select * 
from transactions
INNER JOIN date
ON transactions.order_date = date.date
where year = 2020;




##	7.	total revenue in year 2020

select sum(sales_amount)
from transactions
inner join date
on transactions.order_date = date.date
where year = 2020;


##	Show total revenue in year 2020,  January Month

select sum(sales_amount)
from transactions
inner join date
on transactions.order_date = date.date
where month_name = "January";


##	Show total revenue in year 2020,  January & February Month

select sum(sales_amount)
from transactions
inner join date
on transactions.order_date = date.date
where month_name in ("January", "February");

##	Show total revenue in year 2020, in chennai

select sum(sales_amount)
from transactions
inner join date
on transactions.order_date = date.date
where year = 2020 and market_code = "Mark001";






