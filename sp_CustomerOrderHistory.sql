USE [NORTHWND]
GO

/****** Object:  StoredProcedure [dbo].[sp_CustomerOrderHistory]    Script Date: 3/16/2026 5:41:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


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

