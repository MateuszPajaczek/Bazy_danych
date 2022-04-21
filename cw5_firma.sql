-- Database: firma

-- DROP DATABASE IF EXISTS firma;

CREATE DATABASE firma
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Polish_Poland.1250'
    LC_CTYPE = 'Polish_Poland.1250'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
CREATE SCHEMA ksiegowosc;

CREATE TABLE ksiegowosc.pracownicy (
	id_pracownika int PRIMARY KEY NOT NULL, 
	imie VARCHAR(30) NOT NULL, 
	nazwisko VARCHAR(30) NOT NULL, 
	adres VARCHAR(50), 
	telefon VARCHAR(9) UNIQUE
);

CREATE TABLE ksiegowosc.godziny (
	id_godziny int PRIMARY KEY NOT NULL, 
	data DATE NOT NULL, 
	liczba_godzin int, 
	id_pracownika int NOT NULL
);

CREATE TABLE ksiegowosc.pensje (
	id_pensji int PRIMARY KEY NOT NULL, 
	stanowisko VARCHAR(30), 
	kwota float 
);

CREATE TABLE ksiegowosc.premie (
	id_premii int PRIMARY KEY NOT NULL, 
	rodzaj VARCHAR(30), 
	kwota int
);

CREATE TABLE ksiegowosc.wynagrodzenie (
	id_wynagrodzenia int PRIMARY KEY NOT NULL,
	data date NOT NULL,
	id_pracownika int NOT NULL,
	id_godziny int NOT NULL,
	id_pensji int NOT NULL,
	id_premii int 
);

	ALTER TABLE ksiegowosc.godziny ADD CONSTRAINT id_pracownika FOREIGN KEY (id_pracownika) 
	REFERENCES ksiegowosc.pracownicy(id_pracownika) 
	
	ALTER TABLE ksiegowosc.wynagrodzenie ADD CONSTRAINT id_pracownika FOREIGN KEY (id_pracownika) 
	REFERENCES ksiegowosc.pracownicy(id_pracownika);
	
	ALTER TABLE ksiegowosc.wynagrodzenie ADD CONSTRAINT id_pensji FOREIGN KEY (id_pensji) 
	REFERENCES ksiegowosc.pensje(id_pensji);
	
	ALTER TABLE ksiegowosc.wynagrodzenie ADD CONSTRAINT id_godziny FOREIGN KEY (id_godziny) 
	REFERENCES ksiegowosc.godziny(id_godziny);	
	
	ALTER TABLE ksiegowosc.wynagrodzenie ADD CONSTRAINT id_premii FOREIGN KEY (id_premii) 
	REFERENCES ksiegowosc.premie(id_premii);	
	
--wstawiam do tabeli pracownicy
	
INSERT INTO ksiegowosc.pracownicy VALUES(1, 'Andrzej', 'Kowalski', 'Zaborze 28 Krakow, Poland', 844737922);
INSERT INTO ksiegowosc.pracownicy VALUES(2, 'Janina', 'Nowak', 'Stroma 34 Krakow, Poland', 873612923);
INSERT INTO ksiegowosc.pracownicy VALUES(3, 'Konrad', 'Jakubowski', 'Lipowa 3 Krakow, Poland', 923619836);
INSERT INTO ksiegowosc.pracownicy VALUES(4, 'Dagmara', 'Wysocka', 'Foremna 33 Krakow, Poland', 546839843);
INSERT INTO ksiegowosc.pracownicy VALUES(5, 'Iga', 'Malinowska', 'Szara 6 Krakow, Poland', 642378765);
INSERT INTO ksiegowosc.pracownicy VALUES(6, 'Natasza', 'Duda', 'Kudowska 11 Krakow, Poland', 436789327);
INSERT INTO ksiegowosc.pracownicy VALUES(7, 'Jan', 'Witkowski', 'Kirkora 30 Krakow, Poland', 938226734);
INSERT INTO ksiegowosc.pracownicy VALUES(8, 'Alex', 'Mroz', 'Braniborska 17 Krakow, Poland', 738922674);
INSERT INTO ksiegowosc.pracownicy VALUES(9, 'Roksana', 'Rutkowska', 'Kamieniarska 24 Krakow, Poland', 489323732);
INSERT INTO ksiegowosc.pracownicy VALUES(10, 'Arkadiusz', 'Baranowski', 'Zawiszy 33 Krakow, Poland', 348974578);
INSERT INTO ksiegowosc.pracownicy VALUES(11, 'Marek', 'Mostowiak', 'Krzywa 22 Krakow, Poland', 573864643);

--godziny
INSERT INTO ksiegowosc.godziny VALUES(1, '2022-04-01', 163, 7);
INSERT INTO ksiegowosc.godziny VALUES(2, '2022-04-01', 140, 3);
INSERT INTO ksiegowosc.godziny VALUES(3, '2022-04-01', 133, 4);
INSERT INTO ksiegowosc.godziny VALUES(4, '2022-04-02', 172, 6);
INSERT INTO ksiegowosc.godziny VALUES(5, '2022-04-02', 156, 5);
INSERT INTO ksiegowosc.godziny VALUES(6, '2022-04-04', 173, 2);
INSERT INTO ksiegowosc.godziny VALUES(7, '2022-04-05', 132, 1);
INSERT INTO ksiegowosc.godziny VALUES(8, '2022-04-05', 140, 8);
INSERT INTO ksiegowosc.godziny VALUES(9, '2022-04-05', 160, 9);
INSERT INTO ksiegowosc.godziny VALUES(10, '2022-04-05', 203, 10);
INSERT INTO ksiegowosc.godziny VALUES(11, '2022-04-06', 165, 10);

--wstawiam do tabeli pensje
INSERT INTO ksiegowosc.pensje VALUES(1, 'asystent', 950);
INSERT INTO ksiegowosc.pensje VALUES(2, 'młodszy specjalista', 1700);
INSERT INTO ksiegowosc.pensje VALUES(3, 'specjalista', 5500);
INSERT INTO ksiegowosc.pensje VALUES(4, 'starszy specjalista', 7000);
INSERT INTO ksiegowosc.pensje VALUES(5, 'programista', 7000);
INSERT INTO ksiegowosc.pensje VALUES(6, 'kierowca', 4000);
INSERT INTO ksiegowosc.pensje VALUES(7, 'stazysta', 3500);
INSERT INTO ksiegowosc.pensje VALUES(8, 'administrator', 8000);
INSERT INTO ksiegowosc.pensje VALUES(9, 'manager', 10000);
INSERT INTO ksiegowosc.pensje VALUES(10, 'dyrektor', 20000);
	
	
--wstawiam do tabeli premie
INSERT INTO ksiegowosc.premie VALUES(1, 'regulaminowa', 200);
INSERT INTO ksiegowosc.premie VALUES(2, 'uznaniowa', 500);
INSERT INTO ksiegowosc.premie VALUES(3, 'motywacyjna', 800);
INSERT INTO ksiegowosc.premie VALUES(4, 'zadaniowa', 1000);
INSERT INTO ksiegowosc.premie VALUES(5, 'wynikowa', 2000);
INSERT INTO ksiegowosc.premie (id_premii, rodzaj) VALUES(6, 'premia6');
INSERT INTO ksiegowosc.premie (id_premii, rodzaj) VALUES(7, 'premia7');
INSERT INTO ksiegowosc.premie (id_premii, rodzaj) VALUES(8, 'premia8');
INSERT INTO ksiegowosc.premie (id_premii, rodzaj) VALUES(9, 'premia9');
INSERT INTO ksiegowosc.premie (id_premii, rodzaj) VALUES(10, 'premia10');
	
--wstawiam do tabeli wynagrodzenia
INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika,id_godziny, id_pensji) VALUES(1, '2022-04-21', 1, 10, 1);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(2, '2022-04-21', 2, 9, 2, 1);
INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika,id_godziny, id_pensji) VALUES(3, '2022-04-21', 3, 8, 3);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(4, '2022-04-21', 4, 7, 4, 2);
INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika,id_godziny, id_pensji) VALUES(5, '2022-04-21', 5, 6, 5);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(6, '2022-04-21', 6, 5, 6, 3);
INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika,id_godziny, id_pensji) VALUES(7, '2022-04-21', 7, 4, 7);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(8, '2022-04-21', 8, 3, 8, 4);
INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika,id_godziny, id_pensji) VALUES(9, '2022-04-21', 9, 2, 9);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(10, '2022-04-21', 10, 1, 10, 5);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(11, '2022-04-21', 11, 11, 10, 5);
	
SELECT * FROM ksiegowosc.wynagrodzenie;
	
--6.a
SELECT id_pracownika, nazwisko 
FROM ksiegowosc.pracownicy;
	
--6.b
SELECT id_pracownika 
FROM ksiegowosc.wynagrodzenie 
WHERE id_pensji IN (SELECT id_pensji 
					FROM ksiegowosc.pensje 
					WHERE kwota > 1000);
					
--6.c
SELECT id_pracownika 
FROM ksiegowosc.wynagrodzenie 
WHERE id_premii IS NULL
AND id_pensji IN (SELECT id_pensji
				 FROM ksiegowosc.pensje
				 WHERE kwota > 2000);
				 
--6.d
SELECT *
FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%'

--6.e
SELECT *
FROM ksiegowosc.pracownicy
WHERE (nazwisko LIKE '%n%' OR nazwisko LIKE '%N%')
AND imie LIKE '%a'

--6.f
SELECT imie, nazwisko, (liczba_godzin - 160) AS nadgodziny
FROM ksiegowosc.pracownicy 
INNER JOIN ksiegowosc.godziny 
ON godziny.id_pracownika = pracownicy.id_pracownika 
WHERE liczba_godzin > 160;

--6.g
SELECT imie, nazwisko, kwota 
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pracownicy 
ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika 
INNER JOIN ksiegowosc.pensje 
ON wynagrodzenie.id_pensji = pensje.id_pensji 
WHERE kwota BETWEEN 1500 AND 3000;

--6.h
SELECT imie, nazwisko
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.godziny
ON godziny.id_godziny = wynagrodzenie.id_godziny
INNER JOIN ksiegowosc.pracownicy
ON wynagrodzenie.id_pracownika = godziny.id_pracownika 
WHERE id_premii IS NULL
AND liczba_godzin > 160;

--6.i
SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko, pensje.kwota
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pracownicy
ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
INNER JOIN ksiegowosc.pensje
ON wynagrodzenie.id_pensji = pensje.id_pensji
ORDER BY kwota;

--6.j
SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko, pensje.kwota AS pensja, 
	premie.kwota AS premia
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pracownicy
ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
INNER JOIN ksiegowosc.pensje
ON wynagrodzenie.id_pensji = pensje.id_pensji
INNER JOIN ksiegowosc.premie
ON wynagrodzenie.id_premii = premie.id_premii
ORDER BY premie.kwota DESC, pensje.kwota DESC;

--6.k
SELECT stanowisko, COUNT(pensje.stanowisko) AS suma 
FROM ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pracownicy 
ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
INNER JOIN ksiegowosc.pensje 
ON wynagrodzenie.id_pensji = pensje.id_pensji
GROUP BY pensje.stanowisko;

--6.l
SELECT AVG(kwota) AS średnia, MIN(kwota) AS minimum, MAX(kwota) AS maksimum
FROM ksiegowosc.pensje
WHERE pensje.stanowisko = 'dyrektor';

--6.m
SELECT SUM(kwota) AS suma
FROM ksiegowosc.pensje;

--6.f
SELECT stanowisko, SUM(kwota) AS suma, COUNT(stanowisko) AS stanowiska 
FROM ksiegowosc.pensje 
GROUP BY stanowisko;

--6.g
SELECT stanowisko, COUNT(premie.id_premii) AS premie 
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.premie 
ON wynagrodzenie.id_premii = premie.id_premii
INNER JOIN ksiegowosc.pensje 
ON wynagrodzenie.id_pensji = pensje.id_pensji 
GROUP BY stanowisko;

--6.h
DELETE pracownicy 
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pracownicy 
ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
INNER JOIN ksiegowosc.pensje 
ON wynagrodzenie.id_pensji = pensje.id_pensji  
WHERE kwota < 1200;

	
	