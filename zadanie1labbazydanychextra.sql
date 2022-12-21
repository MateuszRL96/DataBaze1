 --zad2/h

SELECT COUNT(*) from [dbo].[Customers]
SELECT COUNT(*) from [dbo].[Nums]
SELECT COUNT(*) from [dbo].[OrderDetails]
SELECT COUNT(*) from [dbo].[Orders]
SELECT COUNT(*) from [HR].[Employees]
SELECT COUNT(*) from [Production].[Categories]
SELECT COUNT(*) from [Production].[Products]
SELECT COUNT(*) from [Production].[Suppliers]
SELECT COUNT(*) from [Sales].[Customers]
SELECT COUNT(*) from [Sales].[OrderDetails]
SELECT COUNT(*) from [Sales].[Orders]
SELECT COUNT(*) from [Sales].[Shippers]
SELECT COUNT(*) from [Stats].[Scores]
SELECT COUNT(*) from [Stats].[Tests]

--zad5 (a) Zwr�ci� zam�wienia z�o�one w czerwcu 2015
--U�yte tabele: Sales.Ordersselect orderid, orderdate, custid, empidfrom Sales.Orderswhere year(orderdate) = 2015 and month(orderdate) = 6;--zad5 (b) Zwr�ci� zam�wienia z�o�one ostatniego dnia miesi�ca
--U�yte tabele: Sales.Orders
select * from Sales.Orders
where day(orderdate) = 31
--do poprawy!!!!!!!!!!!!!!!!!!!

--zad5 (c) Zwr�ci� pracownik�w, kt�rych nazwisko zawiera liter� �e� co najmniej dwukrotnie
-- U�yte tabele: HR.Employees table

select empid, firstname, lastname 
from [HR].[Employees]
where lastname like 'e%e' or lastname like '%e%e' or lastname like 'e%e%' or lastname like '%e%e%';

--zad5 (d) Zwr�ci� zam�wienia, kt�rych ca�kowita warto�� (qty*unitprice) jest wi�ksza ni� 10000, posortowane wed�ug warto�ci ca�kowitej
-- U�yte tabele: Sales.OrderDetails table

select orderid, qty*unitprice as totalvalue
from Sales.OrderDetails
where qty*unitprice > 10000
order by totalvalue desc

--zad5 (e)Napisz zapytanie do tabeli HR.Employees, kt�re zwraca pracownik�w, kt�rych nazwisko zaczyna
--si� od ma�ej litery. Przypomnijmy, �e ustawienie collation przyk�adowej bazy danych nie rozr�nia
--wielko�ci liter (Latin1 General CI AS).
--U�yte tabele: Sales.OrderDetails table

select * from Sales.OrderDetails

select left(LastName, 1) from HR.Employees

SELECT ASCII(AA.A1) AS NumCodeOfFirstChar
FROM (select left(LastName, 1) as A1 from HR.Employees) as AA
where ASCII(AA.A1) between 97 and 122 

--zad5 (f) Wyja�ni� r�nic� pomi�dzy zapytaniami

SELECT empid , COUNT(*) AS numorders
FROM Sales.Orders
WHERE orderdate < '2016050'
GROUP BY empid ;  ---nie !!!!!!!!!!!!!!!!!!!!!!!!!!
----------------------------------------
SELECT empid , COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY empid
HAVING MAX(orderdate) < '20160501' ;

--zad5 (g) Napisa� zapytanie do tabeli Sales.Orders, zwracaj�ce trzy kraje, do kt�rych wysy�ka produkt�w
--mia�a najwy�sz� �redni� warto�� w roku 2015.

select top 3 shipcountry, avg(freight) as avgfreight from (
select * from Sales.Orders
where year(orderdate) = 2015) as AA
group by shipcountry
order by avgfreight desc

--zad5 (h) Wyznaczy� numery wierszy na podstawie daty zam�wienia (u�ywaj�c orderid jako kryterium
--ujednoznaczniaj�cego) dla ka�dego klienta oddzielnie
-- U�yte tabele: Sales.Orders tableselect custid, orderdate, orderid,	ROW_NUMBER() OVER(PARTITION BY O.custid order by custid) AS Rownumfrom Sales.Orders as O--zad5 (i) Odnale�� i zwr�ci� p�e� pracownika na podstawie tytu�u grzeczno�ciowego Ms., Mrs. - Female,
--Mr. - Male, Dr. - Unknown
-- U�yte tabele: HR.Employees tableSELECT empid, firstname, lastname, titleofcourtesy,
CASE
    WHEN titleofcourtesy = 'Mrs.' THEN 'Famele'
	WHEN titleofcourtesy = 'Ms.'  THEN 'Famele'
    WHEN titleofcourtesy = 'Mr.' THEN 'Male'
    WHEN titleofcourtesy = 'Dr.' THEN 'Unknow'
END AS gender
FROM HR.Employees;

--zad5 (j) Dla ka�dego klienta zwr�ci� identyfikator klienta i region. Posortowa� wiersze w danych wyj�ciowych wed�ug regionu, przy czym znaczniki NULL maj� by� umieszczone jako ostatnie (po
--warto�ciach innych ni� NULL). Pami�tajmy, �e domy�lne sortowanie znacznik�w NULL w j�zyku
--T-SQL zak�ada sortowanie tych znacznik�w w pierwszej kolejno�ci (przed warto�ciami innymi ni�
--NULL).
-- U�yte tabele: Sales.Customers table

select custid, region from Sales.Customers


SELECT custid, region
FROM Sales.Customers
ORDER BY CASE
    WHEN region IS NULL THEN 1
        ELSE 0
    END,
region