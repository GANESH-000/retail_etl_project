-- Databricks notebook source

DROP TABLE IF EXISTS retail_dwh.silver.customers_clean;

CREATE TABLE retail_dwh.silver.customers_clean
USING DELTA
AS
SELECT DISTINCT

    CAST(CustomerID AS INT) AS CustomerID,

    INITCAP(TRIM(CustomerName)) AS CustomerName,

    LOWER(TRIM(Email)) AS Email,

    TRIM(City) AS City,

    TRIM(Address) AS Address,

    TO_DATE(LastUpdated) AS LastUpdated

FROM retail_dwh.bronze.customers_raw

WHERE CustomerID IS NOT NULL;

-- COMMAND ----------


SELECT *
FROM retail_dwh.silver.customers_clean;

-- COMMAND ----------


-- Duplicate Customer Validation
SELECT CustomerID, COUNT(*)
FROM retail_dwh.silver.customers_clean
GROUP BY CustomerID
HAVING COUNT(*) > 1;

-- COMMAND ----------


-- Email Lowercase Validation
SELECT *
FROM retail_dwh.silver.customers_clean
WHERE Email != LOWER(Email);

-- COMMAND ----------


-- Null CustomerID Validation
SELECT *
FROM retail_dwh.silver.customers_clean
WHERE CustomerID IS NULL;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.silver.products_clean;

CREATE TABLE retail_dwh.silver.products_clean
USING DELTA
AS
SELECT DISTINCT

    CAST(ProductID AS INT) AS ProductID,

    TRIM(ProductName) AS ProductName,

    TRIM(Category) AS Category,

    CAST(UnitPrice AS DECIMAL(10,2)) AS UnitPrice

FROM retail_dwh.bronze.products_raw

WHERE ProductID IS NOT NULL;

-- COMMAND ----------


SELECT *
FROM retail_dwh.silver.products_clean;

-- COMMAND ----------


-- Duplicate Product Validation
SELECT ProductID, COUNT(*)
FROM retail_dwh.silver.products_clean
GROUP BY ProductID
HAVING COUNT(*) > 1;

-- COMMAND ----------


-- Invalid UnitPrice Validation
SELECT *
FROM retail_dwh.silver.products_clean
WHERE UnitPrice <= 0;

-- COMMAND ----------


-- Null ProductID Validation
SELECT *
FROM retail_dwh.silver.products_clean
WHERE ProductID IS NULL;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.silver.stores_clean;

CREATE TABLE retail_dwh.silver.stores_clean
USING DELTA
AS
SELECT DISTINCT

    CAST(StoreID AS INT) AS StoreID,

    INITCAP(TRIM(StoreName)) AS StoreName,

    TRIM(Region) AS Region

FROM retail_dwh.bronze.stores_raw

WHERE StoreID IS NOT NULL;

-- COMMAND ----------


SELECT *
FROM retail_dwh.silver.stores_clean;

-- COMMAND ----------


-- Duplicate Store Validation
SELECT StoreID, COUNT(*)
FROM retail_dwh.silver.stores_clean
GROUP BY StoreID
HAVING COUNT(*) > 1;

-- COMMAND ----------


-- Null StoreID Validation
SELECT *
FROM retail_dwh.silver.stores_clean
WHERE StoreID IS NULL;

-- COMMAND ----------


-- Null Region Validation
SELECT *
FROM retail_dwh.silver.stores_clean
WHERE Region IS NULL;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.silver.stores_clean;

CREATE TABLE retail_dwh.silver.stores_clean
USING DELTA
AS
SELECT DISTINCT

    CAST(StoreID AS INT) AS StoreID,

    INITCAP(TRIM(StoreName)) AS StoreName,

    COALESCE(TRIM(Region), 'Unknown') AS Region

FROM retail_dwh.bronze.stores_raw

WHERE StoreID IS NOT NULL;

-- COMMAND ----------


SELECT *
FROM retail_dwh.silver.stores_clean
WHERE Region IS NULL;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.silver.sales_clean;

CREATE TABLE retail_dwh.silver.sales_clean
USING DELTA
AS
SELECT DISTINCT

    CAST(TransactionID AS INT) AS TransactionID,

    CAST(CustomerID AS INT) AS CustomerID,

    CAST(ProductID AS INT) AS ProductID,

    CAST(StoreID AS INT) AS StoreID,

    CAST(Quantity AS INT) AS Quantity,

    TO_DATE(TxnDate) AS TxnDate

FROM retail_dwh.bronze.sales_transactions_raw

WHERE TransactionID IS NOT NULL
AND Quantity > 0;

-- COMMAND ----------


SELECT *
FROM retail_dwh.silver.sales_clean;

-- COMMAND ----------


SELECT *
FROM retail_dwh.silver.sales_clean
WHERE TransactionID IS NULL
   OR CustomerID IS NULL
   OR ProductID IS NULL
   OR StoreID IS NULL;

-- COMMAND ----------


SELECT *
FROM retail_dwh.silver.sales_clean
WHERE Quantity <= 0;

-- COMMAND ----------


SELECT TransactionID, COUNT(*)
FROM retail_dwh.silver.sales_clean
GROUP BY TransactionID
HAVING COUNT(*) > 1;

-- COMMAND ----------


SELECT COUNT(*) AS sales_count
FROM retail_dwh.silver.sales_clean;

-- COMMAND ----------


DESCRIBE retail_dwh.silver.sales_clean;