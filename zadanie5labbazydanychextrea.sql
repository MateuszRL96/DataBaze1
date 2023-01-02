PRINT 'AKTUALNA DATA :' + CONVERT ( CHAR (8) , GETDATE () )
PRINT 'AKTUALNA DATA :' + CONVERT ( CHAR (8) , GETDATE () ,108)

-- Oczekiwany wynik
-- Started executing query at Line 1
-- AKTUALNA DATA : Nov 24 2
-- AKTUALNA DATA :10:10:56
-- Total execution time : 00:00:00.015


DECLARE @TEKST VARCHAR (10)
SET @TEKST = 'ALA MA KOTA '

Print @TEKST
-- oczekiwany wynik
--Started executing query at Line 1
--ALA MA KOT
--Total execution time : 00:00:00.002;
;

				--Przyk³adowe zadanie 2.
--Korzystaj¹c poleceñ DECLARE i PRINT wyœwietliæ informacjê o liczbie osób pracuj¹cych na stanowisku przedawca.
--Oczekiwany wynik powinien mieæ formê: Jest X
--Sprzedawców (gdzie X to liczba osób, zwrócona poprzez odpowiednie zapytanie).
 DECLARE @LICZBA INT
 SELECT @LICZBA = COUNT ( Id_pracownika ) FROM PRACOWNICY
 WHERE Stanowisko = 'Sprzedawca '
 PRINT 'Jest '+ CAST ( @LICZBA AS VARCHAR (2) ) +' sprzedawcow '
/* oczekiwany wynik
 Started executing query at Line 1
 Jest 3 sprzedawcow
 Total execution time : 00:00:00.003 */



DECLARE @TEKST2 VARCHAR (10) , @TEKST3 VARCHAR (10) , @TEKST4 VARCHAR (10)
SELECT @TEKST2 = 'ALA ', @TEKST3 = 'MA ', @TEKST4 = 'KOTA '

PRINT @TEKST2 + @TEKST3 + @TEKST4
-- oczekiwany wynik
--Started executing query at Line 1
--ALAMAKOTA
--Total execution time : 00:00:00.002

DECLARE @TEKST5 VARCHAR(50)
SELECT @TEKST5 = Nazwisko from PRACOWNICY

select * from Pracownicy

					----- zadanie 1 ---- 
 /*Korzystaj¹c poleceñ DECLARE i PRINT znajdŸ najwy¿sze zarobki.*/

 DECLARE @zarobki INT
 SELECT @zarobki = MAX(Zarobki) FROM PRACOWNICY
 PRINT 'Najwy¿sze zarobki to:  '+ CAST ( @zarobki AS VARCHAR (10) )

					---- zadanie 2 ---- 
 /*Korzystaj¹c poleceñ DECLARE i PRINT wyœwietliæ informacjê o najwczeœniej zatrudnionej osobie i jej zarobkach.
 Oczekiwany wynik powinien mieæ formê: Pracownik X zosta³ zatrudniony w dniu Y i zarabia Z 
 (gdzie X,Y,Z to dane zwrócone przez odpowiednie zapytanie).*/


 DECLARE @ZAROBKI2 INT
 DECLARE @ZATRUDNIONY2 DATE
 DECLARE @nazwisko2 VARCHAR(50)
 DECLARE @imie2 VARCHAR(50)
 SELECT @ZATRUDNIONY2 = MIN(Data_zatrud) FROM PRACOWNICY
 SELECT @nazwisko2 = Nazwisko from Pracownicy where Data_zatrud = @ZATRUDNIONY2
 SELECT @imie2 = Imie from Pracownicy where Data_zatrud = @ZATRUDNIONY2
 SELECT @ZAROBKI2 = Zarobki from Pracownicy where imie = @imie2 and nazwisko = @nazwisko2
 
 PRINT 'Pracownik ' + @imie2 + ' ' + @nazwisko2 + ' zosta³ zatrudniony w dniu: ' + cast ( @zatrudniony2 as varchar(10)) + ' i zarabia: ' + cast(@zarobki2 as varchar(10))

					-- Przyk³adowe zadanie 3 -- 
	/*SprawdŸ czy nazwisko pracownika zarabiaj¹cego najmniej zaczyna siê na
	literê K. Wyœwielt jede z dwóch komunikatów: NAZWISKO NAJMNIEJ ZARABIAJACEGO PRACOWNIKA ZACZYNA SIE NA K  lub
	NAZWISKO NAJMNIEJ ZARABIAJECEGO PRACOWNIKA NIE ZACZYNA SIE NA K */

 DECLARE @nazwisko VARCHAR (50)
 SELECT @nazwisko = NAZWISKO FROM PRACOWNICY ORDER BY Zarobki DESC
 IF LEFT ( @nazwisko ,1) ='K'
 BEGIN
 PRINT 'NAZWISKO NAJMNIEJ ZARABIAJACEGO PRACOWNIKA ZACZYNA SIE NA K'
 PRINT 'JEST TO: '+ @NAZWISKO
 END
 ELSE
 PRINT 'NAZWISKO NAJMNIEJ ZARABIAJECEGO PRACOWNIKA NIE ZACZYNA SIE NA K'


					---- zadanie 3 ----
/*Je¿eli œrednia pensja w firmie jest mniejsza ni¿ 1600, to nale¿y wydrukowaæ komunikat
Zarobki s¹ za ma³e. W sytuacji odwrotnej komunikat ma mieæ postaæ Zarobki s¹ w porz¹dku.
Skorzystaj z polecenia IF. . . ELSE */

  DECLARE @SREDNIE_ZAROBKI INT
  SELECT @SREDNIE_ZAROBKI = AVG(Zarobki) from Pracownicy
	IF (@SREDNIE_ZAROBKI) < 1600
		BEGIN
		PRINT 'Zarobki s¹ za ma³e'
		PRINT 'Zarobki wynosza: ' + CAST(@SREDNIE_ZAROBKI AS VARCHAR(10))
		END
	ELSE
		PRINT 'Zarobki s¹ w porz¹dku'
		PRINT 'Zarobki wynosza: ' + CAST(@SREDNIE_ZAROBKI AS VARCHAR(10))

					---- zadanie 4 ----
/* Dla pracownika o identyfikatorze 6 sprawdziæ ile obs³ugiwa³ zamówieñ. Je¿eli jakieœ
obs³ugiwa³ to nale¿y wydrukowaæ komunikat Klient o podanym identyfikatorze obs³ugiwa³: X
zamówieñ, (gdzie X to liczba zamówieñ), natomiast jeœli nie obs³ugiwa³ ¿adnych zamówieñ, to komunikat powinien mieæ postaæ: Pracownik o podanym identyfikatorze nie obs³ugiwa³ ¿adnych
zamówieñ!. Nastêpnie to samo wykonaæ dla klienta o id=9. (baza NorthWind) */
		
		DECLARE @X4 INT
		DECLARE @ID4 INT
		SELECT @ID4 = 4
		SELECT @X4 = COUNT(OrderID) from Orders where EmployeeID = @ID4
			
			IF(@X4) > 0
				PRINT 'Klient o podanym identyfikatorze obs³ugiwa³: ' + CAST(@X4 AS VARCHAR(10)) + ' zamówieñ'
			ELSE
				PRINT 'Pracownik o podanym identyfikatorze nie obs³ugiwa³ ¿adnychzamówieñ!'
				;

		DECLARE @X42 INT
		DECLARE @ID42 INT
		SELECT @ID42 = 9
		SELECT @X42 = COUNT(OrderID) from Orders where EmployeeID = @ID42
			
			IF(@X42) > 0
				PRINT 'Klient o podanym identyfikatorze obs³ugiwa³: ' + CAST(@X42 AS VARCHAR(10)) + ' zamówieñ'
			ELSE
				PRINT 'Pracownik o podanym identyfikatorze nie obs³ugiwa³ ¿adnychzamówieñ!'
				;
		
		--Przyk³adowe zadanie 4
		--Przypisz do nazwiska pracownika nazwê dzia³u w którym pracuje.
SELECT Nazwisko ,
CASE
	WHEN kod_dzialu =10 THEN 'pracuje w ksiegowosci '
	WHEN kod_dzialu =20 THEN 'pracuje w badaniach '
	WHEN kod_dzialu =30 THEN 'pracuje w sprzedazy '
--WHEN id_depart =40 then ’pracuje w innowacjach ’
ELSE 'pracuje w innowacjach '
END AS [Przypisanie]
FROM Pracownicy
 

					---- zadanie 5 ----		
/* Dla pracowników zarabiaj¹cych mnie ni¿ 3000 nale¿y zwiêkszyœæ wynagrodzenie o 20%,
natomiast tym którzy zarabiaj¹ wiêcej ni¿ 3000 zmniejsz wynagrodzenie o 100.*/
	
SELECT Nazwisko ,
CASE 
	WHEN Zarobki < 3000 THEN Zarobki * 1.2
	WHEN Zarobki = 3000 THEN Zarobki * 1
ELSE Zarobki -100
END AS [Nowe Zarobki]
FROM Pracownicy

					---- zadanie 6 ----		
/* Dla ka¿dego pracownika podaæ imiê, nazwisko, stanowisko i pensjê. W polu pensja
zamiast kwoty wyra¿onej w liczbach, nale¿y umieœciæ tekst:
• Niskie zarobki (je¿eli pracownik zarabia mniej ni¿ 1500),
• Œrednie zarobki (dla zarobków z przedzia³u od 1500 do 3000 w³¹cznie),
• Wysokie zarobki (dla pracowników z zarobkami wiêkszymi ni¿ 3000).*/

SELECT Imie, Nazwisko, Stanowisko ,
CASE 
	WHEN Zarobki < 1500 THEN 'Niskie zarobki'
	WHEN Zarobki > 1500 and Zarobki < 3000 THEN 'Œrednie zarobki'
ELSE 'Wysokie zarobki'
END AS [Pensja]
FROM Pracownicy		;

--Przyk³adowe zadanie 5
/*Przygotuj procedurê sk³adowan¹ która wypisze najwczeœniej zatrudnione
osoby, w ka¿dym departamencie. Identyfikator departamentu powinien byæ przekazanym jako argument
procedur. Natomiast data zatrudnienia przekazywana jest przez drugi argument, który jest zadeklarowany jako wyjœciowy. */
 CREATE PROCEDURE p_NajwczesniejZatrudniony
 ( @IDdepart int = 0 ,
 @Data date OUTPUT)
 AS
	 SELECT @Data = max( Data_zatrud )
	 FROM PRACOWNICY
	 WHERE kod_dzialu = @IDdepart
 GO

 Declare @D date
 EXEC p_NajwczesniejZatrudniony 20 , @D OUTPUT
 Select @D as 'something';


					---- zadanie 7 ----		
/*Utwórz procedurê sk³adowan¹, pokazuj¹c¹ zamówienia klientów i sumaryczn¹ cenê
produktów ka¿dego zamówienia (baza Northwind).*/

CREATE PROCEDURE cena_zamowienia
()
;
--nie rozumiem polecenia

					--Przyk³adowe zadanie 6--
--Zdefiniuj perspektywê, która wypisze maksymalne zarobki na ka¿dymstanowisku.
 CREATE VIEW lab5zad6b (stanowisko, najwyzsze_zarobki )
 AS SELECT stanowisko, max(zarobki) FROM pracownicy
 GROUP BY stanowisko
 GO
 -- sprawdzenie
 SELECT * FROM lab5zad6b
 ;


					---- zadanie 8 ----		
/*Zmieñ strukturê perspektywy z poprzedniego zadania tak aby wyœwietla³a jeszcze
najmniejsze zarobki*/

 CREATE VIEW lab5zad8 (stanowisko, najnizsze_zarobki )
 AS SELECT stanowisko, min(zarobki) FROM pracownicy
 GROUP BY stanowisko
 GO
 -- sprawdzenie
 SELECT * FROM lab5zad8
 ;
 ----------------------------------------------------------------------------
				--Przykladowe zadanie--
	/*CREATE TRIGGER nazwa_wyzwalacza
	ON nazwa_tabeli
	[ WITH ENCRYPTION ]
	{
		{ { FOR | AFTER } { [ INSERT ] [ , UPDATE ] [ , DELETE ] }
			AS instrukcja_T - sql
		}
	|
	{ { FOR | AFTER } { [ INSERT ] [ , UPDATE ]}
		AS
			IF UPDATE ( nazwa_pola )
				[ { AND | OR | UPDATE ( nazwa_pola ) [...]]
			instrukcja_sql [...]
		}
	}
	*/

				--Przyk³adowe zadanie 7--
--Zdefiniuj wyzwalacz, który zabroni zmniejszania pensji pracownikom
 CREATE TRIGGER zakaz ON PRACOWNICY
 after UPDATE
 AS
 BEGIN
 IF update (zarobki)
 begin
 update PRACOWNICY set Zarobki = deleted.zarobki
 from deleted join PRACOWNICY
 on PRACOWNICY.Id_pracownika = deleted.Id_pracownika
 where deleted.zarobki > PRACOWNICY.Zarobki
 end
 end
 go
 -- sprawdzenie
 update PRACOWNICY set Zarobki = Zarobki -1000 where id_pracownika =2
 					
					---- zadanie 9 ----		
/*Dla relacji Pracownicy stwórz wyzwalacz, który w przypadku braku prowizji zamieni
wartoœæ NULL na 10 */

CREATE TRIGGER wyzwalacz_Zad9
on Pracownicy 
AFTER update
AS
BEGIN
	IF update(Prowizja) 
		begin 
		select * from Pracownicy where Prowizja = NULL
		update Pracownicy set Prowizja = 10
		end
END
GO
update Pracownicy set Prowizja = 10

					

				--KURSORY

			DECLARE kur CURSOR
			 FOR SELECT Zarobki FROM PRACOWNICY ORDER BY Zarobki
			 FOR UPDATE OF Zarobki

			 DECLARE @zarobki money
			 DECLARE @podwyzka money
			 DECLARE @pula money
			 SET @pula = 1000

			 OPEN kur
			 -- pobranie nastepny rekordset z kursora i zapisuje wynik w zmiennych

			 -- liczba zmiennych powinna sie pokrywac z liczbe zmiennych z selecta
			 FETCH NEXT FROM kur INTO @zarobki
			 -- zmienna systemowa przechowujaca status operacji fetch otwartego kursora
			 -- 0 oznacza ze zwrocono rekordset , -1 - blad , -2 brak rekordsetu
			 WHILE @@FETCH_STATUS = 0
			 BEGIN
			 -- ustawia podwyzke na 5\% zarobkow
			 SET @podwyzka = @zarobki *0.05
			 -- w puli brakuje zeby pokryc podwyzke to przypisujemy do podwyzki
			 -- reszte puli
			 IF @pula < @podwyzka
			 SET @podwyzka = @pula


			 print 'podwyzka : ' + CAST ( @podwyzka AS varchar ) + ' w puli : ' + CAST ( @pula AS
			varchar )

			 -- update biezacy wiersz na ktorym stoi kursor
			 UPDATE PRACOWNICY SET Zarobki = Zarobki + @podwyzka
			 WHERE CURRENT OF kur

			 SET @pula = @pula - @podwyzka

			 -- przejscie do kolejnego rekordsetu
			 FETCH NEXT FROM kur INTO @zarobki
			 END
			 CLOSE kur
			 DEALLOCATE kur
-----------------------------------------------------------------------------------------
				--Przyk³adowe zadanie 8-- 
/*Przygotuj tabelê produkty, a nastêpnie transakcjê, która przeniesie wszystkie produkty z magazynu nr 1 do magazynu nr 2. Maksymalna pojemnoœæ magazynu nr 2 wynosi 500.
Je¿eli powy¿sza operacja spowoduje przepe³nienie magazynu nale¿y j¹ wycofaæ i przenieœæ produkty do magazynu nr 3. */
 CREATE TABLE Produkty (
 ID_produktu int NOT NULL PRIMARY KEY ,
 Ilosc int NOT NULL ,
 Nr_magazynu int NOT NULL
 )

 INSERT INTO Produkty(Ilosc, Nr_magazynu, ID_produktu )
 VALUES (1, 100, 1)
 INSERT INTO Produkty(Ilosc, Nr_magazynu, ID_produktu )
 VALUES (2, 450, 2)
 INSERT INTO Produkty(Ilosc, Nr_magazynu, ID_produktu )
 VALUES (3, 200, 3)

 begin transaction
 save transaction zamiana
 update Produkty set nr_magazynu =2 where nr_magazynu =1
 if ( select SUM( ilosc ) from produkty where nr_magazynu =2) >500
 begin
 rollback transaction zamiana
 update produkty set nr_magazynu =3 where nr_magazynu =1
 end
 commit transaction
					---- zadanie 10 ----		
/* Korzystaj¹c z tabeli pracownicy oraz dzia³y przygotuj transakcjê, która:
• umo¿liwi zwiêkszenie zarobków w dziale sprzeda¿y o 10%
• dokona symulacji zwiêkszenia zarobków pozosta³ych pracowników, oprócz prezesa, o 10% (wykorzystaj save point)
• wyœwietli informacjê o ile zwiêkszy³y siê miesiêczne wydatki na pensje (po podwy¿ce w dziale
sprzeda¿y) i o ile zwiêkszy³yby siê gdyby podwy¿ka dotyczy³a pozosta³ych pracowników, oprócz
prezesa (rezultat symulacji z poprzedniego punktu) */


begin transaction
save transaction zad10lab5
update Pracownicy set Zarobki = Zarobki * 1.2
where  kod_dzialu = (select id_depart from Dzial where Nazwa = ' Sprzedaz ') --kod30 SprzedaZ

save transaction symulacjazad10lab5;
update Pracownicy set Zarobki = Zarobki * 1.1
where  kod_dzialu != (select id_depart from Dzial where Nazwa = ' Sprzedaz ') and kod_dzialu != (select id_depart from Dzial where Nazwa = ' Prezes ') --kod10 Prezes --pozostalipracownicy
rollback transaction symulacjazad10lab5


save transaction section3
(select sum(Zarobki) from zad10lab5 - (select sum(Zarobki) from Pracownicy)) as Podpunkt 3

save transaction section4
select sum(Zarobki) from symulacjazad10lab5 - (select sum(Zarobki) from Pracownicy) as Podpunkt3



select * from Dzial
select * from Pracownicy









