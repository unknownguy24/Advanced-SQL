ALTER PROCEDURE dbo.OrdersAboveThreshold(@Threshold MONEY, @StartYear INT, @EndYear INT, @OrderType INT)

AS

BEGIN
	IF @OrderType = 1
		BEGIN
			SELECT 
				A.SalesOrderID,
				A.OrderDate,
				A.TotalDue

			FROM  AdventureWorks2019.Sales.SalesOrderHeader A
				JOIN AdventureWorks2019.dbo.Calendar B
					ON A.OrderDate = B.DateValue

			WHERE A.TotalDue >= @Threshold
				AND B.YearNumber BETWEEN @StartYear AND @EndYear

			ORDER BY A.TotalDue DESC
		END

		IF @OrderType = 2
			BEGIN
				SELECT 
					A.PurchaseOrderID,
					A.OrderDate,
					A.TotalDue

				FROM  AdventureWorks2019.Purchasing.PurchaseOrderHeader A
					JOIN AdventureWorks2019.dbo.Calendar B
						ON A.OrderDate = B.DateValue

				WHERE A.TotalDue >= @Threshold
					AND B.YearNumber BETWEEN @StartYear AND @EndYear

				ORDER BY A.TotalDue DESC
			END

		IF @OrderType = 3
			BEGIN
				SELECT 
					OrderID = A.SalesOrderID,
					OrderType = 'Sales',
					A.OrderDate,
					A.TotalDue

				FROM  AdventureWorks2019.Sales.SalesOrderHeader A
					JOIN AdventureWorks2019.dbo.Calendar B
						ON A.OrderDate = B.DateValue

				WHERE A.TotalDue >= @Threshold
					AND B.YearNumber BETWEEN @StartYear AND @EndYear

				UNION ALL

				SELECT 
					OrderID = A.PurchaseOrderID,
					OrderType = 'Purchase',
					A.OrderDate,
					A.TotalDue

				FROM  AdventureWorks2019.Purchasing.PurchaseOrderHeader A
					JOIN AdventureWorks2019.dbo.Calendar B
						ON A.OrderDate = B.DateValue

				WHERE A.TotalDue >= @Threshold
					AND B.YearNumber BETWEEN @StartYear AND @EndYear

				ORDER BY TotalDue DESC
			END
END



--Call modified stored procedure

EXEC dbo.OrdersAboveThreshold 10000, 2011, 2013, 3



