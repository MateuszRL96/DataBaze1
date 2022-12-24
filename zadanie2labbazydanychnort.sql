--lab2. 
--Zad1 (a) Spoœród klientów z Londynu wybierz tych których nazwa zaczyna na siê na A, B lub C,
SELECT *
From Customers
WHERE City = 'London'
AND
(ContactName LIKE 'A%' or ContactName LIKE 'B%' OR ContactName LIKE 'c%')

--zad1 (b) Wyœwietl informacje o zamówieniach z czerwca 1996 obs³ugiwanych na wschodzie, których wartoœæ
--przekroczy³a œredni¹ wartoœæ wszystkich zamówieñ,
SELECT OD.OrderID, AVG(OD.UnitPrice*OD.Quantity) AS SREDNIA
From [Order Details] AS OD INNER JOIN Orders as O
ON OD.OrderID=O.OrderID
WHERE MONTH(O.OrderDate) = 7 AND YEAR(O.OrderDate) = 1996
GROUP BY OD.OrderID
HAVING AVG(OD.UnitPrice*OD.Quantity) > 
(SELECT AVG(OD1.UnitPrice*OD1.Quantity)
FROM [Order Details] AS OD1)

--zmieniono miesiac na lipiec poniewaz w czerwcu nie bylo jeszcze zamowien

--zad1 (c) ZnaleŸæ produkty o cenach najni¿szych w swoich kategoriach,
SELECT CategoryID, Min(UnitPrice) cena_minimalna 
FROM Products 
group BY CategoryID

--zad1 (d) Podaj ilu pracowników mieszka w takich samych miastach,

SELECT SUM(AAA.liczbaPracownikow) AS 'iluu mieszka w tym samym'
FROM
(SELECT City, count(City) as 'liczbaPracownikow'
FROM dbo.Employees
GROUP BY City
HAVING count(City) > 1) AS AAA


--zad1 (e) Wskazaæ produkt, którego nikt inny nie zamawia³,
SELECT AAA.ProductName, COUNT(ProductID) AS 'Ile'
FROM (select Products.ProductName, [Order Details]
.ProductID
from [Order Details]
inner join Products
ON Products.ProductID = [Order Details]
.ProductID) AS AAA
Group by ProductName
having COUNT(ProductID) < 10
ORDER BY ProductName; 


select ile, P.productid, ProductName from Products as P
inner join (select count(Customerid) as ile,  OD.Productid from [dbo].[Order Details] as OD
inner join Orders as O
on O.Orderid = OD.OrderID 
group by productid) as AA
ON AA.productid = P.productid
where ile < 10
order by productname
/* wskazuje produkt którego zamowien by³o ponizej 10 */

--zad1 (f) Którzy klienci najczêœciej zamawiali produkty,
/*
SELECT *
from(select count(AAA.CustomerID) AS 'ile', CustomerID, CompanyName
from(SELECT [Order Details]
.ProductID, Orders.CustomerID, Customers.CompanyName
FROM Orders
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details]
.OrderID
INNER JOIN Customers ON Customers.CustomerID = Orders.CustomerID) as AAA
GROUP BY CompanyName, CustomerID) AS BBB
WHERE BBB.ile = (select max(BBB.ile) as najwiecej
from
(select count(AAA.CustomerID) AS 'ile', CustomerID, CompanyName
from(SELECT [Order Details]
.ProductID, Orders.CustomerID, Customers.CompanyName
FROM Orders
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details]
.OrderID
INNER JOIN Customers ON Customers.CustomerID = Orders.CustomerID) as AAA
GROUP BY CompanyName, CustomerID) as BBB)
*/

--------------
create view[lab2zad1f] as
select count(Orderid) as ile,  Customerid from Orders
group by Customerid
------------------
select * from lab2zad1f
where ile = (select max(ile) as najwiecej
from
(select count(Orderid) as ile,  Customerid from Orders
group by Customerid) as AA);


--zad1 (g) Napisz kwerendê, która zwróci listê miast, w których mieszkaj¹ zarówno klienci, jak i pracownicy.
SELECT DISTINCT E.City
FROM Employees AS E
WHERE EXISTS (
SELECT C.City
FROM Customers AS C
WHERE E.City=C.City)

