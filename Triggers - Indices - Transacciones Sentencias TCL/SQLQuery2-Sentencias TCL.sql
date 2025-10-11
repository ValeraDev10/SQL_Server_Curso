

--SENTENCIAS TCL
--En SQL Server, las sentencias TCL (Transaction Control Language) permiten gestionar transacciones 
--para asegurar la integridad de los datos. Las principales son: 
--BEGIN TRANSACTION, COMMIT, ROLLBACK, SAVEPOINT y RELEASE SAVEPOINT.
--Aquí tienes un desglose completo de cada una:

--¿Qué es TCL en SQL Server?
--TCL (Transaction Control Language) es el conjunto de comandos que controlan el comportamiento de las 
--transacciones en una base de datos. Una transacción es una unidad lógica de trabajo que agrupa varias 
--operaciones SQL que deben ejecutarse de forma atómica o de lo contrario ninguna se ejecutara.

--BEGIN TRANSACTION Inicia una transacción. Todas las operaciones posteriores se agrupan.
--COMMIT Confirma la transacción y guarda los cambios de forma permanente.
--ROLLBACK Revierte todos los cambios realizados desde el inicio de la transacción.
--SAVEPOINT Crea un punto de restauración dentro de una transacción.
--ROLLBACK TO SAVEPOINT Revierte los cambios hasta el punto de guardado especificado.
--RELEASE SAVEPOINT Elimina un punto de guardado previamente creado.

--Usar la transaccion es el mejor metodo debido a que cumple con las cuatro propiedades de todo sistema
-- de base de datos relacional, a estas propiedades se les conoce como ACID
--(atomicity, consistency, isolation y durability).

--Atomicity: Totalidad de las operaciones realizadas correctamente de lo contrario se cancelan en el punto de falla.
--Consistency: Garantiza que todos los datos seran consistentes despues de que se complete una transaccion.
--Isolation: Indica que todas las transaccionesestan estan aisladas de otras.
--Durability: La modificaciones confirmadas se vuelven persistentes.


USE NORTHWND
GO

SELECT * FROM Customers
ORDER BY CustomerID DESC
GO

BEGIN TRAN

	INSERT INTO Customers
	VALUES('RAPPI','RAPPI SA','Juan Pablo Ortega','owner',
	NULL,'Bogota',NULL,NULL,'Colombia',NULL,NULL);


	SELECT @@TRANCOUNT AS openTransactions;
	--ROLLBACK TRAN;
	COMMIT TRAN;

	SELECT @@TRANCOUNT AS openTransactions;
GO

BEGIN TRAN

	INSERT INTO Customers
	VALUES('ZNDXT','INDITEX','Amancio','Owner',
	'AV Diputacion edf inditex N.15142','Coruña',NULL,NULL,'España',NULL,NULL);

	IF @@ROWCOUNT = 1
		COMMIT TRAN;
	ELSE
		ROLLBACK TRAN;
		
GO


BEGIN TRAN
	UPDATE Customers
	SET ContactName = 'Amancio Ortega'
	WHERE CustomerID = 'ZNDXT'

	IF @@ROWCOUNT = 1
		COMMIT TRAN;
	ELSE
		ROLLBACK TRAN;		
GO

BEGIN TRAN
	DELETE FROM Customers	
	WHERE CustomerID = 'ZNDXT'

	IF @@ROWCOUNT = 1
		COMMIT TRAN;
	ELSE
		ROLLBACK TRAN;		
GO



--TRANSACCIONES CON PROCEDIMIENTO ALMACENADO

--INSERT

CREATE OR ALTER PROC SP_InsertCustomer
(
	@CustomerID NCHAR(5),
	@CompanyName NVARCHAR(40),
	@ContactName NVARCHAR(30),
	@ContactTitle NVARCHAR(30),
	@Address NVARCHAR(60),
	@City NVARCHAR(15),
	@Region NVARCHAR(15),
	@PostalCode NVARCHAR(10),
	@Country NVARCHAR(15),
	@Phone NVARCHAR(24),
	@Fax NVARCHAR(24)
)
AS 

BEGIN TRAN

	INSERT INTO Customers
	VALUES(@CustomerID,@CompanyName,@ContactName,@ContactTitle,
	@Address,@City,@Region,@PostalCode,@Country,@Phone,@Fax);

	IF @@ROWCOUNT = 1
	BEGIN
		COMMIT TRAN;
		PRINT ' Transaccion Completada Satisfactoriamente'
	END
	ELSE
	BEGIN
		ROLLBACK TRAN;
		PRINT 'Error en Transaccion se han revertido los cambios'
	END
		
GO

EXEC SP_InsertCustomer 'ZNDXT','INDITEX','Amancio','Owner',
	'AV Diputacion edf inditex N.15142','Coruña',NULL,NULL,'España',NULL,NULL;
GO

SELECT * FROM Customers
ORDER BY CustomerID DESC
GO

--UPDATE

CREATE OR ALTER PROC SP_UpdateCustomer
(
	@CustomerID NCHAR(5),
	@CompanyName NVARCHAR(40)

)
AS
BEGIN TRAN
	UPDATE Customers
	SET ContactName = @CompanyName
	WHERE CustomerID = @CustomerID

	IF @@ROWCOUNT = 1
	BEGIN
		COMMIT TRAN;
		PRINT ' Transaccion Completada Satisfactoriamente'
	END
	ELSE
	BEGIN
		ROLLBACK TRAN;
		PRINT 'Error en Transaccion se han revertido los cambios'
	END		
GO

EXEC SP_UpdateCustomer 'ZNDXT', 'Amancio Ortega'
GO

--DELETE

CREATE OR ALTER PROC SP_DeleteCustomer
(
	@CustomerID NCHAR(5)
	

)
AS

BEGIN TRAN
	DELETE FROM Customers	
	WHERE CustomerID = @CustomerID

	IF @@ROWCOUNT = 1
	BEGIN
		COMMIT TRAN;
		PRINT ' Transaccion Completada Satisfactoriamente'
	END
	ELSE
	BEGIN
		ROLLBACK TRAN;
		PRINT 'Error en Transaccion se han revertido los cambios'
	END		
GO

EXEC SP_DeleteCustomer 'ZNDXT'
GO

SELECT * FROM Customers
ORDER BY CustomerID DESC
GO


--/////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////


--MANEJO DE ERRORES

--INSERT

CREATE OR ALTER PROC SP_InsertCustomer
(
	@CustomerID NCHAR(5),
	@CompanyName NVARCHAR(40),
	@ContactName NVARCHAR(30),
	@ContactTitle NVARCHAR(30),
	@Address NVARCHAR(60),
	@City NVARCHAR(15),
	@Region NVARCHAR(15),
	@PostalCode NVARCHAR(10),
	@Country NVARCHAR(15),
	@Phone NVARCHAR(24),
	@Fax NVARCHAR(24)
)
AS 

BEGIN TRAN

	BEGIN TRY

		INSERT INTO Customers
		VALUES(@CustomerID,@CompanyName,@ContactName,@ContactTitle,
		@Address,@City,@Region,@PostalCode,@Country,@Phone,@Fax);

		IF @@ROWCOUNT = 1
			BEGIN
				COMMIT TRAN;
				PRINT ' Transaccion Completada Satisfactoriamente'
			END
		ELSE
			BEGIN
				ROLLBACK TRAN;
				PRINT 'Error en Transaccion se han revertido los cambios'
			END

	END TRY

	BEGIN CATCH

		ROLLBACK TRAN;
		PRINT 'Error en Transaccion se han revertido los cambios'
		INSERT INTO dbo.dbErros
		VALUES(SUSER_SNAME(),ERROR_NUMBER(),ERROR_STATE(),ERROR_SEVERITY(),
				ERROR_LINE(),ERROR_PROCEDURE(),ERROR_MESSAGE(), GETDATE());

	END CATCH
		
GO


EXEC SP_InsertCustomer 'ZNDXT','INDITEX','Amancio','Owner',
	'AV Diputacion edf inditex N.15142','Coruña',NULL,NULL,'España',NULL,NULL;
GO

SELECT * FROM Customers
ORDER BY CustomerID DESC
GO

SELECT * FROM dbErros
GO


--UPDATE

CREATE OR ALTER PROC SP_UpdateCustomer
(
	@CustomerID NCHAR(5),
	@CompanyName NVARCHAR(40)

)
AS
BEGIN TRAN

	BEGIN TRY
		UPDATE Customers
		SET ContactName = @CompanyName
		WHERE CustomerID = @CustomerID

		IF @@ROWCOUNT = 1
			BEGIN
				COMMIT TRAN;
				PRINT ' Transaccion Completada Satisfactoriamente'
			END
		ELSE
			BEGIN
				ROLLBACK TRAN;
				PRINT 'Error en Transaccion se han revertido los cambios'
			END
	END TRY

	BEGIN CATCH
		
		ROLLBACK TRAN;
		PRINT 'Error en Transaccion se han revertido los cambios'
		INSERT INTO dbo.dbErros
		VALUES(SUSER_SNAME(),ERROR_NUMBER(),ERROR_STATE(),ERROR_SEVERITY(),
				ERROR_LINE(),ERROR_PROCEDURE(),ERROR_MESSAGE(), GETDATE());

	END CATCH
GO

EXEC SP_UpdateCustomer 'ZNDXT', 'Amancio Ortega'
GO

SELECT * FROM Customers
ORDER BY CustomerID DESC
GO

SELECT * FROM dbErros
GO


--DELETE

CREATE OR ALTER PROC SP_DeleteCustomer
(
	@CustomerID NCHAR(5)
	

)
AS

BEGIN TRAN

	BEGIN TRY 
		DELETE FROM Customers	
		WHERE CustomerID = @CustomerID

		IF @@ROWCOUNT = 1
			BEGIN
				COMMIT TRAN;
				PRINT ' Transaccion Completada Satisfactoriamente'
			END
		ELSE
			BEGIN
				ROLLBACK TRAN;
				PRINT 'Error en Transaccion se han revertido los cambios'
			END
	END TRY

	BEGIN CATCH

		ROLLBACK TRAN;
		PRINT 'Error en Transaccion se han revertido los cambios'
		INSERT INTO dbo.dbErros
		VALUES(SUSER_SNAME(),ERROR_NUMBER(),ERROR_STATE(),ERROR_SEVERITY(),
				ERROR_LINE(),ERROR_PROCEDURE(),ERROR_MESSAGE(), GETDATE());

	END CATCH
GO

EXEC SP_DeleteCustomer 'ZNDXT'
GO

SELECT * FROM Customers
ORDER BY CustomerID DESC
GO

SELECT * FROM dbErros
GO


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


--COMANDO NOLOCK

--El comando NOLOCK en SQL Server se utiliza como una pista de tabla (table hint) para indicar que una consulta 
--puede leer datos sin esperar a que se liberen los bloqueos de otras transacciones. 
--Es decir, permite hacer lecturas sin bloqueo, lo que puede mejorar el rendimiento en 
--sistemas con alta concurrencia, pero con ciertos riesgos

--SINTAXIS BASICA

SELECT *
FROM nombre_tabla WITH (NOLOCK)

--Ventajas
-- ✅ Evita bloqueos: útil en sistemas con muchas transacciones simultáneas.
-- ✅ Mejora el rendimiento de consultas de solo lectura.
--Riesgos
-- ❗ Lectura sucia (dirty reads): puedes leer datos que aún no han sido confirmados (committed).
-- ❗ Lectura fantasma o inconsistente: los datos pueden cambiar mientras se está leyendo.
-- ❗ No garantiza precisión: no es recomendable para reportes financieros, auditorías, ni decisiones críticas.
-- Alternativas más seguras
-- READ COMMITTED SNAPSHOT: usa versiones de fila para evitar bloqueos sin permitir lecturas sucias.
-- READ UNCOMMITTED: equivalente funcional a NOLOCK, pero se usa como nivel de aislamiento



USE NORTHWND
GO

BEGIN TRAN

	UPDATE Customers
	SET ContactName = 'BILL GATES'
	WHERE CustomerID = 'ZMICO';
	SELECT * 
	FROM Orders CROSS JOIN [Order Details];

	ROLLBACK;

GO

--USAMOS NOLOCK PARA CONSULTAR TABLAS BLOQUEADAS POR UNA TRANSACCION

SELECT * FROM Customers (NOLOCK)
GO 





