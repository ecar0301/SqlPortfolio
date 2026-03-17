                    CREATE PROCEDURE  sp_GetCustomerSales
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

	EXEC sp_GetCustomerSales 
	      @StartDate ='1997-01-01', @EndDate = '1997-12-31', @MinSales = 5000;