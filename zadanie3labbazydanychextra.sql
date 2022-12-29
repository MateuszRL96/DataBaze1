
--zad2 (a) Poniższe zapytanie próbuje wyfiltrować zamówienia, które nie zostały złożone ostatniego dnia roku.

select *
from Sales.Orders
where orderdate IN (
SELECT distinct DATEFROMPARTS ( year(orderdate), 12, 31 ) AS Result
from Sales.Orders)


SELECT orderid , orderdate , custid , empid ,
DATEFROMPARTS(YEAR(orderdate) , 12 , 31 ) AS endofyear
FROM Sales.Orders
WHERE orderdate = DATEFROMPARTS(YEAR(orderdate) , 12 , 31 ) ;

--zad2 (b) Napisz zapytanie, które dla każdego pracownika zwraca maksymalną wartość kolumny orderdate

select empid, max(orderdate) as maxorderdate
from Sales.Orders
group by empid

--zad2 (c) Przerobić zapytanie z ćwiczenia b do postaci tabeli pochodnej.
--Napisz zapytanie złączenia pomiędzy tabelą pochodną a tabelą Orders,
-- by dla każdego pracownika zwrócić zamówienia o maksymalnej dacie zamówienia.


select O.empid, orderdate, orderid, custid 
from Sales.Orders as O
inner join (
select empid, max(orderdate) as maxorderdate
from Sales.Orders
group by empid) as OO
ON OO.maxorderdate = O.orderdate AND OO.empid = O.empid

--zad2 (d) Napisz zapytanie, które dla każdego zamówienia oblicza numer wiersza w oparciu o kolejność
-- orderdate, orderid.

SELECT orderid, orderdate, custid , empid,
ROW_NUMBER() OVER( ORDER BY orderid ) AS rownum
FROM Sales.Orders ;

--zad2 (e) Napisz zapytanie, które zwraca wiersze o numerach od 11 do 20 w oparciu o definicję numeru
--wiersza z ćwiczenia d. Użyj wyrażenia CTE do enkapsulacji kodu z ćwiczenia d.

WITH Order_CTE(orderid, orderdate, custid, empid, rownum)
as(SELECT orderid, orderdate, custid , empid,
ROW_NUMBER() OVER( ORDER BY orderid ) AS rownum
FROM Sales.Orders)

select orderid, orderdate, custid, empid, rownum
from Order_CTE
where rownum between 11 AND 20;

--zad2 (f) Napisz rozwiązanie przy użyciu rekurencyjnego wyrażenia CTE, które zwnraca łańcuch zależności
--służbowej prowadzący do pracownika Patricia Doyle (identyfikator pracownika 9).


with EmpsCTE as
(
select empid, mgrid, firstname, lastname from HR.Employees 
where empid = 9

union all 
select P.empid, P.mgrid, P.firstname, P.lastname
from EmpsCTE AS C
inner join HR.Employees AS P
ON C.mgrid = P.empid)
select empid, mgrid, firstname, lastname from EmpsCTE;


--zad2 (g) Utwórz widok, który zwraca łączną ilość dla każdego pracownika i roku.
--Użyte tabele: Sales.Orders i Sales.OrderDetails

select empid, orderdate, sum(suma) as xx
from(
select empid, year(orderdate) as orderdate, sum(qty) as suma
from Sales.Orders as O
inner join
Sales.OrderDetails as OD
ON O.orderid = OD.orderid
group by empid, orderdate) as aa
group by empid, orderdate
order by empid

--zad2 (h) Napisz zapytanie do Sales.VEmpOrders, które zwraca skumulowaną łczną ilość dla każdego pracownika i roku.
--Użyte tabele: widok Sales.VEmpOrders

select empid, orderyear, sum(qty) as qty
from (select empid, year(ordermonth) as orderyear, qty
from Sales.EmpOrders) as aa
group by empid, orderyear
order by empid

select empid, year(ordermonth) as orderyear, qty
from [Sales].[EmpOrders]
group by year(ordermonth), empid
order by empid;


--zad2 (i) Utwórz funkcję TVF, która akceptuje jako dane wejściowe identyfikator dostawcy (@supid AS
--INT) i żądaną liczbą produktów (@n AS INT). Funkcja powinna zwracać liczbę @n produktów
--o najwyższych cenach jednostkowych, które zostały dostarczone przez określonego dostawcę.
--Użyte tabele: Production.Products
--Oczekiwane wyniki po wykonaniu poniższego zapytania:
--SELECT ∗ FROM P r oduc ti on . TopProducts ( 5 , 2 )

  CREATE FUNCTION DBO.[TVF](@supid INT, @number INT)         
	returns TABLE AS
		RETURN (
			select top @number
			from Production.Products
			where supplierid = @supid
				)

	SELECT * FROM dbo.TVF(3,2);


--zad2 (j) Przy użyciu operatora CROSS APPLY i funkcji utworzonej w ćwiczeniu powyżej zwróć dwa
--najdroższe produkty dla każdego dostawcy.
--zad3 (a) Napisz zapytanie generujące wirtualną tabelę pomocniczą 10 liczb z zakresu 1 do 10 bez użycia konstrukcji pętli.;
	
	CREATE VIEW [n] AS
	SELECT * from Nums N
	where N < 11

	select * from N

--zad3 (b) Napisz zapytanie zwracające pary klient/pracownik, którzy wykazali się aktywnością dotyczącą
--zamówiń w styczniu 2016, przy braku aktywności w lutym 2016.
	select AA.custid, AA.empid from (
	select custid, empid from Sales.Orders 
	WHERE OrderDate BETWEEN '2016-01-01' AND '2016-01-31') as AA
	inner join (
	select distinct custid, empid from Sales.Orders
	except
	select distinct custid, empid from Sales.Orders
	WHERE OrderDate BETWEEN '2016-02-01' AND '2016-02-29') as BB
	on AA.custid = BB.custid AND AA.empid = BB.empid

/*select distinct empid from Sales.Orders
except
select distinct empid from Sales.Orders
WHERE OrderDate BETWEEN '2016-02-01' AND '2016-02-29'
order by empid*/

--zad3 (c) Napisz zapytanie zwracające pary klient i pracownik, którzy wykazali się aktywnością dotyczącą
--zamówień w styczniu i lutym 2016.
	select aa.custid,aa.empid  from (select distinct custid, empid from Sales.Orders
	where orderdate between '2016-01-01' AND '2016-01-31') as aa

	inner join
	(select distinct custid, empid from Sales.Orders
	where orderdate between '2016-02-01' AND '2016-02-29') as bb
	on aa.custid = bb.custid AND aa.empid = bb.empid
	order by custid

--zad3 (d) Napisz zapytanie zwracające pary klient i pracownik, którzy wykazali się aktywnością dotyczącą
--zamówień w styczniu i lutym 2016, ale nie w roku 2015.
	select cc.custid, cc.empid from (
	select aa.custid,aa.empid  from (select distinct custid, empid from Sales.Orders
	where orderdate between '2016-01-01' AND '2016-01-31') as aa

	inner join
	(select distinct custid, empid from Sales.Orders
	where orderdate between '2016-02-01' AND '2016-02-29') as bb
	on aa.custid = bb.custid AND aa.empid = bb.empid) as cc
	inner join
	(
	select distinct custid, empid from Sales.Orders
	except
	select distinct custid, empid from Sales.Orders
	where orderdate between '2015-01-01' AND '2015-12-31'
	) as dd
	on cc.custid = dd.custid AND cc.empid = dd.empid

