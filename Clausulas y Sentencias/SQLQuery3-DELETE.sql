
--DELETE SIN CONDICIONAL

SELECT * FROM Calificaciones;

DELETE FROM Calificaciones;



SELECT * FROM Profesores_Alumnos;

DELETE FROM Profesores_Alumnos;

SELECT * FROM Alumnos_Tutores;

DELETE FROM Alumnos_Tutores;


--DELETE CON CONDICIONAL WHERE

SELECT * FROM Alumnos;

DELETE FROM Alumnos
WHERE idAlumno = 1005;

DELETE FROM Alumnos
WHERE nombre = 'Isabel';


SELECT * FROM Asignaturas

DELETE FROM Asignaturas
WHERE idAsignatura = 103;



--DELETE CON FOREIGN KEY


SELECT * FROM Colegiatura;

DELETE FROM Colegiatura
WHERE idColegiatura = 100;


SELECT * FROM Colegiatura;
SELECT * FROM Alumnos;

DELETE FROM Alumnos
WHERE idColegiatura = 100;


--Peliculas


SELECT * FROM Peliculas;

DELETE FROM Peliculas
WHERE idPeliculas = 114;

DELETE FROM Peliculas
WHERE calificacion = 6.5;

DELETE FROM Peliculas
WHERE titulo = 'Frozen';

DELETE FROM Peliculas
WHERE fechaLanzamiento = '2014-07-14';


DELETE FROM Peliculas;