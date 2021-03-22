-- DISTINCT


-- Liste von allen L�ndern, in die wir liefern?

-- das gibt uns den Country-Eintrag f�r jeden einzelnen Kunden aus!
SELECT Country
FROM Customers
-- 91

-- L�sung:
SELECT DISTINCT Country
FROM Customers
-- 21




SELECT DISTINCT Country, City
FROM Customers
-- 69
-- so viele Ergebnisse, wie Cities vorhanden sind (L�nder, in denen mehr als eine Stadt vorhanden ist, m�ssen wieder mehrfach ausgegeben werden)



-- bringt nix:
SELECT DISTINCT Country, City, CustomerID
FROM Customers
-- wieder so viele Ergebnisse, wie es insgesamt Kunden gibt!!!



-- L�nder, in denen Angestellte wohnen:
SELECT DISTINCT Country
FROM Employees
-- UK, USA




