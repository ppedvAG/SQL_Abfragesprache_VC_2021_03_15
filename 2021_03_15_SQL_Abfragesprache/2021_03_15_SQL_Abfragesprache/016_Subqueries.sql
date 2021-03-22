-- Subqueries (Unterabfragen, Subselect)



-- Unterabfrage wie eine Spalte verwenden (darf nur einen Wert ergeben)

SELECT   'Text'
		, Freight
		, (SELECT TOP 1 Freight FROM Orders ORDER BY Freight)
FROM Orders



-- Unterabfrage wie eine Tabelle verwenden (Subquery als Datenquelle verwenden)
SELECT *
FROM -- Tabelle?
		(SELECT OrderID, Freight FROM Orders WHERE EmployeeID = 3) AS t1 -- wenn als Datenquelle verwendet, dann MUSS diese so erzeugte Tabelle einen Namen bekommen (t1)
WHERE t1.Freight > 100



-- Unterabfrage im WHERE unterbringen
SELECT *
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders)
ORDER BY Freight


-- ********************************************** Übungen:


-- alle SupplierID, CompanyName, Kontaktinformation, Land aller Supplier, die aus dem gleichen Land sind wie der Supplier mit der ID 2
SELECT	  SupplierID
		, CompanyName
		, ContactName
		, ContactTitle
		, Address
		, City
		, PostalCode
		, Country
FROM Suppliers
WHERE Country = (SELECT Country FROM Suppliers WHERE SupplierID = 2)


-- alle Angestellten, die im selben Jahr eingestellt wurden wie Mr. Robert King
-- TitleOfCourtesy, Vorname, Nachname soll überprüft werden
-- Uhrzeit soll NICHT mit ausgegeben werden
-- Namen in einer Spalte ausgeben (FullName)

SELECT TitleOfCourtesy
		, CONCAT(FirstName, ' ', LastName) AS EmpName
		, FORMAT(HireDate, 'd', 'de-de') AS HireDate
		, EmployeeID
FROM Employees
WHERE YEAR(HireDate) = (SELECT YEAR(HireDate) FROM Employees WHERE EmployeeID = 7)


-- oder:
-- Lösung 1 ist schöner! :)
--SELECT TitleOfCourtesy
--		, CONCAT(FirstName, ' ', LastName) AS EmpName
--		, FORMAT(HireDate, 'd', 'de-de') AS HireDate
--		, EmployeeID
--FROM Employees
--WHERE YEAR(HireDate) = (SELECT YEAR(HireDate) FROM Employees WHERE CONCAT(TitleOfCourtesy, ' ', FirstName, ' ', LastName) = 'Mr. Robert King')

-- wenn Robert King selbst nicht dabei stehen soll:

SELECT TitleOfCourtesy
		, CONCAT(FirstName, ' ', LastName) AS EmpName
		, FORMAT(HireDate, 'd', 'de-de') AS HireDate
		, EmployeeID
FROM Employees
WHERE YEAR(HireDate) = (SELECT YEAR(HireDate) FROM Employees WHERE EmployeeID = 7) AND EmployeeID != 7



