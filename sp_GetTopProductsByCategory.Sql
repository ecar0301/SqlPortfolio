USE [NORTHWND]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetTopProductsByCategory]    Script Date: 3/17/2026 2:52:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetTopProductsByCategory]
    @CategoryID INT = NULL,
    @StartDate DATE,
    @EndDate DATE,
    @TopCount INT = 5
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

        IF @TopCount <= 0
        BEGIN
            RAISERROR('TopCount must be greater than 0.', 16, 1);
            RETURN;
        END;

        ;WITH ProductSales AS(
        
            SELECT
                c.CategoryID,
                c.CategoryName,
                p.ProductID,
                p.ProductName,
                SUM(od.UnitPrice * od.Qty) AS TotalSales,
                SUM(od.Qty) AS TotalQuantity
            FROM Categories c
            INNER JOIN Products p
                ON c.CategoryID = p.CategoryID
            INNER JOIN [Order Details] od
                ON p.ProductID = od.ProductID
            INNER JOIN Orders o
                ON od.OrderID = o.OrderID
            WHERE o.OrderDate BETWEEN @StartDate AND @EndDate
              AND (@CategoryID IS NULL OR c.CategoryID = @CategoryID)
            GROUP BY
                c.CategoryID,
                c.CategoryName,
                p.ProductID,
                p.ProductName
        ),
        RankedProducts AS(
        
            SELECT
                CategoryID,
                CategoryName,
                ProductID,
                ProductName,
                TotalSales,
                TotalQuantity,
                ROW_NUMBER() OVER (PARTITION BY CategoryID ORDER BY TotalSales DESC)  AS SalesRank
            FROM ProductSales
        )
        SELECT
            CategoryID,
            CategoryName,
            ProductID,
            ProductName,
            TotalSales,
            TotalQuantity,
            SalesRank
        FROM RankedProducts
        WHERE SalesRank <= @TopCount
        ORDER BY CategoryName, SalesRank;

    END TRY
    BEGIN CATCH
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
GO

