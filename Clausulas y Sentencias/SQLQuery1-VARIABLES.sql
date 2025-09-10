

USE NORTHWND
GO

--VALIDAR GO

SELECT * FROM Customers
GO

SELECT * FROM Clientes
GO

SELECT * FROM Employees
GO

--VALIDAR PUNTO Y COMA

SELECT * FROM Customers;

SELECT * FROM Clientes;

SELECT * FROM Employees;


--VARIABLES

DECLARE @edad TINYINT
DECLARE @nombre VARCHAR(20),@apellido VARCHAR(20)
SET @edad = 40 + 5
SET @nombre = 'Cristian'
SET @apellido ='Valera'
SELECT @edad AS edad,@nombre AS nombre,@apellido AS apellido
SELECT @nombre +' '+ @apellido +' '+ CAST(@edad AS VARCHAR(3)) AS nombreCompleto
GO

--SIN USAR SET

DECLARE @edad TINYINT = 40
DECLARE @nombre VARCHAR(20)='Pablo',@apellido VARCHAR(20)='Valera'
SELECT @edad AS edad,@nombre AS nombre,@apellido AS apellido
SELECT @nombre +' '+ @apellido +' '+ CAST(@edad AS VARCHAR(3)) AS nombreCompleto
GO


--CREAR VARIABLES PARA NOMBRE PAIS DE ORIGEN Y SU CAPITAL COMO SALIDA DEBE TENER EL MENSAJE:
--YO <NOMBRE>, SOY DEL PAIS DE <NOMBRE PAIS> Y SU CAPITAL ES <NOMBRE CAPITAL>

DECLARE @nombre VARCHAR(20)='Pablo',@pais VARCHAR(20)='Colombia',@capital VARCHAR(20)='Bogotá'
SELECT 'Yo ' + @nombre + ', soy del pais de ' + @pais + ' y su capital es ' + @capital AS Texto
GO


--AMBITO DE LA VARIABLE


DECLARE @edad TINYINT
DECLARE @nombre VARCHAR(20),@apellido VARCHAR(20)
SET @edad = 40 + 5
SET @nombre = 'Cristian'
SET @apellido ='Valera'
SELECT @edad AS edad,@nombre AS nombre,@apellido AS apellido
SELECT @nombre +' '+ @apellido +' '+ CAST(@edad AS VARCHAR(3)) AS nombreCompleto
GO

--SIN USAR SET

DECLARE @edad2 TINYINT = 40
DECLARE @nombre2 VARCHAR(20)='Pablo',@apellido2 VARCHAR(20)='Valera'
SELECT @edad2 AS edad,@nombre2 AS nombre,@apellido2 AS apellido
SELECT @nombre2 +' '+ @apellido2 +' '+ CAST(@edad2 AS VARCHAR(3)) AS nombreCompleto
GO


--VARIABLE CON LA INSTRUCCION SELECT

USE NORTHWND
GO



SELECT * FROM Customers
GO

DECLARE @pais VARCHAR(25)
SET @pais = 'Mexico'
SELECT * FROM Customers
WHERE Country = @pais
GO


--CONSULTAR EL CLIENTE DE UNA COMPAÑIA A PARTIR DE UNA VARIABLE


DECLARE @idCliente NCHAR(5),@compañia VARCHAR(40)
SET @idCliente = 'ALFKI'
SELECT @compañia = CompanyName
FROM Customers
WHERE CustomerID = @idCliente

SELECT @compañia AS Compañia
GO


--VARIABLE PARA COINCIDENCIA DE PATRONES

DECLARE @coincidencia VARCHAR(10)
SET @coincidencia = '%Manager'
SELECT * FROM Customers
WHERE ContactTitle LIKE @coincidencia
GO


--CONSULTAR LOS EMPLEADOS DONDE SU NOMBRE INICIE CON LA LETRA M

SELECT * FROM Employees
GO


DECLARE @nombre VARCHAR(20)
SET @nombre = 'M%'
SELECT * FROM Employees
WHERE FirstName LIKE @nombre
GO



--INSTRUCCION EXECUTE


USE NORTHWND
GO

DECLARE @tabla VARCHAR (40) = 'Customers'
EXECUTE ('SELECT * FROM ' + @tabla)
GO

DECLARE @tabla VARCHAR (40) = 'Employees'
EXECUTE ('SELECT * FROM ' + @tabla)
GO