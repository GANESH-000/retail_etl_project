# 🚀 Retail ETL Pipeline using Databricks, Delta Lake & AWS S3

An end-to-end Retail Data Engineering project built using **Databricks**, **AWS S3**, **Delta Lake**, and **PySpark/SQL** implementing modern ETL architecture with Bronze, Silver, and Gold layers.

---

# 📌 Project Overview

This project simulates a real-world retail ETL pipeline where raw retail data is ingested from AWS S3, transformed through multiple layers, validated, archived, and prepared for analytics.

The project also includes:

✅ Incremental Data Loading  
✅ Slowly Changing Dimension (SCD Type 2)  
✅ Data Validation Checks  
✅ Archival Process  
Control

📂 Project Structure
🔹 01_initial_setup.ipynb
AWS S3 configuration
Catalog & schema creation
Environment setup
🔹 02_bronze_layer.ipynb
Raw CSV ingestion from S3
Bronze Delta table creation
Initial data loading
🔹 03_silver_layer.ipynb
Data cleaning
Null handling
Data standardization
Duplicate removal
🔹 04_gold_layer.ipynb
Business-ready analytical tables
Aggregated KPIs
Reporting layer
🔹 05_scd_type2.ipynb
SCD Type 2 implementation
Historical data tracking
Active/inactive record handling
🔹 06_archival_process.ipynb
Move processed files to archive
Maintain storage hygiene
File lifecycle management
🔹 07_incremental_load.ipynb
Incremental data ingestion
CDC-style processing
Efficient loading strategy
🗂️ AWS S3 Folder Structure
s3://retail-etl-project-ganesh/

├── sftp/
├── raw/
├── processed/
└── archive/
📊 Datasets Used
Customers Data
Products Data
Stores Data
Sales Transactions Data
✨ Key Features

✅ End-to-End ETL Pipeline
✅ Delta Lake Multi-Layer Architecture
✅ Incremental Processing
✅ SCD Type 2 Tracking
✅ Data Validation Framework
✅ Archival Mechanism
✅ Cloud Storage Integration
✅ Production-Style ETL Design
