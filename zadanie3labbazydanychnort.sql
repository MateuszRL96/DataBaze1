
--zad1 (a) Podaj nazwy klientów, którzy zamówili produkty (przynajmniej jeden)takie jak klient FRANR
--(zaawansowana wersja - wszystkie takie same produkty)
select distinct Customerid
from Orders
inner join
(select orderid
from [dbo].[Order Details] AS OOD
inner join
(select productid
from [dbo].[Order Details] AS OD
inner join
(select orderid
from Orders
where CustomerID = 'FRANR') AS OO
ON OD.orderid = OO.orderid) AS OOO
ON OOD.productid = OOO.productid) AS AA
ON Orders.orderid = AA.orderid
where CustomerID != 'FRANR'

--zad1 (b) Podaj identyfikator najd³u¿ej realizowanego zamówienia

select orderid, BB.maksymalna
from
(SELECT orderid, DATEDIFF(SECOND, OrderDate, RequiredDate) AS DateDiff
from Orders) AS CC
inner join
(select max(DateDiff) AS maksymalna
from
(SELECT orderid, DATEDIFF(SECOND, OrderDate, RequiredDate) AS DateDiff
from Orders) AS AA) AS BB
ON CC.DateDiff = BB.maksymalna

-----szybciej ---->

select  orderid, datediff(second, orderdate, RequiredDate) as Broznica
from Orders
where datediff(second, orderdate, RequiredDate) = 
(select  max(datediff(second, orderdate, RequiredDate)) as Aroznica
from Orders)

--zad1 (c) Podaj klientów, którzy mieli przerwê w zakupach d³u¿sz¹ ni¿ 2 miesi¹ce

SELECT Orderid, OrderDate AS Data, 
    (SELECT TOP 1 OrderDate 
    FROM Orders 
    WHERE OrderID>o.OrderID AND CustomerID=o.CustomerID 
    ORDER BY OrderDate) Nastepny,
    datediff(day,OrderDate,
    (SELECT TOP 1 OrderDate 
    FROM Orders
    WHERE OrderID>o.OrderID AND CustomerID=o.CustomerID 
    ORDER BY OrderDate)) roznica
FROM
customers c join orders o 
on c.customerid = o.customerid 
where datediff(day,OrderDate,
    (SELECT TOP 1 OrderDate 
    FROM Orders 
    WHERE OrderID>o.OrderID AND CustomerID=o.CustomerID 
    ORDER BY OrderDate))>61
ORDER BY o.CustomerId, OrderDate
------------------------------------------------------------------------------- do zastanowiebnia sie!
select orderid, customerid, orderdate from Orders
order by customerid, orderdate

--zad1 (d) Wypisz identyfikatory tych pracowników, którzy realizowali wiêcej zamówieñ ni¿ liczba zamówieñ
--zrealizowanych przez pracowników z tego samego kraju co spedytorzy.

SELECT COUNT(OrderID) as liczba, EmployeeID
FROM Orders
GROUP BY EmployeeID
HAVING COUNT(OrderID) >
(
SELECT COUNT(OrderID)
FROM Orders AS O INNER JOIN Employees AS E
ON O.EmployeeID = E.EmployeeID
WHERE O.ShipCountry = E.Country
)

--zad1 (e) W firmie u¿ywaj¹cej bazy Northwind pracownicy (tabela Employees) posiadaj¹ adresy emial’owe.
--Za³ó¿my, ¿e standardowo nazwa konta (czêœæ przed znakiem @) zbudowana jest z pierwszej litery imienia (firstname), inicja³u œrodkowego (pole middlinitial) oraz pierwszych oœmiu znaków
--nazwiska (lastname). Utwórz zapytanie, które wygeneruje te nazwy email’owe. W tym zadaniu
--nale¿y u¿yæ funkcji ³añcuchowych LOWER i SUBSTRING.

SELECT LastName, FirstName, lower(SUBSTRING(FirstName, 1,1)+SUBSTRING(LastName,1,8)+'@wsiz.pl') AS Email
FROM Employees

--zad1 (f) Podaj dzieñ w którym by³o najwiêcej zamówieñ
select day(OrderDate), count(orderid)
from Orders
group by day(OrderDate)
order by 1
-----------------to i to dziala
select dzien, count(dzien) as ile from (
select day(orderdate)as dzien from Orders ) as AA
group by dzien
order by dzien

--dzien tygodnia
select  Datename(dw,OrderDate), count(orderid)
from Orders
group by Datename(dw,OrderDate)
order by 2 desc
--data
select top 1 with ties OrderDate, count(orderid)
from Orders
group by OrderDate
order by 2 desc
select dzien, ilosc
from (select distinct day(orderdate) dzien,
        (select count(orderid) 
        from orders o1
        where day(o1.orderdate)=day(o2.OrderDate)) ilosc
from Orders o2) wynik
where wynik.ilosc = (select max(ta.ilosc) 
            FROM (select (select count(orderid) 
            from orders o1 
            where day(o1.OrderDate)=day(o2.OrderDate)) ilosc
        from Orders o2) ta)


--zad1 (g) Wypisz nazwê i adres najczêœciej zamawiaj¹cego klienta
SELECT COUNT(*),CompanyName  
FROM orders inner join customers
ON orders.CustomerID=customers.CustomerID
--where companyname='Save-a-lot Markets'
GROUP BY CompanyName
ORDER BY 1 DESC
SELECT companyname, Address
FROM Customers k
WHERE  (SELECT COUNT(*) 
        FROM orders o 
        WHERE k.CustomerID=o.CustomerID) >= ALL 
        (SELECT COUNT(*) 
        FROM orders 
        GROUP BY CustomerID)

    
--zad1 (h) Wskazaæ pracownika który obs³ugiwa³ klienta, którego nie obs³ugiwa³ nikt inny
select AA.customerid, count(*) as tylkoJeden
from (
select distinct customerid, employeeid
from Orders ) as AA
GROUP BY AA.customerid
HAVING count(*) =  1;

--zad1 (i) Wypisz dane pracownika którego nazwisko jest najd³u¿sze. Skorzystaj z funkcji LEN

WITH DL AS (
select Max(Len(LastName)) AS maksimum
from Employees)
Select *
from Employees
where LEN(LastName) = (select * from DL)



