# SQL Portfolio – Edmond Carter

## Overview
This repository showcases my SQL Server skills through real-world styled stored procedures. These projects demonstrate my ability to write efficient queries, apply business logic, and structure data for reporting and analytics.

## Tools & Technologies
- SQL Server
- T-SQL
- SSMS
## Stored Procedures

## Stored Procedures

### 1. sp_CustomerOrderHistory
Returns product purchase history for a specific customer, including total quantity and total sales. Demonstrates joins, grouping, and parameter filtering.

### 2. sp_GetCustomersByDate
Returns customers who placed orders within a date range, including total orders and total sales. Demonstrates CTEs, aggregation, and business logic filtering.

### 3. sp_GetLowInventoryProducts
Identifies products with low inventory based on reorder levels. Demonstrates filtering, joins, and operational reporting logic.

### 4. sp_GetTopProductsByCategory
Ranks top-selling products by category using ROW_NUMBER(). Demonstrates window functions and advanced SQL techniques.

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

## SSIS Project – Top Products by Category ETL

### Overview
This SSIS package extracts top-selling products by category from the Northwind database using a stored procedure. The data flows through an OLE DB Source into an OLE DB Destination, demonstrating ETL pipeline design and execution.

### Tools Used
- SQL Server Integration Services (SSIS)
- SQL Server (Northwind Database)
- Visual Studio

### Control Flow
![Control Flow](SSIS-TopProductsByCategory-ETL/screenshots/controlflow.png)

### Data Flow
![Data Flow](SSIS-TopProductsByCategory-ETL/screenshots/dataflow.png)

### Foreach Loop Container
![Foreach Loop](SSIS-TopProductsByCategory-ETL/screenshots/foreach.png)

### Recordset Destination
![Recordset](SSIS-TopProductsByCategory-ETL/screenshots/recordset.png)
