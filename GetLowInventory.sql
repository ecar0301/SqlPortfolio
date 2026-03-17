                                    CREATE PROCEDURE sp_GetLowInventory
									         @ReorderLevel INT
     AS
	 BEGIN
	  
	    SELECT ProductID,
		       ProductName,
			   UnitsInStock,
			   ReorderLevel
		FROM Products
		WHERE UnitsInStock <= @ReorderLevel
		ORDER BY ReorderLevel DESC
	END;

	EXEC sp_GetLowInventory @ReorderLevel = 3

   
 


							