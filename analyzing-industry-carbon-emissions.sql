-- ================================================
-- Analyzing Industry Carbon Emissions
-- Explores carbon footprint data across companies,
-- industries and countries using SQL aggregations
-- ================================================

CREATE TABLE product_emissions (
    id INT,
    company VARCHAR,
    country VARCHAR,
	industry_group VARCHAR,
	year INT,
	product_name VARCHAR,
	carbon_footprint_pcf FLOAT  --carbon_footprint_pcf = carbon footprint in CO2 equivalent tonnes
);

--insert values in product_emissions

INSERT INTO product_emissions (id, company, country, industry_group, year, product_name, carbon_footprint_pcf) VALUES
(1, 'Toyota', 'Japan', 'Automobiles', 2020, 'Corolla', 4500.00),
(2, 'Toyota', 'Japan', 'Automobiles', 2021, 'Camry', 5100.00),
(3, 'Toyota', 'Japan', 'Automobiles', 2022, 'RAV4', 6200.00),
(4, 'Ford', 'USA', 'Automobiles', 2020, 'F-150', 7800.00),
(5, 'Ford', 'USA', 'Automobiles', 2021, 'Mustang', 6100.00),
(6, 'Ford', 'USA', 'Automobiles', 2022, 'Explorer', 6800.00),
(7, 'Samsung', 'South Korea', 'Technology', 2020, 'Galaxy S20', 85.00),
(8, 'Samsung', 'South Korea', 'Technology', 2021, 'Galaxy S21', 79.00),
(9, 'Samsung', 'South Korea', 'Technology', 2022, 'Galaxy S22', 72.00),
(10, 'Apple', 'USA', 'Technology', 2020, 'iPhone 12', 70.00),
(11, 'Apple', 'USA', 'Technology', 2021, 'iPhone 13', 64.00),
(12, 'Apple', 'USA', 'Technology', 2022, 'MacBook Pro', 147.00),
(13, 'BASF', 'Germany', 'Chemicals', 2020, 'Nylon 6', 9200.00),
(14, 'BASF', 'Germany', 'Chemicals', 2021, 'Polyurethane', 8700.00),
(15, 'BASF', 'Germany', 'Chemicals', 2022, 'Styrene', 7800.00),
(16, 'Dow', 'USA', 'Chemicals', 2020, 'Polyethylene', 8100.00),
(17, 'Dow', 'USA', 'Chemicals', 2021, 'Ethylene', 7600.00),
(18, 'Nestle', 'Switzerland', 'Food & Beverage', 2020, 'Kit Kat', 3.20),
(19, 'Nestle', 'Switzerland', 'Food & Beverage', 2021, 'Nespresso Pod', 0.84),
(20, 'Nestle', 'Switzerland', 'Food & Beverage', 2022, 'Milo', 2.10),
(21, 'Unilever', 'UK', 'Food & Beverage', 2020, 'Dove Soap', 0.96),
(22, 'Unilever', 'UK', 'Food & Beverage', 2021, 'Lipton Tea', 0.43),
(23, 'Nike', 'USA', 'Apparel', 2020, 'Air Max', 13.60),
(24, 'Nike', 'USA', 'Apparel', 2021, 'Air Force 1', 11.10),
(25, 'Adidas', 'Germany', 'Apparel', 2022, 'Ultraboost', 12.40);

-- To check if data loaded correctly

SELECT COUNT(*) FROM product_emissions; -- should return 25
SELECT * FROM product_emissions LIMIT 5;
-----------------------------------------------------------------

-- Find the number of unique companies in the dataset
SELECT COUNT(DISTINCT company) AS num_companies
FROM product_emissions;

-----------------------------------------------------------------

-- Find the total carbon footprint per industry group,
-- rounded to 2 decimal places, highest to lowest
SELECT industry_group,
       ROUND(SUM(carbon_footprint_pcf)::numeric, 2) AS total_carbon_footprint
FROM product_emissions
GROUP BY industry_group
ORDER BY total_carbon_footprint DESC;

-----------------------------------------------------------------

-- Find which industry group has the most products
SELECT industry_group,
       COUNT(DISTINCT product_name) AS num_products
FROM product_emissions
GROUP BY industry_group
ORDER BY num_products DESC
LIMIT 1;

--------------------------------------------------------------------

-- Find the average carbon footprint per country,
-- rounded to 2 decimal places, highest to lowest
SELECT country,
       ROUND(AVG(carbon_footprint_pcf)::numeric, 2) AS avg_carbon_footprint
FROM product_emissions
GROUP BY country
ORDER BY avg_carbon_footprint DESC;

-------------------------------------------------------------------------

-- Find which year had the highest total carbon emissions
SELECT year,
       ROUND(SUM(carbon_footprint_pcf)::numeric, 2) AS total_carbon_footprint
FROM product_emissions
GROUP BY year
ORDER BY total_carbon_footprint DESC
LIMIT 1;

-------------------------------------------------------------------------

-- Find industries where average carbon footprint 
-- is above the overall average
SELECT industry_group,
       ROUND(AVG(carbon_footprint_pcf)::numeric, 2) AS avg_carbon_footprint
FROM product_emissions
GROUP BY industry_group
HAVING AVG(carbon_footprint_pcf) > (
       SELECT AVG(carbon_footprint_pcf)
       FROM product_emissions
)
ORDER BY avg_carbon_footprint DESC;
