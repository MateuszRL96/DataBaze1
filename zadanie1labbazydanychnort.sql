--zad2/e

SELECT COUNT(*) FROM [dbo].[Categories]
SELECT COUNT(*) FROM [dbo].[CustomerCustomerDemo]
SELECT COUNT(*) FROM [dbo].[CustomerDemographics]
SELECT COUNT(*) FROM [dbo].[Customers]
SELECT COUNT(*) FROM [dbo].[Employees]
SELECT COUNT(*) FROM [dbo].[EmployeeTerritories]
SELECT COUNT(*) FROM [dbo].[Order Details]
SELECT COUNT(*) FROM [dbo].[Orders]
SELECT COUNT(*) FROM [dbo].[Products]
SELECT COUNT(*) FROM [dbo].[Region]
SELECT COUNT(*) FROM [dbo].[Shippers]
SELECT COUNT(*) FROM [dbo].[Suppliers]



--zad3 (a) Dla ka¿dego pracownika podaj na jakim stanowisku pracuje
SELECT FirstName, LastName, Title
From Employees

--zad3 (b) ZnajdŸ ró¿nice miêdzy najwy¿sz¹, a najni¿sz¹ cena produktów, nazwij kolumnê wyœwietlaj¹c¹
SELECT MIN(UnitPrice) AS SmallestPrice
FROM Products;

SELECT MAX(UnitPrice) AS LargestPrice
FROM Products;

SELECT MIN(UnitPrice) - MAX(UnitPrice) AS Different
FROM Products;

--zad3 (c) Wybierz nazwy produktów i ich kategorii w kolejnoœci alfabetycznej nazw kategorii,
SELECT *
FROM Products
ORDER BY CategoryID, ProductName 

select ProductName, C.CategoryName
from Products as P
inner join Categories as C
ON P.CategoryID = C.CategoryiD
order by P.Categoryid;

--zad3 (d) ZnajdŸ nazwiska pracowników którzy obs³ugiwali klienta o id = ALFKI (Orders, Employees),
SELECT Distinct LastName, CustomerID
FROM Employees as E INNER JOIN Orders as O
ON E.EmployeeID=O.EmployeeID
WHERE CustomerID like 'ALFKI';

--zad3 (e) ZnajdŸ nazwiska pracowników, którzy realizowali zamówienie przed 1996-08-01,
SELECT Distinct LastName, CustomerID
FROM Employees as E INNER JOIN Orders as O
ON E.EmployeeID=O.EmployeeID
Where (OrderDate<'1996/08/01') ;

--zad3 (f) ZnajdŸ nazwiska i imiona pracowników, którzy podczas zamówieñ korzystali ze statków amerykañskich,select distinct LastName, FirstName from Employees as E
inner join (
select * from Orders as O
inner join Shippers as S
ON S.Shipperid = O.ShipVia) as AA
On AA.Employeeid = E.Employeeid
where AA.CompanyName = 'United Package';
-------------------------------------------------------
SELECT *
FROM Customers
Where Country LIKE 'Mexico' OR Country 
LIKE 'USA' OR Country LIKE 'Canada';

--zad3 (g) Wyœwietl produkty zamówione w 1996 roku
Select *
From Orders
WHERE OrderDate BETWEEN '1996-01-01' AND '1996-12-31';

--zad4 (a) Policzyæ œrednie ceny produktów dla ka¿dej z kategorii z wyj¹tkiem kategorii Seafood,

SELECT CategoryName, AVG(UnitPrice) AS srednia
FROM Products INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
WHERE NOT (CategoryName='Seafood')
GROUP BY CategoryName;

--zad4 (b) Podaj œredni¹ wartoœæ zamówieñ w ka¿dej kategorii,

SELECT CategoryName, AVG(UnitPrice*Quantity) AS srednia
FROM [dbo].[Order Details] INNER JOIN Categories
ON [dbo].[Order Details].ProductID = Categories.CategoryID
GROUP BY CategoryName

--zad4 (c) Wypisz kategorie których œrednie ceny s¹ powy¿ej 1000,

create View[zad4c] as
SELECT CategoryName, AVG(UnitPrice*Quantity) AS srednia
FROM [dbo].[Order Details] INNER JOIN Categories
ON [dbo].[Order Details].ProductID = Categories.CategoryID
GROUP BY CategoryName;

select * from zad4c
where srednia > 1000

--zad4 (d) Wypisz najd³u¿ej pracuj¹ce osoby na ka¿dym stanowisku,

select max(datediff(day, HireDate, GETDATE())) as wKoncu, Title
from Employees
GROUP BY Title;

--zad4 (e) ZnajdŸ nazwê firmy, czyli klienta, któremu przes³ano towar statkiem amerykañskim

--zad4 (f) Ilu pracowników jest kierownikami,
SELECT COUNT(*)
FROM Employees
WHERE Title like 'Sales Manager'

--zad4 (g) Oblicz wiek pracowników (funkcja YEAR),
SELECT FirstName, LastName, DATEDIFF(year, Employees.BirthDate, GETDATE() + 1) as EmployeeOld
FROM Employees 

--zad4 (h) ZnajdŸ pracownika o najd³u¿szym nazwisku (funkcja length),

select LastName, FirstName 
from Employees
where len(LastNaME) = (SELECT max(len(LastName)) FROM Employees);
select * from Employees

--zad4 (i) Podaj ilu pracowników mieszka w takich samych miastach,
SELECT City
FROM Employees

SELECT count(distinct City)
FROM Employees 

SELECT City, count(*)
FROM Employees
GROUP BY City
HAVING count(*) >  1;

--zad4 (j) SprawdŸ czy do wszystkich klientów posiadasz numer faksu.
SELECT *
FROM Customers
WHERE Fax IS Null
