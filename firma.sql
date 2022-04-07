--1. Utwórz now¹ bazê danych nazywaj¹c j¹ firma.

CREATE DATABASE firma;

USE firma;
GO 

--2. Dodaj nowy schemat o nazwie rozliczenia.

CREATE SCHEMA rozliczenia;


--3. Dodaj schematu rozliczenia dodaj cztery tabele: 
--pracownicy(id_pracownika, imie, nazwisko, adres, telefon) 
--godziny(id_godziny, data, liczba_godzin , id_pracownika) 
--pensje(id_pensji, stanowisko, kwota, id_premii) 
--premie(id_premii, rodzaj, kwota)

--wykonuj¹c nastêpuj¹ce dzia³ania: 
--a) Ustal typy danych tak, aby przetwarzanie i sk³adowanie danych by³o optymalne.
--b) Zastanów siê, które pola musz¹ przyjmowaæ wartoœæ NOT NULL. 
--c) Ustaw klucz g³ówny dla ka¿dej tabeli (jako czêœæ polecenia CREATE TABLE).
--d) Zastanów siê jakie zwi¹zki zachodz¹ pomiêdzy tabelami, a nastêpnie dodaj klucze obce 
--tam, gdzie wystêpuj¹ (wykorzystaj polecenie ALTER TABLE – po uprzednim stworzeniu tabeli).

CREATE TABLE rozliczenia.pracownicy (
	id_pracownika int PRIMARY KEY NOT NULL, 
	imie VARCHAR(30) NOT NULL, 
	nazwisko VARCHAR(30) NOT NULL, 
	adres VARCHAR(50), 
	telefon int UNIQUE
);

CREATE TABLE rozliczenia.godziny (
	id_godziny int PRIMARY KEY NOT NULL, 
	data DATE NOT NULL, 
	liczba_godzin int, 
	id_pracownika int NOT NULL
);

CREATE TABLE rozliczenia.pensje (
	id_pensji int PRIMARY KEY NOT NULL, 
	stanowisko VARCHAR(30), 
	kwota float, 
	id_premii int
);

CREATE TABLE rozliczenia.premie (
	id_premii int PRIMARY KEY NOT NULL, 
	rodzaj VARCHAR(30), 
	kwota int
);

--klucz obcy w tabeli godziny
	ALTER TABLE rozliczenia.godziny ADD CONSTRAINT id_pracownika FOREIGN KEY (id_pracownika) 
	REFERENCES rozliczenia.pracownicy(id_pracownika) ON UPDATE CASCADE ON DELETE CASCADE;

--klucz obcy w tabeli pensje
	ALTER TABLE rozliczenia.pensje ADD CONSTRAINT id_premii FOREIGN KEY (id_premii) 
	REFERENCES rozliczenia.premie(id_premii) ON UPDATE CASCADE ON DELETE CASCADE;


--4. Wype³nij ka¿d¹ tabelê 10. rekordami.

--wstawiam do tabeli pracownicy
	INSERT INTO rozliczenia.pracownicy VALUES(1, 'Andrzej', 'Kowalski', 'Zaborze 28 Krakow, Poland', 844737922);
	INSERT INTO rozliczenia.pracownicy VALUES(2, 'Anna', 'Nowak', 'Stroma 34 Krakow, Poland', 873612923);
	INSERT INTO rozliczenia.pracownicy VALUES(3, 'Konrad', 'Jakubowski', 'Lipowa 3 Krakow, Poland', 923619836);
	INSERT INTO rozliczenia.pracownicy VALUES(4, 'Dagmara', 'Wysocka', 'Foremna 33 Krakow, Poland', 546839843);
	INSERT INTO rozliczenia.pracownicy VALUES(5, 'Iga', 'Malinowska', 'Szara 6 Krakow, Poland', 642378765);
	INSERT INTO rozliczenia.pracownicy VALUES(6, 'Natasza', 'Duda', 'Kudowska 11 Krakow, Poland', 436789327);
	INSERT INTO rozliczenia.pracownicy VALUES(7, 'Kamil', 'Witkowski', 'Kirkora 30 Krakow, Poland', 938226734);
	INSERT INTO rozliczenia.pracownicy VALUES(8, 'Alex', 'Mroz', 'Braniborska 17 Krakow, Poland', 738922674);
	INSERT INTO rozliczenia.pracownicy VALUES(9, 'Roksana', 'Rutkowska', 'Kamieniarska 24 Krakow, Poland', 489323732);
	INSERT INTO rozliczenia.pracownicy VALUES(10, 'Arkadiusz', 'Baranowski', 'Zawiszy 33 Krakow, Poland', 348974578);

--wstawiam do tabeli godziny
	INSERT INTO rozliczenia.godziny VALUES(1, '2022-04-01', 8, 7);
	INSERT INTO rozliczenia.godziny VALUES(2, '2022-04-01', 9, 3);
	INSERT INTO rozliczenia.godziny VALUES(3, '2022-04-01', 7, 4);
	INSERT INTO rozliczenia.godziny VALUES(4, '2022-04-02', 9, 6);
	INSERT INTO rozliczenia.godziny VALUES(5, '2022-04-02', 9, 5);
	INSERT INTO rozliczenia.godziny VALUES(6, '2022-04-04', 8, 5);
	INSERT INTO rozliczenia.godziny VALUES(7, '2022-04-05', 7, 1);
	INSERT INTO rozliczenia.godziny VALUES(8, '2022-04-05', 10, 8);
	INSERT INTO rozliczenia.godziny VALUES(9, '2022-04-05', 9, 3);
	INSERT INTO rozliczenia.godziny VALUES(10, '2022-04-05', 9, 7);


--wstawiam do tabeli premie
	INSERT INTO rozliczenia.premie VALUES(1, 'regulaminowa', 200);
	INSERT INTO rozliczenia.premie VALUES(2, 'uznaniowa', 500);
	INSERT INTO rozliczenia.premie VALUES(3, 'motywacyjna', 800);
	INSERT INTO rozliczenia.premie VALUES(4, 'zadaniowa', 1000);
	INSERT INTO rozliczenia.premie VALUES(5, 'wynikowa', 2000);
	INSERT INTO rozliczenia.premie (id_premii, rodzaj) VALUES(6, 'premia6');
	INSERT INTO rozliczenia.premie (id_premii, rodzaj) VALUES(7, 'premia7');
	INSERT INTO rozliczenia.premie (id_premii, rodzaj) VALUES(8, 'premia8');
	INSERT INTO rozliczenia.premie (id_premii, rodzaj) VALUES(9, 'premia9');
	INSERT INTO rozliczenia.premie (id_premii, rodzaj) VALUES(10, 'premia10');


--wstawiam do tabeli pensje
	INSERT INTO rozliczenia.pensje VALUES(1, 'asystent', 4000, 3);
	INSERT INTO rozliczenia.pensje VALUES(2, 'm³odszy specjalista', 4500, 2);
	INSERT INTO rozliczenia.pensje VALUES(3, 'specjalista', 5500, 1);
	INSERT INTO rozliczenia.pensje VALUES(4, 'starszy specjalista', 7000, 4);
	INSERT INTO rozliczenia.pensje VALUES(5, 'programista', 7000, 4);
	INSERT INTO rozliczenia.pensje (id_pensji, stanowisko, kwota) VALUES(6, 'kierowca', 4000);
	INSERT INTO rozliczenia.pensje (id_pensji, stanowisko, kwota) VALUES(7, 'stazysta', 3500);
	INSERT INTO rozliczenia.pensje VALUES(8, 'administrator', 8000, 4);
	INSERT INTO rozliczenia.pensje VALUES(9, 'manager', 10000, 5);
	INSERT INTO rozliczenia.pensje (id_pensji, stanowisko, kwota) VALUES(10, 'dyrektor', 20000);
	
--5. Za pomoc¹ zapytania SQL wyœwietl nazwiska pracowników i ich adresy.

	SELECT nazwisko, adres FROM rozliczenia.pracownicy;

--6. Napisz zapytanie, które przekonwertuje datê w tabeli godziny tak, aby wyœwietlana by³a 
--informacja jaki to dzieñ tygodnia i jaki miesi¹c (funkcja DATEPART x2).

	SELECT DATEPART("w",[data]) AS dzien_tygodnia, DATEPART("m",[data]) AS miesiac, data  FROM rozliczenia.godziny;

--7. W tabeli pensje zmieñ nazwê atrybutu kwota na kwota_brutto oraz dodaj nowy o nazwie 
--kwota_netto. Oblicz kwotê netto i zaktualizuj wartoœci w tabeli.

	EXEC sp_RENAME 'rozliczenia.pensje.kwota' , 'kwota_brutto', 'COLUMN';
	
	ALTER TABLE rozliczenia.pensje ADD kwota_netto AS (kwota_brutto - (kwota_brutto*0.23));

	SELECT * FROM rozliczenia.pensje;