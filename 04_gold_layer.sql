-- Databricks notebook source

CREATE SCHEMA IF NOT EXISTS retail_dwh.gold;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.gold.DimCustomer;

CREATE TABLE retail_dwh.gold.DimCustomer AS

SELECT DISTINCT
    CustomerID,
    CustomerName,
    City,
    Email,
    Address
FROM retail_dwh.silver.customers_clean;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.silver.stores_clean;

CREATE TABLE retail_dwh.silver.stores_clean AS

SELECT DISTINCT
    CAST(StoreID AS INT)      AS StoreID,
    TRIM(StoreName)           AS StoreName,
    TRIM(Region)              AS Region
FROM retail_dwh.bronze.stores_raw
WHERE StoreID IS NOT NULL;

-- COMMAND ----------


SELECT *
FROM retail_dwh.silver.stores_clean
LIMIT 10;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.gold.DimCustomer;

CREATE TABLE retail_dwh.gold.DimCustomer AS

SELECT DISTINCT
    CustomerID,
    CustomerName,
    Email,
    City,
    Address
FROM retail_dwh.silver.customers_clean;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.gold.DimCustomer;

CREATE TABLE retail_dwh.gold.DimCustomer AS

SELECT DISTINCT
    CustomerID,
    CustomerName,
    Email,
    City,
    Address
FROM retail_dwh.silver.customers_clean;

-- COMMAND ----------


SELECT *
FROM retail_dwh.gold.DimCustomer
LIMIT 10;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.gold.DimProduct;

CREATE TABLE retail_dwh.gold.DimProduct AS

SELECT DISTINCT
    ProductID,
    ProductName,
    Category,
    UnitPrice
FROM retail_dwh.silver.products_clean;

-- COMMAND ----------


SELECT *
FROM retail_dwh.gold.DimProduct
LIMIT 10;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.gold.DimStore;

CREATE TABLE retail_dwh.gold.DimStore AS

SELECT DISTINCT
    StoreID,
    StoreName,
    Region
FROM retail_dwh.silver.stores_clean;

-- COMMAND ----------


SELECT *
FROM retail_dwh.gold.DimStore
LIMIT 10;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.gold.FactSales;

CREATE TABLE retail_dwh.gold.FactSales AS

SELECT

    s.TransactionID,

    s.CustomerID,

    s.ProductID,

    s.StoreID,

    s.Quantity,

    (s.Quantity * p.UnitPrice) AS Amount,

    s.TxnDate

FROM retail_dwh.silver.sales_clean s

JOIN retail_dwh.gold.DimCustomer c
ON s.CustomerID = c.CustomerID

JOIN retail_dwh.gold.DimProduct p
ON s.ProductID = p.ProductID

JOIN retail_dwh.gold.DimStore st
ON s.StoreID = st.StoreID;

-- COMMAND ----------


SELECT *
FROM retail_dwh.gold.FactSales
LIMIT 10;

-- COMMAND ----------


SELECT COUNT(*) AS factsales_count
FROM retail_dwh.gold.FactSales;

-- COMMAND ----------


SELECT
    TransactionID,
    Quantity,
    Amount
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
WHERE TxnDate IS NULL;

-- COMMAND ----------

