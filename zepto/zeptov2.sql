
DROP TABLE IF EXISTS zeptov2;

CREATE TABLE zeptov3(
sku_id SERIAL PRIMARY KEY,
Category VARCHAR(120) ,	
name VARCHAR(150) NOT NULL ,
mrp NUMERIC(8,2),
discountPercent	NUMERIC(5,2),
availableQuantity INT,
discountedSellingPrice  NUMERIC(8,2)	,
weightInGms	INTEGER,
outOfStock	BOOLEAN,
quantity  INT


);

--\COPY zeptov3 FROM 'C:/Users/admin/Documents/MY SQL/zepto_v2.csv'
--WITH (FORMAT csv, HEADER true, ENCODING "WIN1252");


-- DATA EXPLORATION

-- COUNT OF ROWS
SELECT COUNT(*) FROM zeptov3

-- sample data
SELECT * FROM zeptov3
LIMIT(10)

-- NULL VALUES
SELECT * FROM zeptov3
WHERE name is NULL
OR 
category is NULL
OR 
mrp is NULL
OR 
discountPercent is NULL
OR 
availableQuantity is NULL
OR 
discountedSellingPrice is NULL
OR 
weightInGms is NULL
OR 
outOfStock is NULL
OR 
quantity is NULL

-- different product categories

SELECT DISTINCT category from zeptov3
ORDER BY category 

--- IN STOCK VS OUT STOCK

SELECT outofstock, count(sku_id)
FROM zeptov3
GROUP BY outofstock


-- product names present multiple times
SELECT name, count(sku_id)
FROM zeptov3
GROUP BY name 
HAVING COUNT(sku_id) > 1
ORDER BY count(sku_id) DESC


-- data cleaning

-- products with price zzero

SELECT * FROM zeptov3
WHERE mrp = 0 or discountedSellingPrice = 0

DELETE FROM zeptov3
where sku_id = 4053


--- Converting mrp dsp into rupees

UPDATE zeptov3
SET mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

SELECT * FROM zeptov3;

-- 
SELECT  DISTINCT name, mrp, discountPercent
FROM zeptov3
ORDER BY discountPercent DESC
LIMIT(10)

--

SELECT* FROM zeptov3
SELECT DISTINCT name, mrp, outofstock 
FROM zeptov3
WHERE outofstock = true and mrp > 300
ORDER BY mrp DESC
limit(10)

SELECT  Category,  sum(discountedSellingPrice * availableQuantity) AS TOTAL_REVENUE
FROM zeptov3

GROUP BY Category
ORDER BY TOTAL_REVENUE 


SELECT DISTINCT name, mrp, discountpercent
FROM zeptov3
WHERE mrp > 500 and discountpercent BETWEEN 1 AND 10
ORDER BY mrp DESC, discountpercent DESC

SELECT category, ROUND(AVG(discountpercent),2) as Avg_disc
FROM zeptov3

GROUP BY category
ORDER BY Avg_dISC ASC
LIMIT(5)

SELECT * FROM zeptov3
SELECT DISTINCT name, discountedsellingprice, weightingms, ROUND((discountedsellingprice/weightingms),2) as price_gram
FROM zeptov3
WHERE weightingms >=100
ORDER BY price_gram 

--

SELECT * FROM zeptov3

SELECT DISTINCT name, weightingms,
CASE WHEN weightingms <1000 THEN 'low'
		WHEN weightingms <5000 THEN 'MEDIUM'
		ELSE 'Bulk'
		END AS Order_type
FROM zeptov3
ORDER BY weightingms ASC

SELECT category, SUM(WEIGHTINGMS) AS TOTAL_weight, count(category) as Total_category
FROM zeptov3
GROUP BY category


SELECT count(DISTINCT category) as Total_category, SUM(weightingms) as Total_weight
FROM zeptov3

SELECT category,
SUM(weightingms * availableQuantity) as Total_weight
FROM zeptov3
GROUP BY category
ORDER BY Total_weight







