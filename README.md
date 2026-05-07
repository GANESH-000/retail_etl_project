# 🚀 Retail ETL Pipeline using Databricks, Delta Lake & AWS S3

## 📋 Project Overview

This project is an end-to-end **Retail ETL (Extract, Transform, Load) Pipeline** built using **Databricks**, **Delta Lake**, and **AWS S3** following the **Medallion Architecture (Bronze → Silver → Gold)**.

The pipeline processes retail transaction data, performs data cleansing, incremental loading, SCD Type 2 implementation, and archival processing for analytics-ready reporting. 

---

# 🎯 Business Purpose

The pipeline processes and manages:

* 👤 Customer Information
* 🛒 Product Catalog
* 🏬 Store Details
* 💰 Sales Transactions

The project is designed to simulate a real-world enterprise retail data engineering workflow.

---

# 📁 Project Structure

```text
retail_etl_project/
│
├── 01_initial_setup
│      AWS S3 setup, catalog & schema creation
│
├── 02_bronze_layer
│      Load raw CSV files into Bronze layer
│
├── 03_silver_layer
│      Data cleaning & transformation
│
├── 04_gold_layer
│      Business-ready Gold layer tables
│
├── 05_scd_type2
│      Slowly Changing Dimension Type 2 implementation
│
├── 06_archival_process
│      Archive processed files
│
├── 07_incremental_load
│      Incremental data processing
│
└── README.md
```

---

# 🏗️ Architecture

```text
          Source CSV Files
                   │
                   ▼
        AWS S3 (sftp/raw folders)
                   │
                   ▼
            Bronze Layer
        (Raw Data Ingestion)
                   │
                   ▼
            Silver Layer
      (Data Cleaning & Validation)
                   │
                   ▼
             Gold Layer
      (Business Analytics Tables)
                   │
                   ▼
          Reporting & Insights
```

---

# 🪙 Data Layers

## 🥉 Bronze Layer

### Purpose

* Raw data ingestion from AWS S3
* Minimal transformations
* Store source data in Delta format

### Tables

* customers_raw
* products_raw
* stores_raw
* sales_transactions_raw

---

## 🥈 Silver Layer

### Purpose

* Data cleaning
* Standardization
* Deduplication
* Validation checks

### Transformations

* Null handling
* Duplicate removal
* Data type conversion
* Invalid record filtering

### Tables

* customers_clean
* products_clean
* stores_clean
* sales_transactions_clean

---

## 🥇 Gold Layer

### Purpose

* Business-ready analytical tables
* Reporting and dashboard support
* Historical tracking using SCD Type 2

### Tables

* DimCustomer_SCD2
* FactSales
* Aggregated reporting tables

---

# 🔄 ETL Process Flow

## 1️⃣ Initial Setup

* Configure AWS S3
* Create catalog & schemas
* Environment setup

---

## 2️⃣ Bronze Layer Load

* Load CSV files from S3
* Create Delta Bronze tables

---

## 3️⃣ Silver Layer Transformation

* Clean and standardize data
* Remove invalid records
* Apply validations

---

## 4️⃣ Gold Layer Load

* Create business-ready tables
* Build analytics layer

---

## 5️⃣ SCD Type 2 Processing

* Track historical changes
* Maintain active/inactive records
* Preserve history for dimension data

---

## 6️⃣ Archival Process

* Move processed files to archive folder
* Maintain storage hygiene

---

## 7️⃣ Incremental Load

* Process only new/changed records
* Improve pipeline efficiency

---

# 🗂️ AWS S3 Folder Structure

```text
s3://retail-etl-project-ganesh/

├── sftp/
├── raw/
├── processed/
└── archive/
```

---

# 📊 Datasets Used

* Customers Dataset
* Products Dataset
* Stores Dataset
* Sales Transactions Dataset

---

# ⚙️ Technologies Used

| Technology | Purpose                   |
| ---------- | ------------------------- |
| Databricks | Data Engineering Platform |
| AWS S3     | Cloud Storage             |
| Delta Lake | Lakehouse Architecture    |
| PySpark    | Data Processing           |
| SQL        | Data Transformation       |
| GitHub     | Version Control           |

---

# ✨ Key Features

✅ Medallion Architecture
✅ Delta Lake Integration
✅ Incremental Data Loading
✅ SCD Type 2 Implementation
✅ Data Validation Checks
✅ Archival Process
✅ Cloud Storage Integration
✅ End-to-End ETL Pipeline
✅ GitHub Version Control

---

# 🛠️ Key Concepts Implemented

* ETL Pipeline Design
* Delta Lake Architecture
* Incremental Processing
* Slowly Changing Dimensions (SCD2)
* Data Validation
* Data Archival
* Data Transformation
* Workflow Orchestration

---

# 🚀 Future Enhancements

* Databricks Workflow Automation
* Real-Time Streaming Pipeline
* Power BI / Tableau Dashboard
* CI/CD Integration
* Monitoring & Alerting

---

# 🎯 Success Criteria

✅ Pipeline runs successfully on Databricks
✅ Historical tracking implemented using SCD2
✅ Data validation checks completed
✅ Incremental loads processed correctly
✅ Business-ready analytical tables created
✅ Project fully version controlled using GitHub

---

# 👨‍💻 Author

## Ganesh Nayak

B.Tech – Computer Science Engineering
CMR College of Engineering & Technology

---

# ⭐ Project Highlights

* Industry-style ETL pipeline
* Cloud-native architecture
* Resume-ready Data Engineering project
* Modular notebook design
* End-to-end Delta Lake implementation

---
