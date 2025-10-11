

--OPERADORES PIVOT Y UNPIVOT
--El operador PIVOT reorganiza los datos de forma horizontal, convirtiendo valores únicos de una columna 
--en nombres de columnas. Es útil cuando quieres ver datos agregados por categorías

--Con PIVOT, puedes convertir los meses en columnas

-- VENDEDOR			MES			VENTAS

-- ANA				ENE			100
-- ANA				FEB			200
-- LUIS				ENE			300
-- LUIS				FEB			250


SELECT *
FROM (
    SELECT Vendedor, Mes, Ventas
    FROM Ventas
) AS Fuente
PIVOT (
    SUM(Ventas)
    FOR Mes IN ([Ene], [Feb])
) AS TablaPivoteada;


-- VENDEDOR			ENE			FEB

-- ANA				100			200
-- LUIS				300			250


--El operador UNPIVOT hace lo contrario: convierte columnas en filas, útil para normalizar datos o preparar
--información para análisis.

--Partiendo del resultado anterior, puedes volver al formato original

SELECT Vendedor, Mes, Ventas
FROM (
    SELECT Vendedor, [Ene], [Feb]
    FROM VentasPivoteadas
) AS Fuente
UNPIVOT (
    Ventas FOR Mes IN ([Ene], [Feb])
) AS TablaUnpivoteada;


-- VENDEDOR			MES			VENTAS

-- ANA				ENE			100
-- ANA				FEB			200
-- LUIS				ENE			300
-- LUIS				FEB			250


-- PIVOT requiere una función de agregación como SUM, AVG, etc.
-- Los nombres de columnas en IN (...) deben estar definidos explícitamente.
-- UNPIVOT es ideal para transformar reportes en estructuras normalizadas

--///////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////

--PIVOT

-- Ubicarnos en la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


/*
Realizar el cálculo de las ventas totales por Año
*/
--		Subconsulta
SELECT * FROM 
(
	SELECT YEAR(SOH.OrderDate) as SalesYear,
		SOH.SubTotal as TotalSales
	FROM sales.SalesOrderHeader SOH INNER JOIN sales.SalesOrderDetail SOD 
		ON SOH.SalesOrderId = SOD.SalesOrderId
) AS Sales
PIVOT 
(
	SUM(TotalSales)
	FOR SalesYear 
	IN ([2011], [2012], [2013], [2014])
) AS PVT
GO


--	USANDO CTE
WITH cte_yearSales
AS
(
	SELECT YEAR(SOH.OrderDate) as SalesYear,
		SOH.SubTotal as TotalSales
	FROM sales.SalesOrderHeader SOH JOIN sales.SalesOrderDetail SOD 
		ON SOH.SalesOrderId = SOD.SalesOrderId
)
SELECT * FROM cte_yearSales
PIVOT 
(
	SUM(TotalSales)
	FOR SalesYear 
	IN ([2011], [2012], [2013], [2014])
) AS PVT
GO







/*
Obtener las ventas Trimestrales por Año
*/
--		Subconsulta
SELECT SalesYear, 
       ISNULL([Q1], 0) AS Q1, 
       ISNULL([Q2], 0) AS Q2, 
       ISNULL([Q3], 0) AS Q3, 
       ISNULL([Q4], 0) AS Q4, 
       (ISNULL([Q1], 0) + ISNULL([Q2], 0) + ISNULL([Q3], 0) + ISNULL([Q4], 0)) SalesYTD
FROM
(
    SELECT YEAR(SOH.OrderDate) AS SalesYear, 
           CAST('Q'+CAST(DATEPART(QUARTER, SOH.OrderDate) AS VARCHAR(1)) AS VARCHAR(2)) Quarters, 
           SOH.SubTotal AS TotalSales
    FROM sales.SalesOrderHeader SOH INNER JOIN sales.SalesOrderDetail SOD 
		ON SOH.SalesOrderId = SOD.SalesOrderId
 ) AS Data 
 PIVOT
 (
	SUM(TotalSales) 
	FOR Quarters 
	IN([Q1], [Q2], [Q3], [Q4])
) AS pvt
ORDER BY SalesYear
GO


--	USANDO CTE
WITH cte_quarterSales
AS
(
    SELECT YEAR(SOH.OrderDate) AS SalesYear, 
           CAST('Q'+CAST(DATEPART(QUARTER, SOH.OrderDate) AS VARCHAR(1)) AS VARCHAR(2)) Quarters, 
           SOH.SubTotal AS TotalSales
    FROM sales.SalesOrderHeader SOH INNER JOIN sales.SalesOrderDetail SOD 
		ON SOH.SalesOrderId = SOD.SalesOrderId
)
SELECT SalesYear, 
       ISNULL([Q1], 0) AS Q1, 
       ISNULL([Q2], 0) AS Q2, 
       ISNULL([Q3], 0) AS Q3, 
       ISNULL([Q4], 0) AS Q4, 
       (ISNULL([Q1], 0) + ISNULL([Q2], 0) + ISNULL([Q3], 0) + ISNULL([Q4], 0)) SalesYTD
FROM cte_quarterSales
PIVOT 
(
	SUM(TotalSales)
	FOR Quarters 
	IN ([Q1], [Q2], [Q3], [Q4])
) AS pvt
ORDER BY SalesYear
GO







/*
Obtener las ventas Mensuales por Año
*/
--		Subconsulta
SELECT SalesYear, 
       ISNULL([1], 0) AS Enero, 
       ISNULL([2], 0) AS Febrero, 
       ISNULL([3], 0) AS Marzo, 
       ISNULL([4], 0) AS Abril, 
       ISNULL([5], 0) AS Mayo, 
       ISNULL([6], 0) AS Junio, 
       ISNULL([7], 0) AS Julio, 
       ISNULL([8], 0) AS Agosto, 
       ISNULL([9], 0) AS Septiembre, 
       ISNULL([10], 0) AS Octubre, 
       ISNULL([11], 0) AS Noviembre, 
       ISNULL([12], 0) AS Deciembre, 
       (ISNULL([1], 0) + ISNULL([2], 0) + ISNULL([3], 0) + ISNULL([4], 0) + ISNULL([4], 0) + 
	    ISNULL([5], 0) + ISNULL([6], 0) + ISNULL([7], 0) + ISNULL([8], 0) + ISNULL([9], 0) + 
		ISNULL([10], 0) + ISNULL([11], 0) + ISNULL([12], 0)) SalesYTD
FROM
(
    SELECT YEAR(SOH.OrderDate) AS SalesYear, 
           DATEPART(MONTH, SOH.OrderDate) Months,
           SOH.SubTotal AS TotalSales
    FROM sales.SalesOrderHeader SOH INNER JOIN sales.SalesOrderDetail SOD 
		ON SOH.SalesOrderId = SOD.SalesOrderId
 ) AS Data 
 PIVOT
 (
	SUM(TotalSales) 
	FOR Months 
	IN([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
) AS pvt
ORDER BY SalesYear
GO


--	USANDO CTE
WITH cte_monthSales
AS
(
    SELECT YEAR(SOH.OrderDate) AS SalesYear, 
           DATEPART(MONTH, SOH.OrderDate) Months,
           SOH.SubTotal AS TotalSales
    FROM sales.SalesOrderHeader SOH INNER JOIN sales.SalesOrderDetail SOD 
		ON SOH.SalesOrderId = SOD.SalesOrderId
)
SELECT SalesYear, 
       ISNULL([1], 0) AS Jan, 
       ISNULL([2], 0) AS Feb, 
       ISNULL([3], 0) AS Mar, 
       ISNULL([4], 0) AS Apr, 
       ISNULL([5], 0) AS May, 
       ISNULL([6], 0) AS Jun, 
       ISNULL([7], 0) AS Jul, 
       ISNULL([8], 0) AS Aug, 
       ISNULL([9], 0) AS Sep, 
       ISNULL([10], 0) AS Oct, 
       ISNULL([11], 0) AS Nov, 
       ISNULL([12], 0) AS Dec, 
       (ISNULL([1], 0) + ISNULL([2], 0) + ISNULL([3], 0) + ISNULL([4], 0) + ISNULL([4], 0) + 
	    ISNULL([5], 0) + ISNULL([6], 0) + ISNULL([7], 0) + ISNULL([8], 0) + ISNULL([9], 0) + 
		ISNULL([10], 0) + ISNULL([11], 0) + ISNULL([12], 0)) SalesYTD
FROM cte_monthSales
PIVOT 
(
	SUM(TotalSales)
	FOR Months 
	IN([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
) AS pvt
ORDER BY SalesYear
GO


--UNPIVOT

-- Ubicarnos en la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


/*
Realizar el cálculo de las ventas totales por Año
*/
--		Subconsulta
SELECT SalesYear,
		TotalSales
FROM
(
	SELECT * FROM 
	(
		SELECT YEAR(SOH.OrderDate) as SalesYear,
			SOH.SubTotal as TotalSales
		FROM sales.SalesOrderHeader SOH INNER JOIN sales.SalesOrderDetail SOD 
			ON SOH.SalesOrderId = SOD.SalesOrderId
	) AS Sales
	PIVOT 
	(
		SUM(TotalSales)
		FOR SalesYear 
		IN ([2011], [2012], [2013], [2014])
	) AS PVT
) AS T
UNPIVOT
(
	TotalSales
	FOR SalesYear
	IN ([2011], [2012], [2013], [2014])
) AS UNPVT
GO


--	USANDO	CTE
WITH cte_yearSales
AS
(
	SELECT YEAR(SOH.OrderDate) as SalesYear,
		SOH.SubTotal as TotalSales
	FROM sales.SalesOrderHeader SOH JOIN sales.SalesOrderDetail SOD 
		ON SOH.SalesOrderId = SOD.SalesOrderId
),
cte_pvtYearSales
AS
(
	SELECT * FROM cte_yearSales
	PIVOT 
	(
		SUM(TotalSales)
		FOR SalesYear 
		IN ([2011], [2012], [2013], [2014])
	) AS PVT
)
SELECT SalesYear,
		TotalSales
FROM cte_pvtYearSales
UNPIVOT
(
	TotalSales
	FOR SalesYear
	IN ([2011], [2012], [2013], [2014])
) AS UNPVT
GO







/*
Obtener las ventas Trimestrales por Año
*/
--		Subconsulta
SELECT SalesYear,
		Quarters AS [Quarter],
		TotalSales
FROM
(
	SELECT SalesYear, 
		   ISNULL([Q1], 0) AS Q1, 
		   ISNULL([Q2], 0) AS Q2, 
		   ISNULL([Q3], 0) AS Q3, 
		   ISNULL([Q4], 0) AS Q4, 
		   (ISNULL([Q1], 0) + ISNULL([Q2], 0) + ISNULL([Q3], 0) + ISNULL([Q4], 0)) SalesYTD
	FROM
	(
		SELECT YEAR(SOH.OrderDate) AS SalesYear, 
			   CAST('Q'+CAST(DATEPART(QUARTER, SOH.OrderDate) AS VARCHAR(1)) AS VARCHAR(2)) Quarters, 
			   SOH.SubTotal AS TotalSales
		FROM sales.SalesOrderHeader SOH INNER JOIN sales.SalesOrderDetail SOD 
			ON SOH.SalesOrderId = SOD.SalesOrderId
	 ) AS Data 
	 PIVOT
	 (
		SUM(TotalSales) 
		FOR Quarters 
		IN([Q1], [Q2], [Q3], [Q4])
	) AS pvt
) AS T
UNPIVOT
(
	TotalSales
	FOR Quarters
	IN ([Q1], [Q2], [Q3], [Q4])
) AS UPVT
ORDER BY SalesYear
GO


--	USANDO	CTE
WITH cte_quarterSales
AS
(
    SELECT YEAR(SOH.OrderDate) AS SalesYear, 
           CAST('Q'+CAST(DATEPART(QUARTER, SOH.OrderDate) AS VARCHAR(1)) AS VARCHAR(2)) Quarters, 
           SOH.SubTotal AS TotalSales
    FROM sales.SalesOrderHeader SOH INNER JOIN sales.SalesOrderDetail SOD 
		ON SOH.SalesOrderId = SOD.SalesOrderId
),
cte_pvtQuarterSales
AS
(
	SELECT SalesYear, 
		   ISNULL([Q1], 0) AS Q1, 
		   ISNULL([Q2], 0) AS Q2, 
		   ISNULL([Q3], 0) AS Q3, 
		   ISNULL([Q4], 0) AS Q4, 
		   (ISNULL([Q1], 0) + ISNULL([Q2], 0) + ISNULL([Q3], 0) + ISNULL([Q4], 0)) SalesYTD
	FROM cte_quarterSales
	PIVOT 
	(
		SUM(TotalSales)
		FOR Quarters 
		IN ([Q1], [Q2], [Q3], [Q4])
	)
	AS pvt
)
SELECT SalesYear,
		Quarters AS [Quarter],
		TotalSales
FROM cte_pvtQuarterSales
UNPIVOT
(
	TotalSales
	FOR Quarters
	IN ([Q1], [Q2], [Q3], [Q4])
) AS UNPVT
ORDER BY SalesYear
GO







/*
Obtener las ventas Mensuales por Año
*/
--		Subconsulta
SELECT SalesYear,
		Months AS [Month],
		TotalSales
FROM
(
	SELECT SalesYear, 
		   ISNULL([1], 0) AS Jan, 
		   ISNULL([2], 0) AS Feb, 
		   ISNULL([3], 0) AS Mar, 
		   ISNULL([4], 0) AS Apr, 
		   ISNULL([5], 0) AS May, 
		   ISNULL([6], 0) AS Jun, 
		   ISNULL([7], 0) AS Jul, 
		   ISNULL([8], 0) AS Aug, 
		   ISNULL([9], 0) AS Sep, 
		   ISNULL([10], 0) AS Oct, 
		   ISNULL([11], 0) AS Nov, 
		   ISNULL([12], 0) AS Dec, 
		   (ISNULL([1], 0) + ISNULL([2], 0) + ISNULL([3], 0) + ISNULL([4], 0) + ISNULL([4], 0) + 
			ISNULL([5], 0) + ISNULL([6], 0) + ISNULL([7], 0) + ISNULL([8], 0) + ISNULL([9], 0) + 
			ISNULL([10], 0) + ISNULL([11], 0) + ISNULL([12], 0)) SalesYTD
	FROM
	(
		SELECT YEAR(SOH.OrderDate) AS SalesYear, 
			   DATEPART(MONTH, SOH.OrderDate) Months,
			   SOH.SubTotal AS TotalSales
		FROM sales.SalesOrderHeader SOH INNER JOIN sales.SalesOrderDetail SOD 
			ON SOH.SalesOrderId = SOD.SalesOrderId
	 ) AS Data 
	 PIVOT
	 (
		SUM(TotalSales) 
		FOR Months 
		IN([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	) AS pvt
) AS T
UNPIVOT
(
	TotalSales
	FOR Months
	IN ([Jan], [Feb], [Mar], [Apr], [May], [Jun],
		[Jul], [Aug], [Sep], [Oct], [Nov], [Dec])
) AS UPVT
ORDER BY SalesYear, Months
GO


--	USANDO	CTE
WITH cte_monthSales
AS
(
    SELECT YEAR(SOH.OrderDate) AS SalesYear, 
           DATEPART(MONTH, SOH.OrderDate) Months,
           SOH.SubTotal AS TotalSales
    FROM sales.SalesOrderHeader SOH INNER JOIN sales.SalesOrderDetail SOD 
		ON SOH.SalesOrderId = SOD.SalesOrderId
),
cte_pvtMonthSales
AS
(
	SELECT SalesYear, 
		   ISNULL([1], 0) AS Jan, 
		   ISNULL([2], 0) AS Feb, 
		   ISNULL([3], 0) AS Mar, 
		   ISNULL([4], 0) AS Apr, 
		   ISNULL([5], 0) AS May, 
		   ISNULL([6], 0) AS Jun, 
		   ISNULL([7], 0) AS Jul, 
		   ISNULL([8], 0) AS Aug, 
		   ISNULL([9], 0) AS Sep, 
		   ISNULL([10], 0) AS Oct, 
		   ISNULL([11], 0) AS Nov, 
		   ISNULL([12], 0) AS Dec, 
		   (ISNULL([1], 0) + ISNULL([2], 0) + ISNULL([3], 0) + ISNULL([4], 0) + ISNULL([4], 0) + 
			ISNULL([5], 0) + ISNULL([6], 0) + ISNULL([7], 0) + ISNULL([8], 0) + ISNULL([9], 0) + 
			ISNULL([10], 0) + ISNULL([11], 0) + ISNULL([12], 0)) SalesYTD
	FROM cte_monthSales
	PIVOT 
	(
		SUM(TotalSales)
		FOR Months 
		IN([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	)
	AS pvt
)
SELECT SalesYear,
		Months AS [Month],
		TotalSales
FROM cte_pvtMonthSales
UNPIVOT
(
	TotalSales
	FOR Months
	IN ([Jan], [Feb], [Mar], [Apr], [May], [Jun],
		[Jul], [Aug], [Sep], [Oct], [Nov], [Dec])
) AS UPVT
ORDER BY SalesYear, Months
GO

