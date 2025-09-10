
USE NORTHWND;

SELECT * FROM Employees;

--ALIAS A UNA COLUMNA

SELECT FirstName AS NOMBRE, LastName AS APELLIDO
FROM Employees;

SELECT FirstName  NOMBRE, LastName APELLIDO
FROM Employees;

SELECT FirstName  [NOMBRE EMPELADO], LastName APELLIDO
FROM Employees;

SELECT FirstName  'NOMBRE EMPELADO', LastName APELLIDO
FROM Employees;

--ALIAS A UNA TABLA

SELECT FirstName  'NOMBRE EMPELADO', LastName APELLIDO
FROM Employees AS EMPLEADO;

SELECT FirstName  'NOMBRE EMPELADO', LastName APELLIDO
FROM Employees  EMPLEADO;

SELECT FirstName  'NOMBRE EMPELADO', LastName APELLIDO
FROM Employees  E;

--CONCATENACION DE CADENAS

SELECT * FROM Employees;


SELECT FirstName + LastName AS NOMBRE_COMPLETO
FROM Employees;

SELECT FirstName +' '+ LastName AS NOMBRE_COMPLETO
FROM Employees;

--INSERTAR REGISTRO A PARTIR DE UNA CONSULTA

USE Escuela;

SELECT * FROM Profesores;

SELECT 'Karen','Saenz','Av. Mexico 160';


INSERT INTO Profesores (nombre,apellido_p,direccion)
SELECT 'Karen','Saenz','Av. Mexico 160';

--DE UNA TABLA DE UNA BASE DE DATOS A OTRA TABLA DE OTRA BASE DE DATOS

SELECT FirstName,LastName, Address
FROM NORTHWND.dbo.Employees

INSERT INTO Profesores (nombre,apellido_p,direccion)
SELECT FirstName,LastName, Address
FROM NORTHWND.dbo.Employees

SELECT * FROM Profesores;
