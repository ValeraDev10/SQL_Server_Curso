

--SUBCONSULTAS ESCALARES
--Una subconsulta escalar es una consulta anidada que devuelve exactamente un valor: cadena, numero, fecha
--una sola fila y una sola columna. Puedes usarla en cualquier lugar donde se permita una expresión, 
--como:
-- En la cláusula SELECT
-- Dentro de WHERE, ORDER BY, o CASE
-- En expresiones calculadas


--1. Subconsulta escalar en SELECT

SELECT 
    empid,
    name,
    salary,
    (SELECT AVG(salary) FROM employee) AS avg_salary
FROM employee; --Esto agrega una columna con el salario promedio de todos los empleados, calculado una sola vez.

--2. Subconsulta escalar en WHERE

SELECT 
    name,
    salary
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee);--Filtra empleados cuyo salario está por encima del promedio

--3. Subconsulta escalar en CASE

SELECT 
    empid,
    name,
    salary,
    CASE 
        WHEN salary > (SELECT AVG(salary) FROM employee) THEN 'Above Average'
        ELSE 'Below Average'
    END AS salary_category
FROM employee;--Clasifica cada empleado según su salario comparado con el promedio

-- Si la subconsulta devuelve más de una fila o columna, SQL Server lanzará un error.
-- En entrevistas, es común que te pidan reescribir una subconsulta escalar 
-- usando JOIN para comparar rendimiento o legibilidad



--EJEMPLO UDEMY

USE NORTHWND
GO

-- Subconsultas devolviendo un valor único(Subconsulta Escalar)
--	Consultando la Tabla Products
SELECT ProductName, UnitPrice FROM Products;


--	Promedio del precio unitario
SELECT AVG(UnitPrice) Average FROM Products;


--	Subconsulta Escalar en la Cláusula SELECT
SELECT ProductName, UnitPrice, 
		avg(UnitPrice) 
FROM Products; --Error

SELECT ProductName, UnitPrice,
		(SELECT AVG(UnitPrice) FROM Products) AS Average,
		(SELECT AVG(UnitPrice) FROM Products) - UnitPrice AS Desv
FROM Products --Correcto
GO


-- Subconsulta Escalar en la Cláusula WHERE
SELECT ProductName, UnitPrice
FROM Products 
WHERE UnitPrice > ( SELECT AVG(UnitPrice) FROM Products )
ORDER BY UnitPrice -- Opcional
GO


-- Subconsulta Escalar en Expresiones de Asignación
DECLARE @precioPromedio DECIMAL(10,2)
SET @precioPromedio = ( SELECT AVG(UnitPrice) FROM Products )
SELECT @precioPromedio AS avgUnitPrice
GO

--SUBCONSULTAS MULTIVALOR

--Una subconsulta multivalor es aquella que devuelve más de una fila o más de una columna. 
--No puedes usarla directamente con operadores como = o <>, porque esos esperan un único valor. 
--En cambio, debes usar operadores como:
- IN
- EXISTS
- ANY / SOME
- ALL

--Ejemplos prácticos
--1. Subconsulta con IN
SELECT nombre
FROM empleados
WHERE departamento_id IN (
    SELECT id
    FROM departamentos
    WHERE ubicacion = 'Bogotá'
);

--Devuelve empleados que trabajan en departamentos ubicados en Bogotá


--2. Subconsulta con EXISTS
SELECT nombre
FROM clientes c
WHERE EXISTS (
    SELECT 1
    FROM pedidos p
    WHERE p.cliente_id = c.id
);

--Devuelve clientes que han hecho al menos un pedido


--3. Subconsulta en cláusula FROM (tratada como tabla derivada)
SELECT d.nombre, t.total_empleados
FROM departamentos d
JOIN (
    SELECT departamento_id, COUNT(*) AS total_empleados
    FROM empleados
    GROUP BY departamento_id
) t ON d.id = t.departamento_id;

--Calcula el total de empleados por departamento y lo une con los nombres


--EJEMPLO UDEMY

-- Utilizar la Base de Datos NORTHWND
USE NORTHWND
GO


-- Consultando la Tabla Customers
SELECT CustomerID, CompanyName, ContactName, Country
FROM Customers;
GO


-- Consultando la Tabla Orders
SELECT DISTINCT CustomerID FROM Orders
GO


-- Subconsultas Multivalor
--	Subconsulta Multivalor con IN
SELECT CustomerID, CompanyName, ContactName, Country
FROM Customers
WHERE CustomerID IN ( 'ALFKI', 'PARIS' )
GO

SELECT CustomerID, CompanyName, ContactName, Country
FROM Customers
WHERE CustomerID IN ( SELECT DISTINCT CustomerID FROM Orders )
GO



-- Subconsulta Multivalor con EXISTS
SELECT CustomerID, CompanyName, ContactName, Country
FROM Customers 
WHERE EXISTS (SELECT DISTINCT CustomerID FROM Orders); --Devuelve como mínimo un valor
GO

SELECT CustomerID, CompanyName, ContactName, Country
FROM Customers 
WHERE EXISTS (SELECT DISTINCT CustomerID FROM Orders
				WHERE CustomerID = 'NADA'); --No devuelve ningún valor
GO


--	Subconsulta Correlacionada
SELECT c.CustomerID, c.CompanyName, c.ContactName, c.Country
FROM Customers AS c
WHERE EXISTS (SELECT DISTINCT CustomerID FROM Orders AS o
				WHERE c.CustomerID = o.CustomerID);



-- Subconsulta Multivalor en la cláusula FROM
--	Simulando una Consulta Macro de Ventas
SELECT C.CustomerID, C.CompanyName, C.Address, C.Country, C.City,
		O.OrderDate, YEAR(O.OrderDate) Year, MONTH(o.OrderDate) Month,
		P.ProductName, OD.UnitPrice, OD.Quantity, OD.Discount,
		OD.Quantity * ( OD.UnitPrice - ( OD.UnitPrice * OD.Discount ) ) Total,
		CA.CategoryName, CA.Description
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
INNER JOIN Products P ON P.ProductID = OD.ProductID
INNER JOIN Categories CA ON CA.CategoryID = P.CategoryID
GO


SELECT T.Year, T.ProductName, T.Quantity, T.UnitPrice, T.Total
FROM 
(SELECT C.CustomerID, C.CompanyName, C.Address, C.Country, C.City,
		O.OrderDate, YEAR(O.OrderDate) Year, MONTH(o.OrderDate) Month,
		P.ProductName, OD.UnitPrice, OD.Quantity, OD.Discount,
		OD.Quantity * ( OD.UnitPrice - ( OD.UnitPrice * OD.Discount ) ) Total,
		CA.CategoryName, CA.Description
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
INNER JOIN Products P ON P.ProductID = OD.ProductID
INNER JOIN Categories CA ON CA.CategoryID = P.CategoryID) AS T
WHERE T.Year = 1998
GO


SELECT T.Year, ROUND( SUM( T.Total ), 2) Total
FROM 
(SELECT C.CustomerID, C.CompanyName, C.Address, C.Country, C.City,
		O.OrderDate, YEAR(O.OrderDate) Year, MONTH(o.OrderDate) Month,
		P.ProductName, OD.UnitPrice, OD.Quantity, OD.Discount,
		OD.Quantity * ( OD.UnitPrice - ( OD.UnitPrice * OD.Discount ) ) Total,
		CA.CategoryName, CA.Description
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
INNER JOIN Products P ON P.ProductID = OD.ProductID
INNER JOIN Categories CA ON CA.CategoryID = P.CategoryID) AS T
GROUP BY T.Year
ORDER BY T.Year
GO



