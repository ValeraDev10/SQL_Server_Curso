

--CLAUSULA OVER
--La cláusula OVER() en SQL es una herramienta poderosa que permite aplicar funciones de ventana 
--(window functions) sobre un conjunto de filas sin colapsarlas como lo haría una función de agregación tradicional. 
--Es especialmente útil cuando necesitas realizar cálculos fila por fila, 
--pero dentro de un contexto de grupo o secuencia.

--Permite:
-- Calcular totales acumulativos
-- Asignar rangos o posiciones (como ROW_NUMBER(), RANK())
-- Calcular medias móviles
-- Comparar valores individuales con agregados del grupo

--PARTITION BY: Divide el conjunto de datos en grupos (como un GROUP BY, pero sin colapsar filas)
--ORDER BY: Define el orden dentro de cada partición para cálculos secuenciales
--ROWS/RANGE: Opcional: define el marco de ventana (por ejemplo, desde la fila actual hasta X anteriores)


--OVER(
--	[PARTITION BY value_expression]
--	[ORDER BY order_by_expresion[ASC|DESC]]
--	)


USE  AdventureWorks2022
GO

SELECT * FROM HumanResources.Department
GO


SELECT DepartmentID,Name,GroupName,
		MIN(DepartmentID) OVER() MIN,
		MAX(DepartmentID) OVER() MAX
FROM HumanResources.Department
GO

SELECT DepartmentID,Name,GroupName,
		MIN(DepartmentID) OVER(PARTITION BY GroupName) MIN,
		MAX(DepartmentID) OVER(PARTITION BY GroupName) MAX
FROM HumanResources.Department
GO


SELECT DepartmentID,Name,GroupName,
		MIN(DepartmentID) OVER(PARTITION BY GroupName ORDER BY DepartmentID ) MIN,
		MAX(DepartmentID) OVER(PARTITION BY GroupName ORDER BY DepartmentID ) MAX
FROM HumanResources.Department
GO


--FUNCION ROW_NUMBER
--Es especialmente útil cuando necesitas identificar o filtrar registros duplicados, 
--paginar resultados, o aplicar lógica basada en el orden de los datos.

--Asigna un número secuencial a cada fila de un conjunto de resultados, 
--empezando desde 1. Este número se reinicia si usas la cláusula PARTITION BY.


--ROW_NUMBER() OVER (
--  [PARTITION BY columna1, columna2, ...]
--  ORDER BY columnaX [ASC|DESC]
--)

-- PARTITION BY: Opcional. Divide el conjunto de datos en grupos. El contador se reinicia en cada grupo.
-- ORDER BY: Obligatorio. Define el orden en que se asignan los números dentro de cada partición o del conjunto completo.


SELECT * FROM Sales.SalesTerritory
GO

SELECT Name, CountryRegionCode, [Group],
		ROW_NUMBER() OVER(ORDER BY Name) AS RowNumber
FROM Sales.SalesTerritory
GO

SELECT Name, CountryRegionCode, [Group],
		ROW_NUMBER() OVER(PARTITION BY [Group] ORDER BY Name) AS RowNumber
FROM Sales.SalesTerritory
GO


--FUNCION RANK
--clasificar filas dentro de un conjunto de resultados, especialmente útil en análisis comparativos 
--como rankings por ventas, rendimiento, o fechas. 

-- Asigna un número de rango a cada fila según el orden especificado.
-- Si hay empates (valores iguales), se les asigna el mismo rango.
-- El siguiente rango salta según el número de empates (no es consecutivo).

--SELECT 
--  columna,
--  RANK() OVER (ORDER BY columna_ordenacion ASC|DESC) AS rango
--FROM tabla;

--ORDER BY
SELECT Name, CountryRegionCode, [Group],
		ROW_NUMBER() OVER(PARTITION BY [Group] ORDER BY Name) AS RowNumber,
		RANK() OVER(ORDER BY Name) AS Rank1,
		RANK() OVER(ORDER BY [Group]) AS Rank2
FROM Sales.SalesTerritory
GO

--PARTITION BY
SELECT Name, CountryRegionCode, [Group],
		ROW_NUMBER() OVER(PARTITION BY [Group] ORDER BY Name) AS RowNumber,
		RANK() OVER(PARTITION BY [Group] ORDER BY Name) AS Rank1,
		RANK() OVER(PARTITION BY [Group] ORDER BY CountryRegionCode) AS Rank2
FROM Sales.SalesTerritory
GO


--FUNCION DENSE_RANK
--La función DENSE_RANK() en SQL es una función de ventana que asigna rangos consecutivos 
--a filas dentro de una partición, sin dejar huecos entre los valores de rango. 
--Es especialmente útil cuando quieres clasificar datos y mantener una secuencia continua, 
--incluso cuando hay empates.

-- Si dos o más filas tienen el mismo valor en la columna de ordenación, reciben el mismo rango.
-- La siguiente fila obtiene el rango inmediatamente siguiente (sin saltos)


DENSE_RANK() OVER (
  PARTITION BY columna_particion
  ORDER BY columna_ordenacion ASC|DESC
)

-- PARTITION BY: divide el conjunto de resultados en grupos.
-- ORDER BY: determina el orden dentro de cada grupo.


--ORDER BY
SELECT Name, CountryRegionCode, [Group],
		ROW_NUMBER() OVER(PARTITION BY [Group] ORDER BY Name) AS RowNumber,
		RANK() OVER(ORDER BY Name) AS Rank1,
		RANK() OVER(ORDER BY [Group]) AS Rank2,
		DENSE_RANK() OVER(ORDER BY [Group]) AS DenseRank
FROM Sales.SalesTerritory
GO

--PARTITION BY
SELECT Name, CountryRegionCode, [Group],
		ROW_NUMBER() OVER(PARTITION BY [Group] ORDER BY Name) AS RowNumber,
		RANK() OVER(PARTITION BY [Group] ORDER BY Name) AS Rank1,
		RANK() OVER(PARTITION BY [Group] ORDER BY CountryRegionCode) AS Rank2,
		DENSE_RANK() OVER(PARTITION BY [Group]ORDER BY CountryRegionCode) AS DenseRank
FROM Sales.SalesTerritory
GO


--FUNCION NTILE
--La función NTILE() en SQL es una poderosa herramienta de análisis que te permite dividir 
--un conjunto de filas ordenadas en N grupos aproximadamente iguales. 
--Es parte de las funciones de ventana, y se usa comúnmente para crear cuartiles, 
--deciles o cualquier tipo de agrupación basada en rangos.

NTILE(N) OVER (ORDER BY columna)


-- N: número de grupos que quieres crear.
-- ORDER BY: define cómo se ordenan las filas antes de dividirlas.
-- Resultado: cada fila recibe un número de grupo entre 1 y N

-- ¿Cuándo usar NTILE?
-- Para análisis estadístico: cuartiles, deciles, percentiles.
-- Para segmentar clientes por nivel de gasto.
-- Para distribuir tareas o datos en bloques equitativos.



SELECT Name, CountryRegionCode, [Group],
		ROW_NUMBER() OVER(PARTITION BY [Group] ORDER BY Name) AS RowNumber,
		RANK() OVER(ORDER BY Name) AS Rank1,
		RANK() OVER(ORDER BY [Group]) AS Rank2,
		DENSE_RANK() OVER(ORDER BY [Group]) AS DenseRank,
		NTILE(5)OVER(ORDER BY [Group]) AS NTile
FROM Sales.SalesTerritory
GO



--PARTITION BY
SELECT Name, CountryRegionCode, [Group],
		ROW_NUMBER() OVER(PARTITION BY [Group] ORDER BY Name) AS RowNumber,
		RANK() OVER(PARTITION BY [Group] ORDER BY Name) AS Rank1,
		RANK() OVER(PARTITION BY [Group] ORDER BY CountryRegionCode) AS Rank2,
		DENSE_RANK() OVER(PARTITION BY [Group]ORDER BY CountryRegionCode) AS DenseRank,
		NTILE(3)OVER(PARTITION BY [Group]ORDER BY CountryRegionCode) AS NTile
FROM Sales.SalesTerritory
GO


SELECT Name, CountryRegionCode, [Group],
		ROW_NUMBER() OVER(PARTITION BY [Group] ORDER BY Name) AS RowNumber,
		RANK() OVER(PARTITION BY [Group] ORDER BY Name) AS Rank1,
		RANK() OVER(PARTITION BY [Group] ORDER BY CountryRegionCode) AS Rank2,
		DENSE_RANK() OVER(PARTITION BY [Group]ORDER BY CountryRegionCode) AS DenseRank,
		NTILE(3)OVER(PARTITION BY [Group]ORDER BY CountryRegionCode) AS NTile
FROM Sales.SalesTerritory
ORDER BY Name
GO



--EJERCICIOS COMPLEJOS


-- Usar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


-- Consultar la Tabla Sales.SalesTerritory
SELECT * FROM Sales.SalesTerritory
GO


/*
Utilizar la Tabla SalesTerritory y resolver lo siguiente:
Mostrar las columnas TerritoryID, Name y SalesYTD
Contar la cantidad de registros
Obtener las Ventas(SalesYTD) mínimas y redondear con dos decimales
Obtener las Ventas(SalesYTD) máximas y redondear con dos decimales
Obtener la Suma de las Ventas(SalesYTD) y redondear con dos decimales
Obtener el Promedio de las Ventas(SalesYTD) y redondear con dos decimales
*/
SELECT TerritoryID, Name, SalesYTD,
		COUNT(1) OVER() [Count],
		ROUND( MIN(SalesYTD) OVER(), 2 ) AS [Min],
		ROUND( MAX(SalesYTD) OVER(), 2 ) AS [Max],
		ROUND( SUM(SalesYTD) OVER(), 2 ) AS [Sum],
		ROUND( AVG(SalesYTD) OVER(), 2 ) AS [Avg]
FROM Sales.SalesTerritory
GO



-- Consultar la Tabla HumanResources.Employee
SELECT * FROM HumanResources.Employee
GO

/*
Utilizar la Tabla Employee y resolver lo siguiente:
Mostrar las columnas JobTitle y VacationHours
Agregar otra columna llamada 'RankVacationHours'
que va a clasificar por las Horas de Vacaciones(VacationHours)
De manera Descendente
*/
SELECT JobTitle, VacationHours,
		ROW_NUMBER() OVER(ORDER BY VacationHours DESC) AS RankVacationHours
FROM HumanResources.Employee
GO



-- Consultar la Tabla Person.Address
SELECT * FROM Person.Address
GO

/*
Utilizar la Tabla Address y resolver lo siguiente:
Mostrar las columnas AddressLine1 y City
Luego clasificar la Dirección(AddressLine1) de manera Ascendente
dividido por la Ciudad(City)
*/
SELECT AddressLine1, City,
		RANK() OVER(PARTITION BY City ORDER BY AddressLine1) AS [Rank],
		DENSE_RANK() OVER(PARTITION BY City ORDER BY AddressLine1) AS [DenseRank]
FROM Person.Address
GO


--EJERCICIOS PROPUESTOS


USE NORTHWND
GO

--Ejercicio 1:
--Trabajar con la Tabla “Customers” y resolver lo siguiente:
-- Mostrar las columnas ContactName, City, Country y PostalCode
-- Luego crear una columna llamada “Order” que va a clasificar por el Nombre del Contacto(ContactName) 
--de manera Ascendente dividido por el País(Country).
SELECT * FROM Customers
GO

SELECT ContactName, City, Country, PostalCode,
		ROW_NUMBER() OVER(PARTITION BY Country ORDER BY ContactName ASC) AS Orders		
FROM Customers
GO


--Ejercicio 2:
--Trabajar con la Tabla “Products” y resolver lo siguiente:
--Mostrar las columnas ProductName y UnitPrice
--Luego crear una columna llamada “Position” que va a clasificar por el Precio Unitario(UnitPrice) 
--de manera Ascendente y si dos o más Productos tienes el mismo Precio Unitario deben de tener 
--la misma clasificación y los Productos con Precio Unitario siguientes deben de continuar 
--con el orden de la clasificación.

SELECT * FROM Products
GO

SELECT ProductName, UnitPrice,
		DENSE_RANK() OVER(ORDER BY UnitPrice) AS Position
FROM Products
GO