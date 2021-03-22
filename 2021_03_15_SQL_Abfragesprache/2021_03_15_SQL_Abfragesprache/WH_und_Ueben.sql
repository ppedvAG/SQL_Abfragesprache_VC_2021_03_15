
-- Wiederholen und Üben

-- USE Northwind


SELECT	  EmployeeID
		, FirstName
		, LastName
		, HomePhone
FROM Employees


SELECT	  Freight AS Netto
		, Freight*1.19 AS Brutto
		, Freight*0.19 AS MwSt
FROM Orders



SELECT	  EmployeeID
		, FirstName
		, LastName
		, HomePhone
FROM Employees
WHERE Country = 'UK'



SELECT	  EmployeeID
		, FirstName
		, LastName
		, HomePhone
FROM Employees
WHERE EmployeeID IN(2,3,7)




-- Umgekehrt als in der Übung gestern, sollen von der Telefonnummer aus der Customers-Tabelle nur die letzten 3 Zeichen angezeigt werden; alle anderen sollen mit x ersetzt werden. (xxxxxxxxxxxxxxx890)


-- Möglichkeit 1:
-- langsam aufgebaut:

SELECT STUFF('1234567890', 1, 7, 'xxxxxxx')


SELECT REPLICATE('x', 7)


-- in STUFF einsetzen:


SELECT STUFF('1234567890', 1, 7, REPLICATE('x', 7))


-- wie kommen wir auf "7"?
SELECT LEN('1234567890')-3

-- einsetzen, dort, wo im Moment noch 7 steht:

SELECT STUFF('1234567890', 1, LEN('1234567890')-3, REPLICATE('x', LEN('1234567890')-3))


-- mit DB:

SELECT STUFF(Phone, 1, LEN(Phone)-3, REPLICATE('x', LEN(Phone)-3))
FROM Customers


-- Möglichkeit 2:
SELECT CONCAT(REPLICATE('x', LEN(Phone)-3), RIGHT(Phone, 3))
FROM Customers





-- Bestellnummer, Wunschtermin, Lieferdatum und die Lieferverzögerung der Bestellungen
-- Datum in leserlichem Format

SELECT	  OrderID
		, FORMAT(RequiredDate, 'dd.MM.yyyy') AS RequiredDate
		, FORMAT(ShippedDate, 'dd.MM.yyyy') AS ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Delay
FROM Orders
ORDER BY DATEDIFF(dd, RequiredDate, ShippedDate) -- ASC (ascending: vom kleinsten zum größten Wert geordnet - Default)
-- mit ORDER BY

-- im ORDER BY dürfen wir auch das Spaltenalias verwenden:
SELECT	  OrderID
		, FORMAT(RequiredDate, 'dd.MM.yyyy') AS RequiredDate
		, FORMAT(ShippedDate, 'dd.MM.yyyy') AS ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Delay
FROM Orders
ORDER BY Delay -- DESC  -- descending (vom größten zum kleinsten Wert geordnet)



-- mehrere Möglichkeiten für Datum:

-- mit Format und Culture-Parameter
SELECT	  OrderID
		, FORMAT(RequiredDate, 'd', 'de-de') AS RequiredDate
		, FORMAT(ShippedDate, 'd', 'de-de') AS ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Delay
FROM Orders



-- mit CONVERT und Style-Parameter
SELECT	  OrderID
		, CONVERT(varchar, RequiredDate, 104) AS RequiredDate
		, CONVERT(varchar, ShippedDate, 104) AS ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Delay
FROM Orders




-- nur die, die schon geliefert wurden:

SELECT	  OrderID
		, FORMAT(RequiredDate, 'dd.MM.yyyy') AS RequiredDate
		, FORMAT(ShippedDate, 'dd.MM.yyyy') AS ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Delay
FROM Orders
WHERE DATEDIFF(dd, RequiredDate, ShippedDate) IS NOT NULL
ORDER BY Delay

-- in diesem Fall auch möglich: nur Shipped Date is not null abfragen (wenn da NULL drin steht, ist noch nicht geliefert worden)
SELECT	  OrderID
		, FORMAT(RequiredDate, 'dd.MM.yyyy') AS RequiredDate
		, FORMAT(ShippedDate, 'dd.MM.yyyy') AS ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Delay
FROM Orders
WHERE ShippedDate IS NOT NULL
ORDER BY Delay



-- Welche Tabellen brauchen wir, um eine Rechnung auszudrucken?
-- Welche Informationen stehen auf einer Rechnung? --> entsprechende Spalten auswählen

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





-- Wie viele Produkte haben wir im Sortiment?
SELECT COUNT(ProductID) AS AnzahlProdukte
FROM Products



-- In wie vielen Ländern haben wir Kunden?
SELECT COUNT(DISTINCT Country) AS AnzahlKunden
FROM Customers



-- Was ist der durchschnittliche Produktpreis pro Anbieter?
-- Durchschnittspreis, SupplierID, CompanyName
-- vom größten zum kleinsten Durchschnittspreis geordnet
SELECT	  AVG(p.UnitPrice) AS Durchschnittspreis
		, p.SupplierID
		, s.CompanyName
FROM Suppliers s INNER JOIN Products p ON s.SupplierID = p.SupplierID
GROUP BY p.SupplierID, s.CompanyName
ORDER BY Durchschnittspreis DESC




-- Summe der Frachtkosten pro Kunde im jeweiligen Land, die im Jahr 1996
-- mit Spaltenüberschrift
-- nach Summe der Frachtkosten geordnet
SELECT	  o.CustomerID
		, c.CompanyName
		, SUM(o.Freight) AS Freight1996
		, c.Country
FROM Orders o INNER JOIN Customers C ON o.CustomerID = c.CustomerID
WHERE YEAR(o.ShippedDate) = 1996
GROUP BY c.CompanyName, o.CustomerID, c.Country
ORDER BY Freight1996





-- OrderID, höchsten Frachtkostenwert, 'höchster Frachtkostenwert'
-- OrderID, niedrigste Frachtkostenwert, 'niedrigster Frachtkostenwert'

SELECT TOP 1  Freight AS Frachtkosten
			, OrderID AS Bestellnummer
			, 'höchster Frachtkostenwert' AS Anmerkung
INTO #hoechster_Wert
FROM Orders
ORDER BY Freight DESC



SELECT TOP 1  Freight AS Frachtkosten
			, OrderID AS Bestellnummer
			, 'niedrigster Frachtkostenwert' AS Anmerkung
INTO #niedrigster_Wert
FROM Orders
ORDER BY Freight


SELECT *
FROM #hoechster_Wert
UNION ALL
SELECT *
FROM #niedrigster_Wert




-- mit MIN/MAX nur ohne OrderID möglich (sonst ist es der jeweilige Frachtkostenwert und kein min/max Wert mehr)

SELECT MIN(Freight)
FROM Orders
UNION ALL
SELECT MAX(Freight)
FROM Orders



SELECT    MIN(Freight) AS Frachtkosten
		, 'niedrigster Wert' AS Anmerkung
FROM Orders
UNION ALL
SELECT MAX(Freight)
		, 'höchster Wert'
FROM Orders




-- gleiche Angabe, Lösung mit Unterabfrage:
SELECT TOP 1 (SELECT TOP 1 Freight FROM Orders ORDER BY Freight DESC)
		, 'höchster Frachtkostenwert' 
		, OrderID
FROM Orders
UNION ALL
SELECT TOP 1 (SELECT TOP 1 Freight FROM Orders ORDER BY Freight)
		, 'niedrigster Frachtkostenwert' 
		, OrderID
FROM Orders



-- oder:
SELECT *
FROM (SELECT TOP 1 Freight, 'höchster Frachtkostenwert' AS Anmerkung, OrderID FROM Orders ORDER BY Freight DESC) AS h
UNION ALL
SELECT *
FROM (SELECT TOP 1 Freight, 'niedrigster Frachtkostenwert' AS Anmerkung, OrderID FROM Orders ORDER BY Freight) AS n
