

--CLAUSULA INNER JOIN
--La cláusula INNER JOIN se usa para combinar filas de dos o más tablas cuando hay una coincidencia 
--en los valores de una columna relacionada. Solo devuelve las filas que tienen coincidencias en ambas tablas.
--SINTAXIS
SELECT columnas
FROM tabla1
INNER JOIN tabla2
ON tabla1.columna_relacionada = tabla2.columna_relacionada;


-- Utilizar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO

-- Consultar Tablas
SELECT * FROM Person.Person;
SELECT * FROM Sales.Customer;
GO

-- ==========================
-- JOIN con dos tablas
-- ==========================
-- ANSI SQL-89
SELECT Person.BusinessEntityID, Person.FirstName, Person.MiddleName, Person.LastName,
		Customer.CustomerID, Customer.PersonID, Customer.StoreID, Customer.AccountNumber
FROM Person.Person, Sales.Customer
WHERE Person.BusinessEntityID = Customer.PersonID
GO

-- Alias de Tabla
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName,
		C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber
FROM Person.Person AS P, Sales.Customer AS C
WHERE P.BusinessEntityID = C.PersonID
GO


-- ANSI SQL-92
-- INNER JOIN(JOIN INTERNO)
--	INNER JOIN
SELECT Person.BusinessEntityID, Person.FirstName, Person.MiddleName, Person.LastName,
		Customer.CustomerID, Customer.PersonID, Customer.StoreID, Customer.AccountNumber
FROM Person.Person INNER JOIN Sales.Customer
ON Person.BusinessEntityID = Customer.PersonID
GO

--	JOIN
SELECT Person.BusinessEntityID, Person.FirstName, Person.MiddleName, Person.LastName,
		Customer.CustomerID, Customer.PersonID, Customer.StoreID, Customer.AccountNumber
FROM Person.Person JOIN Sales.Customer
ON Person.BusinessEntityID = Customer.PersonID
GO

--	Alias de Tabla
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName,
		C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber
FROM Person.Person AS P INNER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID
GO


-- ==========================
-- JOIN con mas tablas
-- ==========================
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName,
		C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber,
		S.BusinessEntityID, S.Name
FROM Person.Person AS P INNER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID
						INNER JOIN Sales.Store AS S
ON C.StoreID = S.BusinessEntityID						
GO


--CLAUSULA LEFT JOIN
--La cláusula LEFT JOIN (también conocida como LEFT OUTER JOIN) se usa para combinar dos tablas 
--y mantener todos los registros de la tabla izquierda, incluso si no hay coincidencias en la tabla derecha.
-- Si hay coincidencia entre las tablas, se muestran los datos de ambas.
-- Si no hay coincidencia, se muestran los datos de la izquierda y NULL en las columnas de la derecha

SELECT columnas
FROM tabla_izquierda
LEFT JOIN tabla_derecha
ON tabla_izquierda.columna_clave = tabla_derecha.columna_clave;


-- Utilizar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO

-- Consultar Tablas
SELECT * FROM Person.Person;
SELECT * FROM Sales.Customer;
GO


-- ==========================
-- JOIN con dos tablas
-- ==========================
-- ANSI SQL-92
-- LEFT JOIN(JOIN EXTERNO)
--	LEFT JOIN
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName,
		C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber
FROM Person.Person AS P LEFT JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID
ORDER BY P.BusinessEntityID
GO

--	LEFT OUTER JOIN
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName,
		C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber
FROM Person.Person AS P LEFT OUTER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID
ORDER BY P.BusinessEntityID
GO

--	LEFT OUTER JOIN sin coincidencia con la Tabla derecha
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName,
		C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber
FROM Person.Person AS P LEFT OUTER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID
WHERE C.PersonID IS NULL
ORDER BY P.BusinessEntityID
GO

--	LEFT OUTER JOIN el orden de la Tabla es IMPORTANTE
SELECT C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber,
		P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName
FROM Sales.Customer AS C LEFT OUTER JOIN Person.Person AS P
-- FROM Person.Person AS P LEFT OUTER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID
WHERE P.BusinessEntityID IS NULL
ORDER BY P.BusinessEntityID
GO

-- ==========================
-- JOIN con mas tablas
-- ==========================
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName,
		C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber,
		S.BusinessEntityID, S.Name
FROM Person.Person AS P INNER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID
						LEFT JOIN Sales.Store AS S
ON C.StoreID = S.BusinessEntityID
ORDER BY S.BusinessEntityID
GO



--CLAUSULA RIGHT JOIN
--La cláusula RIGHT JOIN (también conocida como RIGHT OUTER JOIN) combina filas de dos tablas basándose
--en una columna relacionada. Pero a diferencia de INNER JOIN, devuelve todas las filas de la tabla derecha, 
--y las coincidencias de la izquierda si existen. Si no hay coincidencia, 
--las columnas de la tabla izquierda se rellenan con NULL
--SINTAXIS
SELECT columnas
FROM tabla_izquierda
RIGHT JOIN tabla_derecha
ON tabla_izquierda.columna = tabla_derecha.columna;


-- Utilizar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO

-- Consultar Tablas
SELECT * FROM Person.Person;
SELECT * FROM Sales.Customer;
GO


-- ==========================
-- JOIN con dos tablas
-- ==========================
-- ANSI SQL-92
-- RIGHT JOIN(JOIN EXTERNO)
--	RIGHT JOIN
SELECT C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber,
		P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName
FROM Sales.Customer AS C RIGHT JOIN Person.Person AS P
ON C.PersonID = P.BusinessEntityID
ORDER BY P.BusinessEntityID
GO

--	RIGHT OUTER JOIN
SELECT C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber,
		P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName
FROM Sales.Customer AS C RIGHT OUTER JOIN Person.Person AS P
ON C.PersonID = P.BusinessEntityID
ORDER BY P.BusinessEntityID
GO

--	RIGHT OUTER JOIN sin coincidencia con la Tabla Izquierda
SELECT C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber,
		P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName
FROM Sales.Customer AS C RIGHT OUTER JOIN Person.Person AS P
ON C.PersonID = P.BusinessEntityID
WHERE C.PersonID IS NULL
ORDER BY P.BusinessEntityID
GO

--	RIGHT OUTER JOIN el orden de la Tabla es IMPORTANTE
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName,
		C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber
-- FROM Sales.Customer AS C RIGHT OUTER JOIN Person.Person AS P
FROM Person.Person AS P RIGHT OUTER JOIN Sales.Customer AS C
ON C.PersonID = P.BusinessEntityID
WHERE C.PersonID IS NULL
ORDER BY P.BusinessEntityID
GO


-- ==========================
-- JOIN con mas tablas
-- ==========================
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName,
		C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber,
		S.BusinessEntityID, S.Name
FROM Person.Person AS P INNER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID
						RIGHT JOIN Sales.Store AS S
ON C.StoreID = S.BusinessEntityID
ORDER BY S.BusinessEntityID
GO


--CLAUSULA FULL JOIN
-- Combina los resultados de LEFT JOIN y RIGHT JOIN.
-- Devuelve todas las filas de ambas tablas.
-- Si no hay coincidencia entre las tablas, los valores faltantes se rellenan con NULL
--SINTAXIS
SELECT *
FROM tabla1
FULL JOIN tabla2
ON tabla1.columna = tabla2.columna;

-- tabla1 y tabla2 son las tablas que estás uniendo.
-- columna es el campo común que se usa para hacer la unión

-- Utilizar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO

-- Consultar Tablas
SELECT * FROM Person.Person;
SELECT * FROM Sales.Customer;
GO


-- ==========================
-- JOIN con dos tablas
-- ==========================
-- ANSI SQL-92
-- FULL JOIN(JOIN EXTERNO)
--	FULL JOIN
SELECT C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber,
		P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName
FROM Sales.Customer AS C FULL JOIN Person.Person AS P
ON C.PersonID = P.BusinessEntityID
ORDER BY C.CustomerID
GO

--	FULL OUTER JOIN
SELECT C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber,
		P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName
FROM Sales.Customer AS C FULL OUTER JOIN Person.Person AS P
ON C.PersonID = P.BusinessEntityID
ORDER BY C.CustomerID
GO

--	FULL OUTER JOIN sin coincidencia con los KEY iguales
SELECT C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber,
		P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName
FROM Sales.Customer AS C FULL OUTER JOIN Person.Person AS P
ON C.PersonID = P.BusinessEntityID
WHERE C.PersonID IS NULL OR P.BusinessEntityID IS NULL
ORDER BY C.CustomerID
GO



-- ==========================
-- JOIN con mas tablas
-- ==========================
SELECT P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName,
		C.CustomerID, C.PersonID, C.StoreID, C.AccountNumber,
		S.BusinessEntityID, S.Name
FROM Person.Person AS P INNER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID
						FULL OUTER JOIN Sales.Store AS S
ON C.StoreID = S.BusinessEntityID
ORDER BY P.BusinessEntityID
GO


--CLAUSULA CROSS JOIN
--La cláusula CROSS JOIN genera el producto cartesiano entre dos tablas. Es decir, 
--combina cada fila de la primera tabla con cada fila de la segunda, sin necesidad de una condición de unión
--SINTAXIS
SELECT *
FROM tabla1
CROSS JOIN tabla2;

-- Utilizar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO

-- Consultar Tablas
SELECT DISTINCT PersonType FROM Person.Person;
SELECT DISTINCT CountryRegionCode FROM Person.StateProvince;
GO


-- ==========================
-- JOIN con dos tablas
-- ==========================
-- ANSI SQL-92
-- CROSS JOIN(JOIN CRUZADO)
--	CROSS JOIN
SELECT DISTINCT P.PersonType, S.CountryRegionCode
FROM Person.Person AS P CROSS JOIN Person.StateProvince AS S
GO


--CLAUSULA SELF JOIN
--Un SELF JOIN no es una cláusula especial, sino una forma de usar el JOIN tradicional 
--con dos alias de la misma tabla. Esto te permite tratar la tabla como 
--si fueran dos entidades distintas
--SINTAXIS
SELECT 
  t1.columna1, 
  t2.columna2
FROM 
  tabla AS t1
JOIN 
  tabla AS t2
ON 
  t1.columna_relacionada = t2.columna_clave;

-- Para mostrar jerarquías (empleado-supervisor, categorías-subcategorías)
-- Para comparar registros similares (clientes en la misma ciudad, productos con el mismo precio)
-- Para detectar duplicados o patrones internoS


  -- Utilizar la Base de Datos NORTHWND
USE NORTHWND
GO


-- Consultar la Tabla Employees
SELECT * FROM Employees
GO


-- Consulta con columnas específicas
SELECT EmployeeID, LastName + ' ' + FirstName AS Name,
		Title, ReportsTo
FROM Employees
GO


-- ==========================
-- SELF JOIN(Auto Unión)
-- ==========================
-- ANSI SQL-92
SELECT E.EmployeeID, E.LastName + ' ' + E.FirstName AS Name, --Empleado
		E.Title, E.ReportsTo,
		S.EmployeeID, S.LastName + ' ' + S.FirstName AS Name, --Supervisor
		S.Title, S.ReportsTo
FROM Employees AS S INNER JOIN Employees AS E
ON S.EmployeeID = E.ReportsTo
GO


--EJERCICIOS COMPLEJOS

-- Usar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


-- Consultar las Tablas:
SELECT * FROM Production.Product;
SELECT * FROM Production.ProductSubcategory;
SELECT * FROM Production.ProductCategory;


/*
Mostrar los productos, la subcategoría y la categoría a la que pertenecen.
*/
SELECT P.Name AS Product, P.Color, SafetyStockLevel, 
		PS.Name AS Subcategory, PC.Name AS Category
FROM Production.Product AS P INNER JOIN Production.ProductSubcategory AS PS
ON P.ProductSubcategoryID = PS.ProductSubcategoryID
							INNER JOIN Production.ProductCategory AS PC
ON PC.ProductCategoryID = PS.ProductCategoryID
GO


/*
Mostrar los productos que NO pertenecen a una subcategoría.
*/
SELECT P.ProductSubcategoryID, P.Name AS Product, P.Color, SafetyStockLevel, 
		PS.Name AS Subcategory
FROM Production.Product AS P LEFT JOIN Production.ProductSubcategory AS PS
ON P.ProductSubcategoryID = PS.ProductSubcategoryID
WHERE PS.ProductSubcategoryID IS NULL
GO


-- Consultar las Tablas:
SELECT * FROM Person.Person;
SELECT * FROM Person.PersonPhone;
SELECT * FROM Person.PhoneNumberType;
SELECT * FROM Person.EmailAddress;
SELECT * FROM HumanResources.Employee;
GO


/*
Mostrar las siguientes informaciones de los empleados:
- Cargo, Nombre, Fecha de Nacimiento
- Estado Civil, Genero, 
- Número de teléfono y su tipo de número del teléfono
- Email, el departamento y al grupo que se encuentra asignado.
*/
SELECT  E.JobTitle,
		P.FirstName + ' ' + P.LastName Name,
		DATENAME(weekday, E.BirthDate) + ' ' +
		CAST(DAY(E.BirthDate) AS CHAR(2)) + ', de ' +
		DATENAME(month, E.BirthDate) + ' del ' +
		CAST(YEAR(E.BirthDate) AS CHAR(4)) AS BirthDate,
		IIF(E.MaritalStatus = 'S', 'Single', 'Married') AS MaritalStatus,
		IIF(E.Gender = 'M', 'Male', 'Female') AS Gender,
		PP.PhoneNumber, PNT.Name AS Type,
		PE.EmailAddress AS Email,
		D.Name AS Department,
		D.GroupName AS GroupDepartment
FROM HumanResources.Employee E 
INNER JOIN Person.Person P ON P.BusinessEntityID = E.BusinessEntityID
INNER JOIN Person.PersonPhone PP ON P.BusinessEntityID = PP.BusinessEntityID
INNER JOIN Person.PhoneNumberType PNT ON PNT.PhoneNumberTypeID = PP.PhoneNumberTypeID
INNER JOIN Person.EmailAddress PE ON P.BusinessEntityID = PE.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory EDH ON E.BusinessEntityID = EDH.BusinessEntityID
INNER JOIN HumanResources.Department D ON EDH.DepartmentID = D.DepartmentID
GO



--EJERCICIOS


USE NORTHWND
GO


--Ejercicio 1:
--Mostrar los Empleados con las siguientes informaciones:
-- Su nombre y apellido
-- Su cargo
-- El territorio al que pertenece
-- La región a la que pertenece

SELECT 
    E.FirstName + ' ' + E.LastName AS Name,
    E.Title AS Title,
    T.TerritoryDescription AS Territory,
    R.RegionDescription AS Región
FROM Employees E
INNER JOIN EmployeeTerritories ET ON E.EmployeeID = ET.EmployeeID
INNER JOIN Territories T ON ET.TerritoryID = T.TerritoryID
INNER JOIN Region R ON T.RegionID = R.RegionID;

-- Employees: contiene el nombre, apellido y cargo del empleado.
-- EmployeeTerritories: tabla intermedia que conecta empleados con territorios.
-- Territories: contiene la descripción del territorio y el RegionID.
-- Region: contiene la descripción de la región.


--Ejercicio 2:
--Mostrar los Clientes que no tienen un pedido asignado.


SELECT C.CompanyName,C.ContactName,C.ContactTitle,C.Address,C.City,C.Region,C.PostalCode,C.Country,
		O.OrderID,O.CustomerID,O.EmployeeID,O.OrderDate,O.RequiredDate,O.ShippedDate,O.ShipVia,O.Freight
FROM Customers AS C LEFT JOIN Orders AS O
ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL
GO


--Ejercicio 3:
--Mostrar los Clientes que tienen un pedido asignado y debe de mostrar la información siguiente:
--La compania, contacto, título, dirección, ciudad, región, código postal y pais del cliente
--Fecha de Pedido, Fecha Requerida y Fecha de Envío del Pedido
--Nombre del Producto
--Precio Unitario, Cantidad, Descuento y Total (hacer el cálculo) a pagar del Pedido
--Nota: En la Tabla producto hay un precio unitario que es el precio del producto 
--y en la Tabla [Order Datails] hay un precio unitario que es el precio de la factura.

SELECT C.CompanyName,C.ContactName,C.ContactTitle,C.Address,C.City,C.Region,C.PostalCode,C.Country,
		O.OrderDate,O.RequiredDate,O.ShippedDate,
		P.ProductName,
		OD.UnitPrice AS Precio_factura,OD.Quantity,OD.Discount,
		(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Total_a_pagar
FROM Customers AS C 
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
INNER JOIN Products AS P ON P.ProductID = OD.ProductID
GO