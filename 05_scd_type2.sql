-- Databricks notebook source

DROP TABLE IF EXISTS retail_dwh.gold.DimCustomer_SCD2;

CREATE TABLE retail_dwh.gold.DimCustomer_SCD2
USING DELTA
AS

SELECT

    monotonically_increasing_id() AS CustomerSK,

    CustomerID,

    CustomerName,

    Email,

    City,

    Address,

    current_date() AS StartDate,

    DATE('9999-12-31') AS EndDate,

    1 AS IsActive

FROM retail_dwh.silver.customers_clean;

-- COMMAND ----------


SELECT *
FROM retail_dwh.gold.DimCustomer_SCD2
LIMIT 10;

-- COMMAND ----------


SELECT *
FROM retail_dwh.gold.DimCustomer_SCD2
WHERE IsActive = 1;

-- COMMAND ----------


SELECT *
FROM retail_dwh.gold.DimCustomer_SCD2
WHERE EndDate != '9999-12-31';

-- COMMAND ----------


SELECT CustomerSK
FROM retail_dwh.gold.DimCustomer_SCD2;

-- COMMAND ----------


SELECT CustomerID, COUNT(*)
FROM retail_dwh.gold.DimCustomer_SCD2
WHERE IsActive = 1
GROUP BY CustomerID
HAVING COUNT(*) > 1;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.gold.DimCustomer_SCD2;

CREATE TABLE retail_dwh.gold.DimCustomer_SCD2
USING DELTA
AS

SELECT DISTINCT

    monotonically_increasing_id() AS CustomerSK,

    CustomerID,

    CustomerName,

    Email,

    City,

    Address,

    current_date() AS StartDate,

    DATE('9999-12-31') AS EndDate,

    1 AS IsActive

FROM retail_dwh.silver.customers_clean;

-- COMMAND ----------

SELECT CustomerID, COUNT(*)
FROM retail_dwh.gold.DimCustomer_SCD2
WHERE IsActive = 1
GROUP BY CustomerID
HAVING COUNT(*) > 1;

-- COMMAND ----------


SELECT CustomerID, COUNT(*)
FROM retail_dwh.silver.customers_clean
GROUP BY CustomerID
HAVING COUNT(*) > 1;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.silver.customers_clean;

CREATE TABLE retail_dwh.silver.customers_clean AS

SELECT *

FROM (

    SELECT
        CAST(CustomerID AS INT)      AS CustomerID,
        TRIM(CustomerName)           AS CustomerName,
        TRIM(Email)                  AS Email,
        TRIM(City)                   AS City,
        TRIM(Address)                AS Address,
        CAST(LastUpdated AS DATE)    AS LastUpdated,

        ROW_NUMBER() OVER (
            PARTITION BY CustomerID
            ORDER BY LastUpdated DESC
        ) AS rn

    FROM retail_dwh.bronze.customers_raw

    WHERE CustomerID IS NOT NULL

)

tmp

WHERE rn = 1;

-- COMMAND ----------


SELECT CustomerID, COUNT(*)

FROM retail_dwh.silver.customers_clean

GROUP BY CustomerID

HAVING COUNT(*) > 1;

-- COMMAND ----------


CREATE SCHEMA IF NOT EXISTS retail_dwh.qa;

-- COMMAND ----------


SELECT COUNT(*) AS factsales_count
FROM retail_dwh.gold.FactSales;

-- COMMAND ----------


SELECT *
FROM retail_dwh.gold.FactSales
WHERE CustomerID IS NULL
   OR ProductID IS NULL
   OR StoreID IS NULL;

-- COMMAND ----------


SELECT TransactionID, COUNT(*)

FROM retail_dwh.gold.FactSales

GROUP BY TransactionID

HAVING COUNT(*) > 1;

-- COMMAND ----------


SELECT *

FROM retail_dwh.gold.FactSales

WHERE Amount <= 0;

-- COMMAND ----------

