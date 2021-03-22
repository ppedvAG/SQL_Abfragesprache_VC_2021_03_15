-- häufig verwendete Serverfunktionen


-- ******************************** TRIM, LEN, DATALENGTH ****************************************


SELECT 'Test'


-- z.B. wenn ein Eintrag mit Leerzeichen aufgefüllt wurde

SELECT 'Test    '


SELECT '     Test    '


-- LEN = length (wieviele Zeichen)

SELECT LEN('Test') -- 4


SELECT LEN('Test    ') -- LEN ignoriert Leerzeichen am Ende!


SELECT LEN('   Test') -- LEN zählt Leerzeichen am Anfang mit


SELECT LEN('Test Text') -- LEN zählt Leerzeichen in der Mitte mit



SELECT DATALENGTH('Test') -- 4


SELECT DATALENGTH('Test    ') -- 8 (zählt Leerzeichen am Ende mit)



-- Achtung bei Unicode: doppelt so viel wie Zeichen
SELECT DATALENGTH(CustomerID)
FROM Customers
-- 10

-- TRIM schneidet unerwünschte Leerzeichen weg

-- LTRIM schneidet Leerzeichen am Anfang (links) weg
SELECT LTRIM('   Test')

-- RTRIM schneidet Leerzeichen am Ende (rechts) weg
SELECT RTRIM('Test     ')

-- TRIM schneidet Leerzeichen am Anfang und Ende weg
SELECT TRIM('    Test     ')



SELECT DATALENGTH(TRIM('    Test     ')) -- 4



SELECT TRIM(CustomerID) AS CustomerID
FROM Customers



-- ********************************** REVERSE *******************************************
-- Inhalt in umgekehrter Reihenfolge ausgeben:

SELECT REVERSE('REITTIER')

SELECT REVERSE('Trug Tim eine so helle Hose nie mit Gurt?')



-- ********************************** LEFT, RIGHT, SUBSTRING *********************************************

-- Zeichen "ausschneiden"


SELECT LEFT('Testtext', 4) -- Test
-- 1. Parameter: wovon möchten wir ausschneiden
-- 2.: wie viele Zeichen?


SELECT RIGHT('Testtext', 4) -- text


-- Substring ist präziser: Textausschnitt erstellen von beliebiger Stelle ausgehend:

SELECT SUBSTRING('Testtext', 4, 2) -- tt
-- wovon möchten wir ausschneiden
-- von welcher Stelle beginnend (4)
-- wie viele Zeichen (2)



-- ************************************** STUFF *************************************************
-- Text einfügen oder ersetzen ('reinstopfen')

SELECT STUFF('Testtext', 5, 0, '_')
-- wo möchte ich einfügen oder ersetzen
-- beginnend bei welcher Stelle
-- wie viele Zeichen sollen weggelöscht werden (0, wenn man nichts löschen möchte)
-- was soll eingefügt werden




/*
	Ziel: Üben von String Funktionen
	Aufgabenstellung: Die letzten drei Stellen einer Telefonnummer sollen durch xxx ersetzt werden.
	Bonus: die Lösung soll unabhängig von der Länge der Telefonnummer funktionieren
	TIPPS:
	•	Beginnen Sie zunächst mit der Zahlenfolge 1234567890. Wenn es damit funktioniert, versuchen Sie, die Anzahl der Zeichen zu verändern und die Abfrage so umzuformulieren, dass sie unabhängig von der Anzahl der Ziffern funktioniert. Testen Sie es an den Telefonnummern der Kunden in der Customers-Tabelle.
	•	Serverfunktionen können miteinander verschachtelt werden.
	•	Es gibt mehrere Möglichkeiten, diese Aufgabe umzusetzen. Hilfreiche Funktionen für diese Aufgabenstellung sind z.B. CONCAT, LEFT, LEN, STUFF und/oder REVERSE.

*/


SELECT 'Test' + 'text'


-- Möglichkeit 1
SELECT LEFT('1234567890', 7) + 'xxx' -- nur für Telefonnummern mit gleicher Länge

-- Möglichkeit 2
SELECT STUFF('1234567890', 8, 3, 'xxx') -- nur für Telefonnummern mit gleicher Länge

-- Möglichkeit 3
SELECT LEN('1234567890') -- 10
-- von dieser Zahl 3 abziehen
SELECT LEFT('1234567890', LEN('1234567890')-3) + 'xxx' -- funktioniert unabhängig von Anzahl der Zeichen

-- mit DB-Abfrage:
SELECT    Phone
		, LEFT(Phone, LEN(Phone)-3) + 'xxx'
FROM Customers


-- Möglichkeit 4

SELECT STUFF(REVERSE('1234567890'), 1, 3, 'xxx')
-->
SELECT REVERSE(STUFF(REVERSE('1234567890'), 1, 3, 'xxx'))



-- mit DB:
SELECT    REVERSE(STUFF(REVERSE(Phone), 1, 3, 'xxx')) AS PhoneX
-- 		, Phone  -- zum Testen, ob es funktioniert hat
FROM Customers



-- ************************************** CONCAT **********************************************

-- Strings zusammenfügen

SELECT CONCAT('abc', 'def', 'ghi')

SELECT CONCAT('Ich weiß, ', 'dass ich', ' nichts weiß.') AS Zitat


SELECT CONCAT('James', ' ', 'Bond')

-- mit DB:
SELECT CONCAT(FirstName, ' ', LastName) AS EmpName
FROM Employees


SELECT ContactName
FROM Customers


-- **************************************** REPLICATE *****************************************
-- Zeichen mehrfach ausgeben


SELECT REPLICATE('?', 5) -- ?????

SELECT REPLICATE('x', 3) -- xxx

SELECT REPLICATE('abc', 3) -- abcabcabc




-- ********************************** Groß- und Kleinbuchstaben


SELECT UPPER('test') -- TEST

SELECT LOWER('TEST') -- test





-- ****************************************** CHARINDEX ****************************************

-- an welcher Stelle befindet sich ein gesuchtes Zeichen oder Zeichenfolge?
-- CHARINDEX gibt das erste Vorkommen des gesuchten Zeichens aus 

SELECT CHARINDEX('a', 'Leo') -- 0 (wenn es nicht vorkommt)


SELECT CHARINDEX('e', 'Leo') -- 2 (befindet sich an der 2. Stelle)


SELECT CHARINDEX('f', 'ALFKI') -- 3
SELECT CHARINDEX('F', 'ALFKI') -- 3


-- Suchen nach Zeichenfolgen:
SELECT CHARINDEX('schnecke', 'Zuckerschnecke')


-- Leerzeichen gesucht
SELECT CHARINDEX(' ', 'James Bond') -- 6

-- mit DB:

SELECT CHARINDEX(' ', ContactName)
FROM Customers



-- An welcher Stelle befindet sich das letzte Leerzeichen in "Wolfgang Amadeus Mozart"?

SELECT LEN('Wolfgang Amadeus Mozart') - CHARINDEX(' ', REVERSE('Wolfgang Amadeus Mozart')) + 1 -- 17
SELECT LEN('Georg Friedrich Händel') - CHARINDEX(' ', REVERSE('Georg Friedrich Händel')) + 1 -- 16



-- ************************************** REPLACE **************************************

SELECT REPLACE('Hallo!', 'a', 'e')
-- wo möchten wir etwas ersetzen
-- was möchten wir ersetzen
-- wodurch möchten wir ersetzen


SELECT REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?')

SELECT REPLACE(REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?'), 'H', 'B')


SELECT REPLACE('Hallihallo!', 'a', 'e')