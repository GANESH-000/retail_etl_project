-- Databricks notebook source

CREATE OR REPLACE TABLE retail_dwh.bronze.customers_incremental_raw
USING DELTA
AS
SELECT *
FROM read_files(
  's3://retail-etl-project-ganesh/sftp/customers_src_21042026120000.csv',
  format => 'csv',
  header => true
);

-- COMMAND ----------


SELECT *
FROM retail_dwh.bronze.customers_incremental_raw;

-- COMMAND ----------


DROP TABLE IF EXISTS retail_dwh.silver.customers_incremental_clean;

CREATE TABLE retail_dwh.silver.customers_incremental_clean AS

SELECT DISTINCT

    CAST(CustomerID AS INT) AS CustomerID,

    INITCAP(TRIM(CustomerName)) AS CustomerName,

    LOWER(TRIM(Email)) AS Email,

    TRIM(City) AS City,

    TRIM(Address) AS Address,

    TO_DATE(LastUpdated) AS LastUpdated

FROM retail_dwh.bronze.customers_incremental_raw

WHERE CustomerID IS NOT NULL;

-- COMMAND ----------


SELECT *
FROM retail_dwh.silver.customers_incremental_clean;

-- COMMAND ----------


UPDATE retail_dwh.gold.DimCustomer_SCD2 tgt

SET
    tgt.IsActive = 0,
    tgt.EndDate = current_date()

WHERE tgt.CustomerID IN (

    SELECT src.CustomerID

    FROM retail_dwh.silver.customers_incremental_clean src

    WHERE tgt.CustomerID = src.CustomerID
    AND (
        tgt.City <> src.City
        OR tgt.Address <> src.Address
    )

)
AND tgt.IsActive = 1;

-- COMMAND ----------


SELECT *
FROM retail_dwh.gold.DimCustomer_SCD2
WHERE IsActive = 0;

-- COMMAND ----------


INSERT INTO retail_dwh.gold.DimCustomer_SCD2

SELECT

    monotonically_increasing_id() AS CustomerSK,

    src.CustomerID,

    src.CustomerName,

    src.Email,

    src.City,

    src.Address,

    current_date() AS StartDate,

    DATE('9999-12-31') AS EndDate,

    1 AS IsActive

FROM retail_dwh.silver.customers_incremental_clean src

JOIN retail_dwh.gold.DimCustomer_SCD2 tgt
ON src.CustomerID = tgt.CustomerID

WHERE
    tgt.IsActive = 0
    AND (
        tgt.City <> src.City
        OR tgt.Address <> src.Address
    );

-- COMMAND ----------


SELECT *
FROM retail_dwh.gold.DimCustomer_SCD2
WHERE CustomerID = 1
ORDER BY IsActive DESC;

-- COMMAND ----------


SELECT
    CustomerID,
    CustomerName,
    City,
    Address,
    StartDate,
    EndDate,
    IsActive
FROM retail_dwh.gold.DimCustomer_SCD2
WHERE CustomerID = 1
ORDER BY IsActive DESC;

-- COMMAND ----------

