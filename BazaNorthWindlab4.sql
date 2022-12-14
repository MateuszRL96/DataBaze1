/*
   niedziela, 1 stycznia 202317:15:25
   User: 
   Server: DESKTOP-7BQ2H0J\MISSQLSEWER
   Database: Northwind
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
--zad1 (a)
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Department
	(
	id_depart int NOT NULL,
	Nazwa varchar(50) NULL,
	Lokalizacja varchar(50) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Department ADD CONSTRAINT
	PK_Department PRIMARY KEY CLUSTERED 
	(
	id_depart
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Department SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Pracownicy
	(
	Id_pracownika int NOT NULL,
	Nazwisko varchar(50) NULL,
	Imie varchar(50) NULL,
	Stanowisko varchar(50) NULL,
	Kierownik int NULL,
	Data_zatrud date NULL,
	Zarobki decimal(10, 2) NULL,
	Prowizja decimal(10, 2) NULL,
	Id_depart int NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Pracownicy ADD CONSTRAINT
	PK_Pracownicy PRIMARY KEY CLUSTERED 
	(
	Id_pracownika
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Pracownicy ADD CONSTRAINT
	FK_Pracownicy_Department FOREIGN KEY
	(
	Id_depart
	) REFERENCES dbo.Department
	(
	id_depart
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Pracownicy SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--zad1 (b) Uzupełnij tabelę Department danymi

INSERT INTO [dbo].[Department] VALUES ( 10 , ' Ksiegowosc ' , ' Rzeszow ' ) ;
INSERT INTO [dbo].[Department] VALUES ( 20 , ' Badan ' , ' Krakow ' ) ;
INSERT INTO [dbo].[Department] VALUES ( 30 , ' Sprzedaz ' , ' Zamosc ' ) ;
INSERT INTO [dbo].[Department] VALUES ( 40 , ' Innowacji ' , 'Wroclaw ' ) ;

--zad1 (c) Uzupełnij tabelę Pracownicy danymi

INSERT INTO PRACOWNICY VALUES
( 1 , ' Kowalski ' , ' Jan ' , ' Prezes ' ,NULL, ' 2002−01−01 ' , 7000.20 ,NULL, 10 ) ;
INSERT INTO PRACOWNICY VALUES
( 2 , ' Glowacki ' , ' Mateusz ' , ' Kierownik ' , 1 , ' 2002−05−01 ' , 3210 , 150 , 40 );
INSERT INTO PRACOWNICY VALUES
( 3 , ' Sikorski ' , 'Adam ' , ' Kierownik ' , 1 , ' 2002−05−01 ' , 3210 , 250 , 20 );
INSERT INTO PRACOWNICY VALUES
( 4 , 'Nowak ' , ' Stanislaw ' , ' Kierownik ' , 1 , ' 2002−05−01 ' , 3210 , 350 , 30 );
INSERT INTO PRACOWNICY VALUES
( 5 , ' Wisniewski ' , ' Marcin ' , ' Sprzedawca ' , 4 , ' 2007−06−27 ' , 1210 , 250 , 30 );
INSERT INTO PRACOWNICY VALUES
( 6 , ' Kochanowski ' , ' Juliusz ' , ' Sprzedawca ' , 4 , ' 2005−11−22 ' , 1210 , 260 , 30 );
INSERT INTO PRACOWNICY VALUES
( 7 , ' Charysz ' , ' Szczepan ' , ' Sprzedawca ' , 4 , ' 2006−12−01 ' , 1210 , 200 , 30 );
INSERT INTO PRACOWNICY VALUES
( 8 , ' Kordecki ' , 'Adam ' , ' Laborant ' , 3 , ' 2002−12−11 ' , 2210 , 150 , 20 );
INSERT INTO PRACOWNICY VALUES
( 9 , ' Kopacz ' , 'Ewa ' , ' Laborant ' , 3 , ' 2003−04−21 ' , 2110 , 150 , 20 );
INSERT INTO PRACOWNICY VALUES
( 10 , ' Ziolkowska ' , ' Krystyna ' , ' Laborant ' , 3 , ' 2002−07−10 ' , 2510 , 100 , 20 );
INSERT INTO PRACOWNICY VALUES
( 11 , ' Szela ' , ' Katarzyna ' , ' Konsultant ' , 2 , ' 2002−05−10 ' , 2810 , 100 , 40 );
INSERT INTO PRACOWNICY VALUES
( 12 , ' Kedzior ' , ' Jakub ' , ' Analityk ' , 2 , ' 2002−05−10 ' , 2710 , 120 , 40 );
INSERT INTO PRACOWNICY VALUES
( 13 , ' Ziobro ' , ' Marlena ' , ' Konsultant ' , 2 , ' 2003−02−13 ' , 2610 , 200 , 40 );
INSERT INTO PRACOWNICY VALUES
( 14 , ' Pigwa ' , ' Genowefa ' , ' Ksiegowa ' , 1 , ' 2002−01−02 ' , 2000 , NULL , 10 ) ;

--zad1 (d) Do tabeli Pracownicy dodaj atrybut Adres.

ALTER TABLE dbo.Pracownicy
ADD Adress varchar(50)

--zad1 (e) Usuń z tabeli Pracownicy atrybut Adres.

ALTER TABLE dbo.Pracownicy
DROP COLUMN Adress;

--zad1 (f) Wszystkim pracownikom z działu 10 powiększ zarobki o 100 zł.

UPDATE Pracownicy
SET zarobki = zarobki + 100
where id_depart = 10 ;

--zad1 (g) Zmień nazwę kolumny Id depart w tabeli Departament na kod działu.

EXEC sp_rename 'dbo.Pracownicy.Id_depart', 'kod_dzialu', 'COLUMN';

--zad1 (h) Zmień nazwę tabeli Departament na Dział.

EXEC sp_rename 'Department','Dzial';

--zad1 (i) Usuń z tabeli Pracownicy pracownika o identyfikatorze 14.

DELETE FROM Pracownicy WHERE Id_pracownika = 14;

--zad2 (j) Zmodyfikuj tabele Pracownicy w taki sposób by nie możliwe było wprowadzanie zarobków poniżej płacy minimalnej.

ALTER TABLE Pracownicy ADD CHECK (Zarobki > 3010.00)


--zad1 (k) Zweryfikuj działanie nałożonego ograniczenia.

--Zad1 (l) Zdefiniuj perspektywę (widok), która wypisze maksymalne zarobki na każdym stanowisku.
	create view max_zarobki(Zarobki, Stanowisko) AS
	Select Max(Zarobki), Stanowisko
	from Pracownicy
	Group by Stanowisko
	select * from max_zarobki


 



