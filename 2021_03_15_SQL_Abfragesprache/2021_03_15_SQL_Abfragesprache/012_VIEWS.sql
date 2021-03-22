-- VIEWS (Sichten)



CREATE VIEW v_Test
AS 
SELECT CustomerID, CompanyName
FROM Customers


SELECT *
FROM v_Test



CREATE VIEW v_D_A_CH_Customers
AS
SELECT	  c.CompanyName
		, c.Address
		, c.City
		, c.PostalCode
		, c.Country
		, o.OrderID
--		, o.EmployeeID
		, od.ProductID
		, od.Quantity
		, od.Discount
		, od.UnitPrice
		, p.ProductName
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
					INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
						INNER JOIN Products p ON od.ProductID = p.ProductID
WHERE c.Country IN('Germany', 'Austria', 'Switzerland')




SELECT    CompanyName
		, City
		, Country
FROM v_D_A_CH_Customers
WHERE CompanyName LIKE '[a-c]%'



