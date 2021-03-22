-- Procedures (Prozeduren)


-- Variablen

/*
	-- @varname
	-- welcher Datentyp?

	-- nur solange der Batch läuft
	-- Zugriff nur innerhalb der Session, wo sie erstellt wurde


	DECLARE @varname AS Datentyp

	Bsp.: DECLARE @test AS int = 100



*/


DECLARE @test AS int

SET @test = 100

SELECT @test





CREATE PROC p_AllCustomers @City varchar(30)
AS
SELECT *
FROM Customers
WHERE City = @City
GO



EXEC p_AllCustomers @City = 'Salzburg'




CREATE PROC p_Customers_City_Country @City varchar(30), @Country varchar(30)
AS
SELECT *
FROM Customers
WHERE City = @City AND Country = @Country
GO



EXEC p_Customers_City_Country @City = 'Berlin', @Country = 'Germany'


