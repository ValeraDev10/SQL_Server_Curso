
SELECT * FROM Profesores;

SELECT nombre,apellido_p,apellido_m  FROM Profesores;

SELECT nombre,apellido_p,apellido_m, telefono
FROM Profesores;

--Clausula Distinct

SELECT * FROM Asignaturas;

SELECT DISTINCT nombre
FROM Asignaturas;

SELECT DISTINCT horainicio
FROM Asignaturas;

--Clausula Where

SELECT * FROM Profesores;

SELECT * FROM Profesores
WHERE nombre='Eva';

SELECT * FROM Profesores
WHERE idProfesor=1;

SELECT * FROM Profesores
WHERE fechaNacimiento='2000-02-13';

--Clausula Order By


SELECT idProfesor,nombre,fechaNacimiento,direccion
FROM Profesores;

SELECT idProfesor,nombre,fechaNacimiento,direccion
FROM Profesores
ORDER BY nombre, fechaNacimiento;

SELECT idProfesor,nombre,fechaNacimiento,direccion
FROM Profesores
ORDER BY nombre DESC;

SELECT idProfesor,nombre,fechaNacimiento,direccion
FROM Profesores
ORDER BY nombre ASC;


SELECT idProfesor,nombre,fechaNacimiento,direccion
FROM Profesores
ORDER BY 3,2;


--Clausula Top


SELECT * FROM Profesores;

SELECT TOP 20 * FROM Profesores;

SELECT TOP 20 idProfesor,nombre,apellido_p 
FROM Profesores;

--Clausula Percent

SELECT  idProfesor,nombre,apellido_p 
FROM Profesores;

SELECT TOP 50 PERCENT  idProfesor,nombre,apellido_p 
FROM Profesores; --devuelve el 50 porcuento de los registros

SELECT TOP 30 PERCENT  idProfesor,nombre,apellido_p 
FROM Profesores; --devuelve el 30 porcuento de los registros

--Clausula With Ties


SELECT * FROM Calificaciones;

SELECT * FROM Calificaciones
ORDER BY calificacion;

SELECT * FROM Calificaciones
ORDER BY calificacion DESC;

SELECT TOP 4 WITH TIES * FROM Calificaciones
ORDER BY calificacion DESC;

--Peliculas

SELECT * FROM Peliculas;

SELECT DISTINCT tiempoDuracion
FROM Peliculas;

SELECT * FROM Peliculas
WHERE tiempoDuracion = 99;

SELECT * FROM Peliculas
ORDER BY  fechaLanzamiento ASC;


SELECT TOP 5  Titulo,calificacion 
FROM Peliculas ORDER BY  calificacion DESC;

SELECT TOP 50 PERCENT Titulo,ganancia 
FROM Peliculas ORDER BY  ganancia DESC;



