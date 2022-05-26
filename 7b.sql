--Wykorzystuj¹c bazê danych AdventureWorks, zrealizuj poni¿sze zadania.
--1. Napisz procedurê wypisuj¹c¹ do konsoli ci¹g Fibonacciego. Procedura musi przyjmowaæ jako 
--argument wejœciowy liczbê n. Generowanie ci¹gu Fibonacciego musi zostaæ 
--zaimplementowane jako osobna funkcja, wywo³ywana przez procedurê.

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
     

--2. Napisz trigger DML, który po wprowadzeniu danych do tabeli Persons zmodyfikuje nazwisko 
--tak, aby by³o napisane du¿ymi literami. 

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

--3. Przygotuj trigger ‘taxRateMonitoring’, który wyœwietli komunikat o b³êdzie, je¿eli nast¹pi 
--zmiana wartoœci w polu ‘TaxRate’ o wiêcej ni¿ 30%.

CREATE TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
DECLARE @NTR int, @TR int
SELECT @NTR = TaxRate FROM INSERTED SalesTaxRate
SELECT @TR = TaxRate FROM DELETED SalesTaxRate
IF @NTR > 1.3*@TR
PRINT 'B³¹d - zmiana wartoœci w polu ‘TaxRate’ o wiêcej ni¿ 30%!'
END;

SELECT * FROM Sales.SalesTaxRate;

UPDATE Sales.SalesTaxRate
SET TaxRate = 100
WHERE SalesTaxRateID = 5;