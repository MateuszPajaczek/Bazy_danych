--Wykorzystuj�c baz� danych AdventureWorks, zrealizuj poni�sze zadania.
--1. Napisz procedur� wypisuj�c� do konsoli ci�g Fibonacciego. Procedura musi przyjmowa� jako 
--argument wej�ciowy liczb� n. Generowanie ci�gu Fibonacciego musi zosta� 
--zaimplementowane jako osobna funkcja, wywo�ywana przez procedur�.

WITH Fibonacci (PrevN, N) AS
(
     SELECT 0, 1
     UNION ALL
     SELECT N, PrevN + N
     FROM Fibonacci
     WHERE N < 10000
)

SELECT PrevN as Fibo
FROM Fibonacci;
     

--2. Napisz trigger DML, kt�ry po wprowadzeniu danych do tabeli Persons zmodyfikuje nazwisko 
--tak, aby by�o napisane du�ymi literami. 

SELECT * FROM Person.Person;
SELECT * FROM Person.BusinessEntity;

CREATE TRIGGER NAZWISKO
ON Person.Person
AFTER UPDATE 
AS 
BEGIN
UPDATE Person.Person

SET LastName=UPPER(LastName)
END;


INSERT INTO Person.BusinessEntity(rowguid)
VALUES(newid());

INSERT INTO Person.Person(BusinessEntityID,PersonType,FirstName,LastName)
VALUES (20782,'IN','Jan','Nowak');

--3. Przygotuj trigger �taxRateMonitoring�, kt�ry wy�wietli komunikat o b��dzie, je�eli nast�pi 
--zmiana warto�ci w polu �TaxRate� o wi�cej ni� 30%.

CREATE TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
DECLARE @NTR int, @TR int
SELECT @NTR = TaxRate FROM INSERTED SalesTaxRate
SELECT @TR = TaxRate FROM DELETED SalesTaxRate
IF @NTR > 1.3*@TR
PRINT 'B��d - zmiana warto�ci w polu �TaxRate� o wi�cej ni� 30%!'
END;

SELECT * FROM Sales.SalesTaxRate;

UPDATE Sales.SalesTaxRate
SET TaxRate = 100
WHERE SalesTaxRateID = 5;