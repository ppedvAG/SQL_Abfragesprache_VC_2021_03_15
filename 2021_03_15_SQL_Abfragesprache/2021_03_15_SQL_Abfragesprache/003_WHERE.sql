-- WHERE clause, WHERE-Klausel, WHERE-Bedingung
-- bestimmte Ergebnisse aufgrund der hier festgesetzten Bedingung


/*

	WHERE Operatoren:
			
			=, <, >, <=, >=
			!=, <>    -- darf NICHT diesen Wert enthalten



			AND, OR

			IN, BETWEEN, LIKE

			NOT IN
			NOT BETWEEN
			NOT LIKE

			-- positiv formulieren: schneller! Wenn man es vermeiden kann, dann kein NOT verwenden



*/


-- alle Kunden, die in Deutschland ansässig sind

SELECT *
FROM Customers
WHERE Country = 'Germany'



-- mit Spaltenauswahl
SELECT	  CustomerID
		, CompanyName
		, ContactName
		, Phone
FROM Customers
WHERE Country = 'Germany'




-- alle Kunden aus D aus Berlin
SELECT	  CustomerID
		, CompanyName
		, ContactName
		, Phone
FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'



-- alle deutschsprachigen Kunden (D, A, CH)
SELECT	  CustomerID
		, CompanyName
		, ContactName
		, Phone
FROM Customers
WHERE Country = 'Germany' OR Country = 'Austria' OR Country = 'Switzerland'



-- alle Bestellungen, wo die Frachtkosten niedriger als 100 sind:
SELECT	  OrderID
		, CustomerID
		, Freight
FROM Orders
WHERE Freight < 100



-- alle, wo die Frachtkosten NICHT einem bestimmten Wert entsprechen
SELECT	  OrderID
		, CustomerID
		, Freight
FROM Orders
WHERE Freight != 148.33



-- alle Kunden aus Frankreich:
SELECT *
FROM Customers
WHERE Country = 'France'




-- Kunden aus München:
SELECT *
FROM Customers
WHERE Country = 'Germany' AND City = N'München'



-- alle portugiesischen und spanischen Kunden:
SELECT *
FROM Customers
WHERE Country = 'Portugal' OR Country = 'Spain'



-- mit IN:
SELECT *
FROM Customers
WHERE Country IN('Portugal', 'Spain')



-- alle Bestellungen, die von Angestellten mit den 3, 5 und 7 bearbeitet worden sind:

SELECT *
FROM Orders
WHERE EmployeeID = 3 OR EmployeeID = 5 OR EmployeeID = 7

-- oder mit IN:
SELECT *
FROM Orders
WHERE EmployeeID IN(3, 5, 7);



-- alle Bestellungen, bei denen die Frachtkosten zwischen 100 und 200 liegen (inklusive)
SELECT *
FROM Orders
WHERE Freight >= 100 AND Freight <= 200


-- Bereich abdecken mit BETWEEN
SELECT *
FROM Orders
WHERE Freight BETWEEN 100 AND 200
-- Wichtig: macht ein >= und <= (die Grenzwerte sind mit eingeschlossen)



-- 100 und 200 soll nicht mit dabei sein
SELECT *
FROM Orders
WHERE Freight BETWEEN 100.00000000001 AND 199.9999999999
-- nicht schön, nicht präzise

-- in diesem Fall würden wir eher < und > verwenden
SELECT *
FROM Orders
WHERE Freight > 100 AND Freight < 200



-- alle Produkte mit ProduktID zwischen 10 und 15
SELECT *
FROM Products
WHERE ProductID BETWEEN 10 AND 15


-- alle Produkte, die von den Anbietern mit der SupplierID 2, 7 oder 15 geliefert werden:
SELECT *
FROM Products
WHERE SupplierID IN(2, 7, 15)



-- alle Produkte die von den Anbietern mit der SupplierID 5, 10 oder 15 geliefert werden, von denen mehr als 10 Stück vorrätig sind und deren Stückpreis unter 100 liegt:
-- sinnvolle Spalten auswählen
SELECT	  ProductID
		, ProductName
		, SupplierID
		, UnitsInStock
		, UnitPrice
FROM Products
WHERE SupplierID IN(5, 10, 15) AND UnitsInStock > 10 AND UnitPrice < 100


