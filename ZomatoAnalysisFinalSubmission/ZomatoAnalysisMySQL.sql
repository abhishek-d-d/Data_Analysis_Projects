## Creating New Database for Zomato
SET sql_safe_updates = 0;

CREATE DATABASE zomato_db;

use zomato_db;

show tables;


## importing tables using data Import Wizard

DESC Country;
DESC Currency;
DESC Calender;
DESC Main;

SELECT *
FROM country;
SELECT count(*)
FROM country;

SELECT *
FROM currency;
SELECT count(*)
FROM currency;


SELECT * 
FROM main; 
SELECT count(*) 
FROM main; 

SELECT * FROM Calender;

## imported tables using data Import Wizard


TRUNCATE TABLE main;


alter table main
rename column ï»¿RestaurantID to RestaurantID;

alter table main
drop column MyUnknownColumn;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/main_uncleaned.csv'
INTO TABLE main
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(RestaurantID,RestaurantName,CountryCode,City,Address,Locality,LocalityVerbose,Longitude,Latitude,Cuisines,Currency,Has_Table_booking,Has_Online_delivery,Is_delivering_now,Switch_to_order_menu,Price_range,Votes,Average_Cost_for_two,Rating,Datekey_Opening);




## Imported all the Data

## DEALING WITH CAlENDER TABLE

CREATE TABLE calender (DateKey VARCHAR(15));

TRUNCATE TABLE Calender;
DROP TABLE calender;

## adding value to DateKey column
select * from calender;
SELECT COUNT(*) FROM calender;



INSERT INTO calender(DateKey) 
SELECT DISTINCT(main.Datekey_Opening) FROM main;

## Main Has 9551 rows Which are reduced to 2890 rows only in Calender Table which saved a lot of storage



## DATE 
ALTER TABLE calender
ADD COLUMN date DATE;

## DAY
ALTER TABLE calender
ADD COLUMN Day INT;

UPDATE calender
SET day = CAST(SUBSTRING_INDEX(DateKey, '_', -1) AS UNSIGNED);

## Month
ALTER TABLE calender
ADD COLUMN Month INT;

UPDATE Calender
SET month = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(DateKey, '_', -2), '_', 1) AS UNSIGNED);

## Year
ALTER TABLE calender
ADD COLUMN Year INT;

UPDATE Calender
SET year = CAST(SUBSTRING_INDEX(DateKey, '_', 1) AS UNSIGNED);

UPDATE calender
SET date = date(CONCAT(Year,'-',Month,'-',Day));

SELECT * FROM calender;

ALTER TABLE calender
ADD column Monthfullname VARCHAR(10);

UPDATE calender
SET Monthfullname = MONTHNAME(date);

## Quarter(Q1,Q2,Q3,Q4)

ALTER TABLE Calender
ADD COLUMN Quarters VARCHAR(2);

UPDATE calender
SET Quarters = CONCAT('Q',QUARTER(date));

## YearMonth
SELECT * FROM calender;

ALTER TABLE calender
ADD COLUMN YearMonth VARCHAR(10);

UPDATE calender
SET YearMonth = CONCAT(YEAR(date),'-',DATE_FORMAT(date, '%b'));

## Weekdayno

ALTER TABLE calender
ADD COLUMN Weekdayno SMALLINT;

UPDATE calender
SET Weekdayno = WEEKDAY(date);

## Weekdayname

ALTER TABLE calender
ADD COLUMN Weekdayname VARCHAR(10);

UPDATE calender
SET Weekdayname = DAYNAME(date);


## FinancialMOnth ( April = FM1, May= FM2  …. March = FM12)

ALTER TABLE calender
ADD COLUMN FinancialMOnthNo SMALLINT;

UPDATE calender
SET FinancialMOnthNo = CASE 
WHEN Monthfullname = 'April' THEN 1
WHEN Monthfullname = 'May' THEN 2
WHEN Monthfullname = 'June' THEN 3
WHEN Monthfullname = 'July' THEN 4
WHEN Monthfullname = 'August' THEN 5
WHEN Monthfullname = 'September' THEN 6
WHEN Monthfullname = 'Octomber' THEN 7
WHEN Monthfullname = 'November' THEN 8
WHEN Monthfullname = 'December' THEN 9
WHEN Monthfullname = 'January' THEN 10
WHEN Monthfullname = 'February' THEN 11
ELSE 12
END;


ALTER TABLE calender
ADD COLUMN FinancialMOnth VARCHAR(4);


UPDATE calender
SET FinancialMonth = CASE 
WHEN Monthfullname = 'April' THEN CONCAT('FM',FinancialMOnthNo)
WHEN Monthfullname = 'May' THEN CONCAT('FM',FinancialMOnthNo)
WHEN Monthfullname = 'June' THEN CONCAT('FM',FinancialMOnthNo)
WHEN Monthfullname = 'July' THEN CONCAT('FM',FinancialMOnthNo)
WHEN Monthfullname = 'August' THEN CONCAT('FM',FinancialMOnthNo)
WHEN Monthfullname = 'September' THEN CONCAT('FM',FinancialMOnthNo)
WHEN Monthfullname = 'Octomber' THEN CONCAT('FM',FinancialMOnthNo)
WHEN Monthfullname = 'November' THEN CONCAT('FM',FinancialMOnthNo)
WHEN Monthfullname = 'December' THEN CONCAT('FM',FinancialMOnthNo)
WHEN Monthfullname = 'January' THEN CONCAT('FM',FinancialMOnthNo)
WHEN Monthfullname = 'February' THEN CONCAT('FM',FinancialMOnthNo)
ELSE CONCAT('FM',FinancialMOnthNo)
END
;

## Financial Quarter ( Quarters based on Financial Month FQ-1 . FQ-2..)

ALTER TABLE calender
ADD COLUMN FinancialQuarter VARCHAR(5);

UPDATE calender
SET FinancialQuarter = CASE 
WHEN Monthfullname = 'April' THEN CONCAT('FQ-',ROUND(FinancialMOnthNo/3))
WHEN Monthfullname = 'May' THEN CONCAT('FQ-',ROUND(FinancialMOnthNo/3))
WHEN Monthfullname = 'June' THEN CONCAT('FQ-',ROUND(FinancialMOnthNo/3))
WHEN Monthfullname = 'July' THEN CONCAT('FQ-',ROUND(FinancialMOnthNo/3))
WHEN Monthfullname = 'August' THEN CONCAT('FQ-',ROUND(FinancialMOnthNo/3))
WHEN Monthfullname = 'September' THEN CONCAT('FQ-',ROUND(FinancialMOnthNo/3))
WHEN Monthfullname = 'Octomber' THEN CONCAT('FQ-',ROUND(FinancialMOnthNo/3))
WHEN Monthfullname = 'November' THEN CONCAT('FQ-',ROUND(FinancialMOnthNo/3))
WHEN Monthfullname = 'December' THEN CONCAT('FQ-',ROUND(FinancialMOnthNo/3))
WHEN Monthfullname = 'January' THEN CONCAT('FQ-',ROUND(FinancialMOnthNo/3))
WHEN Monthfullname = 'February' THEN CONCAT('FQ-',ROUND(FinancialMOnthNo/3))
ELSE CONCAT('FQ-',ROUND(FinancialMOnthNo/3))
END;

SELECT * FROM calender;

DROP TABLE Calender1;
CREATE TABLE Calender1 AS
SELECT * FROM calender
order by date;




## DATA MODELLING




## Starting with country table

## CountryID is a primary Key

alter table country
modify CountryID int primary key;


## Currency Table
## currency is the primary key

alter table Currency
modify currency varchar(50) primary key;

## Calender Table
## DateKey is Primary Key

alter table Calender
modify DateKey varchar(15) primary key;


## Main Table
DESC Main;

SELECT * FROM Main;

ALTER TABLE Main
Modify RestaurantID int Primary Key;

Alter TABLE Main
MODIFY COLUMN DateKey_Opening VARCHAR(15),
ADD FOREIGN KEY (DateKey_Opening) REFERENCES Calender (DateKey);

Alter TABLE Main
MODIFY COLUMN Currency VARCHAR(50),
ADD FOREIGN KEY (Currency) REFERENCES Currency (Currency);

Alter TABLE Main
ADD FOREIGN KEY (CountryCode) REFERENCES Country (CountryID);



## Answering The Questions from Questionair

## Question 3 
## Convert the Average cost for 2 column into USD dollars (currently the Average cost for 2 in local currencies

SELECT * FROM main;
SELECT * FROM currency;

SELECT (Average_Cost_for_two * c.`USD Rate`)
FROM Main AS m
LEFT JOIN Currency AS c
ON m.Currency = c.currency
WHERE m.currency = c.currency;

## Replacing values in column

ALTER TABLE main
ADD COLUMN Average_Cost_for_two_USD double;

-- UPDATE Main as m
-- JOIN main_temp as mt
-- ON m.RestaurantID = mt.RestaurantID
-- SET m.Average_Cost_for_two = mt.Average_Cost_for_two;

UPDATE Main AS m
LEFT JOIN Currency AS c ON m.Currency = c.currency
SET m.Average_Cost_for_two_USD = m.Average_Cost_for_two * c.`USD Rate`;


CREATE TABLE MAIN_Temp AS
SELECT * FROM zomato.main;


SELECT COUNT(*) FROM main_temp;
SELECT COUNT(*) FROM main;

SELECT * FROM main;
SELECT * FROM Country;

##  4.Find the Numbers of Resturants based on City and Country.

SELECT City, c.Countryname, COUNT(RestaurantID) AS Number_Of_Restaurants
FROM main AS m
Join Country AS c
ON m.CountryCode = c.CountryID
GROUP By  City, CountryCode
ORDER BY Number_Of_Restaurants DESC;


SELECT c.Countryname, COUNT(RestaurantID) AS Number_Of_Restaurants
FROM main AS m
Join Country AS c
ON m.CountryCode = c.CountryID
GROUP By  CountryCode
ORDER BY Number_Of_Restaurants DESC;

## Number of Resturants based on city

SELECT City, COUNT(RestaurantID) AS Number_Of_Resturants
FROM main
GROUP By City
ORDER BY Number_Of_Resturants DESC;

## Number of Resturants based on Country

SELECT c.Countryname, COUNT(RestaurantID) AS Number_Of_Restaurants
FROM main AS m
Join Country AS c
ON m.CountryCode = c.CountryID
GROUP By CountryCode
ORDER BY Number_Of_Restaurants DESC;


## 5.Numbers of Resturants opening based on Year , Quarter , Month
SELECT c.year, COUNT(m.RestaurantID) AS Number_Of_Restaurants
FROM main AS m
JOIN Calender AS c
On m.DateKey_Opening = c.DateKey
GROUP BY c.year
ORDER BY c.year, Number_Of_Restaurants DESC;

SELECT c.Year, c.Month, COUNT(m.RestaurantID) AS Number_Of_Restaurants
FROM main AS m
JOIN Calender AS c
On m.DateKey_Opening = c.DateKey
GROUP BY c.Year,c.month 
ORDER BY c.Year, c.Month, Number_Of_Restaurants DESC;

SELECT c.Year, c.Quarters, COUNT(m.RestaurantID) AS Number_Of_Restaurants
FROM main AS m
JOIN Calender AS c
On m.DateKey_Opening = c.DateKey
GROUP BY c.Year, c.Quarters
ORDER BY c.Year, c.Quarters, Number_Of_Restaurants DESC;


SELECT c.Year,c.Quarters, c.Month, COUNT(m.RestaurantID) AS Number_Of_Restaurants
FROM main AS m
JOIN Calender AS c
On m.DateKey_Opening = c.DateKey
GROUP BY c.Year,c.Quarters, c.month 
ORDER BY c.Year,c.Quarters, c.Month, Number_Of_Restaurants DESC;

## 6. Count of Resturants based on Average Ratings
SELECT Rating, COUNT(RestaurantID) AS Number_Of_Restaurants
FROM main
GROUP BY Rating
ORDER BY Number_Of_Restaurants DESC;


## Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets
SELECT MAX(Price_range) AS MaximumPrice, MIN(Price_range) AS MinimumPrice
FROM main;

SELECT 
Price_range
FROM main
GROUP BY price_range;

## Finding Maximum and Minimum Cost for 2 range
SELECT MAX(Average_Cost_for_two_USD) AS MaximumCost, MIN(Average_Cost_for_two_USD) AS MinimumCost
FROM main;

## Here Maximum Cost = 500 USD and Minimum Cost = 0 USD
## So creating Buckets of 100 USD

SELECT 
CASE
WHEN Average_Cost_for_two_USD BETWEEN 0 AND 100 THEN 100
WHEN Average_Cost_for_two_USD BETWEEN 100 AND 200 THEN 200
WHEN Average_Cost_for_two_USD BETWEEN 200 AND 300 THEN 300
WHEN Average_Cost_for_two_USD BETWEEN 300 AND 400 THEN 400
ELSE 500
END AS `Bucket(USD)`,COUNT(RestaurantID) AS Number_Of_Restaurants
FROM Main
GROUP BY `Bucket(USD)`;


## 8.Percentage of Resturants based on "Has_Table_booking"

SELECT 
CONCAT(ROUND(((SUM(CASE WHEN Has_Table_booking = "Yes" THEN 1 ELSE 0 END))/COUNT(Has_Table_booking)) * 100,2), ' %') AS 'Percentage OF Has_Table_booking',
CONCAT(ROUND(((SUM(CASE WHEN Has_Table_booking = "No" THEN 1 ELSE 0 END))/COUNT(Has_Table_booking)) * 100,2), ' %') AS 'Percentage not Having_Table_booking'
FROM main;

## Percentage of Resturants based on "Has_Online_delivery"

SELECT 
CONCAT(ROUND(((SUM(CASE WHEN Has_Online_delivery = "Yes" THEN 1 ELSE 0 END))/COUNT(Has_Online_delivery)) * 100,2), ' %') AS 'Percentage OF Has_Online_delivery',
CONCAT(ROUND(((SUM(CASE WHEN Has_Online_delivery = "No" THEN 1 ELSE 0 END))/COUNT(Has_Online_delivery)) * 100,2), ' %') AS 'Percentage Not Having_Online_delivery'
FROM main;





USE zomato_db;

## Number of Resturants based on City

CREATE OR REPLACE VIEW Restaurants_in_City AS
SELECT City, COUNT(RestaurantID) AS Number_Of_Resturants
FROM main
GROUP By City
ORDER BY Number_Of_Resturants DESC;

SELECT * FROM Restaurants_in_City;


## Number of Resturants based on Country

CREATE OR REPLACE VIEW Restaurants_in_Country AS
SELECT c.Countryname, COUNT(RestaurantID) AS Number_Of_Restaurants
FROM main AS m
Join Country AS c
ON m.CountryCode = c.CountryID
GROUP By CountryCode
ORDER BY Number_Of_Restaurants DESC;

SELECT * FROM Restaurants_in_City;


## 5.Numbers of Resturants opening based on Year , Quarter , Month
CREATE OR REPLACE VIEW Restaurants_By_Year AS
SELECT c.year, COUNT(m.RestaurantID) AS Number_Of_Restaurants
FROM main AS m
JOIN Calender AS c
On m.DateKey_Opening = c.DateKey
GROUP BY c.year
ORDER BY c.year, Number_Of_Restaurants DESC;

SELECT * FROM Restaurants_By_Year;

CREATE OR REPLACE VIEW Restaurants_By_Month AS
SELECT c.Year, c.Month, COUNT(m.RestaurantID) AS Number_Of_Restaurants
FROM main AS m
JOIN Calender AS c
On m.DateKey_Opening = c.DateKey
GROUP BY c.Year,c.month 
ORDER BY c.Year, c.Month, Number_Of_Restaurants DESC;

SELECT * FROM Restaurants_By_Month;

CREATE OR REPLACE VIEW Restaurants_By_Quarter AS
SELECT c.Year, c.Quarters, COUNT(m.RestaurantID) AS Number_Of_Restaurants
FROM main AS m
JOIN Calender AS c
On m.DateKey_Opening = c.DateKey
GROUP BY c.Year, c.Quarters
ORDER BY c.Year, c.Quarters, Number_Of_Restaurants DESC;

SELECT * FROM Restaurants_By_Quarter;


## 6. Count of Resturants based on Average Ratings
CREATE OR REPLACE VIEW Restaurants_by_Avg_Rating AS
SELECT Rating, COUNT(RestaurantID) AS Number_Of_Restaurants
FROM main
GROUP BY Rating
ORDER BY Number_Of_Restaurants DESC;

SELECT * FROM Restaurants_by_Avg_Rating;

## Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets

CREATE OR REPLACE VIEW Average_Cost_Bucket AS
SELECT 
CASE
WHEN Average_Cost_for_two_USD BETWEEN 0 AND 100 THEN 100
WHEN Average_Cost_for_two_USD BETWEEN 100 AND 200 THEN 200
WHEN Average_Cost_for_two_USD BETWEEN 200 AND 300 THEN 300
WHEN Average_Cost_for_two_USD BETWEEN 300 AND 400 THEN 400
ELSE 500
END AS `Bucket(USD)`,COUNT(RestaurantID) AS Number_Of_Restaurants
FROM Main
GROUP BY `Bucket(USD)`;

SELECT * FROM Average_Cost_Bucket;


## 8.Percentage of Resturants based on "Has_Table_booking"

CREATE OR REPLACE VIEW Booking_Parcent AS
SELECT 
CONCAT(ROUND(((SUM(CASE WHEN Has_Table_booking = "Yes" THEN 1 ELSE 0 END))/COUNT(Has_Table_booking)) * 100,2), ' %') AS 'Percentage OF Has_Table_booking'
FROM main;

SELECT * FROM Booking_Parcent;

## 9 Percentage of Resturants based on "Has_Online_delivery"

CREATE OR REPLACE VIEW Online_Delivery_Percent AS
SELECT 
CONCAT(ROUND(((SUM(CASE WHEN Has_Online_delivery = "Yes" THEN 1 ELSE 0 END))/COUNT(Has_Online_delivery)) * 100,2), ' %') AS 'Percentage OF Has_Online_delivery'
FROM main;


SELECT * FROM Online_Delivery_Percent;









