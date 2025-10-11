

--TRIGGERS
--Los triggers en SQL (o desencadenadores) son objetos de base de datos que se ejecutan 
--automáticamente en respuesta a ciertos eventos en una tabla o vista. Son muy útiles 
--para mantener la integridad de los datos, auditar cambios o automatizar procesos

--DDL - DML - LOGON 

--Un trigger es un bloque de código que se activa cuando ocurre un evento específico como:
-- INSERT
-- UPDATE
--- DELETE
--Se puede configurar para que se ejecute antes (BEFORE) o después (AFTER) del evento

--SINTAXIS BASICA
CREATE TRIGGER NombreDelTrigger
ON NombreDeLaTabla
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Código que se ejecuta cuando se dispara el trigger
END;


--TIPOS
--AFETER - Se ejecuta después de que la operación se haya completado.
--INSTEAD OF - Reemplaza la operación original (útil en vistas).
--BEFORE - No está disponible en SQL Server, pero sí en otros motores como PostgreSQL o MySQL.

--CONSIDERACIONES
-- Evita lógica compleja dentro de triggers: puede afectar el rendimiento.
-- No uses ROLLBACK dentro de triggers a menos que sea estrictamente necesario.
-- Usa las tablas virtuales inserted y deleted para acceder a los datos antes y después del cambio


--TRIGGER DDL 
--Se ejecuta en respuesta a una variedad de eventos de lenguaje de definicion de datos DDL. Estos eventos
-- corresponden principalmente a instrucciones CREATE, ALTER Y DROP de sql y a determinados procedimientos almacendados
--que ejecutan operaciones de tipo DDL.

--TRIGGER DML
--Se ejecuta automaticamente cuando tiene lugar un evento de lenguaje de manipulacion de datos DML que afecta a la tabla
--o la vista definida en el trigger. Los Triggers DML incluyen las instrucciones INSERT, UPDATE, DELETE.
--Se usan para aplicar reglas de negocios y la integridad de los datos, consultar otras tablas e 
--incluir instrucciones sql complejas.

--Ejemplo
CREATE TRIGGER nombre_trigger      
ON tabla
FOR INSERT
AS
BEGIN
 -- INSTRUCCIONES SQL
END

--///////////////////////////////////

CREATE TRIGGER nombre_trigger
ON tabla
FOR UPDATE, DELETE
AS
BEGIN
 -- INSTRUCCIONES SQL
END

--//////////////////////////////////////////////////////////////////////////////////////////////////////////




---------------------------------
--    Usar la Base de Datos    --
---------------------------------
USE tempdb;
GO




-----------------------------------
--    CREAR LA TABLA CLIENTES    --
-----------------------------------
CREATE TABLE CLIENTES(
	id		TINYINT PRIMARY KEY,
	nombre	VARCHAR(20),
	paterno VARCHAR(20),
	materno VARCHAR(20),
	edad	TINYINT
	CONSTRAINT chk_edad CHECK(edad >= 0 AND edad <= 120)
);
GO




--------------------------------------------------
--    CREAR TRIGGER - INSERT, DELETE, UPDATE    --
--------------------------------------------------
CREATE OR ALTER TRIGGER tgr_insert_clientes
ON CLIENTES
FOR INSERT, DELETE, UPDATE
AS
BEGIN
	
	SELECT * INTO insertado FROM inserted;

	SELECT * INTO eliminado FROM deleted;

END;
GO




-----------------------------
--    INSERTAR REGISTRO    --
-----------------------------
INSERT INTO CLIENTES(id, nombre, paterno, materno, edad)
			 VALUES (101, 'Isabel', 'Campos', 'Torres', 19),
					(102, 'Marco', 'Gallegos', 'Ochoa', 35),
					(103, 'Julia', 'Gamboa', 'Gallegos', 35);
GO




---------------------------------------------------------------
--    CONSULTAR LAS TABLAS CLIENTES, INSERTADO, ELIMINADO    --
---------------------------------------------------------------
SELECT * FROM CLIENTES;
SELECT * FROM insertado;
SELECT * FROM eliminado;
GO




-----------------------------------------------------
--    ELIMINAR LAS TABLAS INSERTADO Y ELIMINADO    --
-----------------------------------------------------
DROP TABLE insertado;
DROP TABLE eliminado;
GO




----------------------------------------------------
--    ALTERAR TRIIGER - INSERT, DELETE, UPDATE    --
----------------------------------------------------
CREATE OR ALTER TRIGGER tgr_insert_clientes
ON CLIENTES
FOR INSERT, DELETE, UPDATE
AS
BEGIN

	SET NOCOUNT ON;
	
	SELECT * INTO insertado FROM inserted;

	SELECT * INTO eliminado FROM deleted;

END;
GO




-------------------------------------------
--    CONSULTAR EL CLIENTE A ELIMINAR    --
-------------------------------------------
SELECT * FROM CLIENTES WHERE id = 103;
GO




------------------------------------------
--    ELIMINAR EL CLIENTE CON ID 103    --
------------------------------------------
DELETE FROM CLIENTES WHERE id = 103;
GO




---------------------------------------------------------------
--    CONSULTAR LAS TABLAS CLIENTES, INSERTADO, ELIMINADO    --
---------------------------------------------------------------
SELECT * FROM CLIENTES;
SELECT * FROM insertado;
SELECT * FROM eliminado;
GO




-----------------------------------------------------
--    ELIMINAR LAS TABLAS INSERTADO Y ELIMINADO    --
-----------------------------------------------------
DROP TABLE insertado;
DROP TABLE eliminado;
GO




---------------------------------------------
--    CONSULTAR EL CLIENTE A ACTUALIZAR    --
---------------------------------------------
SELECT * FROM CLIENTES WHERE id = 101;
GO




--------------------------------------------
--    ACTUALIZAR EL CLIENTE CON ID 101    --
--------------------------------------------
UPDATE CLIENTES 
SET nombre = 'Karen'
WHERE id = 101;
GO




---------------------------------------------------------------
--    CONSULTAR LAS TABLAS CLIENTES, INSERTADO, ELIMINADO    --
---------------------------------------------------------------
SELECT * FROM CLIENTES;
SELECT * FROM insertado;
SELECT * FROM eliminado;
GO




----------------------------------------------------
--    ELIMINAR EL TRIGGER DE LA TABLA CLIENTES    --
----------------------------------------------------
DROP TRIGGER tgr_insert_clientes
GO




---------------------------------------------------------------
--    ELIMINAR LAS TABLAS CLIENTES, INSERTADO Y ELIMINADO    --
---------------------------------------------------------------
DROP TABLE CLIENTES;
DROP TABLE insertado;
DROP TABLE eliminado;
GO



--TRIGGER DDL - ALL SERVER

-- Ubicarnos en la Base de Datos MASTER
USE master
GO


-- Validar si existe la Base de Datos Retail
DROP DATABASE IF EXISTS Retail
GO


-- Crear la Base de Datos Retail
CREATE DATABASE Retail
GO


-- Usar la Base de Datos Retail
USE Retail
GO

--DROP TABLE ProductsSource
--GO


--ACCIONES DDL


-- Crear la Tabla Products
CREATE TABLE Products(
	productoID		INT,
	nombre			VARCHAR(20)
)
GO


-- Agregar la columna "precio"
ALTER TABLE Products ADD precio DECIMAL(10,2) CONSTRAINT DF_precio DEFAULT 0
GO


-- Eliminar la Restricción DEFAULT
ALTER TABLE Products DROP CONSTRAINT DF_precio
GO


-- Eliminar la columna "precio"
ALTER TABLE Products DROP COLUMN precio
GO


-- Cambiar el nombre a la Tabla
EXEC sp_rename @objname = 'Products', @newname = 'Productos'
GO


-- Eliminar la Tabla Productos
DROP TABLE Productos
GO




-- Crear el Trigger para el Servidor
CREATE OR ALTER TRIGGER TG_DDLServer
ON ALL SERVER
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE, RENAME
AS
	SET NOCOUNT ON;
	DECLARE @eventData XML
	SET @eventData = EVENTDATA()
	SELECT @eventData AS [EVENTDATA]
GO





-- Modificar el Trigger para el Servidor
CREATE OR ALTER TRIGGER TG_DDLServer
ON ALL SERVER
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE, RENAME
AS
	SET NOCOUNT ON;
	DECLARE @eventData XML;
	SET @eventData = EVENTDATA()
	
	SELECT @eventData.value('(/EVENT_INSTANCE/EventType)[1]', 'VARCHAR(128)') AS eventType,
		   @eventData.value('(/EVENT_INSTANCE/PostTime)[1]', 'DATETIME2(0)') AS postTime,
		   @eventData.value('(/EVENT_INSTANCE/SPID)[1]', 'INT') AS spid,
		   @eventData.value('(/EVENT_INSTANCE/ServerName)[1]', 'VARCHAR(128)') AS serverName,
		   @eventData.value('(/EVENT_INSTANCE/LoginName)[1]', 'VARCHAR(128)') AS loginName,
		   @eventData.value('(/EVENT_INSTANCE/UserName)[1]', 'VARCHAR(128)') AS userName,
		   @eventData.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'VARCHAR(128)') AS databaseName,
		   @eventData.value('(/EVENT_INSTANCE/SchemaName)[1]', 'VARCHAR(128)') AS schemaName,
		   @eventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'VARCHAR(128)') AS objectName,
		   @eventData.value('(/EVENT_INSTANCE/NewObjectName)[1]', 'VARCHAR(128)') AS newObjectName,
		   @eventData.value('(/EVENT_INSTANCE/ObjectType)[1]', 'VARCHAR(128)') AS objectType,
		   @eventData.value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]', 'VARCHAR(MAX)') AS TSqlCommand
GO





-- Modificar el Trigger para el Servidor
CREATE OR ALTER TRIGGER TG_DDLServer
ON ALL SERVER
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE, RENAME
AS
	SET NOCOUNT ON;
	DECLARE @eventData XML;
	SET @eventData = EVENTDATA()
	
	INSERT INTO SQLDDLTriggerLog.dbo.DDLLog
	(
	 eventType, postTime, spid, serverName, loginName, userName, databaseName, 
	 schemaName, objectName, newObjectName, objectType, TSqlCommand
	)
	SELECT @eventData.value('(/EVENT_INSTANCE/EventType)[1]', 'VARCHAR(128)') AS eventType,
		   @eventData.value('(/EVENT_INSTANCE/PostTime)[1]', 'DATETIME2(0)') AS postTime,
		   @eventData.value('(/EVENT_INSTANCE/SPID)[1]', 'INT') AS spid,
		   @eventData.value('(/EVENT_INSTANCE/ServerName)[1]', 'VARCHAR(128)') AS serverName,
		   @eventData.value('(/EVENT_INSTANCE/LoginName)[1]', 'VARCHAR(128)') AS loginName,
		   @eventData.value('(/EVENT_INSTANCE/UserName)[1]', 'VARCHAR(128)') AS userName,
		   @eventData.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'VARCHAR(128)') AS databaseName,
		   @eventData.value('(/EVENT_INSTANCE/SchemaName)[1]', 'VARCHAR(128)') AS schemaName,
		   @eventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'VARCHAR(128)') AS objectName,
		   @eventData.value('(/EVENT_INSTANCE/NewObjectName)[1]', 'VARCHAR(128)') AS newObjectName,
		   @eventData.value('(/EVENT_INSTANCE/ObjectType)[1]', 'VARCHAR(128)') AS objectType,
		   @eventData.value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]', 'VARCHAR(MAX)') AS TSqlCommand
GO


-- Eliminar el Trigger del Servidor
DROP TRIGGER TG_DDLServer
ON ALL SERVER
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Ubicarnos en la Base de Datos MASTER
USE master
GO


-- Validar si existe la Base de Datos SQLDDLTriggerLog
DROP DATABASE IF EXISTS SQLDDLTriggerLog
GO


-- Crear la Base de Datos SQLDDLTriggerLog
CREATE DATABASE SQLDDLTriggerLog
GO


-- Usar la Base de Datos SQLDDLTriggerLog
USE SQLDDLTriggerLog
GO


-- Crear la Tabla DDLLog
CREATE TABLE DDLLog(
	rowID			BIGINT	PRIMARY KEY IDENTITY(1,1),
	eventType		VARCHAR(128),
	postTime		DATETIME2(0),
	spid			INT,
	serverName		VARCHAR(128),
	loginName		VARCHAR(128),
	userName		VARCHAR(128),
	databaseName	VARCHAR(128),
	schemaName		VARCHAR(128),
	objectName		VARCHAR(128),
	newObjectName	VARCHAR(128),
	objectType		VARCHAR(128),
	TSqlCommand		VARCHAR(MAX)
)
GO


-- Consultar la Tabla DDLLog
SELECT * FROM DDLLog
GO


--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


--TRIGGER DDL DATABASE

-- Ubicarnos en la Base de Datos Master
USE master
GO


-- Validar si Existe la Base de Datos Retail
DROP DATABASE IF EXISTS Retail
GO


-- Crear la Base de Datos Retail
CREATE DATABASE Retail
GO


-- Usar la Base de Datos Retail
USE Retail
GO




-- Crear la Tabla Products
CREATE TABLE Products(
	productoID		INT,
	nombre			VARCHAR(20)
)
GO


-- Agregar la columna "precio"
ALTER TABLE Products ADD precio DECIMAL(10,2) CONSTRAINT DF_precio DEFAULT 0
GO


-- Eliminar la Restricción DEFAULT
ALTER TABLE Products DROP CONSTRAINT DF_precio
GO


-- Eliminar la columna "precio"
ALTER TABLE Products DROP COLUMN precio
GO


-- Cambiar el nombre a la Tabla
EXEC sp_rename @objname = 'Products', @newname = 'Productos'
GO


-- Eliminar la Tabla Productos
DROP TABLE Productos
GO




-- Crear la Tabla TableLog
CREATE TABLE TableLog(
   logID		INT IDENTITY(1,1) PRIMARY KEY,
   xmlEvento	XML,
   fechaEvento	DATETIME,
   usuario		VARCHAR(20)
)
GO


-- Consultar la Tabla TableLog
SELECT * FROM TableLog
GO




-- Crear el Trigger DDL TG_TableLog
CREATE OR ALTER TRIGGER TG_TableLog
ON DATABASE
FOR	CREATE_TABLE, ALTER_TABLE, DROP_TABLE, RENAME
AS
    SET NOCOUNT ON;
    INSERT INTO TableLog(xmlEvento, fechaEvento, usuario)
				  VALUES(EVENTDATA(),GETDATE(),USER)
GO


-- Consultar los Triggers que se encuentran en la Base de Datos
SELECT * FROM sys.triggers
GO


-- Eliminar el Trigger de la Base de Datos
DROP TRIGGER TG_TableLog 
ON DATABASE
GO


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--TRIGGER DML - FOR|AFTER

---------------------------------
--    Usar la Base de Datos    --
---------------------------------
USE tempdb
GO




-----------------------------------
--    CREAR LA TABLA PRODUCTOS    --
-----------------------------------
CREATE TABLE PRODUCTOS(
	id_producto		TINYINT PRIMARY KEY,
	nombre			VARCHAR(50),
	stock			VARCHAR(20)
	CONSTRAINT chk_stock CHECK(stock >= 0)--RESTRICCION
)
GO




------------------------------------------
--    CREAR LA TABLA DETALLE FACTURA    --
------------------------------------------
CREATE TABLE DETALLE_FACTURA(
	codigo		CHAR(4),
	id_producto	TINYINT FOREIGN KEY REFERENCES PRODUCTOS(id_producto),
	precio		DECIMAL(7,2),
	cantidad	SMALLINT
	CONSTRAINT chk_cantidad CHECK(cantidad >= 0),
	PRIMARY KEY (codigo, id_producto)
)
GO




----------------------------------
--    INSERTAR LOS PRODUCTOS    --
----------------------------------
INSERT INTO PRODUCTOS (id_producto, nombre, stock)
			   VALUES (101, 'Monitor LG 27 pulgadas', 50),
					  (102, 'Mouse Logitech G502', 100),
					  (103, 'SSD Kingston 960GB', 50);
GO




--------------------------------------------
--    CREAR TRIGGER PARA REDUCIR STOCK    --
--------------------------------------------
CREATE OR ALTER TRIGGER tgr_stock_modificados
ON DETALLE_FACTURA
AFTER UPDATE, INSERT, DELETE
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE	PRODUCTOS
	SET		stock = stock + total_cantidad
	FROM	(
			SELECT id_producto AS id, SUM(cantidad) AS total_cantidad
			FROM	(
					SELECT id_producto, -cantidad AS cantidad FROM Inserted
					UNION ALL
					SELECT id_producto, cantidad FROM Deleted
					) T
			GROUP BY id_producto
			) A
	WHERE id_producto = A.id;

END
GO




-------------------------------------------------
--    CONSULTAR PRODUCTOS Y DETALLE FACTURA    --
-------------------------------------------------
SELECT * FROM PRODUCTOS;
SELECT * FROM DETALLE_FACTURA;
GO




------------------------------------------------
--    INSERTAR REGISTRO EN DETALLE FACTURA    --
------------------------------------------------
INSERT INTO DETALLE_FACTURA (codigo, id_producto, precio, cantidad)
					 VALUES ('F101', 101, 499.90, 10),
							('F101', 102, 89.90, 20),
							('F102', 102, 89.90, 40),
							('F103', 103, 99.90, 10);
GO




-------------------------------------------------
--    CONSULTAR PRODUCTOS Y DETALLE FACTURA    --
-------------------------------------------------
SELECT * FROM PRODUCTOS;
SELECT * FROM DETALLE_FACTURA;
GO




------------------------------------------------
--    ELIMINAR REGISTRO EN DETALLE FACTURA    --
------------------------------------------------
DELETE FROM DETALLE_FACTURA 
WHERE codigo = 'F101' AND id_producto = 101;
GO

DELETE FROM DETALLE_FACTURA 
WHERE codigo = 'F101' AND id_producto = 102;
GO




-------------------------------------------------
--    CONSULTAR PRODUCTOS Y DETALLE FACTURA    --
-------------------------------------------------
SELECT * FROM PRODUCTOS;
SELECT * FROM DETALLE_FACTURA;
GO




--------------------------------------------------
--    ACTUALIZAR REGISTRO EN DETALLE FACTURA    --
--------------------------------------------------
UPDATE	DETALLE_FACTURA
SET		cantidad = 30
WHERE	codigo = 'F103' AND id_producto = 103;
GO




-------------------------------------------------
--    CONSULTAR PRODUCTOS Y DETALLE FACTURA    --
-------------------------------------------------
SELECT * FROM PRODUCTOS;
SELECT * FROM DETALLE_FACTURA;
GO




-----------------------------------------------------------
--    ELIMINAR EL TRIGGER DE LA TABLA DETALLE_FACTURA    --
-----------------------------------------------------------
DROP TRIGGER tgr_stock_modificados
GO




-----------------------------------------------------------
--    ELIMINAR LAS TABLAS DETALLE_FACTURA Y PRODUCTOS    --
-----------------------------------------------------------
DROP TABLE DETALLE_FACTURA;
DROP TABLE PRODUCTOS;
GO



--////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////


--TRIGGER DML INSTEAD OF
--Se dispara en lugar de la accion desencadennante habitual. significa que en lugar de la operacion
-- de insercion, actualizacion o Eliminacion se ejecute directamente en la tabla, el trigger instead of se
--ejecutara en su lugar permitiendo controlar la operacion.

---------------------------------
--    Usar la Base de Datos    --
---------------------------------
USE tempdb;
GO




-----------------------------------
--    CREAR LA TABLA PADRES    --
-----------------------------------
CREATE TABLE PADRES(
  id_padre	SMALLINT PRIMARY KEY,
  nombre	VARCHAR(10) NOT NULL
);
GO




-----------------------------------
--    CREAR LA TABLA HIJOS1    --
-----------------------------------
CREATE TABLE HIJOS1(
  id_hijo1	SMALLINT PRIMARY KEY,
  id_padre	SMALLINT,
  nombre	VARCHAR(10) NOT NULL
);
GO




-----------------------------------
--    CREAR LA TABLA HIJOS2    --
-----------------------------------
CREATE TABLE HIJOS2(
  id_hijo2	SMALLINT PRIMARY KEY,
  id_padre	SMALLINT,
  nombre	VARCHAR(10) NOT NULL
);
GO




-----------------------------------
--    CREAR LA TABLA NIETOS    --
-----------------------------------
CREATE TABLE NIETOS(
  id_nietos	SMALLINT PRIMARY KEY,
  id_hijo1	SMALLINT,
  id_hijo2	SMALLINT,
  nombre	VARCHAR(10) NOT NULL
);
GO




-------------------------------------------
--    CREAR FOREIGN KEY DE LAS TABLAS    --
-------------------------------------------
ALTER TABLE HIJOS1
ADD CONSTRAINT FK_HIJO1_PADRE FOREIGN KEY(id_padre)
REFERENCES PADRES(id_padre)
ON DELETE CASCADE;
GO


ALTER TABLE HIJOS2
ADD CONSTRAINT FK_HIJO2_PADRE FOREIGN KEY(id_padre)
REFERENCES PADRES(id_padre)
ON DELETE CASCADE;
GO


ALTER TABLE NIETOS
ADD CONSTRAINT FK_NIETOS_HIJOS1 FOREIGN KEY(id_hijo1)
REFERENCES HIJOS1(id_hijo1)
ON DELETE CASCADE;
GO


ALTER TABLE NIETOS
ADD CONSTRAINT FK_NIETOS_HIJOS2 FOREIGN KEY(id_hijo2)
REFERENCES HIJOS2(id_hijo2)
ON DELETE CASCADE;
GO




-------------------------------------------------------
--    ELIMINAR LAS RELACIONES FOREIGN KEY CREADAS    --
-------------------------------------------------------
ALTER TABLE HIJOS1 DROP CONSTRAINT FK_HIJO1_PADRE;
ALTER TABLE HIJOS2 DROP CONSTRAINT FK_HIJO2_PADRE;
ALTER TABLE NIETOS DROP CONSTRAINT FK_NIETOS_HIJOS1;
GO




-------------------------------------------------------
--    RE-CREAR LAS RELACIONES FOREIGN KEY CREADAS    --
-------------------------------------------------------
ALTER TABLE HIJOS1
ADD CONSTRAINT FK_HIJO1_PADRE FOREIGN KEY(id_padre)
REFERENCES PADRES(id_padre);
GO


ALTER TABLE HIJOS2
ADD CONSTRAINT FK_HIJO2_PADRE FOREIGN KEY(id_padre)
REFERENCES PADRES(id_padre);
GO


ALTER TABLE NIETOS
ADD CONSTRAINT FK_NIETOS_HIJOS1 FOREIGN KEY(id_hijo1)
REFERENCES HIJOS1(id_hijo1);
GO


ALTER TABLE NIETOS
ADD CONSTRAINT FK_NIETOS_HIJOS2 FOREIGN KEY(id_hijo2)
REFERENCES HIJOS2(id_hijo2);
GO




--------------------------------------------
--    CREAR TRIGGER EN LA TABLA PADRES    --
--------------------------------------------
CREATE OR ALTER TRIGGER tgr_eliminar_padres
   ON PADRES
   INSTEAD OF DELETE
AS 
BEGIN
 
 SET NOCOUNT ON;

 DELETE FROM HIJOS1 WHERE id_padre IN (SELECT id_padre FROM DELETED)
 DELETE FROM HIJOS2 WHERE id_padre IN (SELECT id_padre FROM DELETED)
 DELETE FROM PADRES WHERE id_padre IN (SELECT id_padre FROM DELETED)

END;
GO




--------------------------------------------
--    CREAR TRIGGER EN LA TABLA HIJOS1    --
--------------------------------------------
CREATE OR ALTER TRIGGER tgr_eliminar_hijos1
   ON HIJOS1
   INSTEAD OF DELETE
AS 
BEGIN

 SET NOCOUNT ON;

 DELETE FROM NIETOS WHERE id_hijo1 IN (SELECT id_hijo1 FROM DELETED)
 DELETE FROM HIJOS1 WHERE id_hijo1 IN (SELECT id_hijo1 FROM DELETED)

END;
GO




--------------------------------------------
--    CREAR TRIGGER EN LA TABLA HIJOS2    --
--------------------------------------------
CREATE OR ALTER TRIGGER tgr_eliminar_hijos2
   ON HIJOS2
   INSTEAD OF DELETE
AS 
BEGIN

 SET NOCOUNT ON;

 DELETE FROM NIETOS WHERE id_hijo2 IN (SELECT id_hijo2 FROM DELETED)
 DELETE FROM HIJOS2 WHERE id_hijo2 IN (SELECT id_hijo2 FROM DELETED)

END;
GO




---------------------------------------------------------------------------
--    INSERTAR REGISTROS A LAS TABLAS PADRES, HIJOS1, HIJOS2 Y NIETOS    --
---------------------------------------------------------------------------
INSERT INTO PADRES VALUES (1,'Padre');
INSERT INTO PADRES VALUES (2,'Padre');
INSERT INTO PADRES VALUES (3,'Padre');
INSERT INTO PADRES VALUES (4,'Padre');
INSERT INTO HIJOS1 VALUES (1,1,'test');
INSERT INTO HIJOS2 VALUES (10,2,'test');
INSERT INTO HIJOS1 VALUES (2,3,'test');
INSERT INTO HIJOS2 VALUES (11,4,'test');
INSERT INTO NIETOS VALUES (1,1,null,'test');
INSERT INTO NIETOS VALUES (2,null,10,'test');
INSERT INTO NIETOS VALUES (3,2,null,'test');
INSERT INTO NIETOS VALUES (4,null,11,'test');
GO




------------------------------------------------------------
--    CONSULTAR TABLAS PADRES, HIJOS1, HIJOS2 Y NIETOS    --
------------------------------------------------------------
SELECT * FROM PADRES;
SELECT * FROM HIJOS1;
SELECT * FROM HIJOS2;
SELECT * FROM NIETOS;
GO




-------------------------------------
--    ELIMINAR PADRE CON id = 1    --
-------------------------------------
DELETE FROM PADRES WHERE id_padre = 1;
GO




------------------------------------------------------------
--    CONSULTAR TABLAS PADRES, HIJOS1, HIJOS2 Y NIETOS    --
------------------------------------------------------------
SELECT * FROM PADRES;
SELECT * FROM HIJOS1;
SELECT * FROM HIJOS2;
SELECT * FROM NIETOS;
GO




-------------------------------------
--    ELIMINAR PADRE CON id = 2    --
-------------------------------------
DELETE FROM PADRES WHERE id_padre = 2;
GO




------------------------------------------------------------
--    CONSULTAR TABLAS PADRES, HIJOS1, HIJOS2 Y NIETOS    --
------------------------------------------------------------
SELECT * FROM PADRES;
SELECT * FROM HIJOS1;
SELECT * FROM HIJOS2;
SELECT * FROM NIETOS;
GO




---------------------------------
--    ELIMINAR LOS TRIGGERS    --
---------------------------------
DROP TRIGGER tgr_eliminar_padres;
DROP TRIGGER tgr_eliminar_hijos1;
DROP TRIGGER tgr_eliminar_hijos2;
GO




---------------------------------------------------------------
--    ELIMINAR LAS TABLAS NIETOS, HIJOS1, HIJOS1 Y PADRES    --
---------------------------------------------------------------
DROP TABLE NIETOS;
DROP TABLE HIJOS1;
DROP TABLE HIJOS2;
DROP TABLE PADRES;
GO



--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


--IMPLEMENTACION EN LA BASE DE DATOS

-- Ubicarse en la Base de Datos master
USE master
GO


-- Validar si existe la Base de Datos MundoCineXYZ
DROP DATABASE IF EXISTS MundoCineXYZ
GO


-- Crear la Base de Datos MundoCineXYZ
CREATE DATABASE MundoCineXYZ
ON
(	
	NAME = MundoCineXYZ_dat,
	FILENAME = 'C:\Master en SQL Server\MundoCineXYZ_dat.mdf',
	SIZE = 50MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 10MB
)
LOG ON
(
	NAME = MundoCineXYZ_log,
	FILENAME = 'C:\Master en SQL Server\MundoCineXYZ_dat.ldf',
	SIZE = 50MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 10MB
)
GO


-- Usar la Base de Datos MundoCineXYZ
USE MundoCineXYZ
GO


-- Crear la Tabla CineLog
CREATE TABLE CineLog(
	logID			INT PRIMARY KEY IDENTITY(1,1),
	eventoXML		XML,
	fechaEvento		DATETIME,
	usuario			VARCHAR(20)
)
GO


-- Crear el Trigger DDL DATABASE TG_CineLog
CREATE OR ALTER TRIGGER TG_TableLog
ON DATABASE
FOR	CREATE_TABLE, ALTER_TABLE, DROP_TABLE, RENAME
AS
    SET NOCOUNT ON;
    INSERT INTO CineLog(eventoXML, fechaEvento, usuario)
				 VALUES(EVENTDATA(),GETDATE(),USER)
GO


-- Crear la Tabla Empleados
CREATE TABLE Cargos(
	cargoID				INT PRIMARY KEY,
	tipo				VARCHAR(40)		NOT NULL,
	descripcion			VARCHAR(255)
)
GO


-- Crear la Tabla Empleados
CREATE TABLE Empleados(
	empleadoID			INT PRIMARY KEY,
	cargoID				INT,
	nombre				VARCHAR(40)		NOT NULL,
	paterno				VARCHAR(40)		NOT NULL,
	materno				VARCHAR(40)		NOT NULL,
	salario				DECIMAL(18,2)	NOT NULL,
		CONSTRAINT CK_salario CHECK (salario > 0),
	fechaContratacion	DATE			NOT NULL,
	fechaNacimiento		DATE			NOT NULL,
		CONSTRAINT FK_Cargo_Empleado FOREIGN KEY(cargoID)
		REFERENCES Cargos(cargoID)
			ON UPDATE CASCADE
			ON DELETE NO ACTION
)
GO


-- Crear la Tabla Salas
CREATE TABLE Salas(
	salaID				INT PRIMARY KEY,
	numero				VARCHAR(15)		NOT NULL,
	capacidad			SMALLINT		NOT NULL,
	tipo				VARCHAR(20)		NOT NULL
)
GO


-- Crear la Tabla Salas_Empleados
CREATE TABLE Salas_Empleados(
	empleadoID			INT,
	salaID				INT,
	CONSTRAINT FK_Empleado_SalEmp FOREIGN KEY(empleadoID)
		REFERENCES Empleados(empleadoID)
			ON UPDATE CASCADE
			ON DELETE NO ACTION,
	CONSTRAINT FK_Salas_SalEmp FOREIGN KEY(salaID)
		REFERENCES Salas(salaID)
			ON UPDATE CASCADE
			ON DELETE NO ACTION,
	CONSTRAINT PK_Sal_Emp PRIMARY KEY(empleadoID, salaID)
)
GO



-- Crear la Tabla Asientos
CREATE TABLE Asientos(
	asientoID			INT PRIMARY KEY,
	salaID				INT,
	asiento				VARCHAR(15)		NOT NULL,
		CONSTRAINT FK_Sala_Asiento FOREIGN KEY(salaID)
		REFERENCES Salas(salaID)
			ON UPDATE CASCADE
			ON DELETE NO ACTION
)
GO


-- Crear la Tabla Generos
CREATE TABLE Generos(
	generoID			INT PRIMARY KEY,
	nombre				VARCHAR(50)		NOT NULL
)
GO


-- Crear la Tabla Peliculas
CREATE TABLE Peliculas(
	peliculaID			INT PRIMARY KEY,
	titulo				VARCHAR(50)		NOT NULL,
	descripcion			VARCHAR(MAX),
	eslogan				VARCHAR(255),
	fechaLanzamiento	DATE			NOT NULL,
	tiempoDuracion		TINYINT			NOT NULL,
	estado				BIT				NOT NULL

-- estado:
-- 1 -> Disponible
-- 0 -> No Disponible
)
GO


-- Crear la Tabla Generos_Peliculas
CREATE TABLE Generos_Peliculas(
	generoID			INT,
	peliculaID			INT,
	CONSTRAINT FK_Generos_GenPel FOREIGN KEY(generoID)
	REFERENCES Generos(generoID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT FK_Peliculas_GenPel FOREIGN KEY(peliculaID)
	REFERENCES Peliculas(peliculaID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT PK_Gen_Pel PRIMARY KEY(generoID, peliculaID)
)
GO


-- Crear la Tabla Funciones
CREATE TABLE Funciones(
	funcionID			INT PRIMARY KEY,
	peliculaID			INT,
	salaID				INT,
	fecha				DATE	NOT NULL,
	hora				TIME	NOT NULL,
	CONSTRAINT FK_Pelicula_Funcion FOREIGN KEY(peliculaID)
	REFERENCES Peliculas(peliculaID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT FK_Sala_Funcion FOREIGN KEY(salaID)
	REFERENCES Salas(salaID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION
)
GO


-- Crear la Tabla Promociones
CREATE TABLE Promociones(
	promocionID			INT PRIMARY KEY,
	codigo				VARCHAR(20)		NOT NULL,
	descuento			DECIMAL(10,2)	NOT NULL,
	fechaInicio			DATE,
	horaInicio			TIME,
	fechaFin			DATE,
	horaFin				TIME
)
GO


-- Crear la Tabla Entradas
CREATE TABLE Entradas(
	entradaID			INT PRIMARY KEY IDENTITY(1,1),
	empleadoID			INT,
	promocionID			INT,
	funcionID			INT,
	precio				DECIMAL(10,2)	NOT NULL CONSTRAINT DF_precio DEFAULT 25,
		CONSTRAINT CK_precio CHECK (precio > 0),
	total				DECIMAL(10,2)	NOT NULL CONSTRAINT DF_total DEFAULT 0,
		CONSTRAINT CK_total CHECK (total >= 0),
	fechaCompra			DATE			NOT NULL CONSTRAINT DF_fechaCompra DEFAULT GETDATE(),
	horaCompra			TIME			NOT NULL CONSTRAINT DF_horaCompra DEFAULT GETDATE(),

		CONSTRAINT FK_Promocion_Entrada FOREIGN KEY(promocionID)
		REFERENCES Promociones(promocionID)
			ON UPDATE CASCADE
			ON DELETE NO ACTION,
		CONSTRAINT FK_Empleado_Entrada FOREIGN KEY(empleadoID)
		REFERENCES Empleados(empleadoID)
			ON UPDATE CASCADE
			ON DELETE NO ACTION,
		CONSTRAINT FK_Funcion_Entrada FOREIGN KEY(funcionID)
		REFERENCES Funciones(funcionID)
			ON UPDATE CASCADE
			ON DELETE NO ACTION
)
GO


-- Crear la Tabla Reservas
/*
	Podran producirse ciclos o multiples rutas en cascada
*/
-- Incorrecto -
CREATE TABLE Reservas(
	reservaID			INT PRIMARY KEY IDENTITY(1,1),
	entradaID			INT,
	asientoID			INT,
	estado				BIT		NOT NULL CONSTRAINT DF_estado DEFAULT 1,
	-- 0 -> Disponible
	-- 1 -> Ocupado
	CONSTRAINT FK_Entrada_Reserva FOREIGN KEY(entradaID)
	REFERENCES Entradas(entradaID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT FK_Entrada_Asiento FOREIGN KEY(asientoID)
	REFERENCES Asientos(asientoID)
		ON UPDATE CASCADE --se debe cambiar a NO ACTION para coregir ciclos o pultiples rutas en cascada
		ON DELETE NO ACTION
)
GO


-- Correcto
CREATE TABLE Reservas(
	reservaID			INT PRIMARY KEY IDENTITY(1,1),
	entradaID			INT,
	asientoID			INT,
	estado				BIT		NOT NULL CONSTRAINT DF_estado DEFAULT 1,
	-- 0 -> Disponible
	-- 1 -> Ocupado
	CONSTRAINT FK_Entrada_Reserva FOREIGN KEY(entradaID)
	REFERENCES Entradas(entradaID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT FK_Entrada_Asiento FOREIGN KEY(asientoID)
	REFERENCES Asientos(asientoID)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
)
GO


-- Consultar la Tabla CineLog
SELECT * FROM CineLog
GO


--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


--INSERTAR REGISTROS EN LA BASE DE DATOS


-- Ubicarse en la Base de Datos MundoCineXYZ
USE MundoCineXYZ
GO




-- Insertar registro en la Tabla Cargos
INSERT INTO Cargos(cargoID, tipo, descripcion)
			VALUES(1, 'Cajero', 'Encargado de la venta de Ticket'),
				  (2, 'Encargado de Proyección', NULL),
				  (3, 'Limpieza', 'Encargado de limpiar la sala de cine'),
				  (4, 'Supervisor', NULL)
GO

-- Consultar la Tabla Cargos
SELECT * FROM Cargos
GO




-- Insertar registro en la Tabla Empleados
INSERT INTO Empleados(empleadoID, cargoID, nombre, paterno, materno, 
					  salario, fechaContratacion, fechaNacimiento)
VALUES(1, 4, 'Juan', 'Pérez', 'González', 4000, '2020-01-01', '2020-04-04'),
	  (2, 1, 'Martha', 'García', 'Rodríguez', 3500, '2022-08-01', '2000-05-17'),
	  (3, 1, 'Carlos', 'Ramírez', 'Hernández', 3000, '2023-06-06', '1998-07-15'),
	  (4, 2, 'Ana', 'Martínez', 'López', 3000, '2021-09-01', '2000-04-08'),
	  (5, 2, 'Luis', 'Fernández', 'Sánchez', 3300, '2018-12-01', '1997-02-02'),
	  (6, 2, 'Sofía', 'Torres', 'Morales', 3400, '2015-10-10', '1996-11-11'),
	  (7, 3, 'José', 'Rivera', 'Castillo', 2800, '2019-12-12', '1998-07-14'),
	  (8, 3, 'Laura', 'Ortiz', 'Gómez', 3000, '2019-03-12', '2000-08-10'),
	  (9, 3, 'Daniel', 'Chávez', 'Méndez', 2500, '2021-06-12', '2000-03-01'),
	  (10, 3, 'Valeria', 'Flores', 'Romero', 3000, '2018-06-07', '1997-08-08')
GO

-- Consultar la Tabla Empleados
SELECT * FROM Empleados
GO




-- Insertar registro en la Tabla Salas
INSERT INTO Salas(salaID, numero, capacidad, tipo)
		   VALUES(1, 'SALA 1', 100, '2D'),
			     (2, 'SALA 2', 120, '3D'),
				 (3, 'SALA 3', 150, '2D'),
				 (4, 'SALA 4', 200, '3D'),
				 (5, 'SALA 5', 270, '4D')
GO

-- Consultar la Tabla Salas
SELECT * FROM Salas
GO




-- Insertar registro en la Tabla Salas_Empleados
INSERT INTO Salas_Empleados(empleadoID, salaID)
					 VALUES(4, 1), (7, 1),
						   (5, 2), (8, 2),
						   (6, 3), (9, 3),
						   (4, 4), (10, 4),
						   (1, 5), (2, 5)

GO

-- Consultar la Tabla Salas_Empleados
SELECT * FROM Salas_Empleados
GO




-- Insertar registro en la Tabla Asientos
INSERT INTO Asientos(asientoID, salaID, asiento)
VALUES(1, 1, 'A1'), (2, 1, 'A2'), (3, 1, 'A3'), (4, 1, 'A4'), (5, 1, 'A5'),
	  (6, 1, 'A6'), (7, 1, 'A7'), (8, 1, 'A8'), (9, 1, 'A9'), (10, 1, 'A10'),
	  (11, 1, 'B1'), (12, 1, 'B2'), (13, 1, 'B3'), (14, 1, 'B4'), (15, 1, 'B5'),
	  (16, 1, 'B6'), (17, 1, 'B7'), (18, 1, 'B8'), (19, 1, 'B9'), (20, 1, 'B10'),
	  (21, 2, 'A1'), (22, 2, 'A2'), (23, 2, 'A3'), (24, 2, 'A4'), (25, 2, 'A5'),
	  (26, 2, 'A6'), (27, 2, 'A7'), (28, 2, 'A8'), (29, 2, 'A9'), (30, 2, 'A10'),
	  (31, 2, 'B1'), (32, 2, 'B2'), (33, 2, 'B3'), (34, 2, 'B4'), (35, 2, 'B5'),
	  (36, 2, 'B6'), (37, 2, 'B7'), (38, 2, 'B8'), (39, 2, 'B9'), (40, 2, 'B10'),
	  (41, 3, 'A1'), (42, 3, 'A2'), (43, 3, 'A3'), (44, 3, 'A4'), (45, 3, 'A5'),
	  (46, 3, 'A6'), (47, 3, 'A7'), (48, 3, 'A8'), (49, 3, 'A9'), (50, 3, 'A10'),
	  (51, 3, 'B1'), (52, 3, 'B2'), (53, 3, 'B3'), (54, 3, 'B4'), (55, 3, 'B5'),
	  (56, 3, 'B6'), (57, 3, 'B7'), (58, 3, 'B8'), (59, 3, 'B9'), (60, 3, 'B10'),
	  (61, 4, 'A1'), (62, 4, 'A2'), (63, 4, 'A3'), (64, 4, 'A4'), (65, 4, 'A5'),
	  (66, 4, 'A6'), (67, 4, 'A7'), (68, 4, 'A8'), (69, 4, 'A9'), (70, 4, 'A10'),
	  (71, 4, 'B1'), (72, 4, 'B2'), (73, 4, 'B3'), (74, 4, 'B4'), (75, 4, 'B5'),
	  (76, 4, 'B6'), (77, 4, 'B7'), (78, 4, 'B8'), (79, 4, 'B9'), (80, 4, 'B10'),
	  (81, 5, 'B6'), (82, 5, 'B7'), (83, 5, 'B8'), (84, 5, 'B9'), (85, 5, 'B10')
GO

-- Consultar la Tabla Asientos
SELECT * FROM Asientos
GO




-- Insertar registro en la Tabla Generos
INSERT INTO Generos(generoID, nombre)
VALUES(101, 'Aventura'), (102, 'Fantasía'), (103, 'Drama'),
      (104, 'Horror'), (105, 'Acción'), (106, 'Comedia'),
	  (107, 'Historia'), (108, 'Suspenso'), (109, 'Crimen'),
	  (110, 'Misterio'), (111, 'Música'), (112, 'Romance'),
	  (113, 'Familia'), (114, 'Guerra'), (115, 'Ciencia ficción')
GO

-- Consultar la Tabla Generos
SELECT * FROM Generos
GO




-- Insertar registro en la Tabla Peliculas
INSERT INTO Peliculas(peliculaID, titulo, descripcion, eslogan, fechaLanzamiento, tiempoDuracion, estado)
VALUES
(1, 'El Último Refugio', 'En un futuro distópico, un grupo de supervivientes lucha por encontrar un lugar seguro.', 'La esperanza es lo último que se pierde.', '2024-02-14', 130, 0),
(2, 'Horizonte Perdido', 'Una expedición descubre un mundo oculto bajo el océano.', 'Más allá del horizonte, comienza la aventura.', '2024-03-01', 145, 0),
(3, 'Memorias del Futuro', 'Un científico desarrolla una máquina que permite ver recuerdos del futuro.', 'El futuro está escrito en nuestras mentes.', '2024-04-12', 128, 0),
(4, 'El Enigma de la Estrella Roja', 'Un equipo de astronautas descubre un misterio en Marte que podría cambiar la humanidad.', 'El descubrimiento es solo el principio.', '2024-05-24', 137, 0),
(5, 'Cazadores del Tiempo', 'Un grupo de arqueólogos viaja al pasado para recuperar artefactos perdidos.', 'El pasado está al alcance de tu mano.', '2024-06-07', 122, 0),
(6, 'El Código Omega', 'Un hacker descubre un código que puede controlar el mundo.', 'El poder absoluto en las manos equivocadas.', '2024-07-19', 118, 0),
(7, 'Sombras en la Ciudad', 'Un detective investiga una serie de desapariciones en una ciudad donde nunca sale el sol.', 'En la oscuridad, todos los secretos son revelados.', '2024-08-02', 110, 0),
(8, 'Sueños Artificiales', 'Un hombre se enamora de una inteligencia artificial en un mundo donde la realidad y la fantasía se mezclan.', 'El amor no conoce límites.', CAST(GETDATE() AS DATE), 132, 1),
(9, 'El Legado de los Inmortales', 'Una sociedad secreta de inmortales lucha por el control del destino de la humanidad.', 'La eternidad tiene un precio.', '2024-10-25', 140, 0),
(10, 'La Última Frontera', 'Una nave espacial en una misión desesperada para encontrar un nuevo hogar para la humanidad.', 'El futuro de la humanidad está en sus manos.', CAST(GETDATE() AS DATE), 150, 1),
(11, 'Reflejos del Pasado', 'Una mujer descubre que puede comunicarse con su yo del pasado a través de los espejos.', 'Lo que ves no siempre es lo que parece.', '2024-01-05', 119, 0),
(12, 'El Rescate Imposible', 'Un equipo de élite intenta rescatar a científicos atrapados en una base bajo el hielo.', 'No hay misión imposible.', '2024-03-22', 125, 0),
(13, 'Almas Perdidas', 'Un sacerdote y un médium unen fuerzas para combatir una amenaza sobrenatural.', 'El mal siempre encuentra una manera de regresar.', '2024-04-19', 114, 0),
(14, 'La Ciudad Invisible', 'Un grupo de amigos descubre una ciudad escondida en las montañas que no aparece en ningún mapa.', 'Algunas ciudades no están destinadas a ser encontradas.', '2024-05-03', 108, 0),
(15, 'Ecos del Silencio', 'Una periodista investiga un caso de desaparición que la lleva a descubrir una verdad inquietante.', 'El silencio tiene su propio lenguaje.', '2024-06-14', 116, 0),
(16, 'Más Allá del Velo', 'Una mujer que ha perdido a su hija comienza a ver visiones de ella en un mundo paralelo.', 'El amor traspasa todas las fronteras.', '2024-07-26', 121, 0),
(17, 'El Juicio Final', 'Un abogado debe defender a un hombre acusado de crímenes que aún no ha cometido.', 'La justicia está en el futuro.', CAST(GETDATE() AS DATE), 126, 1),
(18, 'La Resistencia Oculta', 'En un mundo controlado por corporaciones, un grupo de rebeldes lucha por la libertad.', 'El espíritu humano nunca será domado.', '2024-09-27', 135, 0),
(19, 'Las Crónicas de Titán', 'Un grupo de exploradores coloniza una luna lejana, enfrentando desafíos inesperados.', 'La aventura está más allá de las estrellas.', '2024-10-18', 142, 0),
(20, 'El Susurro del Bosque', 'Una familia se muda a una cabaña en un bosque encantado lleno de secretos antiguos.', 'Los árboles guardan historias antiguas.', '2024-11-29', 111, 0),
(21, 'Sin Retorno', 'Un hombre despierta en un mundo donde todos sus seres queridos han desaparecido.', 'En la búsqueda de la verdad, a veces no hay regreso.', '2024-01-26', 117, 0),
(22, 'El Portal Oculto', 'Un joven descubre un portal que lo transporta a diferentes épocas y dimensiones.', 'Cada puerta oculta un nuevo mundo.', '2024-03-08', 124, 0),
(23, 'El Último Guerrero', 'En un mundo post-apocalíptico, el último guerrero lucha por restaurar la civilización.', 'La esperanza es la última arma.', '2024-04-05', 138, 0),
(24, 'El Ojo de la Tormenta', 'Un piloto debe enfrentar sus miedos y una tormenta sobrenatural para salvar a su tripulación.', 'En la tormenta, el miedo es el enemigo.', '2024-06-21', 127, 0),
(25, 'Las Sombras del Ayer', 'Un historiador descubre un complot que ha sido ocultado durante siglos.', 'El pasado nunca muere.', '2024-07-12', 109, 0),
(26, 'El Guardián del Tiempo', 'Un relojero se convierte en el guardián del tiempo cuando descubre un reloj que puede detener el mundo.', 'El tiempo está en sus manos.', CAST(GETDATE() AS DATE), 115, 1),
(27, 'El Despertar de los Dragones', 'En un mundo de fantasía, los dragones despiertan para reclamar su dominio.', 'El fuego regresa para purificar.', '2024-09-05', 131, 0),
(28, 'La Guerra de los Sueños', 'Dos facciones luchan por el control de los sueños en un mundo donde los sueños pueden ser mortales.', 'El poder de los sueños es infinito.', '2024-10-11', 120, 0),
(29, 'La Maldición del Faro', 'Un grupo de investigadores desentraña los misterios de un faro abandonado donde ocurrieron hechos macabros.', 'Algunas luces nunca deben encenderse.', '2024-11-15', 103, 0),
(30, 'El Último Deseo', 'Una mujer recibe la oportunidad de cumplir un último deseo antes de que se acabe el tiempo.', '¿Qué harías si te quedara un solo deseo?', CAST(GETDATE() AS DATE), 113, 1),
(31, 'El Origen', 'Un thriller que desafía la mente sobre sueños dentro de sueños.', 'Tu mente es el escenario del crimen.', '2010-07-16', 148, 0),
(32, 'Matrix', 'Un hacker descubre que el mundo es una realidad simulada.', 'Libera tu mente.', '1999-03-31', 136, 0),
(33, 'El Laberinto del Fauno', 'Una niña se escapa a un mundo de fantasía en medio de la Guerra Civil Española.', 'Inocencia ha sido perdida.', '2006-10-11', 118, 0),
(34, 'Amores Perros', 'Tres historias entrelazadas que exploran la brutalidad de la vida en la Ciudad de México.', 'Todo está conectado.', '2000-05-19', 154, 0),
(35, 'La Vida es Bella', 'Un padre utiliza su imaginación para proteger a su hijo de los horrores de un campo de concentración.', 'La vida es hermosa en medio del horror.', '1997-12-20', 116, 0),
(36, 'Roma', 'Una mirada íntima a la vida de una empleada doméstica en la Ciudad de México en los años 70.', 'Una historia universal.', '2018-11-21', 135, 0),
(37, 'El Secreto de sus Ojos', 'Un antiguo investigador revisita un caso de asesinato que lo obsesiona.', 'La justicia no es ciega.', '2009-08-13', 129, 0),
(38, 'El Hijo de la Novia', 'Un hombre reconsidera su vida tras un infarto mientras su madre padece Alzheimer.', 'Nunca es tarde para cambiar.', CAST(GETDATE() AS DATE), 124, 1),
(39, 'Relatos Salvajes', 'Seis historias que muestran lo que sucede cuando las personas son empujadas al límite.', 'Todos tenemos un límite.', '2014-08-21', 122, 0),
(40, 'El Espinazo del Diablo', 'Un orfanato en la Guerra Civil Española esconde un oscuro secreto.', 'Lo que ves no es lo único que existe.', '2001-04-20', 108, 0),
(41, 'Mar Adentro', 'La lucha de un hombre por su derecho a morir con dignidad.', 'La vida es un derecho, no una obligación.', '2004-09-03', 126, 0),
(42, 'Todo Sobre mi Madre', 'Una mujer busca al padre de su hijo fallecido en el mundo del teatro y la transgeneridad.', 'Un homenaje al amor materno.', '1999-04-16', 101, 0),
(43, 'La Lengua de las Mariposas', 'Un niño y su maestro experimentan las tensiones de la Guerra Civil Española.', 'La educación como resistencia.', '1999-01-24', 96, 0),
(44, 'Volver', 'Una mujer regresa a su pueblo natal y enfrenta el pasado y los secretos familiares.', 'El pasado siempre vuelve.', '2006-03-17', 121, 0),
(45, 'Tesis', 'Una estudiante de cine descubre una red de snuff movies mientras investiga para su tesis.', 'La curiosidad puede ser mortal.', '1996-04-12', 125, 0),
(46, 'El Laberinto del Fauno', 'Una niña escapa a un mundo de fantasía en medio de la Guerra Civil Española.', 'Inocencia perdida en tiempos oscuros.', '2006-10-11', 118, 0),
(47, 'La Comunidad', 'Una agente inmobiliaria encuentra una fortuna oculta en un apartamento y desata una lucha por el dinero.', 'El dinero puede ser la raíz del mal.', '2000-09-29', 106, 0),
(48, 'Celda 211', 'Un funcionario de prisiones se encuentra atrapado en un motín y debe fingir ser un prisionero.', 'En la celda, todos somos iguales.', '2009-11-06', 113, 0),
(49, 'Abre los Ojos', 'Un hombre con desfiguración facial tiene problemas para distinguir entre sueño y realidad.', 'Despierta a la verdad.', '1997-12-19', 117, 0),
(50, 'La Isla Mínima', 'Dos detectives investigan una serie de desapariciones en un remoto pueblo durante la transición española.', 'En el silencio del campo, nadie te oye gritar.', '2014-09-26', 105, 0),
(51, 'El Hombre de las Mil Caras', 'La historia del estafador Francisco Paesa y su implicación en uno de los mayores escándalos de España.', 'El arte de la mentira.', CAST(GETDATE() AS DATE), 123, 1),
(52, 'Los Otros', 'Una mujer vive con sus hijos en una mansión oscura donde suceden cosas inexplicables.', 'No todos los fantasmas son visibles.', '2001-08-02', 101, 0),
(53, 'Balada Triste de Trompeta', 'La rivalidad entre dos payasos de un circo en la España franquista.', 'El circo de la guerra.', '2010-12-17', 107, 0),
(54, 'El Bola', 'La amistad entre dos niños revela los abusos que uno de ellos sufre en su hogar.', 'El silencio no protege a nadie.', '2000-11-10', 88, 0),
(55, 'El Día de la Bestia', 'Un cura intenta evitar el nacimiento del Anticristo en la noche de Navidad en Madrid.', 'El Apocalipsis ha llegado.', '1995-10-20', 99, 0),
(56, 'Camarón: Flamenco y Revolución', 'La vida y carrera de Camarón de la Isla, una leyenda del flamenco.', 'El arte no tiene fronteras.', '2005-07-15', 119, 0),
(57, 'El Milagro de P. Tinto', 'Una excéntrica comedia sobre un hombre que espera un milagro para tener hijos.', 'La espera vale la pena.', '1998-09-25', 105, 0),
(58, 'Nadie Hablará de Nosotras Cuando Hayamos Muerto', 'Una mujer que trabajó para la mafia huye a España donde enfrenta su oscuro pasado.', 'El pasado siempre vuelve.', '1995-10-06', 104, 0),
(59, 'Los Lunes al Sol', 'Un grupo de desempleados en la España post-industrial busca sentido a su vida.', 'La dignidad no tiene precio.', '2002-09-27', 113, 0),
(60, 'El Cuerpo', 'El cadáver de una mujer desaparece misteriosamente de la morgue, desencadenando una investigación llena de secretos.', 'Algunos cuerpos nunca descansan.', '2012-10-04', 108, 0);
GO

-- Consultar la Tabla Peliculas
SELECT * FROM Peliculas
ORDER BY estado DESC, fechaLanzamiento DESC
GO




-- Insertar registro en la Tabla Peliculas
INSERT INTO Generos_Peliculas(peliculaID, generoID)
VALUES(1, 115), (2, 101), (3, 115), (4, 115), (5, 101),
	  (6, 109), (7, 108), (8, 102), (8, 115), (9, 102),
	  (10, 115), (11, 107), (11, 110), (12, 105), (13, 104),
	  (14, 101), (14, 102), (15, 104), (15, 110), (16, 103),
	  (16, 102), (17, 103), (17, 110), (18, 115), (18, 105),
	  (19, 115), (19, 101), (20, 104), (20, 110), (21, 107),
	  (21, 110), (22, 101), (22, 102), (23, 115), (23, 105),
	  (24, 108), (25, 110), (25, 107), (26, 102), (26, 115),
	  (27, 102), (28, 102), (28, 115), (29, 104), (29, 110),
	  (30, 103), (30, 102), (31, 115), (31, 102), (32, 115),
	  (33, 102), (33, 103), (34, 103), (35, 103), (35, 106),
	  (36, 103), (37, 103), (37, 108), (38, 103), (38, 106),
	  (39, 106), (39, 109), (40, 104), (40, 103), (41, 103),
	  (42, 103), (43, 103), (44, 103), (44, 106), (45, 104),
	  (45, 108), (46, 102), (46, 103), (47, 106), (48, 105),
	  (49, 115), (50, 103), (51, 104), (51, 108), (52, 104),
	  (52, 110), (53, 106), (53, 103), (54, 103), (55, 106),
	  (55, 104), (56, 111), (56, 107), (57, 106), (58, 103),
	  (59, 103), (60, 110), (60, 104), (60, 108)
GO

-- Consultar la Tabla Generos_Peliculas
SELECT * FROM Generos_Peliculas
GO




-- Insertar registro en la Tabla Funciones
INSERT INTO Funciones(funcionID, peliculaID, salaID, fecha, hora)
			   VALUES(1, 8,   1, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), '15:00'),
					 (2, 10,  1, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), '17:45'),
					 (3, 17,  1, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), '20:30'),
					 (4, 26,  2, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), '15:00'),
					 (5, 30,  2, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), '17:45'),
					 (6, 38,  2, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), '20:30'),
					 (7, 51,  3, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), '15:00'),
					 (8, 8,   3, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), '17:45'),
					 (9, 10,  3, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), '20:30'),
					 (10, 17, 4, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), '15:00'),
					 (11, 26, 4, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), '17:45'),
					 (12, 30, 4, CAST(DATEADD(DAY, -2, GETDATE()) AS DATE), '20:30'),
					 (13, 8,  1, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), '15:00'),
					 (14, 10, 1, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), '17:45'),
					 (15, 17, 1, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), '20:30'),
					 (16, 26, 2, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), '15:00'),
					 (17, 30, 2, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), '17:45'),
					 (18, 38, 2, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), '20:30'),
					 (19, 51, 3, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), '15:00'),
					 (20, 8,  3, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), '17:45'),
					 (21, 10, 3, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), '20:30'),
					 (22, 17, 4, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), '15:00'),
					 (23, 26, 4, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), '17:45'),
					 (24, 30, 4, CAST(DATEADD(DAY, -1, GETDATE()) AS DATE), '20:30'),
					 (25, 8,  1, CAST(GETDATE() AS DATE), '15:00'),
					 (26, 10, 1, CAST(GETDATE() AS DATE), '17:45'),
					 (27, 17, 1, CAST(GETDATE() AS DATE), '20:30'),
					 (28, 26, 2, CAST(GETDATE() AS DATE), '15:00'),
					 (29, 30, 2, CAST(GETDATE() AS DATE), '17:45'),
					 (30, 38, 2, CAST(GETDATE() AS DATE), '20:30'),
					 (31, 51, 3, CAST(GETDATE() AS DATE), '15:00'),
					 (32, 8,  3, CAST(GETDATE() AS DATE), '17:45'),
					 (33, 10, 3, CAST(GETDATE() AS DATE), '20:30'),
					 (34, 17, 4, CAST(GETDATE() AS DATE), '15:00'),
					 (35, 26, 4, CAST(GETDATE() AS DATE), '17:45'),
					 (36, 30, 4, CAST(GETDATE() AS DATE), '20:30')
GO

-- Consultar la Tabla Funciones
SELECT * FROM Funciones
GO




-- Insertar registro en la Tabla Promociones
INSERT INTO Promociones(promocionID, codigo, descuento, fechaInicio, horaInicio, fechaFin, horaFin)
VALUES(1, 'Ninguno', 0, '2000-01-01', '00:00', '2199-01-01', '23:59'),
	  (2, 'DSCTO', 10, CAST(GETDATE() AS DATE), '00:00', CAST(GETDATE() AS DATE), '23:59'),
	  (3, 'CINE', 12, CAST(DATEADD(DAY, +7, GETDATE()) AS DATE), '00:00', 
					  CAST(DATEADD(DAY, +9, GETDATE()) AS DATE), '23:59')
GO

-- Consultar la Tabla Promociones
SELECT * FROM Promociones
GO




-- Crear el Trigger DML TG_Entrada
CREATE OR ALTER TRIGGER TG_Entrada
ON Entradas
AFTER INSERT
AS
	SET NOCOUNT ON;

	DECLARE @entradaID	INT
	DECLARE @desct		DECIMAL(10, 2)
	DECLARE @total		DECIMAL(10, 2)

	SET @entradaID = (SELECT entradaID FROM inserted);

	SET @desct = (SELECT P.descuento 
				  FROM inserted AS I INNER JOIN Promociones AS P
				  ON I.promocionID = P.promocionID);
	SET @total = (SELECT precio - @desct FROM inserted);


	UPDATE	Entradas
	SET		total = @total
	WHERE	entradaID = @entradaID

GO




-- Crear el Procedimiento Almacenado para Insertar Entradas
CREATE OR ALTER PROCEDURE SP_InsertarEntrada
(
	@empleadoID		INT,
	@promocionID	INT,
	@funcionID		INT,
	@asientoID		INT
)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO Entradas(empleadoID, promocionID, funcionID)
				  VALUES(@empleadoID, @promocionID, @funcionID);


	DECLARE @maxEntradaID	INT
	SET @maxEntradaID = ( SELECT MAX(entradaID) FROM Entradas );

	INSERT INTO Reservas(entradaID, asientoID)--PARA LA ENTRADA INSERTADA EL ASIENTO YA SE ENCUENTRA OCUPADO 
				  VALUES(@maxEntradaID, @asientoID);

END
GO


-- Insertar registro en la Tabla Entradas y Reservas
EXECUTE SP_InsertarEntrada 2, 1, 28, 25
GO


-- Consultar las Tablas Entradas y Reservas
SELECT * FROM Entradas;
SELECT * FROM Reservas;
GO




-- Insertar mas registros en la Tabla Entradas y Reservas
EXECUTE SP_InsertarEntrada 2, 1, 28, 26;
GO

EXECUTE SP_InsertarEntrada 3, 2, 30, 25;
GO

EXECUTE SP_InsertarEntrada 3, 2, 30, 26;
GO

EXECUTE SP_InsertarEntrada 3, 3, 34, 65;
GO

EXECUTE SP_InsertarEntrada 3, 3, 34, 66;
GO

EXECUTE SP_InsertarEntrada 3, 3, 34, 70;
GO

EXECUTE SP_InsertarEntrada 3, 3, 34, 71;
GO

EXECUTE SP_InsertarEntrada 3, 3, 34, 72;
GO

EXECUTE SP_InsertarEntrada 2, 2, 31, 41;
GO

EXECUTE SP_InsertarEntrada 2, 2, 31, 55;
GO

EXECUTE SP_InsertarEntrada 2, 2, 31, 56;
GO

EXECUTE SP_InsertarEntrada 2, 1, 31, 59;
GO

EXECUTE SP_InsertarEntrada 2, 1, 31, 60;
GO

EXECUTE SP_InsertarEntrada 3, 2, 30, 31;
GO



-- Reporte de las entradas vendidas en el Día de hoy
SELECT E.entradaID, E.precio, P.descuento, E.total, 
		Em.nombre, Em.paterno, Em.materno, C.tipo Cargo,
		Pe.titulo, Pe.tiempoDuracion, F.fecha, F.hora, 
		S.numero, S.capacidad, S.tipo, A.asiento, R.estado
FROM Entradas E JOIN Promociones P ON E.promocionID = P.promocionID
				JOIN Empleados Em ON EM.empleadoID = E.empleadoID
				JOIN Cargos C ON Em.cargoID = C.cargoID
				JOIN Funciones F ON E.funcionID = F.funcionID
				JOIN Peliculas Pe ON F.peliculaID = Pe.peliculaID
				JOIN Salas S ON F.salaID = S.salaID
				JOIN Asientos A ON A.salaID = S.salaID
				JOIN Reservas R ON (R.asientoID = A.asientoID AND
									R.entradaID = E.entradaID)
WHERE E.fechaCompra = CAST(GETDATE() AS DATE )
GO


--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



