USE [NORTHWND]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetCustomerSales]    Script Date: 3/16/2026 2:49:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

         CREATE PROCEDURE  [dbo].[sp_GetCustomerSales]
			              @StartDate Date,
			             @EndDate Date,
			            @MinSales MONEY

	AS
	BEGIN
     
	SELECT c.CustomerID,c.CompanyName,SUM(od.Qty * od.UnitPrice) AS TotalSales
	FROM Customers c
	JOIN Orders o
	ON  c.CustomerID = o.CustomerID
	JOIN [Order Details] od
	ON o.OrderID = od.OrderID
	WHERE O.OrderDate BETWEEN @StartDate AND @EndDate
	GROUP BY C.CustomerID, C.CompanyName
	HAVING SUM(od.Qty * od.UnitPrice) >= 5000
	ORDER BY  TotalSales ASC

	End;
GO

