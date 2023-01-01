
--zad2 (a) Uruchomiæ poni¿szy kod
DROP TABLE IF EXISTS dbo.Customers ;
CREATE TABLE dbo.Customers
(
custid INT NOT NULL PRIMARY KEY,
companyname NVARCHAR(40) NOT NULL,
country NVARCHAR(15) NOT NULL,
region NVARCHAR(15) NULL,
city NVARCHAR(15)  NOT NULL) ;

--zad2 (b) Wstawiæ do tabeli dbo.Customers wiersz, który zawiera: custid : 100;  companyname : Coho Winery; country : USA; region : WA; city : Redmond

INSERT INTO dbo.Customers VALUES
( 100 , 'Coho Winery' , 'USA' , 'WA' , 'Redmond') ;

select * from Customers;

--zad2 (c) Wstawiæ do tabeli dbo.Customers wszystkich klientów z tabeli Sales.Customers, którzy z³o¿yli zamówienia.
select * from Customers
INSERT INTO dbo.Customers
SELECT custid, companyname, country, region, city FROM Sales.Customers;

--zad2 (d) U¿yæ instrukcji SELECT INTO do utworzenia tabeli dbo.Orders i wype³nienia jej zamówieniami
--z tabeli Sales.Orders, które zosta³y z³o¿one w latach 2014 do 2016.

SELECT * INTO dbo.Orders
from Sales.Orders
where orderdate between '2014-01-01' and '2016-12-31'

select * from dbo.Orders

--zad2 (e) Z tabeli dbo.Orders usun¹æ zamówienia z³o¿one przed sierpniem 2014. U¿yæ klauzuli OUTPUT,
--by zwróciæ atrybuty orderid i orderdate usuniêtych zamówieñ.

delete from dbo.Orders
where orderdate < '2014-08-01' 

--zad2 (f) Z tabeli dbo.Orders usun¹æ zamówienia z³o¿one przez klientów z Brazylii.

select * from Orders
delete from Orders
where shipcountry = 'Brazil'

--zad2 (g) Uruchomiæ poni¿sze zapytanie do tabeli dbo.Customers; zwróæ uwagê, ¿e w niektórych wierszach,
--w kolumnie region znajduje siê znaczniki NULL.

select * from dbo.Customers

select custid, region from dbo.Customers
where region = '<None>'

UPDATE dbo.Customers SET region = '<None>' WHERE region is Null;

ALTER TABLE dbo.Customers MODIFY region VARCHAR(20) NOT NULL;

/*
UPDATE Employee SET FirstName='nowe imie'
OUTPUT getdate(),'aktualizacja wiersza',inserted.ID_EMPLOYEE,inserted.FirstName,deleted.FirstName INTO EmployeeLog
WHERE ID_EMPLOYEE=1    */

--zad2 (h) Zaktualizowaæ wszystkie zamówienia w tabeli dbo.Orders z³o¿one przez klientów z Wielkiej Brytanii oraz ustawiæ wartoœci shipcountry, shipregion i shipcity za pomoc¹ wartoœci country, region
--i city odpowiednich klientów
select shipcountry as country, shipregion as region , shipcity as city 
from dbo.Orders
where shipcountry = 'UK'

UPDATE  dbo.Orders SET shipregion='<None>'
 WHERE shipcountry = 'UK' AND shipregion is Null


--zad2 (i) Uruchomiæ poni¿szy kod, aby utworzy¿ tabele Orders i OrderDetails i wype³niæ je danymi.
 
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


