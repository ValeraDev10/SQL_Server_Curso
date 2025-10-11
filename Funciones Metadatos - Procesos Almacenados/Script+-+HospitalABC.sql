-- NOS UBICAMOS EN LA BASE DE DATOS MASTER
USE master
GO


-- VALIDAR SI LA BASE DE DATOS EXISTE
--		IS NOT NULL
--IF DB_ID('HospitalABC') IS NOT NULL
--BEGIN
--	DROP DATABASE HospitalABC
--END
--GO

--		EXISTS
--IF EXISTS( SELECT name FROM sys.sysdatabases WHERE name = 'HospitalABC' )
--BEGIN
--	DROP DATABASE HospitalABC
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

-- AGREGAR LA RESTRICCIÓN NOT NULL
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

-- AGREGAR LA RESTRICCIÓN UNIQUE
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

-- AGREGAR LA RESTRICCIÓN PRIMARY KEY
--		TABLA Medicos
ALTER TABLE Medicos
ADD PRIMARY KEY (idMedico) --Nombre generado por MS-SQL Server
GO

--		TABLA Pacientes
ALTER TABLE Pacientes
ADD CONSTRAINT PK_idPaciente PRIMARY KEY (idPaciente) --Nombre generedo por nosotros
GO


-- AGREGAR LA RESTRICCIÓN CHECK
ALTER TABLE Pacientes
ADD CONSTRAINT CHK_edad CHECK( edad >= 1 AND edad < = 100 ) --Nombre generedo por nosotros
GO

--		Crear Función para validar el Email
CREATE FUNCTION fn_validar_email
(
    @Email varchar(50) --Parámetro email
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

--		Agregar restricción de la función creada
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

--		Agregar restricción FOREIGN KEY
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

--		Agregar restricción DEFAULT
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