
--zad2 (a) Uruchomi� poni�szy kod
DROP TABLE IF EXISTS dbo.Customers ;
CREATE TABLE dbo.Customers
(
custid INT NOT NULL PRIMARY KEY,
companyname NVARCHAR(40) NOT NULL,
country NVARCHAR(15) NOT NULL,
region NVARCHAR(15) NULL,
city NVARCHAR(15)  NOT NULL) ;

--zad2 (b) Wstawi� do tabeli dbo.Customers wiersz, kt�ry zawiera: custid : 100;  companyname : Coho Winery; country : USA; region : WA; city : Redmond

INSERT INTO dbo.Customers VALUES
( 100 , 'Coho Winery' , 'USA' , 'WA' , 'Redmond') ;

select * from Customers;

--zad2 (c) Wstawi� do tabeli dbo.Customers wszystkich klient�w z tabeli Sales.Customers, kt�rzy z�o�yli zam�wienia.
select * from Customers
INSERT INTO dbo.Customers
SELECT custid, companyname, country, region, city FROM Sales.Customers;

--zad2 (d) U�y� instrukcji SELECT INTO do utworzenia tabeli dbo.Orders i wype�nienia jej zam�wieniami
--z tabeli Sales.Orders, kt�re zosta�y z�o�one w latach 2014 do 2016.

SELECT * INTO dbo.Orders
from Sales.Orders
where orderdate between '2014-01-01' and '2016-12-31'

select * from dbo.Orders

--zad2 (e) Z tabeli dbo.Orders usun�� zam�wienia z�o�one przed sierpniem 2014. U�y� klauzuli OUTPUT,
--by zwr�ci� atrybuty orderid i orderdate usuni�tych zam�wie�.

delete from dbo.Orders
where orderdate < '2014-08-01' 

--zad2 (f) Z tabeli dbo.Orders usun�� zam�wienia z�o�one przez klient�w z Brazylii.

select * from Orders
delete from Orders
where shipcountry = 'Brazil'

--zad2 (g) Uruchomi� poni�sze zapytanie do tabeli dbo.Customers; zwr�� uwag�, �e w niekt�rych wierszach,
--w kolumnie region znajduje si� znaczniki NULL.

select * from dbo.Customers

select custid, region from dbo.Customers
where region = '<None>'

UPDATE dbo.Customers SET region = '<None>' WHERE region is Null;

ALTER TABLE dbo.Customers MODIFY region VARCHAR(20) NOT NULL;

/*
UPDATE Employee SET FirstName='nowe imie'
OUTPUT getdate(),'aktualizacja wiersza',inserted.ID_EMPLOYEE,inserted.FirstName,deleted.FirstName INTO EmployeeLog
WHERE ID_EMPLOYEE=1    */

--zad2 (h) Zaktualizowa� wszystkie zam�wienia w tabeli dbo.Orders z�o�one przez klient�w z Wielkiej Brytanii oraz ustawi� warto�ci shipcountry, shipregion i shipcity za pomoc� warto�ci country, region
--i city odpowiednich klient�w
select shipcountry as country, shipregion as region , shipcity as city 
from dbo.Orders
where shipcountry = 'UK'

UPDATE  dbo.Orders SET shipregion='<None>'
 WHERE shipcountry = 'UK' AND shipregion is Null


--zad2 (i) Uruchomi� poni�szy kod, aby utworzy� tabele Orders i OrderDetails i wype�ni� je danymi.
 
DROP TABLE IF EXISTS dbo.OrderDetails ;
DROP TABLE IF EXISTS dbo.Orders  ;
CREATE TABLE dbo.Orders
(
orderid INT NOT NULL,
custid INT NULL,
empid INT NOT NULL,
orderdate DATE NOT NULL,
requireddate DATE NOT NULL,
shippeddate DATE NULL,
shipperid INT NOT NULL,
freight MONEY NOT NULL
CONSTRAINT DFT_Orders_freight DEFAULT(0) ,
shipname NVARCHAR(40) NOT NULL,
shipaddress NVARCHAR(60) NOT NULL,
shipcity NVARCHAR(15) NOT NULL,
shipregion NVARCHAR(15) NULL,
shippostalcode NVARCHAR(10) NULL,
shipcountry NVARCHAR(15) NOT NULL,
CONSTRAINT PK_Orders PRIMARY KEY(orderid)
) ;
CREATE TABLE dbo.OrderDetails
(
orderid INT NOT NULL,
productid INT NOT NULL,
unitprice MONEY NOT NULL
CONSTRAINT DFT_OrderDetails_unitprice DEFAULT(0) ,
qty SMALLINT NOT NULL
CONSTRAINT DFT_OrderDetails_qty DEFAULT(1) ,
discount NUMERIC(4, 3) NOT NULL
CONSTRAINT DFT_OrderDetails_discount DEFAULT(0) ,
CONSTRAINT PK_OrderDetails PRIMARY KEY(orderid , productid ) ,
CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY(orderid )
REFERENCES dbo.Orders (orderid) ,
CONSTRAINT CHK_discount CHECK ( discount BETWEEN 0 AND 1 ) ,
CONSTRAINT CHK_qty CHECK ( qty > 0 ) ,
CONSTRAINT CHK_unitprice CHECK (unitprice >= 0 )
) ;
INSERT INTO dbo.Orders SELECT * FROM Sales.Orders ;
INSERT INTO dbo.OrderDetails SELECT * FROM Sales.OrderDetails ;

select * from dbo.OrderDetails
select * from dbo.Orders


DELETE FROM dbo.OrderDetails 
DELETE FROM dbo.Orders



DELETE FROM dbo.OrderDetails 
DELETE FROM dbo.Orders


