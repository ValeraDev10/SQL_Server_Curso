
--CREAR BASE DE DATOS

CREATE DATABASE testDB
GO



CREATE DATABASE EmpresaX
ON
(
	NAME = EmpresaX_dat,
	FILENAME ='C:\Master en SQL Server\EmpresaX_dat.mdf',
	SIZE = 10MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5MB
)
LOG ON
(
	NAME = EmpresaX_Log,
	FILENAME ='C:\Master en SQL Server\EmpresaX_log.ldf',
	SIZE = 10MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5MB
)
GO

--ESQUEMAS

USE EmpresaX;
GO

CREATE SCHEMA Persona
GO

CREATE SCHEMA Servicio
GO

CREATE SCHEMA Propiedad
GO

--RECOMENDACIONES
--PRIMERO TABLAS PRICIPALES LUEGO SECUNDARIAS FINALMENTE LAS TABLAS QUE RELACIONAN 2 TABLAS

--CREAR TABLA EMPLEADOS DENTRO DEL ESQUEMA Persona

CREATE TABLE Persona.Empleados(
		nombre		VARCHAR(100),
		apellido	VARCHAR(50),
		cargo		VARCHAR(50),
		telefono	VARCHAR(50),
		email		VARCHAR(50)
)
GO

--ELIMINANDO COLUMNA DE LA TABLA


ALTER TABLE Persona.Empleados
DROP COLUMN email
GO


--MODIFICAR EL TIPO DE DATO DE UNA COLUMNA

ALTER TABLE Persona.Empleados
ALTER COLUMN nombre VARCHAR(50)
GO

--AGREGAR CAMPO O COLUMNA A UNA TABLA

ALTER TABLE Persona.Empleados
ADD idEmpleado INT NOT NULL
GO

--ESTABLECER CAMPO O COLUMNA COMO PRIMARY KEY DE UNA TABLA
--UNA PRIMARY KEY NO DEBE ACEPTAR VALORES NULOS

ALTER TABLE Persona.Empleados
ADD PRIMARY KEY (idEmpleado)
GO

--ESTABLECER PROPIEDAD IDENTITY A UN CAMPO O COLUMNA

ALTER TABLE Persona.Empleados
DROP COLUMN idEmpleado
GO--ERROR DE PRIMARY KEY - NO DEJA ELIMINAR LA COLUMNA

ALTER TABLE Persona.Empleados
DROP CONSTRAINT PK__Empleado__5295297CA485F048
GO

--ES POSIBLE ELIMINAR LA COLUMNA

ALTER TABLE Persona.Empleados
DROP COLUMN idEmpleado
GO

--ESTABLECER PROPIEDAD IDENTITY

ALTER TABLE Persona.Empleados
ADD idEmpleado INT IDENTITY(1,1) PRIMARY KEY
GO

--CREAR TABLA PARTE 2

CREATE TABLE Persona.Cliente(
		idCliente		INT PRIMARY KEY IDENTITY(1,1),--NOT NULL
		nombre			VARCHAR(50), --NULL
		apellido_p		VARCHAR(50),
		apellido_m		VARCHAR(50),
		telefono		VARCHAR(50),
		email			VARCHAR(50)

)
GO
-- SEGUNDA OPCION
CREATE TABLE Persona.Cliente(
		idCliente		INT IDENTITY(1,1),--NOT NULL
		nombre			VARCHAR(50), --NULL
		apellido_p		VARCHAR(50),
		apellido_m		VARCHAR(50),
		telefono		VARCHAR(50),
		email			VARCHAR(50)
		PRIMARY KEY (idCliente)
)
GO

--EJERCICIO CREAR TABLA - PARTE 3


CREATE TABLE Persona.Propietarios(
		idPropietario	INT IDENTITY(1,1),--NOT NULL
		nombre			VARCHAR(50), --NULL
		apellido_p		VARCHAR(50),
		apellido_m		VARCHAR(50),
		direccion		VARCHAR(50),
		telefono		VARCHAR(50),
		email			VARCHAR(50)
		PRIMARY KEY (idPropietario)
)
GO


--DESCRIPCION FOREIGN KEY

----------------------------------------
--	UTILIZAR LA BASE DE DATOS tempdb --
----------------------------------------
USE tempdb;


---------------------------------
--	CREAR LA TABLA PROFESORES  --
---------------------------------
CREATE TABLE PROFESORES
(
   dni 		INT PRIMARY KEY ,
   nombre 	VARCHAR(40),
   paterno 	VARCHAR(20),
   materno 	VARCHAR(20),
   email 	VARCHAR(40),
   edad 	INT
);

-----------------------------
--	CREAR LA TABLA CURSOS  --
-----------------------------
CREATE TABLE CURSOS
(
	cod_cur	INT PRIMARY KEY ,
	dni 	INT FOREIGN KEY REFERENCES PROFESORES(dni),
	nombre 	VARCHAR(40)
);


----------------------------------------------
--	INSERTAR VALORES A LA TABLA PROFESORES  --
----------------------------------------------
INSERT INTO PROFESORES VALUES(99999999, 'FERNANDA', 'TORRES', 'GUILLEN', 'f.torres@example.com', 25);
INSERT INTO PROFESORES VALUES(88888888, 'LUISA', 'PEREZ', 'GARCIA', 'l.perez@example.com', NULL);
INSERT INTO PROFESORES VALUES(77777777, 'FATIMA', 'TORRES', 'GALLEGOS', 'f.torresg@example.com', 30);


------------------------------------------
--	INSERTAR VALORES A LA TABLA CURSOS  --
------------------------------------------
INSERT INTO CURSOS VALUES(1, 99999999, 'REDES');
INSERT INTO CURSOS VALUES(2, 99999999, 'ALGEBRA');
INSERT INTO CURSOS VALUES(3, 88888888, 'PROGRAMACI N');
INSERT INTO CURSOS VALUES(4, 77777777, 'SQL SERVER');


------------------------------------------------
--	CONSULTAR LAS TABLAS PROFESORES Y CURSOS  --
------------------------------------------------
SELECT * FROM PROFESORES;

SELECT * FROM CURSOS;

------------------------------------------------------------------------------------------
--	INSERTAR UN VALOR A LA TABLA CURSOS QUE NO ESTA RELACIONADA CON LA TABLA PRINCIPAL  --
------------------------------------------------------------------------------------------
INSERT INTO CURSOS VALUES(5, 55555555, 'CLOUD COMPUTING');


----------------------------------------
--	ACTUALIZAR EL DNI DE UN PROFESOR  --
----------------------------------------
UPDATE PROFESORES
SET dni = 22222222
WHERE dni = 99999999


----------------------------
--	ELIMINAR UN PROFESOR  --
----------------------------
DELETE FROM PROFESORES
WHERE dni = 77777777;


--ORDEN DE ELIMINACION PARA NOM GENERAR ERRORES

-------------------------
--	ELIMINAR UN CURSO  --
-------------------------
DELETE FROM CURSOS
WHERE cod_cur = 4;

----------------------------
--	ELIMINAR UN PROFESOR  --
----------------------------
DELETE FROM PROFESORES
WHERE dni = 77777777;



--FOREIGN KEY - NO ACCTION


----------------------------------------
--	UTILIZAR LA BASE DE DATOS tempdb --
----------------------------------------
USE tempdb;


--------------------------------------------
--	ELIMINAR LA TABLA CURSOS Y PROFESORES --
--------------------------------------------
DROP TABLE CURSOS;

DROP TABLE PROFESORES;


---------------------------------
--	CREAR LA TABLA PROFESORES  --
---------------------------------
CREATE TABLE PROFESORES
(
   dni 		INT PRIMARY KEY ,
   nombre 	VARCHAR(40),
   paterno 	VARCHAR(20),
   materno 	VARCHAR(20),
   email 	VARCHAR(40),
   edad 	INT
);


-----------------------------
--	CREAR LA TABLA CURSOS  --
-----------------------------
CREATE TABLE CURSOS
(
	cod_cur	INT PRIMARY KEY ,
	dni 	INT FOREIGN KEY REFERENCES PROFESORES(dni)
			ON UPDATE NO ACTION
			ON DELETE NO ACTION,
	nombre 	VARCHAR(40)  NOT NULL
);


----------------------------------------------
--	INSERTAR VALORES A LA TABLA PROFESORES  --
----------------------------------------------
INSERT INTO PROFESORES VALUES(99999999, 'FERNANDA', 'TORRES', 'GUILLEN', 'f.torres@example.com', 25);
INSERT INTO PROFESORES VALUES(88888888, 'LUISA', 'PEREZ', 'GARCIA', 'l.perez@example.com', NULL);
INSERT INTO PROFESORES VALUES(77777777, 'FATIMA', 'TORRES', 'GALLEGOS', 'f.torresg@example.com', 30);


------------------------------------------
--	INSERTAR VALORES A LA TABLA CURSOS  --
------------------------------------------
INSERT INTO CURSOS VALUES(1, 99999999, 'REDES');
INSERT INTO CURSOS VALUES(2, 99999999, 'ALGEBRA');
INSERT INTO CURSOS VALUES(3, 88888888, 'PROGRAMACI N');
INSERT INTO CURSOS VALUES(4, 77777777, 'SQL SERVER');


------------------------------------------------
--	CONSULTAR LAS TABLAS PROFESORES Y CURSOS  --
------------------------------------------------
SELECT * FROM PROFESORES;

SELECT * FROM CURSOS;


------------------------------------------------------------------------------------------
--	INSERTAR UN VALOR A LA TABLA CURSOS QUE NO ESTA RELACIONADA CON LA TABLA PRINCIPAL  --
------------------------------------------------------------------------------------------
INSERT INTO CURSOS VALUES(5, 55555555, 'CLOUD COMPUTING');


------------------------------------------------
--	CONSULTAR LAS TABLAS PROFESORES Y CURSOS  --
------------------------------------------------
SELECT * FROM PROFESORES;

SELECT * FROM CURSOS;


----------------------------------------
--	ACTUALIZAR EL DNI DE UN PROFESOR  --
----------------------------------------
UPDATE PROFESORES
SET dni = 22222222
WHERE dni = 99999999

----------------------------
--	ELIMINAR UN PROFESOR  --
----------------------------
DELETE FROM PROFESORES
WHERE dni = 77777777;


------------------------------------------------
--	CONSULTAR LAS TABLAS PROFESORES Y CURSOS  --
------------------------------------------------
SELECT * FROM PROFESORES;

SELECT * FROM CURSOS;



--FOREIGN KEY CASCADE


----------------------------------------
--	UTILIZAR LA BASE DE DATOS tempdb --
----------------------------------------
USE tempdb;


--------------------------------------------
--	ELIMINAR LA TABLA CURSOS Y PROFESORES --
--------------------------------------------
DROP TABLE CURSOS;

DROP TABLE PROFESORES;


---------------------------------
--	CREAR LA TABLA PROFESORES  --
---------------------------------
CREATE TABLE PROFESORES
(
   dni 		INT PRIMARY KEY ,
   nombre 	VARCHAR(40),
   paterno 	VARCHAR(20),
   materno 	VARCHAR(20),
   email 	VARCHAR(40),
   edad 	INT
);


-----------------------------
--	CREAR LA TABLA CURSOS  --
-----------------------------
CREATE TABLE CURSOS
(
	cod_cur	INT PRIMARY KEY ,
	dni 	INT FOREIGN KEY REFERENCES PROFESORES(dni)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
	nombre 	VARCHAR(40)  NOT NULL
);


----------------------------------------------
--	INSERTAR VALORES A LA TABLA PROFESORES  --
----------------------------------------------
INSERT INTO PROFESORES VALUES(99999999, 'FERNANDA', 'TORRES', 'GUILLEN', 'f.torres@example.com', 25);
INSERT INTO PROFESORES VALUES(88888888, 'LUISA', 'PEREZ', 'GARCIA', 'l.perez@example.com', NULL);
INSERT INTO PROFESORES VALUES(77777777, 'FATIMA', 'TORRES', 'GALLEGOS', 'f.torresg@example.com', 30);


------------------------------------------
--	INSERTAR VALORES A LA TABLA CURSOS  --
------------------------------------------
INSERT INTO CURSOS VALUES(1, 99999999, 'REDES');
INSERT INTO CURSOS VALUES(2, 99999999, 'ALGEBRA');
INSERT INTO CURSOS VALUES(3, 88888888, 'PROGRAMACI N');
INSERT INTO CURSOS VALUES(4, 77777777, 'SQL SERVER');


------------------------------------------------
--	CONSULTAR LAS TABLAS PROFESORES Y CURSOS  --
------------------------------------------------
SELECT * FROM PROFESORES;

SELECT * FROM CURSOS;


----------------------------------------
--	ACTUALIZAR EL DNI DE UN PROFESOR  --
----------------------------------------
UPDATE PROFESORES
SET dni = '22222222'
WHERE dni = '99999999'


------------------------------------------------
--	CONSULTAR LAS TABLAS PROFESORES Y CURSOS  --
------------------------------------------------
SELECT * FROM PROFESORES;

SELECT * FROM CURSOS;


----------------------------
--	ELIMINAR UN PROFESOR  --
----------------------------
DELETE FROM PROFESORES
WHERE dni = '77777777';


------------------------------------------------
--	CONSULTAR LAS TABLAS PROFESORES Y CURSOS  --
------------------------------------------------
SELECT * FROM PROFESORES;

SELECT * FROM CURSOS;



--FOREIGN KEY SET NULL


----------------------------------------
--	UTILIZAR LA BASE DE DATOS tempdb --
----------------------------------------
USE tempdb;


--------------------------------------------
--	ELIMINAR LA TABLA CURSOS Y PROFESORES --
--------------------------------------------
DROP TABLE CURSOS;

DROP TABLE PROFESORES;


---------------------------------
--	CREAR LA TABLA PROFESORES  --
---------------------------------
CREATE TABLE PROFESORES
(
   dni 		INT PRIMARY KEY ,
   nombre 	VARCHAR(40),
   paterno 	VARCHAR(20),
   materno 	VARCHAR(20),
   email 	VARCHAR(40),
   edad 	INT
);


-----------------------------
--	CREAR LA TABLA CURSOS  --
-----------------------------
CREATE TABLE CURSOS
(
	cod_cur	INT PRIMARY KEY ,
	dni 	INT FOREIGN KEY REFERENCES PROFESORES(dni)
			ON UPDATE SET NULL
			ON DELETE SET NULL,
	nombre 	VARCHAR(40)  NOT NULL
);


----------------------------------------------
--	INSERTAR VALORES A LA TABLA PROFESORES  --
----------------------------------------------
INSERT INTO PROFESORES VALUES(99999999, 'FERNANDA', 'TORRES', 'GUILLEN', 'f.torres@example.com', 25);
INSERT INTO PROFESORES VALUES(88888888, 'LUISA', 'PEREZ', 'GARCIA', 'l.perez@example.com', NULL);
INSERT INTO PROFESORES VALUES(77777777, 'FATIMA', 'TORRES', 'GALLEGOS', 'f.torresg@example.com', 30);


------------------------------------------
--	INSERTAR VALORES A LA TABLA CURSOS  --
------------------------------------------
INSERT INTO CURSOS VALUES(1, 99999999, 'REDES');
INSERT INTO CURSOS VALUES(2, 99999999, 'ALGEBRA');
INSERT INTO CURSOS VALUES(3, 88888888, 'PROGRAMACI N');
INSERT INTO CURSOS VALUES(4, 77777777, 'SQL SERVER');


------------------------------------------------
--	CONSULTAR LAS TABLAS PROFESORES Y CURSOS  --
------------------------------------------------
SELECT * FROM PROFESORES;

SELECT * FROM CURSOS;


----------------------------------------
--	ACTUALIZAR EL DNI DE UN PROFESOR  --
----------------------------------------
UPDATE PROFESORES
SET dni = '22222222'
WHERE dni = '99999999';


------------------------------------------------
--	CONSULTAR LAS TABLAS PROFESORES Y CURSOS  --
------------------------------------------------
SELECT * FROM PROFESORES;

SELECT * FROM CURSOS;


----------------------------
--	ELIMINAR UN PROFESOR  --
----------------------------
DELETE FROM PROFESORES
WHERE dni = '77777777'


------------------------------------------------
--	CONSULTAR LAS TABLAS PROFESORES Y CURSOS  --
------------------------------------------------
SELECT * FROM PROFESORES;

SELECT * FROM CURSOS;



--FOREIGN SET DEFAULT


----------------------------------------
--	UTILIZAR LA BASE DE DATOS tempdb --
----------------------------------------
USE tempdb;


--------------------------------------------
--	ELIMINAR LA TABLA CURSOS Y PROFESORES --
--------------------------------------------
DROP TABLE CURSOS;

DROP TABLE PROFESORES;


---------------------------------
--	CREAR LA TABLA PROFESORES  --
---------------------------------
CREATE TABLE PROFESORES
(
   dni 		INT PRIMARY KEY ,
   nombre 	VARCHAR(40),
   paterno 	VARCHAR(20),
   materno 	VARCHAR(20),
   email 	VARCHAR(40),
   edad 	INT
);


-----------------------------
--	CREAR LA TABLA CURSOS  --
-----------------------------
CREATE TABLE CURSOS
(
	cod_cur	INT PRIMARY KEY ,
	dni 	INT DEFAULT 1 FOREIGN KEY REFERENCES PROFESORES(dni)
			ON UPDATE SET DEFAULT
			ON DELETE SET DEFAULT,
	nombre 	VARCHAR(40)  NOT NULL
);


----------------------------------------------
--	INSERTAR VALORES A LA TABLA PROFESORES  --
----------------------------------------------
INSERT INTO PROFESORES VALUES(99999999, 'FERNANDA', 'TORRES', 'GUILLEN', 'f.torres@example.com', 25);
INSERT INTO PROFESORES VALUES(88888888, 'LUISA', 'PEREZ', 'GARCIA', 'l.perez@example.com', NULL);
INSERT INTO PROFESORES VALUES(77777777, 'FATIMA', 'TORRES', 'GALLEGOS', 'f.torresg@example.com', 30);
INSERT INTO PROFESORES VALUES(1, 'OTROS', 'OTROS', 'OTROS', 'OTROS', NULL);


------------------------------------------
--	INSERTAR VALORES A LA TABLA CURSOS  --
------------------------------------------
INSERT INTO CURSOS VALUES(1, 99999999, 'REDES');
INSERT INTO CURSOS VALUES(2, 99999999, 'ALGEBRA');
INSERT INTO CURSOS VALUES(3, 88888888, 'PROGRAMACI N');
INSERT INTO CURSOS VALUES(4, 77777777, 'SQL SERVER');


------------------------------------------------
--	CONSULTAR LAS TABLAS PROFESORES Y CURSOS  --
------------------------------------------------
SELECT * FROM PROFESORES;

SELECT * FROM CURSOS;


----------------------------------------
--	ACTUALIZAR EL DNI DE UN PROFESOR  --
----------------------------------------
UPDATE PROFESORES
SET dni = '22222222'
WHERE dni = '99999999'


------------------------------------------------
--	CONSULTAR LAS TABLAS PROFESORES Y CURSOS  --
------------------------------------------------
SELECT * FROM PROFESORES;

SELECT * FROM CURSOS;


----------------------------
--	ELIMINAR UN PROFESOR  --
----------------------------
DELETE FROM PROFESORES
WHERE dni = '77777777';


------------------------------------------------
--	CONSULTAR LAS TABLAS PROFESORES Y CURSOS  --
------------------------------------------------
SELECT * FROM PROFESORES;

SELECT * FROM CURSOS;