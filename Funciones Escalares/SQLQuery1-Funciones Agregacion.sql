

--FUNCION MAX MIN
-- MAX(): Devuelve el valor más alto de una columna.
-- MIN(): Devuelve el valor más bajo de una columna.
--Ambas son funciones de agregación, ideales para encontrar extremos en conjuntos de datos.

--SELECT MAX(nombre_columna) FROM nombre_tabla;
--SELECT MIN(nombre_columna) FROM nombre_tabla;

--Supongamos que tienes una tabla Empleados con una columna Salario:
-- Salario más alto
SELECT MAX(Salario) AS SalarioMaximo FROM Empleados;

-- Salario más bajo
SELECT MIN(Salario) AS SalarioMinimo FROM Empleados;


USE AdventureWorks2022
GO

SELECT * FROM HumanResources.Employee
GO


SELECT MIN(BirthDate) AS BirthDateMin,
		MAX(BirthDate) AS BirthDateMax
FROM HumanResources.Employee
GO


SELECT * FROM Sales.SalesTerritory
GO


SELECT MIN(SalesYTD) AS SalesYTDMin,
		MAX(SalesYTD) AS SalesYTDMax

FROM Sales.SalesTerritory
GO


--FUNCION SUM
-- Suma todos los valores numéricos de una columna.
-- Ignora los valores NULL.
-- Puede usarse con GROUP BY, DISTINCT, y expresiones matemáticas.

--SELECT SUM(columna) AS Total FROM tabla;


SELECT * FROM Sales.SalesTerritory
GO


SELECT SUM(SalesYTD) AS SumYTD,
		SUM(SalesLastYear) AS SumSalesLastYear
FROM Sales.SalesTerritory
GO


--FUNCION AVG
--La función AVG() en SQL Server es una función agregada que calcula el promedio de los valores 
--en una columna numérica.

--SELECT AVG(nombre_columna) FROM nombre_tabla;

-- Ignora valores NULL automáticamente.
-- Puedes usar ALL (por defecto) o DISTINCT:
-- AVG(ALL columna) → promedio de todos los valores.
-- AVG(DISTINCT columna) → promedio solo de valores únicos.

SELECT SUM(SalesYTD) AS SumYTD,
		SUM(SalesLastYear) AS SumSalesLastYear,
		AVG(SalesYTD)AS AVGSumYTD,
		AVG(SalesLastYear) AS AVGSalesLastYear
FROM Sales.SalesTerritory
GO

--FUNCIONES COUNT Y COUNT_BIG
--COUNT y COUNT_BIG. Ambas sirven para contar registros, pero tienen diferencias clave 
--que pueden ser importantes en contextos de alto volumen de datos

--COUNT int (4 bytes) Consultas estándar con menos de ~2 mil millones de filas
--COUNT_BIG bigint (8 bytes) Grandes volúmenes de datos, como en data warehouses


SELECT * FROM Person.Address
GO

/*
Calcular de la Tabla Dirección(Address)
la cantidad total de registros por la columna AddressID, 
la cantidad total de no Nulos por la columna AddressLine2,
la cantidad total de registros Distintos por la columna City
la cantidad total de registros de la Tabla
*/
SELECT COUNT(ALL AddressID) AS TotalALL, COUNT(AddressID) AS TotalColumn,  --COUNT_BIG
		COUNT(AddressLine2) AS TotalNotNull, COUNT(DISTINCT City) AS TotalDistinct, 
		COUNT(*) Total, COUNT(1) AS Total1
FROM Person.Address
GO



--CLAUSULA GROUP BY
--La cláusula GROUP BY en SQL es una herramienta poderosa para agrupar filas que comparten 
--valores comunes en una o más columnas, y luego aplicar funciones agregadas como
--SUM(), AVG(), COUNT(), MAX(), o MIN() sobre cada grupo. 
--Es esencial cuando quieres resumir o analizar datos por categorías.

-- Consultar la Tabla Person.Address
SELECT * FROM HumanResources.Employee
GO

/*
Utilizar la Tabla de Empleados(Employee) y resolver lo siguiente:
Contar la cantidad de Empleados(Employee) que están Casados y Solteros
*/
SELECT * -- Error
FROM HumanResources.Employee
GROUP BY MaritalStatus
GO

SELECT MaritalStatus -- Se puede reemplazar 'Married' o 'Single'
FROM HumanResources.Employee
GROUP BY MaritalStatus
GO

SELECT MaritalStatus, COUNT(1) AS Total
FROM HumanResources.Employee
GROUP BY MaritalStatus
GO



-- Consultar la Tabla Sales.SalesTerritory
SELECT * FROM Sales.SalesTerritory
GO


/*
Utilizar la Tabla de SalesTerritory y resolver lo siguiente:
Calcular la Suma, Promedio, Mínimo y Máximo de las Ventas del Año(SalesYTD)
Agrupados por el Código de Región del País(CountryRegionCode)
Donde el CountryRegionCode no sea igual a 'DE'
*/
SELECT CountryRegionCode, SUM(SalesYTD) AS TotalSUM, AVG(SalesYTD) AS SalesAVG,
							MIN(SalesYTD) AS SalesMin, MAX(SalesYTD) AS SalesMax
FROM Sales.SalesTerritory
WHERE CountryRegionCode <> 'DE' --Germany
GROUP BY CountryRegionCode
GO


--CLAUSULA HAVING
--La cláusula HAVING en SQL es una herramienta poderosa para filtrar resultados
--después de aplicar una agregación con GROUP BY. A diferencia de WHERE, 
--que filtra filas individuales antes de agrupar, HAVING se usa para filtrar grupos ya formados.

-- Cuando necesitas aplicar condiciones sobre funciones agregadas como SUM(), COUNT(), AVG(), etc.
-- En reportes donde se agrupan datos y luego se filtran esos grupos

-- Consultar la Tabla Person.Address
SELECT * FROM HumanResources.Employee
GO



/*
Utilizar la Tabla de Empleados(Employee) y resolver lo siguiente:
Contar la cantidad de Empleados(Employee) que están Casados y Solteros
Donde la cantidad sea mayor a 144
*/
SELECT MaritalStatus, COUNT(1) Total
FROM HumanResources.Employee
GROUP BY MaritalStatus
HAVING COUNT(1) > 144
GO



-- Consultar la Tabla Sales.SalesTerritory
SELECT * FROM Sales.SalesTerritory
GO



/*
Utilizar la Tabla de SalesTerritory y resolver lo siguiente:
Calcular la Suma, Promedio, Mínimo y Máximo de las Ventas del Año(SalesYTD)
Agrupados por el Código de Región del País(CountryRegionCode)
Donde el CountryRegionCode no sea igual a 'DE'
y donde la Suma sea menor o igual a 6 000 000
*/
SELECT CountryRegionCode, SUM(SalesYTD) TotalSUM, AVG(SalesYTD) SalesAVG,
							MIN(SalesYTD) SalesMin, MAX(SalesYTD) SalesMax
FROM Sales.SalesTerritory
WHERE CountryRegionCode <> 'DE' --Germany
GROUP BY CountryRegionCode
HAVING SUM(SalesYTD) <= 6000000
GO


--EJERCICIOS COMPLEJOS

-- Consultar la Tabla HumanResources.Employee
SELECT * FROM HumanResources.Employee
GO


/*
Utilizar la Tabla de Empleados(Employee) y resolver lo siguiente:
Contar la cantidad de Empleados(Employee) que se han contratado
a partir de los Años de la Fecha de Contratación(HireDate)
Ordenar de manera Ascendente por el Año de la Fecha de Contratación(HireDate)
*/
SELECT YEAR(HireDate) AS Year, COUNT(1) AS Count
FROM HumanResources.Employee
GROUP BY YEAR(HireDate)
ORDER BY YEAR(HireDate)
GO



-- Consultar la Tabla Production.TransactionHistory
SELECT * FROM Production.TransactionHistory
GO


/*
Utilizar la Tabla de Historial de Transacciones(TransactionHistory) y resolver lo siguiente:
Contar la cantidad de Transacciones que se han realizado
a partir de la Fecha de Transacción(TransactionDate) en los Años y Meses
los Meses deben de mostrarse en Español
y deben de estar Ordenado por el Año y Mes
*/
-- Forma Erronea
SELECT YEAR(TransactionDate) AS Year, 
		DATENAME(month, TransactionDate) Month,
		COUNT(1) AS Count
FROM Production.TransactionHistory
GROUP BY YEAR(TransactionDate), DATENAME(month, TransactionDate)
ORDER BY YEAR(TransactionDate), DATENAME(month, TransactionDate)
GO


-- Forma Incorrecta
SELECT YEAR(TransactionDate) AS Year, 
		MONTH(TransactionDate) Month,
		COUNT(1) AS Count
FROM Production.TransactionHistory
GROUP BY YEAR(TransactionDate), MONTH(TransactionDate)
ORDER BY YEAR(TransactionDate), MONTH(TransactionDate)
GO


-- Correcto
SELECT YEAR(TransactionDate) AS Year, 
		CASE
			WHEN MONTH(TransactionDate) = 1 THEN 'Enero'
			WHEN MONTH(TransactionDate) = 2 THEN 'Febrero'
			WHEN MONTH(TransactionDate) = 3 THEN 'Marzo'
			WHEN MONTH(TransactionDate) = 4 THEN 'Abril'
			WHEN MONTH(TransactionDate) = 5 THEN 'Mayo'
			WHEN MONTH(TransactionDate) = 6 THEN 'Junio'
			WHEN MONTH(TransactionDate) = 7 THEN 'Julio'
			WHEN MONTH(TransactionDate) = 8 THEN 'Agosto'
			WHEN MONTH(TransactionDate) = 9 THEN 'Setiembre'
			WHEN MONTH(TransactionDate) = 10 THEN 'Octubre'
			WHEN MONTH(TransactionDate) = 11 THEN 'Noviembre'
			WHEN MONTH(TransactionDate) = 12 THEN 'Diciembre'
		END AS Month,
		COUNT(1) AS Count
FROM Production.TransactionHistory
GROUP BY YEAR(TransactionDate), MONTH(TransactionDate)
ORDER BY YEAR(TransactionDate), MONTH(TransactionDate)
GO


--EJERCICIOS PROPUESTOS

USE NORTHWND
GO

--Ejercicio 1:
--Trabajar con la Tabla “Customers” y resolver lo siguiente:
--Realizar un Script que calcule la cantidad de Clientes que se tiene por País(Country) 
--y ordenar de manera Ascendente por el País(Country).

SELECT * FROM Customers
GO

SELECT Country,
		COUNT(1) AS Cantidad
FROM Customers
GROUP BY Country
GO

--Ejercicio 2:
--Trabajar con la Tabla “Customers” y resolver lo siguiente:
--Realizar un Script que calcule la cantidad de Clientes que se tiene por País(Country) 
--que tenga una Región asignada donde la cantidad debe ser mayor a cero y ordenar de manera Ascendente 
--por el País(Country).

SELECT Country,
		COUNT(1) AS Cantidad
FROM Customers
WHERE Region IS NOT NULL
GROUP BY Country
HAVING COUNT(1) > 0
ORDER BY Country
GO


--Ejercicio 3:
--Trabajar con la Tabla “Orders” y resolver lo siguiente:
--Realizar un Script que calcule la cantidad de Pedidos que se han realizado a partir 
--de la Fecha de Pedido(OrderDate) en Años y Meses, los Meses deben de mostrarse en Español 
--y deben de estar Ordenados por el Año y Mes.

SELECT YEAR(OrderDate) AS Year, 
		CASE
			WHEN MONTH(OrderDate) = 1 THEN 'Enero'
			WHEN MONTH(OrderDate) = 2 THEN 'Febrero'
			WHEN MONTH(OrderDate) = 3 THEN 'Marzo'
			WHEN MONTH(OrderDate) = 4 THEN 'Abril'
			WHEN MONTH(OrderDate) = 5 THEN 'Mayo'
			WHEN MONTH(OrderDate) = 6 THEN 'Junio'
			WHEN MONTH(OrderDate) = 7 THEN 'Julio'
			WHEN MONTH(OrderDate) = 8 THEN 'Agosto'
			WHEN MONTH(OrderDate) = 9 THEN 'Setiembre'
			WHEN MONTH(OrderDate) = 10 THEN 'Octubre'
			WHEN MONTH(OrderDate) = 11 THEN 'Noviembre'
			WHEN MONTH(OrderDate) = 12 THEN 'Diciembre'
		END AS Month,
		COUNT(1) AS Total
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY YEAR(OrderDate), MONTH(OrderDate)
GO