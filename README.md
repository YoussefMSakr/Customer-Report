# 🧠 SQL Customer Analysis Project

### 📊 Overview
This project focuses on **Customer Behavior Analysis** using **Advanced SQL** techniques.  
It helps businesses understand their customers through spending patterns, order frequency, recency, and segmentation models.

The SQL logic builds a **customer analytics view** (`dbo.customer_Report`) that transforms transactional data into valuable marketing and business insights.

---

## 🎯 Objectives
- Identify **top-performing customers** by sales and quantity.
- Classify customers based on **recency**, **frequency**, and **monetary value**.
- Calculate **customer lifetime value (LTV)** metrics such as:
  - First and last order dates  
  - Total spending & average order value  
  - Monthly revenue trends  
- Segment customers by **age group** and **activity level**.
- Detect **high-value**, **medium**, and **low-engagement** customers.

---

## 🧱 Dataset Structure (Star Schema)
The analysis is based on the `gold` schema that includes:

| Table | Description |
|--------|-------------|
| `gold.fact_sales` | Transactional data (order date, product key, quantity, sales amount) |
| `gold.dim_customers` | Customer demographics (name, age, country, birth date) |

---

## 🧩 SQL Logic Summary
The main logic is structured in **two layers** of Common Table Expressions (CTEs):

### 1️⃣ `customer_orders`
Aggregates key customer-level metrics:
- Total Orders  
- Total Spending  
- Total Quantity  
- First & Last Order Date  
- Customer Age  

### 2️⃣ `customer_segments`
Enhances the data with behavioral metrics:
- Recency in Months  
- Lifespan in Months  
- Average Monthly Revenue  
- Average Order Value  

Finally, the query assigns **segmentation labels**:
- 🧍‍♂️ **Age Group:** under_20, 21_30, 31_40, 41_50, 51_60, above_60  
- ⚙️ **Activity Level:** Active, Medium Active, Low Active  
- 💰 **Spending Segment:** High Spender, Normal, Below Average  

---

## 🧮 Key Metrics & Columns
| Column | Description |
|--------|--------------|
| `customer_name` | Full name (First + Last) |
| `total_spending` | Total revenue from the customer |
| `total_orders` | Total number of orders |
| `recency_in_months` | Months since the last purchase |
| `avg_order_value` | Average value per order |
| `spending_segment` | High, Normal, or Below Average spender |

---

## ⚙️ Tools & Technologies
- Microsoft SQL Server (T-SQL)
- Common Table Expressions (CTE)
- Window Functions
- Aggregation & Segmentation Queries
- Data Cleaning & Feature Engineering

---

## 📈 Business Impact
This project supports:
- **Customer Retention Strategies**
- **Segmentation-Based Marketing**
- **Revenue Forecasting**
- **Personalized Promotions**

---

## 📊 Integration Example
The results of this SQL analysis can be connected to **Power BI** for:
- Real-time dashboards on customer activity  
- Profitability segmentation  
- Demographic insights  

---

## 👨‍💻 Author
**Major General Data Analyst / Youssef Sakr**  
*SQL Customer Analytics Project (2025)*
