-- Wildcards



-- im LIKE

/*

	% ................. steht f�r beliebig viele unbekannte Zeichen
	_ ................. (Unterstrich) steht f�r GENAU EIN unbekanntes Zeichen
	[]................. genau 1 Zeichen aus dem in der eckigen Klammer definierten Wertebereich
	| ................. (pipe) steht innerhalb der eckigen Klammern f�r ein ODER
	^ ................. steht innerhalb der eckigen Klammern f�r NOT

*/



SELECT *
FROM Customers
WHERE CustomerID LIKE 'ALF%'

/*
	m�gliche Treffer:

		ALF
		ALFXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		ALFKI

*/


-- alle Kunden, die mit A beginnen:
SELECT *
FROM Customers
WHERE CustomerID LIKE 'A%'
-- 4 Ergebnisse



-- alle, die mit MI enden:
SELECT *
FROM Customers
WHERE CustomerID LIKE '%MI'
-- COMMI



-- alle, die 'kist' im Namen haben:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%kist%'
-- Alfreds Futterkiste



SELECT *
FROM Customers
WHERE Phone LIKE '(5) 555-472_'
-- ANATR



-- Wertebereiche []
-- alle Kunden, die mit a-c beginnen
SELECT *
FROM Customers
WHERE CustomerID LIKE '[a-c]%'
-- 16 Ergebnisse


-- alle Kunden, die mit a oder c beginnen
SELECT *
FROM Customers
WHERE CustomerID LIKE '[ac]%'
-- 9


-- %-Zeichen im Namen?
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[%]%'
-- kein Ergebnis, keiner hat ein %-Zeichen im Namen


-- Suche nach Hochkomma im Namen
SELECT *
FROM Customers
WHERE CompanyName LIKE '%''%' -- Sonderfall! Trick: zweimal Hochkomma hinschreiben, wenn danach gesucht wird
-- 6 Ergebnisse



-- alle, die mit a oder c beginnen und mit m oder e enden:
SELECT *
FROM Customers
WHERE CompanyName LIKE '[ac]%[em]'
-- 2 Ergebnisse




-- ************************************ �bungen:
-- alle, die mit a-c oder e-g enden

SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c]' OR CompanyName LIKE '%[e-g]'
-- 22 Ergebnisse

-- oder so:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c | e-g]'




-- alle Produkte, deren Name mit D-L beginnt und mit a, b, c, d oder m, n, o endet

-- M�glichkeit 1
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%[abcdmno]'
-- 8

-- M�glichkeit 2
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%[a-d | m-o]'


-- M�glichkeit 3
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%' AND ProductName LIKE '%[a-d | m-o]'


-- M�glichkeit 4
-- Vorsicht:
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%' AND (ProductName LIKE '%[a-d]' OR ProductName LIKE '%[m-o]')
-- in diesem Fall m�ssen wir eine Klammer setzen!!





-- NOT ^

SELECT *
FROM Customers
WHERE CompanyName LIKE '[^a-c]%' -- ^ steht innerhalb der eckigen Klammern f�r NOT
-- 75 Ergebnisse
-- nicht sch�n!



-- alle Kunden, die mit d, e oder f beginnen, der letzte Buchstabe ist ein L und der drittletzte ist ein d

SELECT *
FROM Customers
WHERE CompanyName LIKE '[d-f]%d_l'


/*

	ddxl
	edel
	fidel
	fxxxxxxxxxxdxl


	Ernst Handel (in Northwind DB)
	E........d.l



*/



-- alle Produkte, wo im Namen 'ost' vorkommt
SELECT *
FROM Products
WHERE ProductName LIKE '%ost%'
-- 7 Ergebnisse


