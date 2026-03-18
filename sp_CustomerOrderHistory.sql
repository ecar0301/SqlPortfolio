/*
Author: Edmond Carter
Procedure: sp_CustomerOrderHistory

Description:
Returns product purchase history for a specific customer.
Includes total quantity, total sales, and optional date filtering.
*/



CREATE PROCEDURE [dbo].[sp_CustomerOrderHistory]
    @CustomerID NCHAR(5),
    @StartDate DATE = NULL,
    @EndDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @CustomerID IS NULL
        BEGIN
           RAISERROR ('CustomerID is required.', 1,16)
		   RETURN;
        END;

        ;WITH CustomerHistory AS(
        
            SELECT
                o.CustomerID,
                p.ProductName,
                SUM(od.Qty) AS TotalQuantity,
                SUM(od.UnitPrice * od.Qty) AS TotalSales
            FROM Orders o
            INNER JOIN [Order Details] od
                ON o.OrderID = od.OrderID
            INNER JOIN Products p
                ON od.ProductID = p.ProductID
            WHERE o.CustomerID = @CustomerID
              AND (@StartDate IS NULL OR o.OrderDate >= @StartDate)
              AND (@EndDate IS NULL OR o.OrderDate <= @EndDate)
            GROUP BY
                o.CustomerID,
                p.ProductName
        )
        SELECT
            CustomerID,
            ProductName,
            TotalQuantity,
            CAST(TotalSales AS DECIMAL(12,2)) AS TotalSales
        FROM CustomerHistory
        ORDER BY TotalQuantity DESC, ProductName ASC;

    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;


GO

