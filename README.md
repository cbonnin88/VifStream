# 📺 VifStream: End-to-End Product Analytics Stack
> **Predicting and Preventing User Churn for a Digital Streaming Service.**



## 📌 Project Overview
VifStream is a subscription-based streaming platform. This project implements a Modern Data Stack (MDS) to solve a critical business problem: **High Day-7 user churn.** By centralizing behavioral data and building predictive dashboards, this stack allows the Product team to identify "At-Risk" users before they drop off.

This repository covers the full data lifecycle: **Ingestion → Transformation → BI → Data Product.**

---

## 🛠 The Technical Stack
| Layer | Tool | Purpose |
| :--- | :--- | :--- |
| **Data Warehouse** | **Google BigQuery** | Cost-optimized storage using External Tables (Google Sheets bridge). |
| **Transformation** | **dbt (Data Build Tool)** | Star-schema modeling and SQL business logic (`fct_user_retention`). |
| **Product Analytics** | **Amplitude** | Behavioral funnel analysis and retention cohorts. |
| **Business Intelligence** | **Looker Studio** | Executive KPIs (DAU/MAU, Subscription Conversion). |
| **Data App** | **Streamlit** | Operational "User Health 360" lookup tool for Customer Support. |
| **Processing** | **Python (Polars/Pandas)** | Efficient cleaning of 1M+ raw event logs. |

---

## 🏗 Data Architecture
1. **Extraction:** Simulated event logs are cleaned and pre-processed via Python.
2. **Loading:** Data is synced to BigQuery (bypassing billing constraints via Google Sheets external tables).
3. **Modeling:** dbt generates a production-ready fact table that calculates user "stickiness" and tenure.
4. **Visualization:** * **Executive View:** Looker Studio dashboard for high-level health monitoring.
    * **Operational View:** Streamlit app for real-time user-level behavioral audits.



---

## 📈 Key Product Insights
* **The "Aha! Moment":** Users who tune into **3+ distinct channels** within their first 24 hours have a **70% higher retention rate** at Day 30.
* **Platform Gap:** SmartTV users demonstrate 2.5x higher LTV than Web users, identifying a major opportunity for Web UI optimization.
* **Churn Indicators:** Low interaction frequency (specifically `< 5 events`) in the first 72 hours predicts churn with **85% accuracy**.

---

## 🚀 The Operational Tool (Streamlit)
I developed a custom Python application that empowers non-technical stakeholders to audit user behavior directly from the warehouse.
* **Search:** Instant lookup for any `user_id`.
* **Metrics:** Automated risk scoring (🟢 Healthy vs 🔴 At Risk).
* **Behavioral Timeline:** Interactive Plotly visualizations showing the user's journey.

---

## 📊 Dashboards & Behavioral Insights

To provide a 360-degree view of the product, I developed two primary reporting layers:

### **Executive Health Dashboard (Looker Studio)**
Designed for high-level stakeholders to monitor Growth and Retention KPIs.
* **[🔗 VifStream Dashboard Here](https://lookerstudio.google.com/s/m-6wwNszlCM)**
* **Key Features:** DAU/MAU Stickiness, Revenue by Region, and Plan Conversion Funnels.



### **Overall Metrics**

<img width="900" height="675" alt="image" src="https://github.com/user-attachments/assets/039fc9ae-adb7-483e-8dcc-5ad61e7d9b80" />




### **Engagement**

<img width="885" height="661" alt="image" src="https://github.com/user-attachments/assets/e324d7d9-e325-48be-bafb-ebd172f2a376" />


---


### **Behavioral Analysis (Amplitude)**
Used for deep-dive discovery into the user journey and feature friction points.
* **[🔗 VifStream Amplitude](https://app.eu.amplitude.com/analytics/muddy-wildflower-011456/dashboard/e-wwb7zol6?source=copy+url)**
* **Key Features:** 7-Day Retention Heatmaps and "Aha! Moment" Correlation analysis.


**Segmentation Analysis**
<img width="1792" height="775" alt="Capture d’écran 2026-02-11 à 11 28 26" src="https://github.com/user-attachments/assets/8b8520fc-350c-426f-96d0-78fce51d8cf8" />



## 📂 Repository Structure
```text
├── app/
│   └── vifstream_ops_tool.py    # Streamlit Application
├── dbt/
│   ├── models/
│   │   └── fct_user_retention.sql # Transformation Logic
│   └── schema.yml               # Data Documentation
├── notebooks/
│   └── data_cleaning.ipynb      # Polars/Pandas Pre-processing
├── README.md
└── requirements.txt             # Python dependencies
