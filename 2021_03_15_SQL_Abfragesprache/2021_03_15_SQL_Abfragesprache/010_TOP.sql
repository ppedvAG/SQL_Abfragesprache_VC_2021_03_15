-- TOP Abfragen
-- ORDER BY zwingend notwendig!! (Wenn wir ein nachvollziehbares Ergebnis haben wollen)




-- nur die erste Zeile ausgeben

SELECT TOP 1 *
FROM Customers
-- ALFKI
-- ABER: WAS IST die erste Zeile???
-- IMMER ABHÄNGIG VON ORDER BY!



SELECT TOP 1 *
FROM Customers
ORDER BY CustomerID
-- ALFKI



SELECT TOP 1 *
FROM Customers
ORDER BY Country
-- CACTU


SELECT TOP 1 *
FROM Customers
ORDER BY City
-- DRACD



SELECT TOP 1 *
FROM Customers
ORDER BY Phone -- Sinn?? (nur zur Demo)
-- MAISD




SELECT TOP 10	  CustomerID
				, CompanyName
				, ContactName
				, Phone
FROM Customers
ORDER BY CustomerID



-- mit Prozent - wir müssen PERCENT ausschreiben (% funktioniert NICHT)

SELECT TOP 10 PERCENT *
FROM Customers
ORDER BY CustomerID



SELECT TOP 5 PERCENT  CustomerID
					, CompanyName
					, ContactName
					, Phone
FROM Customers
ORDER BY CustomerID


-- die letzten 3?
SELECT TOP 3  CustomerID
			, CompanyName
			, ContactName
			, Phone
FROM Customers
ORDER BY CustomerID DESC



--SELECT TOP 1 *
--FROM [Order Details]
--ORDER BY UnitPrice DESC

--SELECT TOP 1 PERCENT *
--FROM [Order Details]
--ORDER BY UnitPrice DESC

SELECT TOP 1 PERCENT WITH TIES *
FROM [Order Details]
ORDER BY UnitPrice DESC




-- ********************************************** Übungen:

-- das teuerste Produkt (mit TOP-Befehl gelöst):

SELECT TOP 1 *
FROM Products
ORDER BY UnitPrice DESC

-- das günstigste Produkt:
SELECT TOP 1 *
FROM Products
ORDER BY UnitPrice 



-- die Top 10% der Produkte mit den größten Verkaufsmengen
-- inkl. die, die gleich oft verkauft wurden, wie das letzte in der ursprünglichen Ausgabemenge
SELECT TOP 10 PERCENT WITH TIES *
FROM [Order Details]
ORDER BY Quantity DESC



-- die 3 Mitarbeiter, die schon am längsten beim Unternehmen sind (TOP-Befehl) 
SELECT TOP 3  FirstName
			, LastName
			, CAST((DATEDIFF(dd, HireDate, GETDATE())/365.25) AS decimal(10,2)) AS Zeit
FROM Employees
ORDER BY Zeit DESC

-- mit CONVERT
SELECT TOP 3  FirstName
			, LastName
			, CONVERT(decimal(10,2), (DATEDIFF(dd, HireDate, GETDATE())/365.25)) AS Zeit
FROM Employees
ORDER BY Zeit DESC



-- oder:
SELECT TOP 3  FirstName
			, LastName
			, HireDate
FROM Employees
ORDER BY HireDate -- (ASC! kleinster Wert im Datum liegt am längsten zurück)






-- Annahme: 13 Kunden mit den geringsten Frachtkosten bekommen Bonus
-- Wer sind die Glücklichen?
-- Kunde(n) mit gleichem Wert, wie der 13., bekommen auch Bonus
-- mit Firmenname :)

SELECT TOP 13 WITH TIES   c.CompanyName
						, c.CustomerID
						, o.Freight
FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID
ORDER BY Freight
-- 14 Ergebnisse (1 mehr, der den gleichen Wert hat)







