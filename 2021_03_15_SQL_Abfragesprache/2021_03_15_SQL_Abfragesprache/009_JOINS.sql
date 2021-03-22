-- JOINS
-- Informationen aus mehreren Tabellen abfragen


-- INNER JOIN


-- OUTER JOINS  (LEFT JOIN, RIGHT JOIN)







-- INNER JOIN
SELECT *
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID



-- welche Spalten?
SELECT	  OrderID
		, Orders.CustomerID -- wenn Spaltenname in mehreren Tabellen vorkommt, müssen wir dazu sagen woher
		, CompanyName
		, Address
		, City
		, Country
		, ShippedDate
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID



-- bei den anderen Spalten SOLLTEN wir dazu sagen, woher die Information stammt 
SELECT	  Orders.OrderID
		, Orders.CustomerID -- wenn Spaltenname in mehreren Tabellen vorkommt, müssen wir dazu sagen woher
		, Customers.CompanyName
		, Customers.Address
		, Customers.City
		, Customers.Country
		, Orders.ShippedDate
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID




-- ein bisschen kürzere Schreibweise:
SELECT	  o.OrderID
		, o.CustomerID -- wenn Spaltenname in mehreren Tabellen vorkommt, müssen wir dazu sagen woher
		, c.CompanyName
		, c.Address
		, c.City
		, c.Country
		, o.ShippedDate
FROM Customers AS c INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID


-- wir dürfen das AS weglassen:
SELECT	  o.OrderID
		, o.CustomerID -- wenn Spaltenname in mehreren Tabellen vorkommt, müssen wir dazu sagen woher
		, c.CompanyName
		, c.Address
		, c.City
		, c.Country
		, o.ShippedDate
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID




-- auch das können wir selbstverständlich mit WHERE kombinieren:
SELECT	  o.OrderID
		, o.CustomerID 
		, c.CompanyName
		, c.Address
		, c.City
		, c.Country
		, o.ShippedDate
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'Germany'
-- 122


-- mit ORDER BY (nach Städten geordnet)
SELECT	  o.OrderID
		, o.CustomerID 
		, c.CompanyName
		, c.Address
		, c.City
		, c.Country
		, o.ShippedDate
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'Argentina'
ORDER BY c.City, c.CustomerID




-- mit RIGHT JOIN:
SELECT	  o.OrderID
		, o.CustomerID
		, c.CompanyName
		, c.Address
		, c.City
		, c.Country
		, o.ShippedDate
FROM Customers c RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID
-- 830



-- mit LEFT JOIN:
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, c.Address
		, c.City
		, c.Country
		, o.ShippedDate
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
-- 832



-- wie bekommen wir nur die Kunden, die noch nichts bestellt haben?
SELECT *
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL


-- können wir das auch mit einem RIGHT JOIN machen?
SELECT *
FROM Orders o RIGHT JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL




-- alle Kunden aus den USA und den UK und ihre Frachtkosten:
SELECT	  c.CustomerID
		, c.CompanyName
		, c.Country
		, o.Freight
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE Country = 'USA' OR Country = 'UK'



-- JOINS über mehrere Tabellen
SELECT *
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID 
					INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID






-- Annahme: es gab Beschwerden bei den Bestellungen mit den Nr. 10251, 10280, 10990 und 11000
-- Welche/r Angestellte/r hat die Bestellungen bearbeitet?
-- Vor- und Nachname in einem Feld als EmpName


SELECT	  Orders.OrderID
		, Employees.EmployeeID
		, CONCAT(Employees.FirstName, ' ', Employees.LastName) AS EmpName
		, Employees.ReportsTo
		, Orders.CustomerID
FROM Employees INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
WHERE Orders.OrderID IN(10251, 10280, 10990, 11000)





-- bestimmte Produkte nachbestellen:
-- Kontaktinformationen der Anbieter (Supplier), die Sauce verkaufen
-- Achtung: wie heißen die Produkte? Mehrere Möglichkeiten?

SELECT	  s.CompanyName
		, s.ContactName
		, p.ProductName
		, p.ProductID
		, p.UnitPrice
FROM Suppliers s INNER JOIN Products p ON s.SupplierID = p.SupplierID
WHERE p.ProductName LIKE '%sauce%' OR p.ProductName LIKE N'%soße%'



-- welche Kunden haben Chai Tee gekauft und wieviel? 
-- Quantity (keine Berechnung)
-- CompanyName (Customers)
-- wie heißt das Produkt tatsächlich?
SELECT	  c.CustomerID
		, c.CompanyName
		, p.ProductID
		, p.ProductName
		, od.Quantity
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
					INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
						INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE p.ProductName LIKE '%chai%'
-- 38 Ergebnisse


-- Produktname kann "Bier" oder "Lager" enthalten oder kann mit "ale" enden
-- geordnet nach Anzahl (größte zuerst), nach CompanyName alphabetisch
SELECT	  c.CustomerID
		, c.CompanyName
		, p.ProductID
		, p.ProductName
		, od.Quantity
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
					INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
						INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE p.ProductName LIKE '%bier%' OR p.ProductName LIKE '%lager%' OR p.ProductName LIKE '%ale'
ORDER BY od.Quantity DESC, c.CompanyName -- ASC (kann weggelassen werden, weil Default)
-- 114 Ergebnisse





-- EmpName, EmpID, ChefName, ChefID
SELECT	  emp.LastName
		, emp.EmployeeID
--		, emp.ReportsTo
		, boss.LastName
		, boss.EmployeeID
FROM Employees emp INNER JOIN Employees boss ON emp.ReportsTo = boss.EmployeeID
-- 8


SELECT	  emp.LastName
		, emp.EmployeeID
--		, emp.ReportsTo
		, boss.LastName
		, boss.EmployeeID
FROM Employees emp LEFT JOIN Employees boss ON emp.ReportsTo = boss.EmployeeID
-- 9 Ergebnisse (auch der, der keinen Chef hat, steht dabei)



SELECT	  CONCAT(emp.FirstName, ' ', emp.LastName) AS EmpName
		, emp.EmployeeID AS EmpID
--		, emp.ReportsTo
		, CONCAT(boss.FirstName, ' ', boss.LastName) AS ChefName
		, boss.EmployeeID AS ChefID
FROM Employees emp INNER JOIN Employees boss ON emp.ReportsTo = boss.EmployeeID
ORDER BY ChefID



-- Name1, Stadt1, Name2, Stadt2
-- mit CustomerID
-- Name1, Name2, Stadt
-- nach Stadt und Name geordnet

SELECT	  c1.CustomerID AS Name1
		, c2.CustomerID AS Name2
		, c1.City AS Stadt1
--		, c2.City AS Stadt2
FROM Customers c1 INNER JOIN Customers c2 ON c1.City = c2.City
WHERE c1.CustomerID != c2.CustomerID
ORDER BY Stadt1, Name1
-- 88 Ergebnisse