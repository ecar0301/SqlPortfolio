/*
Author: Edmond Carter
Procedure: sp_GetCustomersByDate

Description:
Returns customers who placed orders within a given date range.
Includes total orders, total sales, first order date, and last order date.
Supports an optional country filter and minimum order threshold.
/*


CREATE PROCEDURE [dbo].[sp_GetCustomersByDate]
    @StartDate DATE,
    @EndDate DATE,
    @MinOrders INT = 1,
    @Country NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Validation
        IF @StartDate IS NULL OR @EndDate IS NULL
        BEGIN
            RAISERROR('StartDate and EndDate are required.', 16, 1);
            RETURN;
        END;

        IF @StartDate > @EndDate
        BEGIN
            RAISERROR('StartDate cannot be later than EndDate.', 16, 1);
            RETURN;
        END;

        IF @MinOrders < 1
        BEGIN
            RAISERROR('MinOrders must be at least 1.', 16, 1);
            RETURN;
        END;

        ;WITH CustomerSales AS(
        
            SELECT
                c.CustomerID,
                c.CompanyName,
                c.Country,
                COUNT(DISTINCT o.OrderID) AS TotalOrders,
                SUM(od.UnitPrice * od.Qty * (1 - od.Discount)) AS TotalSales,
                MIN(o.OrderDate) AS FirstOrderDate,
                MAX(o.OrderDate) AS LastOrderDate
            FROM Customers c
            INNER JOIN Orders o
                ON c.CustomerID = o.CustomerID
            INNER JOIN [Order Details] od
                ON o.OrderID = od.OrderID
            WHERE o.OrderDate BETWEEN @StartDate AND @EndDate
              AND (@Country IS NULL OR c.Country = @Country)
            GROUP BY
                c.CustomerID,
                c.CompanyName,
                c.Country
        )
        SELECT
            CustomerID,
            CompanyName,
            Country,
            TotalOrders,
            CAST(TotalSales AS DECIMAL(12,2)) AS TotalSales,
            FirstOrderDate,
            LastOrderDate
        FROM CustomerSales
        WHERE TotalOrders >= @MinOrders
        ORDER BY TotalSales DESC, TotalOrders DESC, CompanyName ASC;

    END TRY
    BEGIN CATCH
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;


