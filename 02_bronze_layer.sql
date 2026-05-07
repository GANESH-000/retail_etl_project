-- Databricks notebook source
USE CATALOG retail_dwh;

USE SCHEMA bronze;

-- COMMAND ----------

SELECT current_catalog(), current_schema();

-- COMMAND ----------


USE SCHEMA bronze;

-- Customers Bronze

CREATE OR REPLACE TABLE customers_raw
USING DELTA
AS
SELECT *
FROM read_files(
's3://retail-etl-project-ganesh/sftp/customers_src_*.csv',
format => 'csv',
header => true
);

-- Products Bronze

CREATE OR REPLACE TABLE products_raw
USING DELTA
AS
SELECT *
FROM read_files(
's3://retail-etl-project-ganesh/sftp/products_src_*.csv',
format => 'csv',
header => true
);

-- Stores Bronze

CREATE OR REPLACE TABLE stores_raw
USING DELTA
AS
SELECT *
FROM read_files(
's3://retail-etl-project-ganesh/sftp/stores_src_*.csv',
format => 'csv',
header => true
);

-- Sales Bronze

CREATE OR REPLACE TABLE sales_raw
USING DELTA
AS
SELECT *
FROM read_files(
's3://retail-etl-project-ganesh/sftp/sales_transactions_src_*.csv',
format => 'csv',
header => true
);

-- COMMAND ----------


CREATE CATALOG IF NOT EXISTS retail_dwh;

CREATE SCHEMA IF NOT EXISTS retail_dwh.bronze;

CREATE SCHEMA IF NOT EXISTS retail_dwh.silver;

CREATE SCHEMA IF NOT EXISTS retail_dwh.gold;

CREATE SCHEMA IF NOT EXISTS retail_dwh.qa;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.bronze.customers_raw;

CREATE TABLE retail_dwh.bronze.customers_raw
AS
SELECT *
FROM read_files(
's3://retail-etl-project-ganesh/sftp/customers_src_*.csv',
format => 'csv',
header => true
);

-- COMMAND ----------


SELECT *
FROM retail_dwh.bronze.customers_raw;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.bronze.products_raw;

CREATE TABLE retail_dwh.bronze.products_raw AS

SELECT *
FROM read_files(
's3://retail-etl-project-ganesh/sftp/products_src_*.csv',
format => 'csv',
header => true
);

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.bronze.products_raw;

CREATE TABLE retail_dwh.bronze.products_raw AS

SELECT *
FROM read_files(
's3://retail-etl-project-ganesh/sftp/products_src_*.csv',
format => 'csv',
header => true
);

-- COMMAND ----------


SELECT *
FROM retail_dwh.bronze.stores_raw;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.bronze.sales_transactions_raw;

CREATE TABLE retail_dwh.bronze.sales_transactions_raw AS

SELECT *
FROM read_files(
's3://retail-etl-project-ganesh/sftp/sales_transactions_src_*.csv',
format => 'csv',
header => true
);

-- COMMAND ----------


SELECT COUNT(*) AS customer_count
FROM retail_dwh.bronze.customers_raw;

SELECT COUNT(*) AS product_count
FROM retail_dwh.bronze.products_raw;

SELECT COUNT(*) AS store_count
FROM retail_dwh.bronze.stores_raw;

SELECT COUNT(*) AS sales_count
FROM retail_dwh.bronze.sales_transactions_raw;

-- COMMAND ----------


DESCRIBE retail_dwh.bronze.customers_raw;

-- COMMAND ----------


SELECT *
FROM retail_dwh.bronze.customers_raw
WHERE CustomerID IS NULL;

-- COMMAND ----------


LIST 's3://retail-etl-project-ganesh/sftp/';