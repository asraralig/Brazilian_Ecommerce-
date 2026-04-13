# 🛒 Brazilian E-Commerce — SQL Analysis

A structured SQL project analysing the **Olist Brazilian E-Commerce** dataset.
This project explores sales trends, customer behaviour, seller performance,
delivery efficiency, and product insights using Microsoft SQL Server.

---

##  Dataset

The dataset contains 9 tables sourced from the
[Olist Brazilian E-Commerce dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce):

- `olist_customers_dataset`
- `orders_dataset`
- `order_items_dataset`
- `order_payments_dataset`
- `order_reviews_dataset`
- `sellers_dataset`
- `products_dataset`
- `geolocation_dataset`
- `product_category_name_translation`

---

## Business Questions Answered

| # | Question | Topic |
|---|----------|-------|
| Q1 | Sales analysis by year and state | Sales |
| Q2 | Most used payment type across the country | Payments |
| Q3 | Review scores by customer budget tier | Customers |
| Q4 | High-performing sellers by state | Sellers |
| Q5 | Low-performing sellers by state | Sellers |
| Q6 | Sellers who delivered before the estimated date | Delivery |
| Q7 | Percentage of early deliveries | Delivery |
| Q8 | Percentage of late deliveries | Delivery |
| Q9 | Percentage of undelivered orders | Delivery |
| Q10 | Top-selling product categories | Products |
| Q11 | States with the highest order cancellations | Orders |
| Q12 | Revenue and order count per product | Products |
| Q13 | Unique customers per year per state | Customers |
| Q14 | Orders placed per city per year | Orders |
| Q15 | Sales trend by city and year | Sales |

---

##  SQL Concepts Used

- CTEs (`WITH` clause)
- SQL Views (`CREATE OR ALTER VIEW`)
- Multi-table `JOIN`s
- `GROUP BY` with aggregations (`SUM`, `COUNT`, `AVG`)
- `CASE WHEN` for customer segmentation
- `DATEPART` for time-based analysis
- Conditional aggregation for delivery KPIs

---

## ▶️ How to Run

1. Create the database: `CREATE DATABASE Brazilian_Ecommerce;`
2. Import all 9 CSV tables into SQL Server.
3. Run the queries in order from the `.sql` file.

---

## 📌 Tools

- Microsoft SQL Server / SSMS
- Dataset: [Kaggle — Olist Brazilian E-Commerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
