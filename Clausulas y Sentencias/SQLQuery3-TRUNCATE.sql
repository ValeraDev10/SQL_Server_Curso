

--SENTENCIA TRUNCATE

-- Usar la Base de Datos EmpresaX
USE EmpresaX
GO

-- Truncar la Tabla Clientes
TRUNCATE TABLE Persona.Clientes
GO


-- Truncar la Tabla Contratos
TRUNCATE TABLE Servicio.Contratos
GO


-- Truncar la Tabla Departamentos
TRUNCATE TABLE Propiedad.Departamentos
GO


-- Truncar la Tabla Propietarios
TRUNCATE TABLE Persona.Propietarios
GO


-- Truncar la Tabla Empleados
TRUNCATE TABLE Persona.Empleados
GO



-- Truncar la Tabla Pagos
TRUNCATE TABLE Servicio.Pagos
GO


-- Truncar la Tabla Mantenimientos
TRUNCATE TABLE Servicio.Mantenimientos
GO


-- Consultar las Tablas Pagos y Mantenimientos
SELECT * FROM Servicio.Pagos
GO

SELECT * FROM Servicio.Mantenimientos
GO



-- Consultar la Tabla Clientes
SELECT * FROM Persona.Cliente
GO


-- Verificar que la Propiedad IDENTITY
-- de la Tabla Clientes
sp_help 'Persona.Cliente'
GO


-- Eliminar la Restricción Foreign Key
ALTER TABLE Servicio.Contratos
DROP CONSTRAINT FK__Contratos__idCli__75A278F5
GO


-- Volver a consultar la Tabla Clientes
SELECT * FROM Persona.Cliente
GO


-- Eliminar todos los registros mediante DELETE
DELETE FROM Persona.Cliente
GO


-- Volver a consultar la Tabla Clientes
SELECT * FROM Persona.Cliente
GO


-- Insertar un registro a la Tabla Clientes
INSERT INTO Persona.Cliente(nombre, apellido_p, apellido_m, telefono, email)
					  VALUES('Ana', 'Paz', 'Torres', '555-3030', 'ana@mail.com')
GO


-- Volver a consultar la Tabla Clientes
SELECT * FROM Persona.Cliente
GO


-- TRUNCAR la Tabla Clientes
TRUNCATE TABLE Persona.Cliente
GO

-- Volver a consultar la Tabla Clientes
SELECT * FROM Persona.Cliente
GO


-- Insertar un registro a la Tabla Clientes
INSERT INTO Persona.Cliente(nombre, apellido_p, apellido_m, telefono, email)
					  VALUES('Ana', 'Paz', 'Torres', '555-3030', 'ana@mail.com')
GO


-- Volver a consultar la Tabla Clientes
SELECT * FROM Persona.Cliente
GO