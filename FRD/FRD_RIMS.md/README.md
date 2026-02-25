1. Document Overview

Project Name: Retail Inventory Management System (RIMS)
Document Type: Functional Requirement Document (FRD)
Prepared By: Anila Tikkha - Technical Business Analyst

Purpose: This document defines system functionality, technical design,  database structure, and data validation rules required to implement the Retail Inventory Management System.

2. System Architecture Overview

High-Level Data Flow

PostgreSQL Database
→ SQL Validation Queries
→ Exported Dataset (CSV)
→ Tableau Dashboard
→ Business Users (Warehouse / Supply Chain)

This diagram illustrates the data flow within the Retail Inventory Management System (RIMS). Inventory data is stored in PostgreSQL, validated through SQL queries,  exported as a structured dataset, visualized in Tableau dashboards, and consumed by warehouse and supply chain teams for decision-making.

3. Database Design (PostgreSQL)

    <img width="658" height="450" alt="image" src="https://github.com/user-attachments/assets/827acdb8-51af-49ab-a666-af0dc08c7187" />
      
4. Functional Process Flow

4.1 Inventory Tracking

* Inventory transactions are recorded in PostgreSQL.

* Stock quantities are aggregated using SQL queries.

* Low stock threshold is evaluated (<5 units).

* Data is exported to CSV for Tableau Public.

* Tableau dashboards display aggregated insights.

5. Business Logic & Validation Rules

5.1 Find Stock Quantities

SELECT sku_id, SUM(stock_qty) as total_stock FROM inventory_transactions GROUP BY sku_id ORDER BY total_stock  ; 

5.2 Find Low Stock SKUs

SELECT sku_id, SUM(stock_qty) as total_stock
FROM inventory_transactions GROUP BY sku_id HAVING SUM(stock_qty) <=5
ORDER BY total_stock;

Low Stock Rule

SELECT sku_id, SUM(stock_qty) as total_stock,
CASE
   WHEN (SUM(stock_qty)<5) THEN 'LOW STOCK'
   ELSE 'OK'
END AS stock_status
from inventory_transactions GROUP BY sku_id; 

The system shall flag an SKU as ‘LOW Stock’ when the total available quantity across all warehouses is less than 5 units. 

Tableau Alert Section


Low Stock Flag

Low Stock Count



The system calculates total stock per SKU by aggregating stock quantities across warehouses. SKUs with total stock below 10 units are flagged as “Low Stock” using calculated fields in Tableau and displayed in the dashboard alert section.

5.3 Data Validation Rules

| Rule ID | Validation Rule         | Description                               |
| ------- | ----------------------- | ----------------------------------------- |
| VR-01   | No Negative Final Stock | Final aggregated stock cannot be negative |
| VR-02   | Valid SKU Format        | SKU must start with "SKU"                 |
| VR-03   | Transaction Type        | Must be either IN or OUT                  |
| VR-04   | Date Validation         | Transaction date cannot be future date    |

6. Reporting & Dashboard Requirements

Sheet 1: Stock by Warehouse

Bar chart

X-axis: Warehouse ID

Y-axis: Total Stock

Data Source: Aggregated SQL output

Sheet 2: Low Stock SKU Alert

Highlight table

Filter: total_stock < 10

Color coded (Red = Critical)

Sheet 3: Transaction Trend

Line chart

X-axis: Transaction Date

Y-axis: Sum(stock_qty)

