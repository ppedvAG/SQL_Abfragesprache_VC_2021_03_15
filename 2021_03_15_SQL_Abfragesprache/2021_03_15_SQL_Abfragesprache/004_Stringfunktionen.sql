-- h�ufig verwendete Serverfunktionen


-- ******************************** TRIM, LEN, DATALENGTH ****************************************


SELECT 'Test'


-- z.B. wenn ein Eintrag mit Leerzeichen aufgef�llt wurde

SELECT 'Test    '


SELECT '     Test    '


-- LEN = length (wieviele Zeichen)

SELECT LEN('Test') -- 4


SELECT LEN('Test    ') -- LEN ignoriert Leerzeichen am Ende!


SELECT LEN('   Test') -- LEN z�hlt Leerzeichen am Anfang mit


SELECT LEN('Test Text') -- LEN z�hlt Leerzeichen in der Mitte mit



SELECT DATALENGTH('Test') -- 4


SELECT DATALENGTH('Test    ') -- 8 (z�hlt Leerzeichen am Ende mit)



-- Achtung bei Unicode: doppelt so viel wie Zeichen
SELECT DATALENGTH(CustomerID)
FROM Customers
-- 10

-- TRIM schneidet unerw�nschte Leerzeichen weg

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
-- 1. Parameter: wovon m�chten wir ausschneiden
-- 2.: wie viele Zeichen?


SELECT RIGHT('Testtext', 4) -- text


-- Substring ist pr�ziser: Textausschnitt erstellen von beliebiger Stelle ausgehend:

SELECT SUBSTRING('Testtext', 4, 2) -- tt
-- wovon m�chten wir ausschneiden
-- von welcher Stelle beginnend (4)
-- wie viele Zeichen (2)



-- ************************************** STUFF *************************************************
-- Text einf�gen oder ersetzen ('reinstopfen')

SELECT STUFF('Testtext', 5, 0, '_')
-- wo m�chte ich einf�gen oder ersetzen
-- beginnend bei welcher Stelle
-- wie viele Zeichen sollen weggel�scht werden (0, wenn man nichts l�schen m�chte)
-- was soll eingef�gt werden




/*
	Ziel: �ben von String Funktionen
	Aufgabenstellung: Die letzten drei Stellen einer Telefonnummer sollen durch xxx ersetzt werden.
	Bonus: die L�sung soll unabh�ngig von der L�nge der Telefonnummer funktionieren
	TIPPS:
	�	Beginnen Sie zun�chst mit der Zahlenfolge 1234567890. Wenn es damit funktioniert, versuchen Sie, die Anzahl der Zeichen zu ver�ndern und die Abfrage so umzuformulieren, dass sie unabh�ngig von der Anzahl der Ziffern funktioniert. Testen Sie es an den Telefonnummern der Kunden in der Customers-Tabelle.
	�	Serverfunktionen k�nnen miteinander verschachtelt werden.
	�	Es gibt mehrere M�glichkeiten, diese Aufgabe umzusetzen. Hilfreiche Funktionen f�r diese Aufgabenstellung sind z.B. CONCAT, LEFT, LEN, STUFF und/oder REVERSE.

*/


SELECT 'Test' + 'text'


-- M�glichkeit 1
SELECT LEFT('1234567890', 7) + 'xxx' -- nur f�r Telefonnummern mit gleicher L�nge

-- M�glichkeit 2
SELECT STUFF('1234567890', 8, 3, 'xxx') -- nur f�r Telefonnummern mit gleicher L�nge

-- M�glichkeit 3
SELECT LEN('1234567890') -- 10
-- von dieser Zahl 3 abziehen
SELECT LEFT('1234567890', LEN('1234567890')-3) + 'xxx' -- funktioniert unabh�ngig von Anzahl der Zeichen

-- mit DB-Abfrage:
SELECT    Phone
		, LEFT(Phone, LEN(Phone)-3) + 'xxx'
FROM Customers


-- M�glichkeit 4

SELECT STUFF(REVERSE('1234567890'), 1, 3, 'xxx')
-->
SELECT REVERSE(STUFF(REVERSE('1234567890'), 1, 3, 'xxx'))



-- mit DB:
SELECT    REVERSE(STUFF(REVERSE(Phone), 1, 3, 'xxx')) AS PhoneX
-- 		, Phone  -- zum Testen, ob es funktioniert hat
FROM Customers



-- ************************************** CONCAT **********************************************

-- Strings zusammenf�gen

SELECT CONCAT('abc', 'def', 'ghi')

SELECT CONCAT('Ich wei�, ', 'dass ich', ' nichts wei�.') AS Zitat


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




-- ********************************** Gro�- und Kleinbuchstaben


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
SELECT LEN('Georg Friedrich H�ndel') - CHARINDEX(' ', REVERSE('Georg Friedrich H�ndel')) + 1 -- 16



-- ************************************** REPLACE **************************************

SELECT REPLACE('Hallo!', 'a', 'e')
-- wo m�chten wir etwas ersetzen
-- was m�chten wir ersetzen
-- wodurch m�chten wir ersetzen


SELECT REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?')

SELECT REPLACE(REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?'), 'H', 'B')


SELECT REPLACE('Hallihallo!', 'a', 'e')