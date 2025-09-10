

--CREAR TABLA PARTE 4

CREATE TABLE Propiedad.Departamentos(
		idDepartamento		INT PRIMARY KEY,
		idPropietario		INT,
		direccion			VARCHAR(50),
		ciudad				VARCHAR(50),
		provincia			VARCHAR(50),
		codigopostal		VARCHAR(50),
		numeroHabitacion	INT,
		numeroSanitario		INT,
		pagoMensual			DECIMAL(7,2)
)
GO

--DETERMINAR RESTRICCION FOREIGN KEY 

ALTER TABLE Propiedad.Departamentos
ADD FOREIGN KEY(idPropietario)
	REFERENCES Persona.Propietarios(idPropietario)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO


--CREAR TABLA PARTE 5

--FORMA UNO

CREATE TABLE Servicio.Contratos(
		idContrato			INT PRIMARY KEY,
		idCliente			INT FOREIGN KEY REFERENCES Persona.Cliente(idCliente)
							ON DELETE CASCADE
							ON UPDATE CASCADE,
		idDepartamento		INT FOREIGN KEY REFERENCES Propiedad.Departamentos(idDepartamento)
							ON DELETE CASCADE
							ON UPDATE CASCADE,
		fechaInicio			DATE,
		fechaFin			DATE,
		montomensual		INT,
		numeroSanitario		DECIMAL(7,2),
		condicion			VARCHAR(100),
)
GO

--FORMA DOS

CREATE TABLE Servicio.Contratos(
		idContrato			INT PRIMARY KEY,
		idCliente			INT,
		idDepartamento		INT,
		fechaInicio			DATE,
		fechaFin			DATE,
		montomensual		INT,
		numeroSanitario		DECIMAL(7,2),
		condicion			VARCHAR(100),
		FOREIGN KEY (idCliente) REFERENCES Persona.Cliente(idCliente)
							ON DELETE CASCADE
							ON UPDATE CASCADE,
		FOREIGN KEY (idDepartamento) REFERENCES Propiedad.Departamentos(idDepartamento)
							ON DELETE CASCADE
							ON UPDATE CASCADE

)
GO

--CREAR TABLA PARTE 6


CREATE TABLE Servicio.Mantenimientos(
		idMantenimiento		INT PRIMARY KEY,
		idDepartamento		INT,
		idEmpleado			INT,
		fecha				DATE,
		descripcion			VARCHAR(100),
		costo				DECIMAL(7,2),			
		FOREIGN KEY (idDepartamento) REFERENCES Propiedad.Departamentos(idDepartamento)
							ON DELETE CASCADE
							ON UPDATE CASCADE,
		FOREIGN KEY (idEmpleado) REFERENCES Persona.Empleados(idEmpleado)
							ON DELETE CASCADE
							ON UPDATE CASCADE
)
GO

--CREAR TABLA PARTE 7

CREATE TABLE Servicio.Pagos(
		idPago				INT PRIMARY KEY,
		idContrato			INT FOREIGN KEY REFERENCES Servicio.Contratos(idContrato)
							ON DELETE CASCADE
							ON UPDATE CASCADE,
		fechaPago			DATE,
		monto				DECIMAL(7,2),
		metodoPago			VARCHAR(100),
)
GO


--BASE DE DATOS ESCUELA
--ELIMINAR TABLAS
--TABLAS CON RELACIONES FOREIGN KEY

USE Escuela;

DROP TABLE Profesores
GO --ERROR

DROP TABLE Profesores_Alumnos
GO --OK ELIMINADO

DROP TABLE Asignaturas
GO 

DROP TABLE Calificaciones
GO 

DROP TABLE Profesores
GO

--ELIMINAR RELACIONES FOREIGN KEY


DROP TABLE Parentescos
GO

--ELIMINAMOS LA RESTRICCION FOREIGN KEY

ALTER TABLE Tutores
DROP CONSTRAINT FK_Tutores_Parentescos
GO

DROP TABLE Parentescos
GO


--ELIMINAR LA RESTRICCION FOREIGN KEY DE LA TABLA ALUMNOS
--Y LUEGO ELIMINAR LA TABLA ALUMNOS - TEN EN CUENTA LAS TABLAS QUE SE HAN ELIMINADO


DROP TABLE Alumnos
GO

ALTER TABLE Alumnos
DROP CONSTRAINT FK_Alumnos_Auxiliares
GO

ALTER TABLE Alumnos
DROP CONSTRAINT FK_Alumnos_Colegiatura
GO

ALTER TABLE Alumnos_Tutores
DROP CONSTRAINT FK_Alumnos_Tutores_Alumnos
GO

DROP TABLE Alumnos
GO

--ELIMINAR BASE DE DATOS

USE NORTHWND
GO

DROP DATABASE Escuela
GO

DROP DATABASE testDB
GO





