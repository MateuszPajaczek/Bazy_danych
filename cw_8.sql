--1. Wykorzystuj�c wyra�enie CTE zbuduj zapytanie, kt�re znajdzie informacje na temat stawki 
--pracownika oraz jego danych, a nast�pnie zapisze je do tabeli tymczasowej 
--TempEmployeeInfo. Rozwi�� w oparciu o AdventureWorks.

USE AdventureWorks2019
GO

SELECT *
FROM HumanResources.EmployeePayHistory;

SELECT *
FROM Person.Person;

SELECT *
FROM HumanResources.Employee;

WITH employee_rate (BusinessEntityID, Title, FirstName, LastName, Rate, HireDate)
AS
(
SELECT p.BusinessEntityID, p.Title, p.FirstName, p.LastName, r.Rate, e.HireDate
FROM Person.Person AS p
INNER JOIN HumanResources.EmployeePayHistory AS r
ON r.BusinessEntityID=p.BusinessEntityID
INNER JOIN HumanResources.Employee AS e
ON p.BusinessEntityID = e.BusinessEntityID
)
SELECT * INTO #TempEmployeeInfo 
FROM employee_rate;

SELECT * FROM #TempEmployeeInfo 
ORDER BY BusinessEntityID ASC;

DROP TABLE #TempEmployeeInfo;

		
--2. Uzyskaj informacje na temat przychod�w ze sprzeda�y wed�ug firmy i kontaktu (za pomoc� 
--CTE i bazy AdventureWorksL). Wynik powinien wygl�da� nast�puj�co:

USE AdventureWorksLT2019;
GO

WITH sales_revenues (CompanyContact, TotalDue)
AS 
(
SELECT CONCAT(CompanyName, ' (', FirstName, ' ', LastName, ')') as CompanyContact, TotalDue as Revenues
FROM SalesLT.Customer c 
INNER JOIN SalesLT.SalesOrderHeader s
ON c.CustomerID = s.CustomerID )

SELECT * FROM sales_revenues 
ORDER BY CompanyContact ASC;

--3. Napisz zapytanie, kt�re zwr�ci warto�� sprzeda�y dla poszczeg�lnych kategorii produkt�w.
--Wykorzystaj CTE i baz� AdventureWorksLT.

WITH product_sales_value (Category, SalesValue)
AS
(
SELECT pc.Name AS Category, SUM(sod.LineTotal) AS SalesValue 
FROM SalesLT.ProductCategory AS pc
INNER JOIN SalesLT.Product AS p
ON  pc.ProductCategoryID = p.ProductCategoryID
INNER JOIN SalesLT.SalesOrderDetail AS sod
ON  sod.ProductID = p.ProductID 
GROUP BY pc.Name
)

SELECT Category, SalesValue 
FROM product_sales_value
ORDER BY Category;
