-- Exercise 1
-- Create a query that returns all records and the following columns from the HumanResources.Employee table:
-- a. BusinessEntityID (alias this as “EmployeeID”)
-- b. JobTitle
-- c. HireDate
-- d. VacationHours
-- Sort the query output by "JobTitle" and HireDate, both in ascending order.
-- Add a derived column called “FirstHireVacationHours” that displays – for a given job title – 
-- the amount of vacation hours possessed by the first employee hired who has that same job title.
-- For example, if 5 employees have the title “Data Guru”, and the one of those 5 with the oldest hire date 
-- has 99 vacation hours, “FirstHireVacationHours” should display “99” for all 5 of those employees’ corresponding records.

SELECT
	  EmployeeID = BusinessEntityID,
      JobTitle,
      HireDate,
      VacationHours,
	  FirstHireVacationHours = FIRST_VALUE(VacationHours) OVER(PARTITION BY JobTitle ORDER BY HireDate)
	  
FROM AdventureWorks2019.HumanResources.Employee

ORDER BY JobTitle, HireDate




-- Exercise 2
-- Create a query with the following columns:
-- a. “ProductID” from the Production.Product table
-- b. “Name” from the Production.Product table (alias this as “ProductName”)
-- c. “ListPrice” from the Production.ProductListPriceHistory table
-- d. “ModifiedDate” from the Production.ProductListPriceHistory
-- Join the Production.Product and Production.ProductListPriceHistory tables on "ProductID".
-- Sort the query output by ProductID and ModifiedDate, both in ascending order.
-- Add a derived column called “HighestPrice” that displays – for a given product – 
-- the highest price that product has been listed at.
-- Similarly, create another derived column called “LowestCost” that displays the all-time lowest price for a given product.
-- Finally, create a third derived column called “PriceRange” that reflects, 
-- for a given product, the difference between its highest and lowest ever list prices.


SELECT
	A.ProductID,
	ProductName = A.[Name],
	B.ListPrice,
    B.ModifiedDate,
	HighestPrice = FIRST_VALUE(B.ListPrice) OVER(PARTITION BY B.ProductID ORDER BY B.ListPrice DESC),
	LowestPrice = FIRST_VALUE(B.ListPrice) OVER(PARTITION BY B.ProductID ORDER BY B.ListPrice),
	PriceRange = FIRST_VALUE(B.ListPrice) OVER(PARTITION BY B.ProductID ORDER BY B.ListPrice DESC)-
		FIRST_VALUE(B.ListPrice) OVER(PARTITION BY B.ProductID ORDER BY B.ListPrice)

FROM AdventureWorks2019.Production.Product A
	JOIN AdventureWorks2019.Production.ProductListPriceHistory B
  ON A.ProductID = B.ProductID

ORDER BY A.ProductID, B.ModifiedDate