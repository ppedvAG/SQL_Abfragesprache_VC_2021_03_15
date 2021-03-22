-- temporary tables
-- temporäre Tabellen


/*
	
	-- lokale temporäre Tabellen
		-- existiert nur in der aktuellen Session
			#tablename



	-- globale temporäre Tabellen
		-- Zugriff auch von anderen Sessions
			##tablename

	

	-- hält nur so lange, wie Session aufrecht ist/ Verbindung da ist

	-- kann auch gelöscht werden



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




