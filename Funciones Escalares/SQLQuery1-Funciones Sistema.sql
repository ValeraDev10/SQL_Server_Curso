


-- Funciones HOST_ID y HOST_NAME
--Las funciones HOST_ID() y HOST_NAME() en SQL Server te permiten identificar desde qu� equipo 
--se est� ejecutando una consulta.

-- HOST_ID()
-- Devuelve el ID del proceso (PID) de la aplicaci�n cliente que se conecta a SQL Server.
-- Tipo de dato: char(10)
-- �til para registrar qu� terminal ejecut� una operaci�n.
-- HOST_NAME()
-- Devuelve el nombre del equipo cliente desde el cual se ejecuta la consulta.
-- Tipo de dato: nvarchar
-- Ideal para identificar el origen de una transacci�n o conexi�n.

--Ejemplo pr�ctico
--Supongamos que quieres registrar qui�n insert� un pedido en una tabla:
CREATE TABLE Orders (
    OrderID     INT PRIMARY KEY,
    CustomerID  NCHAR(5),
    TerminalID  CHAR(10) NOT NULL DEFAULT HOST_ID(),
    HostName    NVARCHAR(128) NOT NULL DEFAULT HOST_NAME(),
    OrderDate   DATETIME NOT NULL
);

--Cada vez que se inserte un registro, se guardar� autom�ticamente el ID del proceso 
--y el nombre del equipo que lo ejecut�.

-- Consulta �til para monitoreo
--Si quieres ver el hostname y la IP de las conexiones activas:
SELECT 
    HOST_NAME() AS HostName,
    client_net_address AS IP
FROM 
    sys.dm_exec_connections
WHERE 
    session_id = @@SPID;

--Esto te da la IP y el nombre del equipo que ejecuta la sesi�n actual.

SELECT HOST_ID(),HOST_NAME()
GO


--FUNCION ISNULL
-- La funci�n ISNULL en SQL es s�per �til cuando est�s trabajando con valores nulos 
--y quieres asegurarte de que tus resultados no se vean afectados por ellos

--Reemplaza un valor NULL por otro valor que t� especifiques.
--ISNULL(expresi�n, valor_reemplazo)

-- expresi�n: el campo o valor que puede contener NULL.
-- valor_reemplazo: el valor que se usar� si la expresi�n es NULL.

USE AdventureWorks2022
GO

SELECT * FROM Production.Product
GO

SELECT ProductID, Name, Color,
		ISNULL(Color,'Blue')
FROM Production. Product
GO


--FUNCION ERROR_LINE
--La funci�n ERROR_LINE() en SQL Server es una herramienta muy �til cuando est�s manejando errores 
--con bloques TRY...CATCH. Te permite saber exactamente en qu� l�nea ocurri� el error dentro del 
--bloque que lo gener�

--ERROR_LINE()

-- Se usa dentro de un bloque CATCH.
-- Devuelve un valor INT que representa el n�mero de l�nea donde ocurri� el error.
-- Si se llama fuera de un bloque CATCH, devuelve NULL.

--EJEMPLO

BEGIN TRY
    -- Esto genera un error de divisi�n por cero
    SELECT 1 / 0;
END TRY
BEGIN CATCH
    SELECT ERROR_LINE() AS LineaDelError;
END CATCH;



--FUNCION ERROR_MESSAGE
--La funci�n ERROR_MESSAGE() en SQL Server es clave para manejar errores de forma profesional
--Devuelve el mensaje de error completo que caus� la ejecuci�n del bloque CATCH dentro de una estructura
--TRY...CATCH.

--ERROR_MESSAGE()
-- Se usa dentro de un bloque CATCH.
-- Devuelve un nvarchar(4000) con el texto del error.
-- Si se llama fuera del CATCH, devuelve NULL.

--Ejemplo

BEGIN TRY
    -- Esto genera un error de divisi�n por cero
    SELECT 1 / 0;
END TRY
BEGIN CATCH
	SELECT ERROR_LINE() AS LineaDelError,
			 ERROR_MESSAGE() AS MensajeError
END CATCH;


--FUNCION ERROR_NUMBER
-- La funci�n ERROR_NUMBER() te permite capturar el c�digo num�rico del error que activ� 
--el bloque CATCH dentro de una estructura TRY...CATCH.

--ERROR_NUMBER()

-- Devuelve un valor INT que representa el n�mero del error.
-- Solo funciona dentro de un bloque CATCH.
-- Si se llama fuera del CATCH, devuelve NULL.


BEGIN TRY
    -- Esto genera un error de divisi�n por cero
    SELECT 1 / 0;
END TRY
BEGIN CATCH
	SELECT ERROR_LINE() AS LineaDelError,
			ERROR_MESSAGE() AS MensajeError,
			ERROR_NUMBER() AS NumeroDeError;
END CATCH;


--FUNCION ERROR_PROCEDURE

--Devuelve el nombre del procedimiento almacenado o desencadenador donde ocurri� un error, 
--si ese error activ� el bloque CATCH.

-- Si el error ocurri� dentro de un procedimiento almacenado o trigger, devuelve su nombre.
-- Si el error ocurri� fuera de un procedimiento o trigger, devuelve NULL.
-- Solo funciona dentro del �mbito de un bloque CATCH.

--ERROR_PROCEDURE()

-- Crear un procedimiento que genera un error
CREATE PROCEDURE usp_ExampleProc, 
    SELECT 1 / 0  -- Divisi�n por cero
GO

BEGIN TRY
    EXECUTE usp_ExampleProc,
END TRY
BEGIN CATCH
    SELECT ERROR_PROCEDURE() AS NombreDelProcedimiento;
END CATCH;

BEGIN TRY
    -- Esto genera un error de divisi�n por cero
    SELECT 1 / 0;
END TRY
BEGIN CATCH
	SELECT ERROR_LINE() AS LineaDelError,
			ERROR_MESSAGE() AS MensajeError,
			ERROR_NUMBER() AS NumeroDeError,
			ERROR_PROCEDURE() AS NombreDelProcedimiento
END CATCH;


--FUNCION ERROR_SEVERITY
-- Devuelve un valor entero que representa la gravedad del error que activ� el bloque CATCH.
-- Solo funciona dentro del �mbito de un bloque CATCH. Si la llamas fuera de ese contexto, devuelve NULL.

-- 0�10 Mensajes informativos o advertencias
-- 11�16 Errores generados por el usuario (por ejemplo, divisi�n por cero)
-- 17�25 Errores graves del sistema o recursos


BEGIN TRY
    -- Provoca un error de divisi�n por cero
    SELECT 1 / 0;
END TRY
BEGIN CATCH
    SELECT ERROR_LINE() AS LineaDelError,
			ERROR_MESSAGE() AS MensajeError,
			ERROR_NUMBER() AS NumeroDeError,
			ERROR_SEVERITY() AS SeveridadDelError;
END CATCH;


--FUNCION ERROR_STATE
-- Devuelve un n�mero entero que representa el estado del error que activ� el bloque CATCH.
-- Este n�mero ayuda a identificar la causa espec�fica del error dentro de un mismo c�digo de error.
-- Solo funciona dentro del bloque CATCH. Fuera de ese contexto, devuelve NULL.


BEGIN TRY
    -- Provoca un error de divisi�n por cero
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
--Permite capturar errores que ocurren durante la ejecuci�n de instrucciones 
--T-SQL y responder a ellos de forma controlada, evitando que el proceso falle abruptamente.

BEGIN TRY
    -- C�digo que puede generar errores
END TRY
BEGIN CATCH
    -- C�digo para manejar el error
END CATCH

--EJEMPLO

BEGIN TRY
    -- Provoca un error de conversi�n
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

-- Funci�n SUSER_SNAME
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










