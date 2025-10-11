

--FUNCIONES DE METADATOS
--Son funciones escalares que devuelven información sobre objetos de la base de datos 
--(tablas, vistas, procedimientos, columnas, etc.). No son deterministas, 
--lo que significa que pueden devolver resultados distintos según el contexto

--Principales funciones de metadatos
 
--OBJECT_NAME(id) Devuelve el nombre del objeto según su ID.
--OBJECT_SCHEMA_NAME(id) Devuelve el nombre del esquema de un objeto.
--OBJECTPROPERTYEX(id, propiedad) Devuelve propiedades específicas de un objeto (ej. si tiene ANSI_NULLS activado)
--COLUMNPROPERTY(id, columna, propiedad) Devuelve información sobre una columna (ej. si permite NULLs).
--DATABASEPROPERTYEX(nombre, propiedad) Devuelve propiedades de una base de datos (ej. si está en modo de recuperación completa)
--DB_ID(nombre) Devuelve el ID de una base de datos.
--DB_NAME(id) Devuelve el nombre de una base de datos según su ID.

--Estas funciones te permiten evitar joins innecesarios con vistas del sistema y 
--escribir consultas más limpias y eficientes



--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




--RESTRICCIONES
--Las restricciones en SQL Server son reglas que se aplican a columnas o 
--tablas para garantizar la integridad de los datos

--Tipos principales de restricciones en SQL Server

--ID INT PRIMARY KEY Identifica de forma única cada fila. No permite valores NULL ni duplicados.
--FOREIGN KEY (DeptID) REFERENCES Departamentos(ID) Enlaza una columna con la clave primaria de otra tabla.
--Email VARCHAR(100) UNIQUE Asegura que los valores en una columna sean únicos.
--Nombre VARCHAR(50) NOT NULL Obliga a que una columna siempre tenga un valor.
--Edad INT CHECK (Edad >= 18) Valida que los datos cumplan una condición lógica.
--FechaRegistro DATETIME DEFAULT GETDATE() Asigna un valor por defecto si no se especifica uno

--Tips para entrevistas y práctica
-- Usa ALTER TABLE para agregar restricciones después de crear la tabla.
-- Las restricciones pueden ser a nivel de columna o a nivel de tabla.
-- En SQL Server, puedes ver las restricciones existentes con INFORMATION_SCHEMA.TABLE_CONSTRAINTS


--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- NOS UBICAMOS EN LA BASE DE DATOS MASTER
USE master
GO

-- VALIDAR SI LA BASE DE DATOS EXISTE

--		IS NOT NULL
--IF DB_ID('HospitalABC') IS NOT NULL
--BEGIN
	--DROP DATABASE HospitalABC
--END
--GO

--		EXISTS
--IF EXISTS( SELECT name FROM sys.sysdatabases WHERE name = 'HospitalABC' )
--BEGIN
	--DROP DATABASE HospitalABC
--END
--GO

--		DROP DATABASE IF EXISTS
DROP DATABASE IF EXISTS HospitalABC
GO


-- CREAR LA BASE DE DATOS HospitalABC
CREATE DATABASE HospitalABC
ON
(
	NAME = HospitalABC_dat,
	FILENAME = 'C:\Master en SQL Server\HospitalABC_dat.mdf',
	SIZE = 10MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5MB
)
LOG ON
(
	NAME = HospitalABC_log,
	FILENAME = 'C:\Master en SQL Server\HospitalABC_log.ldf',
	SIZE = 10MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5MB
)
GO


-- USAR LA BASE DE DATOS HospitalABC
USE HospitalABC
GO


-- VALIDAR SI LA TABLA EXISTE
--		IS NOT NULL
--IF OBJECT_ID('Medicos') IS NOT NULL
--BEGIN
--	DROP TABLE Medicos
--END
--GO

--		EXISTS
--IF EXISTS (SELECT name from sys.tables WHERE name = 'Medicos')
--BEGIN
--	DROP TABLE Medicos
--END
--GO

--		DROP TABLE IF EXISTS
DROP TABLE IF EXISTS Medicos
GO


-- TABLA Medicos
CREATE TABLE Medicos(
    idMedico		INT IDENTITY(1,1),
    nombre			VARCHAR(40) NOT NULL,
    apellido		VARCHAR(40) NOT NULL,
    especialidad	VARCHAR(30),
    telefono		CHAR(9) CHECK( LEN( telefono ) = 9 ), --Nombre generado por MS-SQL Server
    email			VARCHAR(50)
)
GO

-- AGREGAR LA RESTRICCION NOT NULL
ALTER TABLE Medicos
ALTER COLUMN especialidad VARCHAR(30) NOT NULL
GO


-- TABLA Pacientes
--		DROP TABLE IF EXISTS
DROP TABLE IF EXISTS Pacientes
GO

CREATE TABLE Pacientes(
    idPaciente		INT IDENTITY(1,1),
    nombre			VARCHAR(40) NOT NULL,
    apellido		VARCHAR(40) NOT NULL,
    edad			TINYINT		NOT NULL,
    genero			CHAR(1)		NOT NULL,
    direccion		VARCHAR(100),
    telefono		CHAR(9)		UNIQUE NOT NULL,
    email			VARCHAR(50),
	CONSTRAINT CHK_telefono CHECK( LEN( telefono ) = 9 ) --Nombre generedo por nosotros
)
GO

-- AGREGAR LA RESTRICCI N UNIQUE
--		TABLA Medicos
ALTER TABLE Medicos
ADD UNIQUE (telefono) --Nombre generado por MS-SQL Server
GO

ALTER TABLE Medicos
ADD CONSTRAINT UQ_Med_email UNIQUE (email)  --Nombre generedo por nosotros
GO

--		TABLA Pacientes
ALTER TABLE Pacientes
ADD CONSTRAINT UQ_Pac_email UNIQUE (email) --Nombre generedo por nosotros
GO


-- TABLA Medicamentos
--		DROP TABLE IF EXISTS
DROP TABLE IF EXISTS Medicamentos
GO

CREATE TABLE Medicamentos(
    idMedicamento	INT PRIMARY KEY,
    nombre			VARCHAR(40) NOT NULL,
    descripcion		VARCHAR(255)
)
GO

-- AGREGAR LA RESTRICCI N PRIMARY KEY
--		TABLA Medicos
ALTER TABLE Medicos
ADD PRIMARY KEY (idMedico) --Nombre generado por MS-SQL Server
GO

--		TABLA Pacientes
ALTER TABLE Pacientes
ADD CONSTRAINT PK_idPaciente PRIMARY KEY (idPaciente) --Nombre generedo por nosotros
GO


-- AGREGAR LA RESTRICCI N CHECK
ALTER TABLE Pacientes
ADD CONSTRAINT CHK_edad CHECK( edad >= 1 AND edad < = 100 ) --Nombre generedo por nosotros
GO

--		Crear Funci n para validar el Email
CREATE FUNCTION fn_validar_email
(
    @Email varchar(50) --Par metro email
)
RETURNS bit
AS
BEGIN
    DECLARE @valid bit = 0
    
    IF @Email LIKE '%_@__%.__%'  
        SET @valid = 1
    
    RETURN @valid
END
GO

--		Validar si el email esta escrito correctamente
SELECT dbo.fn_validar_email('hugo.perez@example') GO --Incorrecto

SELECT dbo.fn_validar_email('hugo.perezexample.com') GO --Incorrecto

SELECT dbo.fn_validar_email('hugo.perez@example.com') GO --Correcto

--		Agregar restricciOn de la funciOn creada
ALTER TABLE Medicos
ADD CONSTRAINT CHK_Med_email CHECK( dbo.fn_validar_email( email ) = 1 )
GO

ALTER TABLE Pacientes
ADD CONSTRAINT CHK_Pac_email CHECK( dbo.fn_validar_email( email ) = 1 )
GO



-- TABLA Citas
--		DROP TABLE IF EXISTS
DROP TABLE IF EXISTS Citas
GO

CREATE TABLE Citas(
    idCita			INT PRIMARY KEY IDENTITY(1,1),
    idMedico		INT NOT NULL,
    idPaciente		INT NOT NULL,
    fechaHora		DATETIME NOT NULL,
    motivo			VARCHAR(255),
	FOREIGN KEY (idMedico) REFERENCES Medicos(idMedico) --Nombre generado por MS-SQL Server
							ON UPDATE CASCADE
							ON DELETE CASCADE
)
GO

--		Agregar restriccion FOREIGN KEY
ALTER TABLE Citas
ADD CONSTRAINT FK_idPaciente --Nombre generedo por nosotros
FOREIGN KEY (idPaciente) REFERENCES Pacientes(idPaciente)
						ON UPDATE CASCADE
						ON DELETE CASCADE
GO



-- TABLA HistorialesMedicos
--		DROP TABLE IF EXISTS
DROP TABLE IF EXISTS HistorialesMedicos
GO

CREATE TABLE HistorialesMedicos(
    idHistorial		INT PRIMARY KEY IDENTITY(1,1),
    idMedico		INT NOT NULL,
    idPaciente		INT NOT NULL,
    fecha			DATETIME NOT NULL, --DEFAULT GETDATE()
    diagnostico		VARCHAR(255),
    tratamiento		VARCHAR(255),
	FOREIGN KEY (idMedico) REFERENCES Medicos(idMedico)
							ON UPDATE CASCADE
							ON DELETE CASCADE,
    FOREIGN KEY (idPaciente) REFERENCES Pacientes(idPaciente)
							ON UPDATE CASCADE
							ON DELETE CASCADE
)
GO

--		Agregar restriccion DEFAULT
ALTER TABLE HistorialesMedicos
ADD CONSTRAINT DF_fecha
DEFAULT GETDATE() FOR fecha
GO



-- TABLA Prescripciones
--		DROP TABLE IF EXISTS
DROP TABLE IF EXISTS Prescripciones
GO

CREATE TABLE Prescripciones(
    idPrescripcion	INT PRIMARY KEY IDENTITY(1,1),
    idHistorial		INT NOT NULL,
    idMedicamento	INT NOT NULL,
    dosis			VARCHAR(50),
    duracion		VARCHAR(50),
    FOREIGN KEY (idHistorial) REFERENCES HistorialesMedicos(idHistorial)
								ON UPDATE CASCADE
								ON DELETE CASCADE,
    FOREIGN KEY (idMedicamento) REFERENCES Medicamentos(idMedicamento)
								ON UPDATE CASCADE
								ON DELETE CASCADE
)
GO


--PRUEBAS DE IMPLEMENTACIÓN

--------------------------------------------
--    Usar la Base de Datos HospitalABC    --
--------------------------------------------
USE HospitalABC
GO



/********************************************
	TABLA Medicos - Restricción NOT NULL
*********************************************/
--Insertar un Médico sin ningún error
INSERT INTO Medicos (nombre, apellido, especialidad, telefono, email)
			 VALUES ('Carlos', 'Martinez', 'Cardiología', '999999999', 'carlos.ma@example.com');


--Restricción NOT NULL - Columna "apellido"
INSERT INTO Medicos (nombre, apellido, especialidad, telefono, email)
			 VALUES ('Ana', NULL, 'Pediatría', '999990000', 'ana.lopez@example.com');


--Corregir Restricción NOT NULL - Columna "apellido"
INSERT INTO Medicos (nombre, apellido, especialidad, telefono, email)
			 VALUES ('Ana', 'Lopez', 'Pediatría', '999990000', 'ana.lopez@example.com');


--Consultar la Tabla Medicos
SELECT * FROM Medicos;







/********************************************
	TABLA Pacientes - Restricción UNIQUE
*********************************************/
--Insertar un Paciente sin ningún error
INSERT INTO Pacientes (nombre, apellido, edad, genero, direccion, telefono, email)
				VALUES('Juan', 'Perez', 30, 'M', 'Calle Argentina 123', '999998888', 'juan.p@example.com');


--Restricción UNIQUE - Columna "email"
INSERT INTO Pacientes (nombre, apellido, edad, genero, direccion, telefono, email)
				VALUES('Juan', 'Pirlo', 22, 'M', 'Calle Brazil 123', '999997777', 'juan.p@example.com');


--Corregir Restricción UNIQUE - Columna "email"
INSERT INTO Pacientes (nombre, apellido, edad, genero, direccion, telefono, email)
				VALUES('Juan', 'Pirlo', 22, 'M', 'Calle Brazil 123', '999997777', 'juan.pirlo@example.com');


--Consultar la Tabla Pacientes
SELECT * FROM Pacientes;







/****************************************************
	TABLA Medicamentos - Restricción PRIMARY KEY
*****************************************************/
--Insertar un Medicamento sin ningún error
 INSERT INTO Medicamentos (idMedicamento, nombre, descripcion)
					VALUES(1, 'Paracetamol', 'Analgésico y antipirético');


--Restricción PRIMARY KEY - Columna "idMedicamento"
 INSERT INTO Medicamentos (idMedicamento, nombre, descripcion)
					VALUES(1, 'Amoxicilina', 'Antibiótico');


--Restricción PRIMARY KEY - Columna "idMedicamento" como NULL
 INSERT INTO Medicamentos (idMedicamento, nombre, descripcion)
					VALUES(NULL, 'Amoxicilina', 'Antibiótico');


--Corregir Restricción PRIMARY KEY - Columna "idMedicamento"
 INSERT INTO Medicamentos (idMedicamento, nombre, descripcion)
					VALUES(2, 'Amoxicilina', 'Antibiótico'),
						  (3, 'Ibuprofeno', 'Antiinflamatorio no esteroideo'),
						  (4, 'Aspirina', 'Analgésico y antiinflamatorio'),
						  (5, 'Clonazepam', 'Benzodiacepina'),
						  (6, 'Metformina', 'Antidiabético');


--Consultar la Tabla Medicamentos
SELECT * FROM Medicamentos;







/****************************************************
	TABLA Pacientes - Restricción CHECK
*****************************************************/
--Insertar un Pacientes sin ningún error
INSERT INTO Pacientes (nombre, apellido, edad, genero, direccion, telefono, email)
VALUES('Elena', 'Ruiz', 37, 'F', 'Avenida Nebulosa 147', '999996666', 'elena.r@example.com');


--Restricción CHECK - Columna "email"
--		No termina con un punto al final
INSERT INTO Pacientes (nombre, apellido, edad, genero, direccion, telefono, email)
VALUES('Sara', 'Ortiz', 28, 'F', 'Avenida Estrella 369', '999995555', 'sara.o@examplecom');


--		No contiene un @ en el correo
INSERT INTO Pacientes (nombre, apellido, edad, genero, direccion, telefono, email)
VALUES('Sara', 'Ortiz', 28, 'F', 'Avenida Estrella 369', '999995555', 'sara.oexample.com');


--Corregir Restricción CHECK - Columna "email"
INSERT INTO Pacientes (nombre, apellido, edad, genero, direccion, telefono, email)
VALUES('Sara', 'Ortiz', 28, 'F', 'Avenida Estrella 369', '999995555', 'sara.o@example.com');


--Restricción CHECK - Columna "edad"
--		valor fuera del rango
INSERT INTO Pacientes (nombre, apellido, edad, genero, direccion, telefono, email)
VALUES('David', 'Morales', 142, 'M', 'Calle Planeta 258', '999994444', 'david.mo@example.com');


--Corregir Restricción CHECK - Columna "edad"
INSERT INTO Pacientes (nombre, apellido, edad, genero, direccion, telefono, email)
VALUES('David', 'Morales', 42, 'M', 'Calle Planeta 258', '999994444', 'david.mo@example.com');


--Consultar la Tabla Medicamentos
SELECT * FROM Pacientes;







/****************************************************
	TABLA Citas - Restricción FOREIGN KEY
*****************************************************/
--Consultar las Tabas Medicos y Pacientes
SELECT * FROM Medicos;
SELECT * FROM Pacientes;
GO


--Insertar una Cita sin ningún error
INSERT INTO Citas (idMedico, idPaciente, fechaHora, motivo)
			VALUES(1, 1, '2024-09-01 09:00', 'Dolor de rodilla');


--Restricción FOREIGN KEY - Columna "idPaciente"
--		El idPaciente no puede tener un valor NULL
INSERT INTO Citas (idMedico, idPaciente, fechaHora, motivo)
			VALUES(3, NULL, '2024-09-10 09:00', 'Consulta pediátrica');


--		El idPaciente no existe en la Tabla Paciente
INSERT INTO Citas (idMedico, idPaciente, fechaHora, motivo)
			VALUES(3, 100, '2024-09-10 09:00', 'Consulta pediátrica');


--Corregir Restricción FOREIGN KEY - Columna "idPaciente"
INSERT INTO Citas (idMedico, idPaciente, fechaHora, motivo)
			VALUES(3, 3, '2024-09-10 09:00', 'Consulta pediátrica');


--Consultar las Tablas Medicos, Pacientes y Medicamentos
SELECT * FROM Medicos;
SELECT * FROM Pacientes;
SELECT * FROM Citas;
GO







/****************************************************
	TABLA HistorialesMedicos - Restricción DEFAULT
*****************************************************/
--Consultar las Tabas Medicos y Pacientes
SELECT * FROM Medicos;
SELECT * FROM Pacientes;
GO


--Insertar un HistorialesMedicos sin ningún error
--		La columna fecha se Insertar por Defecto
INSERT INTO HistorialesMedicos (idMedico, idPaciente, diagnostico, tratamiento)
			VALUES(1, 1, 'Tendinitis', 'Fisioterapia');


--		Insertar un valor manual en La columna fecha
INSERT INTO HistorialesMedicos (idMedico, idPaciente, fecha, diagnostico, tratamiento)
			VALUES(3, 3, '2024-09-10 08:55', 'Resfriado común', 'Reposo y líquidos');



--Consultar las Tablas Medicos, Pacientes e HistorialesMedicos
SELECT * FROM Medicos;
SELECT * FROM Pacientes;
SELECT * FROM HistorialesMedicos;
GO







/****************************************************
	TABLA Prescripciones
*****************************************************/
--Insertar Prescripciones sin ningún error
INSERT INTO Prescripciones(idHistorial, idMedicamento, dosis, duracion)
					VALUES(1, 1,'850 mg', '60 días'),
						  (2, 6,'500 mg', '5 días');


--Consultar las Tablas Pacientes, HistorialesMedicos, Prescripciones y Medicamentos
SELECT * FROM Pacientes;
SELECT * FROM HistorialesMedicos;
SELECT * FROM Prescripciones;
SELECT * FROM Medicamentos;
GO
