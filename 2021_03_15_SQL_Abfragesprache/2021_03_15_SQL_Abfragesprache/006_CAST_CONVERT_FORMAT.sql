-- CAST, CONVERT und FORMAT
-- in welchem Format und in welchem Datentyp wollen wir etwas darstellen


/*

	-- String Datentypen

		char(n)
		varchar(n)

		nchar(n)
		nvarchar(n)


	-- numerische Datentypen

		bit  0, 1, NULL
		int (tinyint, smallint, bigint)
		float
		decimal(10, 2)

		money


	-- Datumsdatentypen
		
		datetime (auf 3-4 ms genau)
		datetime2 (auf ~100 ns genau)
		date
		time

	boolean (bool)  true/false

*/





-- ******************************* CAST **********************************************
-- Umwandeln von Datentypen

-- funktioniert:
SELECT '123' + 2 -- 125


-- funktioniert NICHT:
SELECT '123.5' + 2
-- Conversion failed when converting the varchar value '123.5' to data type int.


-- wir müssten selbst vorher eine Konvertierung durchführen:
SELECT CAST('123.5' AS float) + 2 -- 125,5



/*
	implizite und explizite Konvertierung in der Microsoft-Dokumentation:
	https://docs.microsoft.com/de-de/sql/t-sql/data-types/data-type-conversion-database-engine?view=sql-server-ver15
*/


-- mit CAST allein haben wir keinen Einfluss auf das Format!
SELECT CAST(SYSDATETIME() AS varchar) -- 2021-03-17 15:38:12.7993938

SELECT CAST(GETDATE() AS varchar) -- Mar 17 2021  3:38PM




-- nicht empfehlenswert!!!
SELECT CAST('2021-03-17' AS date)  -- Achtung! Systemabhängig könnte hier auch der Monat als Tag und umgekehrt interpretiert werden!!
-- Oder Fehlermeldung, weil Jahr nicht als Tag/Monat interpretiert werden kann




-- ********************************** CONVERT *****************************************
-- Datentypen konvertieren (umwandeln)
-- zusätzliche Optionen mit Style-Parameter


SELECT CONVERT(float, '123.5')

-- funktioniert auch mit Datum
SELECT CONVERT(varchar, SYSDATETIME()) -- 2021-03-17 15:46:48.4743088

SELECT CONVERT(varchar, GETDATE()) -- Mar 17 2021  3:47PM


-- mit CONVERT können wir für das Datum einen sog. Style-Parameter angeben:

SELECT CONVERT(varchar, SYSDATETIME(), 104) -- 17.03.2021


-- Date und Time Styles in der Microsoft Dokumentation:
/*
	https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017#date-and-time-styles
*/



SELECT    CONVERT(varchar, SYSDATETIME(), 101) AS US
		, CONVERT(varchar, SYSDATETIME(), 103) AS GB
		, CONVERT(varchar, SYSDATETIME(), 104) AS DE





-- ********************************** FORMAT *****************************************************
-- Daten in ein bestimmtes Format bringen
-- Culture-Parameter


SELECT FORMAT(1234567890, '###-###/##-##') -- 123-456/78-90


-- mit Datum:

SELECT FORMAT(GETDATE(), 'dd.MM.yyyy') -- 17.03.2021

-- ACHTUNG!!!!
SELECT FORMAT(GETDATE(), 'dd.mm.yyyy') -- 17.57.2021 -- wenn klein geschrieben, wird mm fälschlicherweise als MINUTE interpretiert!!!


-- Vorsicht:
SELECT FORMAT('2021-03-17', 'dd.MM.yyyy')
-- Argument data type varchar is invalid for argument 1 of format function.



-- Culture-Parameter:

SELECT FORMAT(SYSDATETIME(), 'd', 'de-de') -- 17.03.2021


/*
	-- Culture-Parameter in der Microsoft-Dokumentation:
	https://docs.microsoft.com/de-de/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes
*/





SELECT    FORMAT(SYSDATETIME(), 'd', 'de-de') AS DE
		, FORMAT(SYSDATETIME(), 'd', 'en-us') AS US
		, FORMAT(SYSDATETIME(), 'd', 'en-gb') AS GB


-- kleines 'd' bedeutet: Datum in Zahlen
-- großes 'D' bedeutet: Datum, wo möglich, als Text ausgeschrieben


SELECT    FORMAT(SYSDATETIME(), 'D', 'de-de') AS DE
		, FORMAT(SYSDATETIME(), 'D', 'en-us') AS US
		, FORMAT(SYSDATETIME(), 'D', 'en-gb') AS GB




SELECT    FORMAT(SYSDATETIME(), 'd', 'de-de') AS DE
		, FORMAT(SYSDATETIME(), 'd', 'en-us') AS US
		, FORMAT(SYSDATETIME(), 'd', 'en-gb') AS GB
		, FORMAT(SYSDATETIME(), 'd', 'sv') AS Schweden




SELECT    FORMAT(ShippedDate, 'D', 'de-de') AS DE
		, FORMAT(ShippedDate, 'D', 'de-at') AS AT
		, FORMAT(ShippedDate, 'D', 'en-us') AS US
		, FORMAT(ShippedDate, 'D', 'en-gb') AS GB
FROM Orders