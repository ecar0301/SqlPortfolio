/*
Author: Edmond Carter
Procedure: sp_GetLowInventoryProducts

Description:
Returns products with low inventory based on reorder level or a custom threshold.
Supports optional category filtering and active-product filtering.
Includes supplier and category details, plus inventory status logic.
*/



CREATE PROCEDURE [dbo].[sp_GetLowInventoryProducts]
    @Threshold INT = NULL,
    @CategoryID INT = NULL,
    @OnlyActive BIT = 1
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Validation
        IF @Threshold IS NOT NULL AND @Threshold < 0
        BEGIN
            RAISERROR('Threshold cannot be negative.', 16, 1);
            RETURN;
        END;

        ;WITH InventoryCheck AS(
        
            SELECT
                p.ProductID,
                p.ProductName,
                c.CategoryID,
                c.CategoryName,
                s.CompanyName AS SupplierName,
                p.UnitsInStock,
                p.UnitsOnOrder,
                p.ReorderLevel,
                p.Discontinued,
                CASE
                    WHEN p.UnitsInStock = 0 THEN 'Out of Stock'
                    WHEN p.UnitsInStock < ISNULL(@Threshold, p.ReorderLevel) THEN 'Low Inventory'
                    ELSE 'Sufficient'
                END AS InventoryStatus
            FROM Products p
            INNER JOIN Categories c
                ON p.CategoryID = c.CategoryID
            INNER JOIN Suppliers s
                ON p.SupplierID = s.SupplierID
            WHERE (@CategoryID IS NULL OR p.CategoryID = @CategoryID)
              AND (@OnlyActive = 0 OR p.Discontinued = 0)
        )
        SELECT
            ProductID,
            ProductName,
            CategoryName,
            SupplierName,
            UnitsInStock,
            UnitsOnOrder,
            ReorderLevel,
            InventoryStatus
        FROM InventoryCheck
        WHERE UnitsInStock < ISNULL(@Threshold, ReorderLevel)
        ORDER BY
            UnitsInStock ASC,
            ReorderLevel DESC,
            ProductName ASC;

    END TRY
    BEGIN CATCH
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
GO

