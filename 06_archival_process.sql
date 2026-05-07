-- Databricks notebook source

LIST 's3://retail-etl-project-ganesh/raw/';

-- COMMAND ----------


LIST 's3://retail-etl-project-ganesh/archive/sales';

-- COMMAND ----------

-- MAGIC %python
-- MAGIC # List files inside raw folder
-- MAGIC
-- MAGIC files = dbutils.fs.ls("s3://retail-etl-project-ganesh/raw/")
-- MAGIC
-- MAGIC for file in files:
-- MAGIC     print(file.name)

-- COMMAND ----------

-- MAGIC %python
-- MAGIC files = dbutils.fs.ls("s3://retail-etl-project-ganesh/raw/")
-- MAGIC
-- MAGIC latest_file = max(files, key=lambda x: x.name)
-- MAGIC
-- MAGIC print("Latest File:")
-- MAGIC print(latest_file.name)

-- COMMAND ----------

-- MAGIC %python
-- MAGIC raw_path = "s3://retail-etl-project-ganesh/raw/"
-- MAGIC archive_path = "s3://retail-etl-project-ganesh/archive/"
-- MAGIC
-- MAGIC files = dbutils.fs.ls(raw_path)
-- MAGIC
-- MAGIC latest_file = max(files, key=lambda x: x.name)
-- MAGIC
-- MAGIC for file in files:
-- MAGIC
-- MAGIC     if file.name != latest_file.name:
-- MAGIC
-- MAGIC         source = raw_path + file.name
-- MAGIC         destination = archive_path + file.name
-- MAGIC
-- MAGIC         dbutils.fs.mv(source, destination)
-- MAGIC
-- MAGIC         print(f"Archived: {file.name}")
-- MAGIC
-- MAGIC print(f"Latest Active File: {latest_file.name}")