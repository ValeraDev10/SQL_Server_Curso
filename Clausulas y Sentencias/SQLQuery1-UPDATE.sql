
SELECT * FROM Auxiliares;

SELECT * FROM Tutores;

UPDATE Auxiliares 
SET telefono = 900000000;


UPDATE Auxiliares 
SET nombre = 'ANA';

UPDATE Tutores 
SET telefono = 999999999;

--CONDICIONAL WHERE

SELECT * FROM Profesores;

UPDATE Profesores
SET nombre = 'Jessy',
	apellido_p='CAMPOS',
	direccion='Av, Historia 111'
WHERE idProfesor = 2

UPDATE Profesores
SET email = 'eva@expample.com'	
WHERE idProfesor = 5;


SELECT * FROM Calificaciones;

UPDATE Calificaciones
SET calificacion = 20	
WHERE calificacion = 17;


--UPDATE FOREIGN KEY

SELECT * FROM Asignaturas;

UPDATE Asignaturas
SET idProfesor = 10
WHERE idAsignatura = 100;

SELECT * FROM Asignaturas;


--Peliculas 

SELECT * FROM Peliculas;

UPDATE Peliculas
SET calificacion = 8.5
WHERE idPeliculas = 110;

UPDATE Peliculas
SET tiempoDuracion = 140
WHERE titulo = 'Avatar';

UPDATE Peliculas
SET fechaLanzamiento = '2010/06/17'
WHERE titulo = 'Toy Story 3';

UPDATE Peliculas
SET titulo = 'Desconocido';


