-- UNION, UNION ALL



SELECT 'Testtext1', 'Testtext2'


SELECT 'Testtext1'
UNION
SELECT 'Testtext2'




SELECT EmployeeID
FROM Employees
UNION
SELECT SupplierID
FROM Suppliers

-- UNION macht auch ein DISTINCT!!
-- wenn wir das nicht wollen --> UNION ALL


SELECT EmployeeID
FROM Employees
UNION ALL
SELECT SupplierID
FROM Suppliers


-- mehrere Spalten
SELECT 'Testtext1', 100
UNION
SELECT 'Testtext2', 200


SELECT 'Testtext1', 100
UNION
SELECT 'Testtext2', 100



-- in einer Spalte müssen gleiche oder implizit konvertierbare Datentypen stehen
SELECT 100, 'Testtext1'
UNION
SELECT 'Testtext2', 200
-- Conversion failed when converting the varchar value 'Testtext2' to data type int.



-- funktioniert nicht! (gleiche Anzahl an Spalten!)
SELECT 100
UNION
SELECT 200, 'Testtext2'
-- All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.


-- funktioniert - Sinn? Von Fall zu Fall entscheiden!
SELECT 100, NULL
UNION
SELECT 200, 'Testtext2'




-- mit ALIAS
SELECT   'Testtext1' AS Text
		, 100 AS Zahl
UNION
SELECT   'Testtext2'
		, 200
-- das erste ALIAS (oder die ersten Spaltennamen) gelten für alle!


SELECT   'Testtext1' AS Text
		, 100 AS Zahl
UNION
SELECT   'Testtext2'
		, 100




-- Achtung! Datentyp!
-- funktioniert NICHT!
SELECT CustomerID, ContactName
FROM Customers
UNION
SELECT EmployeeID, LastName
FROM Employees
-- Conversion failed when converting the nvarchar value 'ALFKI' to data type int.


-- mit expliziter Konvertierung würde es funktionieren, wenn man das unbedingt will

SELECT    CustomerID AS ID
		, ContactName AS Name
FROM Customers
UNION
SELECT CAST(EmployeeID AS varchar(10)), LastName
FROM Employees



-- wir können theoretisch auch mit NULL auffüllen
SELECT    CompanyName AS Name
		, Region
FROM Customers
UNION
SELECT LastName, NULL
FROM Employees



-- selbst Text reinschreiben ist möglich. Sinn? Von Fall zu Fall entscheiden!
SELECT    CompanyName AS Name
		, Region
FROM Customers
UNION
SELECT LastName, 'Blabla'
FROM Employees







-- Liste von allen Kontaktdaten (Customers und Suppliers)
SELECT	  CustomerID AS ID
		, CompanyName
		, ContactName
		, Address
		, City
		, PostalCode
		, Country
		, Phone
		, 'Kunde' AS Kategorie
FROM Customers
UNION ALL
SELECT	  CAST(SupplierID AS varchar(10))
		, CompanyName
		, ContactName
		, Address
		, City
		, PostalCode
		, Country
		, Phone
		, 'Lieferant'
FROM Suppliers
ORDER BY City -- ACHTUNG: ORDER BY gilt für BEIDE!






