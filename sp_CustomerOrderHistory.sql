
-- Author: Edmond Carter
-- Project: SQL Portfolio
-- Stored Procedure: sp_CustomerOrderHistory

-- Description:
-- This stored procedure retrieves the order history for a specific customer.
-- It joins Orders, Order Details, and Products tables to display the products
-- purchased along with the total quantity ordered for each product.

-- Parameter:
-- @CustomerID = The ID of the customer whose order history is being retrieved

-- Logic:
-- 1. Filter Orders by the given CustomerID
-- 2. Join Orders to Order Details to get product-level data
-- 3. Join Products to get product names
-- 4. Aggregate total quantity purchased per product
-- 5. Sort results by total quantity in descending order

USE [NORTHWND]
GO

/****** Object:  StoredProcedure [dbo].[sp_CustomerOrderHistory]    Script Date: 3/16/2026 5:41:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- Author: Edmond Carter
-- Project: SQL Portfolio
-- Stored Procedure: sp_CustomerOrderHistory

-- Description:
-- This stored procedure retrieves the order history for a specific customer.
-- It joins Orders, Order Details, and Products tables to display the products
-- purchased along with the total quantity ordered for each product.

-- Parameter:
-- @CustomerID = The ID of the customer whose order history is being retrieved

-- Logic:
-- 1. Filter Orders by the given CustomerID
-- 2. Join Orders to Order Details to get product-level data
-- 3. Join Products to get product names
-- 4. Aggregate total quantity purchased per product
-- 5. Sort results by total quantity in descending order

	 CREATE PROCEDURE [dbo].[sp_CustomerOrderHistory]
		@CustomerID NCHAR (20)

	AS
	BEGIN
	        
			SELECT c.CustomerID,
			       c.CompanyName,
				   o.OrderID,
				   o.OrderDate,
				   p.ProductName,
				   od.Qty,
				   od.UnitPrice,
				   (od.Qty * od.UnitPrice) AS LineTotal
			FROM Customers c
			JOIN Orders o
			ON c.CustomerID = o.CustomerID
			JOIN [Order Details] od
			ON o.OrderID = od.OrderID
			JOIN Products p
			ON od.ProductID = p.ProductID
			WHERE C.CustomerID = @CustomerID
			ORDER BY O.OrderDate,o.OrderID ASC
			     
			         

	END; 
GO

