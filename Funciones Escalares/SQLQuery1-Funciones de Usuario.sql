

--FUNCIONES DEFINIDAS POR EL USUARIO

USE AdventureWorks2022
GO

--FUNCIONES ESCALARES
--Son bloques de código que:
-- Aceptan parámetros de entrada.
-- Ejecutan una operación (como cálculos, transformaciones, validaciones).
-- Devuelven un solo valor escalar (int, varchar, datetime, etc.).
-- Se almacenan en la base de datos y pueden ser reutilizadas en
-- consultas, cláusulas SELECT, WHERE, ORDER BY, etc.

--SINTAXIS
CREATE FUNCTION dbo.NombreFuncion (@parametro1 INT, @parametro2 VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @resultado INT
    SET @resultado = @parametro1 * LEN(@parametro2)
    RETURN @resultado
END

-- No pueden modificar datos (no se permite INSERT, UPDATE, DELETE).
-- No pueden usar TRY...CATCH para manejo de errores.
-- No pueden llamar a procedimientos almacenados ni usar tablas temporales


-- Usar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


/*-----------------------------------------
		CREAMOS LA FUNCIÓN ESCALAR
------------------------------------------*/
CREATE OR ALTER FUNCTION Cantidad_Empleados_EstadoCivil(@MaritalStatus CHAR(1)) 
RETURNS INT 
AS 
BEGIN

          DECLARE @cantidad_empleado INT;

		  /*
          SET @cantidad_empleado = (
									SELECT COUNT(1) 
									FROM HumanResources.Employee 
									WHERE MaritalStatus = @MaritalStatus
									)
		  */

		  SELECT @cantidad_empleado = COUNT(1) 
		  FROM HumanResources.Employee 
		  WHERE MaritalStatus = @MaritalStatus

          RETURN @cantidad_empleado;

END
GO


/*-----------------------------------------
	Consultamos mediante SELECT
------------------------------------------*/
SELECT dbo.Cantidad_Empleados_EstadoCivil('M') AS CantidadM
GO

SELECT dbo.Cantidad_Empleados_EstadoCivil('S') AS CantidadS
GO

/*------------------------------------------------------
	Asignamos a una Variable, Alteramos y Consultamos
-------------------------------------------------------*/
DECLARE @CantidadDoble INT = 0
SET @CantidadDoble = dbo.Cantidad_Empleados_EstadoCivil('M') * 2
SELECT @CantidadDoble AS Cantidad
GO


/*---------------------------------------------------
	Cremos una Función con múltiples parámetros
----------------------------------------------------*/
CREATE OR ALTER FUNCTION Calcular_Pitagoras(@cateto_a FLOAT, @cateto_b FLOAT) 
RETURNS FLOAT 
AS 
BEGIN

          DECLARE @hipotenusa FLOAT;

          SET @hipotenusa = SQRT( POWER(@cateto_a, 2) + POWER(@cateto_b, 2) )

          RETURN @hipotenusa; 

END
GO



/*-----------------------------------------
	Consultamos mediante SELECT
------------------------------------------*/
SELECT dbo.Calcular_Pitagoras(6, 8) AS Resultado
GO



--FUNCIONES CON VALORES DE TABLA EN LINEA
--Una ITVF es una función definida por el usuario que:
-- Devuelve una tabla como resultado.
-- No utiliza bloques BEGIN...END.
-- Se define con una sola instrucción SELECT.
-- Puede recibir parámetros para personalizar la consulta


CREATE FUNCTION dbo.NombreFuncion (@Parametro INT)
RETURNS TABLE
AS
RETURN (
    SELECT columna1, columna2
    FROM NombreTabla
    WHERE columnaX > @Parametro
);

-- No se usa BEGIN...END ni se declara variables internas.
-- El SELECT es la única instrucción dentro del RETURN


-- Usar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


/*----------------------------------------------------
		CREAMOS LA FUNCIÓN DE TABLA(En Línea)
-----------------------------------------------------*/
CREATE OR ALTER FUNCTION Mostrar_Empleados_HorasVacaciones(@hora SMALLINT) 
RETURNS TABLE
AS 
RETURN(
	SELECT BusinessEntityID, JobTitle, BirthDate, HireDate,
			Gender, MaritalStatus, VacationHours
	FROM HumanResources.Employee
	WHERE VacationHours <= @hora
)
GO


/*------------------------------------------------
	Consultar todas las columnas mediante SELECT
--------------------------------------------------*/
SELECT *
FROM Mostrar_Empleados_HorasVacaciones(50)
ORDER BY VacationHours DESC
GO


/*------------------------------------------------
	Consultar algunas columnas mediante SELECT
--------------------------------------------------*/
SELECT BusinessEntityID, JobTitle, HireDate, VacationHours  
FROM Mostrar_Empleados_HorasVacaciones(50)
ORDER BY VacationHours DESC
GO



--FUNCIONES CON VALORES DE TABLA DE MULTIPLES DECLARACIONES
--Son funciones definidas por el usuario que:
-- Devuelven una tabla como resultado.
-- Permiten múltiples instrucciones en su cuerpo (como IF, WHILE, INSERT, etc.).
-- Son ideales para lógica compleja que no puede resolverse con una sola expresión

CREATE FUNCTION NombreFuncion (
    @Parametro1 INT,
    @Parametro2 VARCHAR(50)
)
RETURNS @TablaResultado TABLE (
    Columna1 INT,
    Columna2 VARCHAR(100)
)
AS
BEGIN
    -- Lógica de negocio
    INSERT INTO @TablaResultado
    SELECT Columna1, Columna2
    FROM OtraTabla
    WHERE Condición = @Parametro1;

    RETURN;
END;

-- La tabla de retorno (@TablaResultado) se declara explícitamente.
-- Puedes usar múltiples instrucciones dentro del bloque BEGIN...END.
-- Se ejecuta como una función, pero se comporta como una tabla en consultas

-- Usar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


/*-------------------------------------------------------------------
		CREAMOS LA FUNCIÓN DE TABLA(Múltiples Declaraciones)
--------------------------------------------------------------------*/
CREATE OR ALTER FUNCTION Lista_Empleados_HorasVacaciones(@hora SMALLINT) 
RETURNS @Lista TABLE(BusinessEntityID INT, JobTitle NVARCHAR(50),
					 HireDate DATE, VacationHours SMALLINT)
AS 
BEGIN
	INSERT INTO @LISTA
	SELECT BusinessEntityID, JobTitle, HireDate, VacationHours
	FROM HumanResources.Employee
	WHERE VacationHours <= @hora

	RETURN
END
GO


/*------------------------------------------------
	Consultar todas las columnas mediante SELECT
--------------------------------------------------*/
SELECT *
FROM Lista_Empleados_HorasVacaciones(50)
ORDER BY VacationHours DESC
GO


/*------------------------------------------------
	Consultar algunas columnas mediante SELECT
--------------------------------------------------*/
SELECT BusinessEntityID, JobTitle, HireDate, VacationHours  
FROM Lista_Empleados_HorasVacaciones(50)
ORDER BY VacationHours DESC
GO



--//////////////////////////////////////////////////////////////////////////////////////////////////////////////7

--EJERCICIOS COMPLEJOS


-- Usar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


-- Ejercicio 1
/*
Crear una función llamada "Fn_getCylinderVolume" que hará lo siguiente:
Calcule el Volumen de un Cilindro, teniendo en cuenta que: 
La fórmula del Volumen es: Pi por Radio al cuadrado por la altura
El radio y la altura nosotros debemos de asignarle un valor.
*/
CREATE OR ALTER FUNCTION Fn_getCylinderVolume
( 
@radio DECIMAL(7,2), @altura DECIMAL(7,2)
)
RETURNS DECIMAL(7,2)
AS
BEGIN

	DECLARE @volumen DECIMAL(7,2)

	SET @volumen = PI() * POWER(@radio, 2) * @altura

	RETURN @volumen
	
END
GO


-- Validar la función "Fn_getCylinderVolume"
SELECT dbo.Fn_getCylinderVolume(5, 10) AS Volumen
GO

PRINT dbo.Fn_getCylinderVolume(5, 10)
GO



-- Consultar la Tabla Person.Address
SELECT * FROM Person.Address
GO


-- Ejercicio 2
/*
Crear una función llamada "Fn_SearchAddresByCity" 
que tendra un parámetro llamado "@City" que será un NVARCHAR(30)
Se debe utilizar la Tabla Address y mostrar las columnas
AddressLine1, AddressLine2, City y PostalCode
donde el valor de columna "City" debe ser igual al parámetro "@City"
Puedes utilizar la Función con Valores de Tabla en Línea o
Función con Valores de Tabla de Múltiples Declaraciones
*/
-- Función con Valores de Tabla en Línea
CREATE OR ALTER FUNCTION Fn_SearchAddresByCity( @City NVARCHAR(30))
RETURNS TABLE
AS
RETURN(
	SELECT AddressLine1, AddressLine2, City, PostalCode
	FROM Person.Address
	WHERE City = @City
)
GO


-- Validar la función "Fn_SearchAddresByCity"
SELECT * 
FROM dbo.Fn_SearchAddresByCity('Paris')
GO


--EJERCICIOS 

USE NORTHWND
GO

--Ejercicio 1:
--Crear una función llamada "Fn_getDistaceBetweenTwoPoint" que hará lo siguiente:
--Calcular la Distancia entre dos puntos de coordenadas, 
--teniendo en cuenta que la fórmula para calcular la distancia es: 
--Raíz Cuadrada de x2 - x1 al cuadrado + y2 - y1 al cuadrado
--los puntos de coordenada X y Y nosotros le debemos asignar.

CREATE OR ALTER FUNCTION Fn_getDistaceBetweenTwoPoint
( 
@X1 DECIMAL(7,2),@X2 DECIMAL(7,2),@Y1 DECIMAL(7,2),@Y2 DECIMAL(7,2)
)
RETURNS DECIMAL(7,2)
AS
BEGIN
	DECLARE @distancia DECIMAL(7,2)
	SET @distancia = SQRT(POWER(@X2 - @X1, 2) + POWER(@Y2 - @Y1, 2) )
	RETURN @distancia	
END
GO

SELECT dbo.Fn_getDistaceBetweenTwoPoint(10,20,5,10) AS DISTANCIA
GO




--Ejercicio 2:
--Crear una función llamada "Fn_getCustomerByCountry" que tendrá un parámetro llamado "@country" 
--que será un NVARCHAR(15)
--Se debe utilizar la Tabla "Customers" y mostrar las columnas 
--“CustomerID”, “CompanyName”, “ContactName”, “Address”, “City”, “Region”, “PostalCode” y “Country”
--Donde el valor de columna "Country" debe ser igual al parámetro "@country"
--Utilizar la Función con Valores de Tabla en Línea

CREATE OR ALTER FUNCTION Fn_getCustomerByCountry( @country NVARCHAR(15))
RETURNS TABLE
AS
RETURN(
	SELECT CustomerID, CompanyName, ContactName, Address,City,Region,PostalCode,Country
	FROM Customers
	WHERE Country = @country
)
GO

SELECT *
FROM Fn_getCustomerByCountry('Mexico') 
GO
SELECT *
FROM Fn_getCustomerByCountry('USA') 
GO



--Ejercicio 3:
--Crear una función llamada "Fn_getProductByUnitPrice" que tendrá un parámetro llamado " @unitPrice" que será un DECIMAL(7,2)
--Se debe utilizar la Tabla "Products" y únicamente mostrar las columnas “ProductName”, “UnitPrice” y “UnitsInStock”
--Donde el valor de columna " UnitPrice" debe ser menor o igual al parámetro "@unitPrice"
--Ordenar por la columna "UnitPrice" de manera Descendente
--Utilizar la Función con Valores de Tabla de Múltiples Declaraciones

CREATE OR ALTER FUNCTION Fn_getProductByUnitPrice (@unitPrice DECIMAL(7,2)) 
RETURNS @Lista TABLE(ProductName NVARCHAR(50), UnitPrice DECIMAL(7,2),UnitsInStock INT)
AS 
BEGIN
	INSERT INTO @LISTA
	SELECT ProductName, UnitPrice, UnitsInStock
	FROM Products
	WHERE UnitPrice <= @unitPrice
	RETURN
END
GO

SELECT *
FROM Fn_getProductByUnitPrice(20) 
ORDER BY UnitPrice DESC
GO
SELECT *
FROM Fn_getProductByUnitPrice(12.5)
ORDER BY UnitPrice DESC
GO


