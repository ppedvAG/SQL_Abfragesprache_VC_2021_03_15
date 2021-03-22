-- CREATE, INSERT, UPDATE, DELETE

-- DROP DATABASE IF EXISTS Test

CREATE DATABASE Test

USE Test



CREATE TABLE Produkte (
							ProduktID int identity(1, 1), -- default(1, 1) ; macht auch NOT NULL und UNIQUE
							ProduktName nvarchar(50),
							Preis money
						--	....
						-- .....
						)


-- VORSICHT: DROP- Befehl l�scht gesamte Tabelle inklusive Inhalt!!!
-- DROP TABLE Produkte


-- einf�gen:
-- INSERT INTO


-- keine gute Idee:
INSERT INTO Produkte
VALUES (1, 'Spaghetti', 1.99)

-- Problem:
INSERT INTO Produkte
VALUES (1.99, 'Spaghetti')

-- besser:
-- in welche Spalten soll die Information eingef�gt werden:
INSERT INTO Produkte (ProduktName, Preis)
VALUES ('Spaghetti', 1.99)

-- das funktioniert:
INSERT INTO Produkte (Preis, ProduktName)
VALUES (1.99, 'Spaghetti')



-- mehrere Produkte auf einmal einf�gen:
INSERT INTO Produkte (ProduktName, Preis)
VALUES    ('Spaghetti', 1.99)
		, ('Profiterols', 4.99)
		, ('Tiramisu', 3.99)
		, ('Pizza Margherita', 6.99)
		, ('Limoncello', 3.99)


SELECT *
FROM Produkte



-- Produkte rausl�schen mit DELETE
-- ACHTUNG: Immer mit WHERE einschr�nken, sonst l�schen wir den gesamten Inhalt der Tabelle
-- im Gegensatz zu DROP ist die Tabelle selbst noch da, aber der Inhalt ist dann weg
DELETE FROM Produkte
WHERE ProduktID = 3



DELETE FROM Produkte
WHERE ProduktID IN(4, 9)



-- Inhalt ver�ndern mit UPDATE
-- auch hier immer mit WHERE einschr�nken!
-- sonst haben ALLE Produkte diesen Preis!
UPDATE Produkte
SET Preis = 5.50
WHERE ProduktID = 6





-- Tabelle selbst ver�ndern mit ALTER TABLE:
-- Spalte hinzuf�gen mit ADD:
ALTER TABLE Produkte
ADD Email nvarchar(30)


-- Spalte rausl�schen mit DROP COLUMN:
ALTER TABLE Produkte
DROP COLUMN Email


SELECT *
FROM Produkte




-- Schl�ssel vergeben:

CREATE TABLE Customers (
							CustomerID int identity PRIMARY KEY,
							CompanyName nvarchar(30),
							ContactName nvarchar(20)
							-- ......
						)

CREATE TABLE Orders (
						OrderID int identity PRIMARY KEY,
						CustomerID int,
						OrderDate date
						-- .....
					)


ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)



SELECT *
INTO TestEmployees
FROM Northwind.dbo.Employees

ALTER TABLE TestEmployees
ADD CONSTRAINT PK_TestEmployees PRIMARY KEY (EmployeeID)


SELECT *
FROM TestEmployees

