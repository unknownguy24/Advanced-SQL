-- Exercise 1
-- Create a query with the following columns:
-- �OrderMonth�, a derived column featuring the month number corresponding with the Order Date in a given row
-- �OrderYear�, a derived column featuring the year corresponding with the Order Date in a given row
-- �SubTotal� from the Purchasing.PurchaseOrderHeader table
-- Your query should be an aggregate query � specifically, it should sum �SubTotal�, 
-- and group by the remaining fields.

-- Exercise 2
-- Modify your query from Exercise 1 by adding a derived column called "Rolling3MonthTotal", 
-- that displays - for a given row - a running total of �SubTotal� for the prior three months (including the current row).
-- HINT: You will need to include multiple fields in your ORDER BY to get this to work!

-- Exercise 3
-- Modify your query from Exercise 2 by adding another derived column called "MovingAvg6Month", 
-- that calculates a rolling average of �SubTotal� for the previous 6 months, 
-- relative to the month in the �current� row. Note that this average should NOT include the current row.

-- Exercise 4
-- Modify your query from Exercise 3 by adding another derived column called �MovingAvgNext2Months�, 
-- that calculates a rolling average of �SubTotal� for the month in the current row 
-- and the next two months after that. This moving average will provide a kind of "forecast" for Subtotal by month.


SELECT
	OrderMonth,
	OrderYear,
	SubTotal,
	Rolling3MonthTotal = SUM(SubTotal) OVER(ORDER BY OrderYear, OrderMonth ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
	MovingAvg6Month = AVG(SubTotal) OVER(ORDER BY OrderYear, OrderMonth ROWS BETWEEN 6 PRECEDING AND 1 PRECEDING),
	MovingAvgNext2Months = AVG(SubTotal) OVER(ORDER BY OrderYear, OrderMonth ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)

FROM (
	SELECT
		OrderMonth = MONTH(OrderDate),
		OrderYear = YEAR(OrderDate),
		SubTotal = SUM(SubTotal)

	FROM Purchasing.PurchaseOrderHeader

	GROUP BY
		MONTH(OrderDate),
		YEAR(OrderDate)
) X