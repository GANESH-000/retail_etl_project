-- Databricks notebook source
CREATE CATALOG IF NOT EXISTS retail_dwh;

-- COMMAND ----------

CREATE CATALOG IF NOT EXISTS retail_dwh;

-- COMMAND ----------

CREATE SCHEMA IF NOT EXISTS retail_dwh.silver;

-- COMMAND ----------

CREATE SCHEMA IF NOT EXISTS retail_dwh.gold;

-- COMMAND ----------

CREATE SCHEMA IF NOT EXISTS retail_dwh.qa;

-- COMMAND ----------

SHOW SCHEMAS IN retail_dwh;

-- COMMAND ----------

