


-- Funciones HOST_ID y HOST_NAME
--Las funciones HOST_ID() y HOST_NAME() en SQL Server te permiten identificar desde qué equipo 
--se está ejecutando una consulta.

-- HOST_ID()
-- Devuelve el ID del proceso (PID) de la aplicación cliente que se conecta a SQL Server.
-- Tipo de dato: char(10)
-- Útil para registrar qué terminal ejecutó una operación.
-- HOST_NAME()
-- Devuelve el nombre del equipo cliente desde el cual se ejecuta la consulta.
-- Tipo de dato: nvarchar
-- Ideal para identificar el origen de una transacción o conexión.

--Ejemplo práctico
--Supongamos que quieres registrar quién insertó un pedido en una tabla:
CREATE TABLE Orders (
    OrderID     INT PRIMARY KEY,
    CustomerID  NCHAR(5),
    TerminalID  CHAR(10) NOT NULL DEFAULT HOST_ID(),
    HostName    NVARCHAR(128) NOT NULL DEFAULT HOST_NAME(),
    OrderDate   DATETIME NOT NULL
);

--Cada vez que se inserte un registro, se guardará automáticamente el ID del proceso 
--y el nombre del equipo que lo ejecutó.

-- Consulta útil para monitoreo
--Si quieres ver el hostname y la IP de las conexiones activas:
SELECT 
    HOST_NAME() AS HostName,
    client_net_address AS IP
FROM 
    sys.dm_exec_connections
WHERE 
    session_id = @@SPID;

--Esto te da la IP y el nombre del equipo que ejecuta la sesión actual.

SELECT HOST_ID(),HOST_NAME()
GO


--FUNCION ISNULL
-- La función ISNULL en SQL es súper útil cuando estás trabajando con valores nulos 
--y quieres asegurarte de que tus resultados no se vean afectados por ellos

--Reemplaza un valor NULL por otro valor que tú especifiques.
--ISNULL(expresión, valor_reemplazo)

-- expresión: el campo o valor que puede contener NULL.
-- valor_reemplazo: el valor que se usará si la expresión es NULL.

USE AdventureWorks2022
GO

SELECT * FROM Production.Product
GO

SELECT ProductID, Name, Color,
		ISNULL(Color,'Blue')
FROM Production. Product
GO


--FUNCION ERROR_LINE
--La función ERROR_LINE() en SQL Server es una herramienta muy útil cuando estás manejando errores 
--con bloques TRY...CATCH. Te permite saber exactamente en qué línea ocurrió el error dentro del 
--bloque que lo generó

--ERROR_LINE()

-- Se usa dentro de un bloque CATCH.
-- Devuelve un valor INT que representa el número de línea donde ocurrió el error.
-- Si se llama fuera de un bloque CATCH, devuelve NULL.

--EJEMPLO

BEGIN TRY
    -- Esto genera un error de división por cero
    SELECT 1 / 0;
END TRY
BEGIN CATCH
    SELECT ERROR_LINE() AS LineaDelError;
END CATCH;



--FUNCION ERROR_MESSAGE
--La función ERROR_MESSAGE() en SQL Server es clave para manejar errores de forma profesional
--Devuelve el mensaje de error completo que causó la ejecución del bloque CATCH dentro de una estructura
--TRY...CATCH.

--ERROR_MESSAGE()
-- Se usa dentro de un bloque CATCH.
-- Devuelve un nvarchar(4000) con el texto del error.
-- Si se llama fuera del CATCH, devuelve NULL.

--Ejemplo

BEGIN TRY
    -- Esto genera un error de división por cero
    SELECT 1 / 0;
END TRY
BEGIN CATCH
	SELECT ERROR_LINE() AS LineaDelError,
			 ERROR_MESSAGE() AS MensajeError
END CATCH;


--FUNCION ERROR_NUMBER
-- La función ERROR_NUMBER() te permite capturar el código numérico del error que activó 
--el bloque CATCH dentro de una estructura TRY...CATCH.

--ERROR_NUMBER()

-- Devuelve un valor INT que representa el número del error.
-- Solo funciona dentro de un bloque CATCH.
-- Si se llama fuera del CATCH, devuelve NULL.


BEGIN TRY
    -- Esto genera un error de división por cero
    SELECT 1 / 0;
END TRY
BEGIN CATCH
	SELECT ERROR_LINE() AS LineaDelError,
			ERROR_MESSAGE() AS MensajeError,
			ERROR_NUMBER() AS NumeroDeError;
END CATCH;


--FUNCION ERROR_PROCEDURE

--Devuelve el nombre del procedimiento almacenado o desencadenador donde ocurrió un error, 
--si ese error activó el bloque CATCH.

-- Si el error ocurrió dentro de un procedimiento almacenado o trigger, devuelve su nombre.
-- Si el error ocurrió fuera de un procedimiento o trigger, devuelve NULL.
-- Solo funciona dentro del ámbito de un bloque CATCH.

--ERROR_PROCEDURE()

-- Crear un procedimiento que genera un error
CREATE PROCEDURE usp_ExampleProc, 
    SELECT 1 / 0  -- División por cero
GO

BEGIN TRY
    EXECUTE usp_ExampleProc,
END TRY
BEGIN CATCH
    SELECT ERROR_PROCEDURE() AS NombreDelProcedimiento;
END CATCH;

BEGIN TRY
    -- Esto genera un error de división por cero
    SELECT 1 / 0;
END TRY
BEGIN CATCH
	SELECT ERROR_LINE() AS LineaDelError,
			ERROR_MESSAGE() AS MensajeError,
			ERROR_NUMBER() AS NumeroDeError,
			ERROR_PROCEDURE() AS NombreDelProcedimiento
END CATCH;


--FUNCION ERROR_SEVERITY
-- Devuelve un valor entero que representa la gravedad del error que activó el bloque CATCH.
-- Solo funciona dentro del ámbito de un bloque CATCH. Si la llamas fuera de ese contexto, devuelve NULL.

-- 0–10 Mensajes informativos o advertencias
-- 11–16 Errores generados por el usuario (por ejemplo, división por cero)
-- 17–25 Errores graves del sistema o recursos


BEGIN TRY
    -- Provoca un error de división por cero
    SELECT 1 / 0;
END TRY
BEGIN CATCH
    SELECT ERROR_LINE() AS LineaDelError,
			ERROR_MESSAGE() AS MensajeError,
			ERROR_NUMBER() AS NumeroDeError,
			ERROR_SEVERITY() AS SeveridadDelError;
END CATCH;


--FUNCION ERROR_STATE
-- Devuelve un número entero que representa el estado del error que activó el bloque CATCH.
-- Este número ayuda a identificar la causa específica del error dentro de un mismo código de error.
-- Solo funciona dentro del bloque CATCH. Fuera de ese contexto, devuelve NULL.


BEGIN TRY
    -- Provoca un error de división por cero
    SELECT 1 / 0;
END TRY
BEGIN CATCH
    SELECT 
		ERROR_LINE() AS LineaDelError,
        ERROR_NUMBER() AS NumeroError,
		ERROR_SEVERITY() AS SeveridadDelError,
        ERROR_STATE() AS EstadoError,
        ERROR_MESSAGE() AS MensajeError
END CATCH;


--FUNCION TRY...CATCH
--Permite capturar errores que ocurren durante la ejecución de instrucciones 
--T-SQL y responder a ellos de forma controlada, evitando que el proceso falle abruptamente.

BEGIN TRY
    -- Código que puede generar errores
END TRY
BEGIN CATCH
    -- Código para manejar el error
END CATCH

--EJEMPLO

BEGIN TRY
    -- Provoca un error de conversión
    DECLARE @x INT = 'Texto';
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS NumeroError,
        ERROR_MESSAGE() AS Mensaje,
        ERROR_LINE() AS Linea,
        ERROR_SEVERITY() AS Severidad,
        ERROR_STATE() AS Estado;
END CATCH;


--EJEMPLO UDEMY

USE NORTHWND
GO

-- Crear la Tabla dbErros
CREATE TABLE dbErros
         (ErrorID        INT IDENTITY(100, 1),
          UserName       VARCHAR(100),
          ErrorNumber    INT,
          ErrorState     INT,
          ErrorSeverity  INT,
          ErrorLine      INT,
          ErrorProcedure VARCHAR(MAX),
          ErrorMessage   VARCHAR(MAX),
          ErrorDateTime  DATETIME)
GO

-- Consultar la Tabla dbErros
SELECT * FROM dbErros
GO

-- Función SUSER_SNAME
SELECT SUSER_SNAME()
GO

-- Consultar la Tabla Customers
SELECT * FROM Customers
GO

-- Control de Errores TRY ... CATCH
BEGIN TRY    
    INSERT INTO Customers(CustomerID, CompanyName, ContactName, ContactTitle, Address, 
							City, Region, PostalCode, Country, Phone, Fax)
	VALUES('ALFKI', 'Microsoft Company', 'Bill Gates', 'Owner', NULL, 
			'Redmond', 'Washington', '98008', 'USA', NULL, NULL)
END TRY
BEGIN CATCH
	INSERT INTO dbo.dbErros
	VALUES(SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(),  ERROR_SEVERITY(),
			ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE())
END CATCH
GO


-- Consultar la Tabla dbErros
SELECT * FROM dbErros
GO

--///////////////////////////////////////////////////////////////////////////////////


-- Control de Errores TRY ... CATCH
BEGIN TRY    
    INSERT INTO Customers(CustomerID, CompanyName, ContactName, ContactTitle, Address, 
							City, Region, PostalCode, Country, Phone, Fax)
	VALUES('ZMICO', 'Microsoft Company', 'Bill Gates', 'Owner', NULL, 
			'Redmond', 'Washington', '98008', 'USA', NULL, NULL)
END TRY
BEGIN CATCH
	INSERT INTO dbo.dbErros
	VALUES(SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(),  ERROR_SEVERITY(),
			ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE())
END CATCH
GO


-- Consultar la Tabla Customers
SELECT * FROM Customers
GO










