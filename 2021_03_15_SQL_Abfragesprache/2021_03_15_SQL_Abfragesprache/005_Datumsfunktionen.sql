-- Datumsfunktionen


/*
	-- Datumsintervalle:

		year, yyyy, yy = Jahr
		quarter, qq, q = Quartal
		month, MM, M = Monat
		week, ww, wk = Woche
		day, dd, d = Tag
		hour, hh = Stunde
		minute, mi, n = Minute
		second, ss, s = Sekunde
		millisecond, ms = Millisekunde
		nanosecond, ns = Nanosekunde


		weekday, dw, w = (day of the week) Wochentag
		dayofyear, dy, y = Tag des Jahres


*/


-- ************************* Datum abfragen **************************************

-- auf 3-4 Millisekunden genau
SELECT GETDATE()


-- auf ~ 100 Nanosekunden genau
SELECT SYSDATETIME()



-- ************************************** DATEADD *************************************
-- zum Datum hinzufügen oder wegrechnen



SELECT DATEADD(HH, 10, '2021-03-17') -- 2021-03-17 10:00:00.000 (wenn wir nichts angeben, gehen wir von 0:00 Uhr aus)

SELECT DATEADD(HH, 10, '2021-03-17 14:07') -- 2021-03-18 00:07:00.000



SELECT DATEADD(HH, 10, GETDATE()) -- 2021-03-18 00:08:43.820



-- wie spät war es vor 10 Stunden?
SELECT DATEADD(HH, -10, GETDATE())
-- negative Vorzeichen sind erlaubt!




-- ************************************* DATEDIFF ***************************************
-- Differenz zwischen zwei Daten


-- SELECT DATEDIFF(Intervall, Startdatum, Enddatum)


-- wie viele Tage bis zum nächsten Feiertag:

SELECT DATEDIFF(DD, '2021-03-17', '2021-04-02') -- 16


SELECT DATEDIFF(DD, '2021-04-02', '2021-03-17') -- -16 (mit negativem Vorzeichen!)


SELECT DATEDIFF(DD, GETDATE(), '2021-04-02')




-- ********************************** DATEPART ***************************************+
-- Datumsteile ausgeben
-- Datentyp, der ausgegeben wird: INT! (ganzzahliger numerischer Datentyp)


SELECT DATEPART(DD, GETDATE()) -- 17

SELECT DATEPART(MM, GETDATE()) -- 3



SELECT DATEPART(QQ, GETDATE()) -- 1



-- oder mit DAY, MONTH, YEAR

SELECT DAY('2021-03-17')
SELECT MONTH(GETDATE())
SELECT YEAR(GETDATE())



-- ******************************* DATENAME *************************************

SELECT DATENAME(DD, '2021-03-17') -- 17
-- bringt nicht viel, dafür haben wir schon DATEPART


-- Datename macht eigentlich nur mit diesen beiden Sinn:
SELECT DATENAME(DW, '2021-03-17') -- Wednesday

SELECT DATENAME(MONTH, '2021-03-17') -- March


-- ********************************************** Übungen:

-- Welches Datum haben wir in 38 Tagen?

SELECT DATEADD(DD, 38, GETDATE())



-- .a) Welcher Wochentag war dein Geburtstag?
-- .b) Welcher Wochentag war der Geburtstag der Angestellten der Northwind-DB
		-- Mit Namen der Angestellten (Vor- und Nachname in einem Feld)

-- .a)

SELECT DATENAME(DW, '1981-04-22') -- Wednesday


-- .b)

SELECT	  DATENAME(DW, BirthDate) AS [Day of Birth]
		, CONCAT(FirstName, ' ', LastName) AS EmpName
FROM Employees



-- Vor wievielen Jahren kam der erste Star Wars Film in die Kinos? (25. Mai 1977 )

SELECT DATEDIFF(YY, '1977', GETDATE()) -- 44



-- Wie alt sind unsere Mitarbeiter?

SELECT	  FLOOR(DATEDIFF(DD, BirthDate, GETDATE())/365.25)
FROM Employees



-- In welchem Jahr sind unsere Mitarbeiter eingestellt worden?

SELECT DATEPART(year, HireDate) AS HireDate
FROM Employees


SELECT YEAR(HireDate) AS HireDate
FROM Employees


--SELECT HireDate
--FROM Employees