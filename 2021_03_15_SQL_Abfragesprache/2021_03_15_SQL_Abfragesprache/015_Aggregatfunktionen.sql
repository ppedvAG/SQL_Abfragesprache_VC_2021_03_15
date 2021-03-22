-- Aggregatfunktionen (aggregate functions)

-- COUNT, AVG, SUM, MIN, MAX


-- wie viele Kunden haben wir?
SELECT COUNT(CustomerID)
FROM Customers
-- 91


-- Achtung: NULL wird nicht mitgezählt
SELECT COUNT(Region)
FROM Customers
-- 31 - die Anzahl Kunden, wo auch eine Region eingetragen ist



-- wie viele Produkte haben wir?
SELECT COUNT(ProductID)
FROM Products
-- 77


-- in wie vielen Ländern haben wir Kunden?
SELECT COUNT(DISTINCT Country)
FROM Customers
-- 21


-- Achtung:
SELECT COUNT(Country)
FROM Customers
-- zählt jeden Eintrag bei den Ländern ab, also so viele, wie Kunden (wenn bei jedem Kunden auch ein Country eingetragen ist)


-- AVG (average = Durchschnittswert)
-- Durchschnittliche Stückpreis 

SELECT AVG(UnitPrice)
FROM Products
-- 28,8663



-- MIN/MAX-Wert

SELECT MIN(UnitPrice)
FROM Products
-- 2,50

SELECT MAX(UnitPrice)
FROM Products
-- 263,50



-- Summe bilden 
SELECT SUM(Freight)
FROM Orders
-- 64942,69



-- funktioniert nicht:
SELECT SUM(Freight), ShipCountry
FROM Orders
-- Column 'Orders.ShipCountry' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.


-- Group by... PRO ... Summe der Frachtkosten PRO Land
SELECT SUM(Freight), ShipCountry
FROM Orders
GROUP BY ShipCountry


-- alphabetisch nach Land geordnet:
SELECT SUM(Freight), ShipCountry
FROM Orders
GROUP BY ShipCountry
ORDER BY ShipCountry

-- nach Frachtkostensumme pro Land (höchster Wert zuerst)
SELECT    SUM(Freight) AS [Freight/Country]
		, ShipCountry
FROM Orders
GROUP BY ShipCountry
ORDER BY [Freight/Country] DESC



-- bringt NIX:
SELECT SUM(Freight), OrderID
FROM Orders
GROUP BY OrderID
-- ergibt die Summe der Frachtkosten pro Bestellung - also genau die Frachtkosten! (Wir können keine Summe von einem Wert bilden.)






