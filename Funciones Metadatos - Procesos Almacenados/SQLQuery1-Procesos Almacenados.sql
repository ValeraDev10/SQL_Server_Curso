

--PROCEDIMIENTOS ALMACENADOS
--Un procedimiento almacenado es un conjunto de instrucciones SQL que se guarda en la base de datos 
--y puede ejecutarse cuando se necesite. Es como una función en programación, 
--pero con más libertad para modificar datos

-- Reutilización de código: Evitas repetir consultas complejas.
-- Seguridad: Puedes controlar el acceso sin exponer directamente las tablas.
-- Rendimiento: Están precompilados, lo que reduce el tiempo de ejecución.
-- Mantenimiento: Centralizas la lógica de negocio en un solo lugar
-- SINTAXIS BASICA
CREATE PROCEDURE insertarModificarCuenta
    @id INT,
    @cuenta INT
AS
BEGIN
    UPDATE Clientes
    SET cuenta = @cuenta
    WHERE idClientes = @id
END


-- Nos ubicamos en la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


-- =========================================== --
--				SET ANSI_NULLS
-- =========================================== --
-- Crear el primer Procedimiento Almacenado
CREATE PROCEDURE SP_001_Person
AS
BEGIN
	SELECT * FROM Person.Person
END
GO


-- Ejecutar un Procedimiento Almacenado
EXECUTE SP_001_Person
GO

EXEC SP_001_Person
GO


-- Consultar la Tabla Person.Person
SELECT * FROM Person.Person
GO

SELECT * FROM Person.Person
WHERE Title = NULL --No muestra información
GO

-- ON: Las comparaciones con NULL usando = o <> siempre devuelven FALSE o UNKNOWN.

SET ANSI_NULLS ON --SET ANSI_NULLS ON es por defecto
GO
SELECT * FROM Person.Person
WHERE Title = NULL
GO

-- OFF: Permite que nombre = NULL devuelva filas donde nombre sea NULL, lo cual no sigue el estándar ANSI y está en desuso


SET ANSI_NULLS OFF --SET ANSI_NULLS OFF cambiando manualmente
GO
SELECT * FROM Person.Person
WHERE Title = NULL
GO


-- Establecer SET ANSI_NULLS ON
SET ANSI_NULLS ON
GO


-- Otra forma de consultar los valores Null aunque sea SET ANSI_NULLS ON
SELECT * FROM Person.Person
WHERE Title IS NOT NULL
GO



-- =========================================== --
--				SET QUOTED_IDENTIFIER
-- =========================================== --

--Es una configuración que controla cómo se interpretan las comillas dobles (") en tus scripts. 
--Es clave cuando trabajas con procedimientos almacenados, nombres de objetos que contienen espacios 
--o palabras reservadas, y scripts que deben seguir el estándar ANSI

-- ON (por defecto):
-- Las comillas dobles ("nombreColumna") se interpretan como identificadores (nombres de columnas, tablas, etc.).
-- Las comillas simples ('valor') se usan para literales de cadena.
-- Permite usar palabras reservadas como nombres de objetos si están entre comillas dobles

-- OFF:
-- Las comillas dobles se tratan como literales de cadena, igual que las comillas simples.
-- No puedes usar palabras reservadas como nombres de objetos, ni nombres con espacios



-- Crear una Tabla SELECT
CREATE TABLE SELECT( --Error
	id	int
)
GO
 
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE "SELECT"( --Correcto
	id	int
)
GO

--Eliminar la Tabla SELECT
DROP TABLE "SELECT"
GO



-- Crear una Tabla SELECT con SET QUOTED_IDENTIFIER ON
SET QUOTED_IDENTIFIER ON --por defecto
GO
CREATE TABLE "SELECT"(
	id	int
)
GO

--Eliminar la Tabla SELECT
DROP TABLE "SELECT"
GO


-- Crear una Tabla SELECT con SET QUOTED_IDENTIFIER OFF
SET QUOTED_IDENTIFIER OFF
GO
CREATE TABLE "SELECT"(
	id	int
)
GO



-- =========================================== --
--				SET SET NOCOUNT
-- =========================================== --

--Cuando ejecutas una instrucción como INSERT, UPDATE, DELETE, o SELECT, SQL Server normalmente devuelve un mensaje como:
--(3 rows affected)
--SET NOCOUNT ON: Suprime ese mensaje.
--SET NOCOUNT OFF: Muestra el mensaje por defecto

-- Mejora el rendimiento en procedimientos almacenados y scripts que hacen muchas operaciones.
-- Evita resultados innecesarios cuando usas herramientas como Power Automate, ADO.NET, 
-- o aplicaciones que procesan la salida.
-- Reduce tráfico entre servidor y cliente, especialmente útil en procesos batch o ETL



-- Consultar la Tabla Person
SELECT * FROM Person.Person
GO


-- Establecer en SET NOCOUNT OFF
SET NOCOUNT OFF -- Por defecto
GO
SELECT * FROM Person.Person
GO


-- Establecer en SET NOCOUNT ON
SET NOCOUNT ON 
GO
SELECT * FROM Person.Person
GO


-- Alterar el Procedimiento Almacenado
ALTER PROCEDURE SP_001_Person
AS
BEGIN
	SET NOCOUNT OFF;
	
	SELECT * FROM Person.Person;

	SELECT * FROM Person.Address;
END
GO

-- Ejecutar un Procedimiento Almacenado
EXECUTE SP_001_Person
GO



-- Alterar el Procedimiento Almacenado
ALTER PROCEDURE SP_001_Person
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT * FROM Person.Person;

	SELECT * FROM Person.Address;
END
GO

-- Ejecutar un Procedimiento Almacenado
EXECUTE SP_001_Person
GO


--PROCEDIMIENTO ALMACENADO DE CONSULTA

-- Usar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


--Consulta información de los Empleados
SELECT  E.JobTitle,
		P.FirstName + ' ' + P.LastName Name,
		E.BirthDate, YEAR(E.BirthDate) Year,
		MONTH(E.BirthDate) Month, DAY(E.BirthDate) Day,
		IIF(E.MaritalStatus = 'S', 'Single', 'Married') MaritalStatus,
		IIF(E.Gender = 'M', 'Male', 'Female') Gender,
		PP.PhoneNumber, PNT.Name Type,
		PE.EmailAddress Email,
		D.Name Department,
		D.GroupName GroupDepartment
FROM HumanResources.Employee E 
INNER JOIN Person.Person P ON P.BusinessEntityID = E.BusinessEntityID
INNER JOIN Person.PersonPhone PP ON P.BusinessEntityID = PP.BusinessEntityID
INNER JOIN Person.PhoneNumberType PNT ON PNT.PhoneNumberTypeID = PP.PhoneNumberTypeID
INNER JOIN Person.EmailAddress PE ON P.BusinessEntityID = PE.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory EDH ON E.BusinessEntityID = EDH.BusinessEntityID
INNER JOIN HumanResources.Department D ON EDH.DepartmentID = D.DepartmentID
ORDER BY YEAR(E.BirthDate)
GO


--Crear un Procedimiento Almacenado
CREATE OR ALTER PROC SP_002_EmployeeInformation
AS
BEGIN
	SELECT  E.JobTitle,
			P.FirstName + ' ' + P.LastName Name,
			E.BirthDate, YEAR(E.BirthDate) Year,
			MONTH(E.BirthDate) Month, DAY(E.BirthDate) Day,
			IIF(E.MaritalStatus = 'S', 'Single', 'Married') MaritalStatus,
			IIF(E.Gender = 'M', 'Male', 'Female') Gender,
			PP.PhoneNumber, PNT.Name Type,
			PE.EmailAddress Email,
			D.Name Department,
			D.GroupName GroupDepartment
	FROM HumanResources.Employee E 
	INNER JOIN Person.Person P ON P.BusinessEntityID = E.BusinessEntityID
	INNER JOIN Person.PersonPhone PP ON P.BusinessEntityID = PP.BusinessEntityID
	INNER JOIN Person.PhoneNumberType PNT ON PNT.PhoneNumberTypeID = PP.PhoneNumberTypeID
	INNER JOIN Person.EmailAddress PE ON P.BusinessEntityID = PE.BusinessEntityID
	INNER JOIN HumanResources.EmployeeDepartmentHistory EDH ON E.BusinessEntityID = EDH.BusinessEntityID
	INNER JOIN HumanResources.Department D ON EDH.DepartmentID = D.DepartmentID
	ORDER BY YEAR(E.BirthDate)
END
GO


--Ejecutar el Procedimiento Almacenado
EXEC SP_002_EmployeeInformation
GO



--Agregar parámetro para el año del cumpleaños
CREATE OR ALTER PROC SP_002_EmployeeInformation
(
	@year SMALLINT
)
AS
BEGIN
	SELECT  E.JobTitle,
			P.FirstName + ' ' + P.LastName Name,
			E.BirthDate, YEAR(E.BirthDate) Year,
			MONTH(E.BirthDate) Month, DAY(E.BirthDate) Day,
			IIF(E.MaritalStatus = 'S', 'Single', 'Married') MaritalStatus,
			IIF(E.Gender = 'M', 'Male', 'Female') Gender,
			PP.PhoneNumber, PNT.Name Type,
			PE.EmailAddress Email,
			D.Name Department,
			D.GroupName GroupDepartment
	FROM HumanResources.Employee E 
	INNER JOIN Person.Person P ON P.BusinessEntityID = E.BusinessEntityID
	INNER JOIN Person.PersonPhone PP ON P.BusinessEntityID = PP.BusinessEntityID
	INNER JOIN Person.PhoneNumberType PNT ON PNT.PhoneNumberTypeID = PP.PhoneNumberTypeID
	INNER JOIN Person.EmailAddress PE ON P.BusinessEntityID = PE.BusinessEntityID
	INNER JOIN HumanResources.EmployeeDepartmentHistory EDH ON E.BusinessEntityID = EDH.BusinessEntityID
	INNER JOIN HumanResources.Department D ON EDH.DepartmentID = D.DepartmentID
	WHERE YEAR(E.BirthDate) = @year
	ORDER BY YEAR(E.BirthDate)
END
GO


--Ejecutar el Procedimiento Almacenado con parámetro
EXEC SP_002_EmployeeInformation 1991
GO


--Agregar un valor por defecto al parámetro
CREATE OR ALTER PROC SP_002_EmployeeInformation
(
	@year SMALLINT = 1983
)
AS
BEGIN
	SELECT  E.JobTitle,
			P.FirstName + ' ' + P.LastName Name,
			E.BirthDate, YEAR(E.BirthDate) Year,
			MONTH(E.BirthDate) Month, DAY(E.BirthDate) Day,
			IIF(E.MaritalStatus = 'S', 'Single', 'Married') MaritalStatus,
			IIF(E.Gender = 'M', 'Male', 'Female') Gender,
			PP.PhoneNumber, PNT.Name Type,
			PE.EmailAddress Email,
			D.Name Department,
			D.GroupName GroupDepartment
	FROM HumanResources.Employee E 
	INNER JOIN Person.Person P ON P.BusinessEntityID = E.BusinessEntityID
	INNER JOIN Person.PersonPhone PP ON P.BusinessEntityID = PP.BusinessEntityID
	INNER JOIN Person.PhoneNumberType PNT ON PNT.PhoneNumberTypeID = PP.PhoneNumberTypeID
	INNER JOIN Person.EmailAddress PE ON P.BusinessEntityID = PE.BusinessEntityID
	INNER JOIN HumanResources.EmployeeDepartmentHistory EDH ON E.BusinessEntityID = EDH.BusinessEntityID
	INNER JOIN HumanResources.Department D ON EDH.DepartmentID = D.DepartmentID
	WHERE YEAR(E.BirthDate) = @year
	ORDER BY YEAR(E.BirthDate)
END
GO


--Ejecutar el Procedimiento Almacenado con parámetro por defecto y opcional
EXEC SP_002_EmployeeInformation
GO

EXEC SP_002_EmployeeInformation 1990
GO



--Agregar otro parámetro y un valor por defecto
CREATE OR ALTER PROC SP_002_EmployeeInformation
(
	@year SMALLINT = 1984,
	@gender CHAR(1) = 'F' 
)
AS
BEGIN
	SELECT  E.JobTitle,
			P.FirstName + ' ' + P.LastName Name,
			E.BirthDate, YEAR(E.BirthDate) Year,
			MONTH(E.BirthDate) Month, DAY(E.BirthDate) Day,
			IIF(E.MaritalStatus = 'S', 'Single', 'Married') MaritalStatus,
			IIF(E.Gender = 'M', 'Male', 'Female') Gender,
			PP.PhoneNumber, PNT.Name Type,
			PE.EmailAddress Email,
			D.Name Department,
			D.GroupName GroupDepartment
	FROM HumanResources.Employee E 
	INNER JOIN Person.Person P ON P.BusinessEntityID = E.BusinessEntityID
	INNER JOIN Person.PersonPhone PP ON P.BusinessEntityID = PP.BusinessEntityID
	INNER JOIN Person.PhoneNumberType PNT ON PNT.PhoneNumberTypeID = PP.PhoneNumberTypeID
	INNER JOIN Person.EmailAddress PE ON P.BusinessEntityID = PE.BusinessEntityID
	INNER JOIN HumanResources.EmployeeDepartmentHistory EDH ON E.BusinessEntityID = EDH.BusinessEntityID
	INNER JOIN HumanResources.Department D ON EDH.DepartmentID = D.DepartmentID
	WHERE YEAR(E.BirthDate) = @year AND E.Gender = @gender
	ORDER BY YEAR(E.BirthDate)
END
GO


--Ejecutar el Procedimiento Almacenado con parámetro por defecto y opcional
EXEC SP_002_EmployeeInformation
GO

EXEC SP_002_EmployeeInformation 1983, 'M'
GO


--PROCEDIMIENTO ALMACENADO DE INSERCION

-- Usar la Base de Datos HospitalABC
USE HospitalABC
GO


-- Consultar la Tabla Medicamentos
SELECT * FROM Medicamentos
GO


-- Crear Procedimiento Almacenado
CREATE OR ALTER PROC SP_003_InsertarMedicamento
(
	@idMedicamento	INT,
	@nombre			VARCHAR(40),
	@descripcion	VARCHAR(255) = NULL
)
AS
BEGIN
	
	IF NOT EXISTS ( SELECT idMedicamento FROM Medicamentos
				WHERE idMedicamento = @idMedicamento)
	BEGIN
		INSERT INTO Medicamentos(idMedicamento, nombre, descripcion)
		VALUES (@idMedicamento, @nombre, @descripcion)

		PRINT( 'El registro se agregó correctamente!' )
	END
	ELSE
	BEGIN
		PRINT( 'Error, el idMedicamento ya existe!' )
	END

END
GO


-- Insertar registro a partir de Procedimiento Almacenado
EXEC SP_003_InsertarMedicamento 1, 'Clonazepam' --ERROR
GO

EXEC SP_003_InsertarMedicamento 7, 'Diazepam' --CORRECTO
GO


-- Consultar la Tabla Medicamentos
SELECT * FROM Medicamentos
GO


--PROCEDIMIENTO ALMACENADO DE ACTUALIZACIÓN

-- Usar la Base de Datos HospitalABC
USE HospitalABC
GO


-- Consultar la Tabla Medicamentos
SELECT * FROM Medicamentos
GO


-- Crear Procedimiento Almacenado
CREATE OR ALTER PROC SP_004_ActualizarMedicamento
(
	@idMedicamento	INT,
	@nombre			VARCHAR(40),
	@descripcion	VARCHAR(255) = NULL
)
AS
BEGIN
	
	IF EXISTS ( SELECT idMedicamento FROM Medicamentos
				WHERE idMedicamento = @idMedicamento)
	BEGIN
		UPDATE Medicamentos
		SET		nombre = @nombre,
				descripcion = @descripcion
		WHERE	idMedicamento = @idMedicamento

		PRINT( 'El Medicamento se actualizó correctamente!' )
	END
	ELSE
	BEGIN
		PRINT( 'Error, el idMedicamento NO existe!' )
	END

END
GO


-- Actualizar un registro a partir de Procedimiento Almacenado
EXEC SP_004_ActualizarMedicamento 10, 'Salbutamol', 'Broncodilatador' --ERROR
GO

EXEC SP_004_ActualizarMedicamento 7, 'Salbutamol', 'Broncodilatador' --CORRECTO
GO


-- Consultar la Tabla Medicamentos
SELECT * FROM Medicamentos
GO


--PROCEDIMIENTO ALMACENADO DE ELIMINACION

-- Usar la Base de Datos HospitalABC
USE HospitalABC
GO


-- Consultar la Tabla Medicamentos
SELECT * FROM Medicamentos
GO


-- Crear Procedimiento Almacenado
CREATE OR ALTER PROC SP_005_EliminarMedicamento
(
	@idMedicamento	INT
)
AS
BEGIN
	
	IF EXISTS ( SELECT idMedicamento FROM Medicamentos
				WHERE idMedicamento = @idMedicamento)
	BEGIN
		DELETE FROM Medicamentos
		WHERE idMedicamento = @idMedicamento

		PRINT( 'El Medicamento se eliminó correctamente!' )
	END
	ELSE
	BEGIN
		PRINT( 'Error, el idMedicamento NO existe!' )
	END

END
GO


-- Eliminar un registro a partir del Procedimiento Almacenado
EXEC SP_005_EliminarMedicamento 10 --ERROR
GO

EXEC SP_005_EliminarMedicamento 7 --CORRECTO
GO


-- Consultar la Tabla Medicamentos
SELECT * FROM Medicamentos
GO


--PROCEDIMIENTO ALAMCENADO DINAMICO
--Un procedimiento almacenado dinámico en SQL se refiere a un procedimiento que construye y ejecuta sentencias SQL 
--de forma dinámica, es decir, que genera el código SQL como texto dentro del procedimiento y lo ejecuta en tiempo 
--de ejecución usando EXEC o sp_executesql. Esto es útil cuando necesitas flexibilidad para cambiar columnas, tablas, 
--condiciones o cláusulas según parámetros de entrada


-- Usar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO

-- Consultar la Tabla Product
SELECT * FROM Production.Product
GO


-- Crear un Procedimiento Almacenado Dinámico
CREATE OR ALTER PROCEDURE SP_006_DynamicProcedure
(
	@table NVARCHAR(50)
)
AS
BEGIN
	DECLARE @script NVARCHAR(255)

	SET @script = ('SELECT * FROM ' + @table)

	SELECT @script

END
GO


-- Ejecutar el Procedimiento Almacenado Dinámico
EXEC SP_006_DynamicProcedure 'Production.Product'
GO


-- Modificar el Procedimiento Almacenado Dinámico
CREATE OR ALTER PROCEDURE SP_006_DynamicProcedure
(
	@table NVARCHAR(50)
)
AS
BEGIN
	DECLARE @script NVARCHAR(255)

	SET @script = ('SELECT * FROM ' + @table)

	EXEC SP_EXECUTESQL @script

END
GO


-- Ejecutar el Procedimiento Almacenado Dinámico
EXEC SP_006_DynamicProcedure 'Production.Product'
GO

EXEC SP_006_DynamicProcedure 'Person.Person'
GO





-- Consultar la Tabla Person
SELECT * FROM Person.Person
GO


-- Crear otro Procedimiento Almacenado Dinámico
CREATE OR ALTER PROCEDURE SP_007_DynamicPerson
(
	@letter CHAR(1) = 'B'
)
AS
BEGIN

	DECLARE @query VARCHAR(500), @order VARCHAR(100)
	DECLARE @script NVARCHAR(MAX)

	SET @query = 'SELECT BusinessEntityID, Title, FirstName, MiddleName, LastName FROM Person.Person'

	SET @order = (CASE
					WHEN @letter = 'B' THEN ' ORDER BY BusinessEntityID'
					WHEN @letter = 'T' THEN ' ORDER BY Title'
					WHEN @letter = 'F' THEN ' ORDER BY FirstName'
					WHEN @letter = 'L' THEN ' ORDER BY LastName'
				  END)

	SET @script = @query + @order

	EXEC SP_EXECUTESQL @script

END
GO


-- Ejecutar el Procedimiento Almacenado Dinámico
EXEC SP_007_DynamicPerson
GO

EXEC SP_007_DynamicPerson 'T'
GO

EXEC SP_007_DynamicPerson 'F'
GO

EXEC SP_007_DynamicPerson 'L'
GO



--OUTPUT EN UN PROCEDIMIENTO ALMACENADO
--parámetro OUTPUT en un procedimiento almacenado permite devolver un valor desde el procedimiento 
--al código que lo invoca. Es útil cuando necesitas que el procedimiento no solo realice acciones 
--(como insertar o actualizar datos), sino también retorne información como resultados intermedios, 
--estados, o identificadores generados
--SINTAXIS BASICA
CREATE PROCEDURE NombreProcedimiento
    @Entrada INT,
    @Resultado INT OUTPUT
AS
BEGIN
    SET @Resultado = @Entrada * 2
END


-- Usar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


-- Crear otro Procedimiento Almacenado Dinámico
-- Con Parámetro OutPut
CREATE OR ALTER PROCEDURE SP_008_DynamicPersonOutPut
(
	@letter CHAR(1) = 'B',
	@rowNumber INT OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @query VARCHAR(500), @order VARCHAR(100)
	DECLARE @script NVARCHAR(MAX)

	SET @query = 'SELECT BusinessEntityID, Title, FirstName, MiddleName, LastName FROM Person.Person'

	SET @order = (CASE
					WHEN @letter = 'B' THEN ' ORDER BY BusinessEntityID'
					WHEN @letter = 'T' THEN ' ORDER BY Title'
					WHEN @letter = 'F' THEN ' ORDER BY FirstName'
					WHEN @letter = 'L' THEN ' ORDER BY LastName'
				  END)

	SET @script = @query + @order

	EXEC SP_EXECUTESQL @script

	SET @rowNumber = @@ROWCOUNT --Cuenta la cantidad de filas

END
GO


-- Ejecutar el Procedimiento Almacenado Dinámico
-- Con parámetro OutPut
DECLARE @variable INT
EXEC SP_008_DynamicPersonOutPut 'B', @variable OUTPUT
SELECT @variable AS rowNumber
GO






-- Crear otro Procedimiento Almacenado Dinámico
-- Con Parámetro OutPut
CREATE OR ALTER PROCEDURE SP_009_DynamicPersonOutPut
(
	@letter CHAR(1) = 'B',
	@out NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
	
	SET NOCOUNT ON;
	DECLARE @query VARCHAR(500), @order VARCHAR(100)

	SET @query = 'SELECT BusinessEntityID, Title, FirstName, MiddleName, LastName FROM Person.Person'

	SET @order = (CASE
					WHEN @letter = 'B' THEN ' ORDER BY BusinessEntityID'
					WHEN @letter = 'T' THEN ' ORDER BY Title'
					WHEN @letter = 'F' THEN ' ORDER BY FirstName'
					WHEN @letter = 'L' THEN ' ORDER BY LastName'
				  END)

	SET @out = @query + @order

END
GO


-- Ejecutar el Procedimiento Almacenado Dinámico
-- Con parámetro OutPut
DECLARE @salida NVARCHAR(MAX)
EXEC SP_009_DynamicPersonOutPut 'T', @salida OUTPUT
PRINT(@salida)
EXEC SP_EXECUTESQL @salida
GO



--MANEJO DE ERRORES CON PROCEDIMIENTO ALAMACENDADO

-- Usar la Base de Datos HospitalABC
USE HospitalABC
GO


-- Crear la Tabla dbErros
CREATE TABLE dbErros
         (ErrorID        INT IDENTITY(1, 1),
          UserName       VARCHAR(100),
          ErrorNumber    INT,
          ErrorState     INT,
          ErrorSeverity  INT,
          ErrorLine      INT,
          ErrorProcedure VARCHAR(MAX),
          ErrorMessage   VARCHAR(MAX),
          ErrorDateTime  DATETIME)
GO


-- Crear un Procedimiento Almacenado de Inserción
CREATE OR ALTER PROCEDURE SP_009_InsertarMedico
(
	@nombre			VARCHAR(40),
	@apellido		VARCHAR(40),
	@especialidad	VARCHAR(30),
	@telefono		CHAR(9),
	@email			VARCHAR(50)
)
AS
BEGIN
	SET NOCOUNT ON;
	--MANEJADOR DE ERRORES TRY
	BEGIN TRY

		INSERT INTO Medicos(nombre, apellido, especialidad, telefono, email)
				VALUES(@nombre, @apellido, @especialidad, @telefono, @email);

		PRINT( 'El registro se agregó correctamente!' )

	END TRY
	BEGIN CATCH

		INSERT INTO dbo.dbErros
		VALUES(SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(),  ERROR_SEVERITY(),
				ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE())

		PRINT( 'Error al insertar un registro!' )

	END CATCH
END
GO


-- Consultar la Tabla Medicos
SELECT * FROM Medicos
GO


-- Insertar registro a partir de Procedimiento Almacenado
-- Correcto
EXEC SP_009_InsertarMedico 'Karen', 'Díaz', 'Neurología', '900000000', 'karen.d@example.com'
GO

-- Incorrecto(Restricción)
EXEC SP_009_InsertarMedico 'Carlos', 'Marquez', 'Neumología', '900000000', 'carlos.m@example.com'
GO


-- Consultar la Tabla dbErros
SELECT * FROM dbErros
GO

--DIFERENCIAS ENTRE PROCEDIMIENTO ALMACENADO Y FUNCIONES
-- Procedimiento almacenado: útil para validar datos, transformar registros, ejecutar múltiples operaciones.
-- Función: perfecta para calcular totales, convertir formatos, o aplicar lógica dentro de una consulta

-- Usa procedimientos almacenados cuando necesitas lógica compleja, manipulación de datos o múltiples pasos.
-- Usa funciones cuando necesitas cálculos reutilizables dentro de consultas SQL


USE NORTHWND
GO

--EJERCICIOS

--Ejercicio 1:
--Crear un procedimiento almacenado (debes de asignarle un nombre) que muestre la información de los 
--Empleados con las siguientes informaciones:
--Su nombre y apellido
--Su cargo
--El territorio al que pertenece
--La región a la que pertenece
--Luego ejecutar el Procedimiento Almacenado.

SELECT * FROM Employees
GO

CREATE OR ALTER PROC SP_001_EmpleadoInfo
AS
BEGIN
	SELECT  E.FirstName + ' ' + E.LastName AS Nombre_y_Apellido,
			E.Title AS Cargo ,
			T.TerritoryDescription AS Territorio,
			R.RegionDescription AS Región

	FROM Employees AS E 
	INNER JOIN EmployeeTerritories ET ON E.EmployeeID = ET.EmployeeID
    INNER JOIN Territories T ON ET.TerritoryID = T.TerritoryID
    INNER JOIN Region R ON T.RegionID = R.RegionID
END
GO

EXEC SP_001_EmpleadoInfo
GO

--Ejercicio 2:
--Crear un procedimiento almacenado (debes de asignarle un nombre) que muestre la información de 
--los Clientes que no tienen un pedido asignado.
--Luego ejecutar el Procedimiento Almacenado.


CREATE OR ALTER PROC SP_002_ClienteSinPedido
AS
BEGIN
	SELECT C.CompanyName,C.ContactName,C.ContactTitle,C.Address,C.City,C.Region,C.PostalCode,C.Country,
				O.OrderID,O.CustomerID,O.EmployeeID,O.OrderDate,O.RequiredDate,O.ShippedDate,O.ShipVia,O.Freight
	FROM Customers AS C LEFT JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
	WHERE O.OrderID IS NULL
END
GO

EXEC SP_002_ClienteSinPedido
GO


--Ejercicio 3:
--Crear un procedimiento almacenado (debes de asignarle un nombre) que muestre la información de los 
--Clientes que tienen un pedido asignado y debe de mostrar la información siguiente:
-- La compañía, contacto, título, dirección, ciudad, región, código postal y pais del cliente
-- Fecha de Pedido, Fecha Requerida y Fecha de Envío del Pedido
-- Nombre del Producto
-- Precio Unitario, Cantidad, Descuento y Total (hacer el cálculo) a pagar del Pedido
--Nota: En la Tabla producto hay un precio unitario que es el precio del producto y en la Tabla 
--[Order Datails] hay un precio unitario que es el precio de la factura.
--Luego ejecutar el Procedimiento Almacenado.


CREATE OR ALTER PROC SP_003_ClienteConPedido
AS
BEGIN
	SELECT C.CompanyName,C.ContactName,C.ContactTitle,C.Address,C.City,C.Region,C.PostalCode,C.Country,
			O.OrderDate,O.RequiredDate,O.ShippedDate,
			P.ProductName,
			OD.UnitPrice AS Precio_factura,OD.Quantity,OD.Discount,
			(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Total_a_pagar
	FROM Customers AS C 
	INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
	INNER JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
	INNER JOIN Products AS P ON P.ProductID = OD.ProductID
	ORDER BY CompanyName
END
GO

EXEC SP_003_ClienteConPedido
GO