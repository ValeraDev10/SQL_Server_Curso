

--FUNCION LAG
--LAG() te permite acceder al valor de una fila anterior dentro de un conjunto de resultados ordenado. 
--Es �til para:
-- Comparar valores actuales con los anteriores (por ejemplo, ventas d�a a d�a)
-- Calcular diferencias entre registros consecutivos
-- Detectar cambios o tendencias en series temporales

--LAG(expresi�n [, desplazamiento [, valor_predeterminado]])
		OVER (PARTITION BY columna ORDER BY columna)

-- expresi�n: el valor que quieres recuperar de la fila anterior.
-- desplazamiento: cu�ntas filas hacia atr�s mirar (por defecto es 1).
-- valor_predeterminado: qu� devolver si no hay fila anterior (por defecto es NULL).
-- OVER(...): define c�mo se agrupan (PARTITION BY) y ordenan (ORDER BY) las filas.

--Aplicaciones comunes
-- Comparar precios entre d�as en una tabla de cotizaciones
-- Detectar ca�das o aumentos en m�tricas
-- Generar columnas auxiliares para c�lculos de diferencia o porcentaje


--FUNCION LEAD
-- Obtener el valor de la siguiente fila (o varias filas adelante).
-- Comparar valores entre la fila actual y la siguiente.
-- Detectar cambios entre registros consecutivos (por ejemplo, precios, fechas, estados).

--LEAD(expresi�n [, desplazamiento [, valor_predeterminado]])
		OVER (PARTITION BY columna ORDER BY columna)

-- expresi�n: el valor que quieres obtener de la fila siguiente.
-- desplazamiento: cu�ntas filas adelante mirar (por defecto es 1).
-- valor_predeterminado: qu� devolver si no hay fila siguiente (por defecto es NULL).
-- PARTITION BY: opcional, divide los datos en grupos.
-- ORDER BY: obligatorio, define el orden de las filas

--Aplicaciones comunes
-- Comparar precios entre d�as consecutivos.
-- Detectar cambios de estado en procesos.
-- Calcular diferencias entre fechas o valores.
-- Generar reportes secuenciales.

USE AdventureWorks2022
GO


SELECT * FROM Sales.SalesPersonQuotaHistory
GO


/*
Trabajar con la Tabla SalesPersonQuotaHistory y realizar lo siguiente:
Consultar los campos BusinessEntityID, A�o del campo QuotaDate,Mes del campo QuotaDate y SalesQuota
Mediante la Funci�n LAG mostrar el valor de la fila anterior de SalesQuota
Mediante la Funci�n LEAD mostrar el valor de la fila posterior de SalesQuota
Ordenar por los campo BusinessEntityID, A�o del campo QuotaDate y Mes del campo QuotaDate
*/

SELECT BusinessEntityID, YEAR(QuotaDate) AS SalesYear,
		MONTH(QuotaDate) AS MONTH, SalesQuota AS CurrentQuota,
		LAG(SalesQuota, 1,0) OVER (ORDER BY YEAR(QuotaDate)) AS PreviousQuota,
		LEAD(SalesQuota, 1, 0) OVER (ORDER BY YEAR(QuotaDate)) AS NextQuota
FROM Sales.SalesPersonQuotaHistory
ORDER BY BusinessEntityID, YEAR(QuotaDate), MONTH(QuotaDate)
GO


/*
Trabajar con la Tabla SalesPersonQuotaHistory y realizar lo siguiente:
Consultar los campos BusinessEntityID, A�o del campo QuotaDate,Mes del campo QuotaDate y SalesQuota
Mediante la Funci�n LAG mostrar el valor de la fila anterior de SalesQuota 
	particionado por el A�o del campo BusinessEntityID
Mediante la Funci�n LEAD mostrar el valor de la fila posterior de SalesQuota
	particionado por el A�o del campo BusinessEntityID
Ordenar por los campo BusinessEntityID, A�o del campo QuotaDate y Mes del campo QuotaDate
*/

SELECT BusinessEntityID, YEAR(QuotaDate) AS SalesYear, 
	   MONTH(QuotaDate) AS Month,SalesQuota AS CurrentQuota,   
       LAG(SalesQuota, 1, 0) OVER (PARTITION BY BusinessEntityID ORDER BY YEAR(QuotaDate)) AS PreviousQuota,
	   LEAD(SalesQuota, 1, 0) OVER (PARTITION BY BusinessEntityID ORDER BY YEAR(QuotaDate)) AS NextQuota
FROM Sales.SalesPersonQuotaHistory  
ORDER BY BusinessEntityID, YEAR(QuotaDate), MONTH(QuotaDate)
GO
