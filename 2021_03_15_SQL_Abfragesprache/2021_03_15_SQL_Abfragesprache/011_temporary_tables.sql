-- temporary tables
-- tempor�re Tabellen


/*
	
	-- lokale tempor�re Tabellen
		-- existiert nur in der aktuellen Session
			#tablename



	-- globale tempor�re Tabellen
		-- Zugriff auch von anderen Sessions
			##tablename

	

	-- h�lt nur so lange, wie Session aufrecht ist/ Verbindung da ist

	-- kann auch gel�scht werden



*/



SELECT CustomerID, Freight
INTO #t1
FROM Orders


SELECT *
FROM #t1



SELECT ProductID, ProductName
INTO ##t1
FROM Products


SELECT *
FROM ##t1




