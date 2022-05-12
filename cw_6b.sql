---------------------------------------------------------------------------------------

--a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodając do niego kierunkowy dla Polski 
--w nawiasie (+48)

ALTER TABLE ksiegowosc.Pracownicy 
ALTER COLUMN telefon TYPE VARCHAR(20);

UPDATE ksiegowosc.Pracownicy 
SET telefon = '(+48)' || telefon;

--b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony był myślnikami wg 
--wzoru: ‘555-222-333’ 

UPDATE ksiegowosc.Pracownicy 
SET telefon = SUBSTRING(telefon, 6, 3) || '-' || SUBSTRING(telefon, 9, 3) || '-' || SUBSTRING(telefon, 12, 3);

--c) Wyświetl dane pracownika, którego nazwisko jest najdłuższe, używając dużych liter

SELECT UPPER(imie), UPPER(nazwisko)
FROM ksiegowosc.Pracownicy
ORDER BY LENGTH(nazwisko) DESC
LIMIT 1;

--d) Wyświetl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5 

SELECT MD5(imie), MD5(nazwisko), MD5(adres), MD5(telefon), MD5(CAST(kwota AS TEXT))
FROM ksiegowosc.Wynagrodzenie
INNER JOIN ksiegowosc.Pracownicy 
ON Wynagrodzenie.id_pracownika = Pracownicy.id_pracownika 
INNER JOIN ksiegowosc.Pensje 
ON Wynagrodzenie.id_pensji = Pensje.id_pensji;

--f) Wyświetl pracowników, ich pensje oraz premie. Wykorzystaj złączenie lewostronne.

SELECT imie, nazwisko, adres, telefon, Pensje.kwota, Premie.kwota
FROM ksiegowosc.Wynagrodzenie
LEFT JOIN ksiegowosc.Pracownicy 
ON Wynagrodzenie.id_pracownika = Pracownicy.id_pracownika
LEFT JOIN ksiegowosc.Pensje 
ON Wynagrodzenie.id_pensji = Pensje.id_pensji
LEFT JOIN ksiegowosc.Premie 
ON Wynagrodzenie.id_premii = Premie.id_premii;

--g) wygeneruj raport (zapytanie), które zwróci w wyniki treść wg poniższego szablonu:

ALTER TABLE ksiegowosc.Godziny
ALTER COLUMN data TYPE VARCHAR(20);

UPDATE ksiegowosc.Godziny 
SET data = SUBSTRING(data, 1, 4) || '.' || SUBSTRING(data, 6, 2) || '.' || SUBSTRING(data, 9, 2);

SELECT CONCAT( 'Pracownik ', imie, ' ', nazwisko, 
			  ', w dniu ', CAST(Wynagrodzenie.data AS date),
			  ' otrzymał pensję całkowitą na kwotę ', CAST((premie.kwota  + pensje.kwota + ((godziny.liczba_godzin - 160) * 20)) AS VARCHAR(15)), 
			  ' zł, gdzie wynagrodzenie zasadnicze wynosiło: ', CAST(pensje.kwota AS VARCHAR(15)),
			  ' zł, premia: ', CAST(Premie.kwota AS VARCHAR(15)),
			  'zł, nadgodziny: ', CAST(((godziny.liczba_godzin - 160) * 20) AS VARCHAR(15)), ' zł') AS Raport
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.Pracownicy 
ON Wynagrodzenie.id_pracownika = Pracownicy.id_pracownika
INNER JOIN ksiegowosc.Premie 
ON Wynagrodzenie.id_premii = Premie.id_premii
INNER JOIN ksiegowosc.Pensje 
ON Wynagrodzenie.id_pensji = Pensje.id_pensji
INNER JOIN ksiegowosc.Godziny 
ON Wynagrodzenie.id_godziny = Godziny.id_godziny
ORDER BY Premie.kwota, Pensje.kwota;

	