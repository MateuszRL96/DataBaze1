--zad2 (a) Napisz zapytanie, które generuje po piêæ kopii ka¿dego wiersza pracownika.
select empid, firstname, lastname, n
from HR.Employees, Nums
WHERE n < 6
Order By n;


--zad2 (b) Napisz zapytanie, które zwraca wiersz dla ka¿dego pracownika i dla ka¿dego dnia z zakresu 12 czerwca 2016 do 16 czerwca 2016.

SELECT E.empid, DATEADD(day, N.n-1, CAST(
'20160612' AS Date)
) AS DT
FROM HR.Employees E CROSS JOIN Nums N
WHERE N.n <= DATEDIFF(day, '20160612', '20160616'
) +1
ORDER BY 1, 2

--zad2 (c) Wyjaœnij, na czym polega b³¹d w poni¿szym zapytaniu i zaproponuj w³aœciwe rozwi¹zanie.
/*
SELECT Customers . c u s ti d , Customers . companyname , Orders . o r d e ri d ,
Orders . o r d e r d a t e
FROM S al e s . Customers AS C
INNER JOIN S al e s . Orders AS O
ON Customers . c u s t i d = Orders . c u s t i d ;*/

SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
INNER JOIN Sales.Orders AS O
On C.custid = O.custid;
/* Poprawiony kod
Bledem jest odwolywanie sie do starych nazw tabel po nadaniu im nowych nazw poprzez AS */

--zad2 (d) Napisz zapytanie, które zwraca klientów z USA i dla ka¿dego klienta zwraca œredni¹ liczbê zamówieñ i œredni¹ iloœæ zamówionego towaru.
--U¿yte tabele: Customers, Orders i OrderDetails


select custid,   sum(qty) as totalqty from (
select custid, productid, unitprice, qty from [Sales].[OrderDetails] as OD
inner join 
(select C.custid, O.Orderid from [Sales].[Customers] as C
inner join [Sales].[Orders] as O
ON C.custid = O.custid
where country = 'USA') as AA
ON OD.orderid = AA.orderid) as AB
group by custid


--zad2 (e) Napisz zapytanie zwracaj¹ce klientów i ich zamówienia, wliczaj¹c w to klientów, którzy nie z³o¿yli zamówieñ.
SELECT O.custid, companyname, orderid, orderdate
from Sales.Orders AS O RIGHT OUTER JOIN Sales.Customers AS C
ON O.custid = C.custid

--zad2 (f) Napisz zapytanie zwracaj¹ce klientów, którzy nie z³o¿yli ¿adnego zamówienia

SELECT C.custid, companyname
from Sales.Orders AS O RIGHT OUTER JOIN Sales.Customers AS C
ON O.custid = C.custid
WHERE orderid IS NULL

--zad2 (g) Napisz zapytanie, które zwraca klienotw z zamówieniami z³o¿onymi 12 lutego 2016 wraz z ich zamówieniami

select O.custid, companyname, orderid, orderdate
from Sales.Customers AS C RIGHT OUTER JOIN Sales.Orders AS O
ON O.custid = C.custid
where orderdate = '20160212'

--zad2 (h) Napisz zapytanie zwracaj¹ce wszystkich klientów, a dla tych, którzy z³o¿yli zamówienia 12 lutego 2016, zwróci równie¿ te zamówienia.

select C.custid, companyname, orderid, orderdate
from [Sales].[Customers] as C
left outer join [Sales].[Orders] as O
ON C.custid = O.custid
where orderdate = '2016-02-12'

select * from Sales.Orders
;--------------------------------------------------------------do poprawy

--zad3 (a) Napisz zapytanie zwracaj¹ce wszystkie zamówienia z³o¿one ostatniego dnia aktywnoœci, który mo¿na znaleŸæ w tabeli Orders.

select orderid, orderdate, custid, empid
from Sales.Orders
where orderdate = (SELECT MAX (orderdate) AS "Max Date" 
FROM Sales.Orders)

--zad3 (b) Napisz zapytanie zwracaj¹ce wszystkie zamówienia z³o¿one przez klienta lub klientów, którzy
--z³o¿yli najwiêcej zamówieñ. Uwaga: wielu klientów mo¿e mieæ tak¹ sam¹ (maksymaln¹) liczb¹
--zamówieñ.
select AA.custid, orderid, orderdate, empid
from Sales.Orders
inner join (select top 1 with ties O.custid
from Sales.Orders AS O
group by O.custid
order by COUNT(*) DESC) AS AA
ON AA.custid = Sales.Orders.custid

--zad3 (c) Napisz zapytanie zwracaj¹ce pracowników, którzy nie z³o¿li zamówieñ 1 maja 2016 lub póŸniej.

select empid, firstname, lastname
from HR.Employees
except
SELECT distinct E.empid, E.firstname, E.lastname
FROM HR.Employees AS E
INNER JOIN (select distinct empid
from Sales.Orders
where orderdate between '2016-05-01' and (GETDATE()
)
) AS O
On E.empid = O.empid;

--> szybciej
select empid, Firstname, lastname from [HR].[Employees]
where empid not in (select distinct empid from Sales.Orders
where orderdate between '2016-05-01' and getdate())

--zad3 (d) Napisz zapytanie zwracaj¹ce kraje, w których s¹ klienci, ala nie ma pracowników.

select distinct country
from Sales.Customers
except
select distinct country
from HR.Employees

--zad3 (e) Napisz zapytanie zwracaj¹ce dla ka¿dego klienta wszystkie zamówienia z³o¿one w ostatnim dniuaktywnoœci klienta.

select custid, max(orderdate) as lastdate
from Sales.Orders
group by custid

--zad3 (f) Napisz zapytanie zwracaj¹ce klientów, którzy z³o¿yli zamówienia w roku 2015, ale nie z³o¿yli ichw roku 2016

select CC.custid, Sales.Customers.companyname
from
(select AA.custid
from
(select distinct custid
from Sales.Orders
where orderdate LIKE '2015%'
group by custid) AS AA
inner join
(select distinct custid
from Sales.Orders
except
select custid
from Sales.Orders
where orderdate LIKE '2016%'
group by custid) AS BB
on AA.custid = BB.custid) as CC
inner join Sales.Customers
ON CC.custid = Sales.Customers.custid

--zad3 (g) Napisz zapytanie zwracaj¹ce klientów, którzy zamówili produkt 12.
select distinct BB.custid, Sales.Customers.companyname
from Sales.Customers
inner join 
(select Sales.Orders.custid
from 
(select *
from Sales.OrderDetails
where productid = 12) AS AA
inner join Sales.Orders 
ON AA.orderid = Sales.Orders.orderid) AS BB
ON BB.custid = Sales.Customers.custid
order by Sales.Customers.companyname

--zad3 (h) Napisz zapytanie, które dla ka¿dego klienta i miesi¹ca oblicza skumulowan¹ ³czn¹ iloœæ zamówionych towarów

create view[lab2zad3h] as
select custid, orderdate, month(orderdate) as mies, qty  from [Sales].[OrderDetails] as OD
inner join 
(select C.custid, O.orderid, O.orderdate from [Sales].[Customers] as C
inner join [Sales].[Orders] as O
ON C.custid = O.custid) as AA
ON OD.orderid = AA.orderid



select custid, mies, sum(qty) as ruqty from lab2zad3h
group by custid, mies
order by custid, mies

select * from lab2zad3h