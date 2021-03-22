-- Tabellenabfragen

-- immer überprüfen, ob wir in der richtigen DB sind!
USE Northwind;
GO  -- Batch Delimiter




SELECT *
FROM Employees



SELECT FirstName, LastName
FROM Employees


-- zwecks Lesbarkeit Spaltennamen untereinander schreiben:

SELECT FirstName, 
--	   LastName
FROM Employees

-- Fehlermeldung wegen Komma nach der "letzten" Spalte




-- noch ein bisschen besser:
SELECT	  FirstName
--		, LastName
FROM Employees
-- mit Komma in der nächsten Zeile können wir auch die letzte Zeile auskommentieren, ohne eine Fehlermeldung zu bekommen



-- ALIAS (Spaltenüberschrift für Textausgabe)
SELECT	  EmployeeID AS Mitarbeiternummer
		, FirstName AS Vorname
		, LastName AS Nachname
		, HomePhone AS Telefonnummer
FROM Employees




-- von Bestellungen Bestellnummer, welcher Kunde (CustomerID), welcher Angestellte (EmployeeID) hat verkauft, in welches Land ist geliefert worden?

SELECT	  OrderID AS Bestellnr	
		, CustomerID AS KNr
		, EmployeeID AS MANr
		, ShipCountry AS Land
FROM Orders



-- Kontaktinformation von den Kunden:
SELECT	  CustomerID
		, CompanyName
		, ContactName
		, ContactTitle
		, Address
		, City
		, Region
		, PostalCode
		, Country
		, Phone
		, Fax
FROM Customers



-- welche Produkte haben wir? ProduktID, Name, Stückpreis
SELECT	  ProductID
		, ProductName
		, UnitPrice
FROM Products




-- einfache Abfragen


-- Zahlen ausgeben
SELECT 100


-- Text ausgeben
SELECT 'Testtext'


-- Berechnung
SELECT 100*3


-- Vorsicht: das wird nicht berechnet, das ist Text
SELECT '100*3'



SELECT	  100
		, 'Testtext'
		, 100*3


-- mit ALIAS:
SELECT	  100 AS Zahl
		, 'Testtext' AS Text
		, 100*3 AS Berechnung




-- Bsp.:
SELECT	  Freight * 3 AS [Frachtkosten * 3]
--		, Freight
FROM Orders
-- wenn Leerzeichen im Namen, dann in eckige Klammern setzen!


