-- DISTINCT


-- Liste von allen Ländern, in die wir liefern?

-- das gibt uns den Country-Eintrag für jeden einzelnen Kunden aus!
SELECT Country
FROM Customers
-- 91

-- Lösung:
SELECT DISTINCT Country
FROM Customers
-- 21




SELECT DISTINCT Country, City
FROM Customers
-- 69
-- so viele Ergebnisse, wie Cities vorhanden sind (Länder, in denen mehr als eine Stadt vorhanden ist, müssen wieder mehrfach ausgegeben werden)



-- bringt nix:
SELECT DISTINCT Country, City, CustomerID
FROM Customers
-- wieder so viele Ergebnisse, wie es insgesamt Kunden gibt!!!



-- Länder, in denen Angestellte wohnen:
SELECT DISTINCT Country
FROM Employees
-- UK, USA




