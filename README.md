# SQL Portfolio – Edmond Carter

## Overview
This repository showcases my SQL Server skills through real-world styled stored procedures. These projects demonstrate my ability to write efficient queries, apply business logic, and structure data for reporting and analytics.

## Tools & Technologies
- SQL Server
- T-SQL
- SSMS
## Stored Procedures

### 1. sp_GetCustomerSales
Calculates total sales for customers within a specified date range. Demonstrates joins, aggregation (SUM), filtering, and grouping.

### 2. sp_CustomerOrderHistory
Returns product purchase history for a specific customer, including total quantity and total sales. Demonstrates joins, grouping, and parameter filtering.

### 3. sp_GetCustomersByDate
Returns customers who placed orders within a date range, including total orders and total sales. Demonstrates CTEs, aggregation, and business logic filtering.

### 4. sp_GetLowInventoryProducts
Identifies products with low inventory based on reorder levels. Demonstrates filtering, joins, and operational reporting logic.

## Key Skills Demonstrated
- Joins (INNER JOIN, multiple tables)
- Aggregations (SUM, GROUP BY, HAVING)
- Parameterized queries
- Filtering and sorting
- Business logic implementation

## How to Run
1. Open SQL Server Management Studio (SSMS)
2. Select the Northwind database
3. Execute the stored procedure script
4. Run using EXEC with parameters

Example:
