

--COMMON TABLE EXPRESSION
--Un Common Table Expression (CTE) en SQL es una construcción que te permite definir una tabla temporal 
--con nombre que puedes usar dentro de una consulta más grande. 
--Es especialmente útil para mejorar la legibilidad, modularidad y reutilización de subconsultas complejas

--Un CTE se define con la cláusula WITH, seguida de un nombre y una consulta que genera el conjunto de datos. 
--Luego puedes referenciar ese nombre como si fuera una tabla.

--SINTAXIS BASICA
WITH ventas_por_mes AS (
    SELECT 
        MONTH(fecha) AS mes,
        SUM(total) AS total_mensual
    FROM ventas
    GROUP BY MONTH(fecha)
)
SELECT * FROM ventas_por_mes
WHERE total_mensual > 10000;

-- Claridad: Evita subconsultas anidadas difíciles de leer.
-- Reutilización: Puedes usar el mismo CTE varias veces en la consulta principal.
-- Recursividad: Permite crear CTEs recursivos para trabajar con estructuras jerárquicas como árboles o grafos


--CTE SIMPLE

-- Usar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


/*
Consultar los principales productos por unidades vendidas
*/
--	Definir CTE
WITH TopSoldProducts 
AS
(
    SELECT P.ProductID, P.Name AS ProductName, SUM(OD.OrderQty) AS TotalQuantitySold
    FROM Production.Product P INNER JOIN Sales.SalesOrderDetail OD
		ON P.ProductID = OD.ProductID
    GROUP BY P.ProductID, P.Name
)
--	Consultar CTE
SELECT ProductID, ProductName, TotalQuantitySold
FROM TopSoldProducts
ORDER BY TotalQuantitySold DESC
GO



/*
Consultar el número total de pedidos 
por ventas por año para cada representante de ventas
*/
--	Definir CTE
WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)
AS
(
    SELECT SalesPersonID, SalesOrderID, YEAR(OrderDate) AS SalesYear
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
)
--	Consultar CTE
SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSales, SalesYear
FROM Sales_CTE
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear
GO


--CTE MULTIPLE EN UNA CONSULTA

-- Usar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


/*
Consultar los productos con su subcategoría y categoría asociadas
*/
WITH ProductCategoryCTE		--Definir CTE ProductCategoryCTE
AS
(
    SELECT ProductCategoryID, Name AS CategoryName
    FROM Production.ProductCategory
),
ProductSubcategoryCTE		--Definir CTE ProductSubcategoryCTE
AS
(
    SELECT ProductSubcategoryID, Name AS SubcategoryName, ProductCategoryID
    FROM Production.ProductSubcategory
),
ProductDetailCTE			--Definir CTE ProductDetailCTE
AS
(
    SELECT P.ProductID, P.Name AS ProductName, P.ProductNumber,
        P.Color, P.ListPrice, PS.SubcategoryName, PC.CategoryName
    FROM Production.Product AS P INNER JOIN ProductSubcategoryCTE AS PS
		ON P.ProductSubcategoryID = PS.ProductSubcategoryID
								 INNER JOIN ProductCategoryCTE AS PC
		ON PS.ProductCategoryID = PC.ProductCategoryID
)
--	Consultar CTE
SELECT PD.ProductID, PD.ProductName, PD.ProductNumber, PD.Color,
    PD.ListPrice, PD.SubcategoryName, PD.CategoryName
FROM ProductDetailCTE AS PD
ORDER BY pd.ProductID
GO




/*
Mostrar los importes monetarios en un formato de Moneda
*/
WITH Sales_CTE(SalesPersonID, TotalSales, SalesYear)			--Definir CTE Sales_CTE
AS
(
    SELECT SalesPersonID, SUM(TotalDue) AS TotalSales, YEAR(OrderDate) AS SalesYear
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
    GROUP BY SalesPersonID, YEAR(OrderDate)

),
Sales_Quota_CTE (BusinessEntityID, SalesQuota, SalesQuotaYear)	--Definir CTE Sales_Quota_CTE
AS
(
       SELECT BusinessEntityID, SUM(SalesQuota) AS SalesQuota, YEAR(QuotaDate) AS SalesQuotaYear
       FROM Sales.SalesPersonQuotaHistory
       GROUP BY BusinessEntityID, YEAR(QuotaDate)
)
--	Consultar CTE
SELECT SalesPersonID, 
	SalesYear
  , FORMAT(TotalSales,'C','en-us') AS TotalSales
  , SalesQuotaYear
  , FORMAT(SalesQuota,'C','en-us') AS SalesQuota
  , FORMAT(TotalSales - SalesQuota, 'C','en-us') AS Amt_Above_or_Below_Quota
FROM Sales_CTE INNER JOIN Sales_Quota_CTE 
	ON Sales_Quota_CTE.BusinessEntityID = Sales_CTE.SalesPersonID
		AND Sales_CTE.SalesYear = Sales_Quota_CTE.SalesQuotaYear
ORDER BY SalesPersonID, SalesYear
GO



--CTE ANIDADOS

-- Usar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


/*
Consultar las ventas totales de cada producto
dentro de sus respectivas categoria del producto
junto con información sobre las ventas totales 
de cada Categoría del Producto
*/
WITH ProductSalesByCategory		--Definir CTE ProductSalesByCategory
AS
(
    SELECT PC.Name AS Category, PSC.Name AS Subcategory,
        P.ProductID, P.Name AS ProductName,
        SUM(SOD.LineTotal) AS TotalSales
    FROM Sales.SalesOrderDetail SOD INNER JOIN Production.Product P
		ON SOD.ProductID = P.ProductID
									INNER JOIN Production.ProductSubcategory PSC
		ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
									INNER JOIN Production.ProductCategory PC
		ON PSC.ProductCategoryID = PC.ProductCategoryID
    GROUP BY PC.Name, PSC.Name, P.ProductID, P.Name
),
CategoryTotalSales				--Definir CTE CategoryTotalSales
AS 
(
    SELECT Category, SUM(TotalSales) AS CategoryTotal
    FROM ProductSalesByCategory		--Definir el CTE ProductSalesByCategory
    GROUP BY Category
)
--	Consultar CTE
SELECT C.Category, 
		C.CategoryTotal, 
		P.ProductName, 
		P.TotalSales
FROM ProductSalesByCategory P INNER JOIN CategoryTotalSales C 
	ON P.Category = C.Category
ORDER BY C.Category, P.ProductName
GO


