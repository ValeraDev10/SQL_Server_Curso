--Cambiar base de datos

USE Escuela;


INSERT INTO Auxiliares (nombre, apellido_p, apellido_m, telefono)
				 values('Mirexa','Gallegos','Vega',313787734);


INSERT INTO Auxiliares (idAuxiliar, apellido_p, apellido_m, telefono)
				 values(102,'Mirexa','Gallegos','Vega',313787734);

INSERT INTO Auxiliares (nombre, apellido_p, apellido_m, telefono)
				 values('Manuel','Santana','Herrera',313787777);

INSERT INTO Auxiliares (nombre, apellido_p, apellido_m, telefono)
					VALUES(313784577,'Reyes','Lopez','Juan');

INSERT INTO Auxiliares (nombre, apellido_p, apellido_m, telefono)
					VALUES('Juan','Reyes','Lopez',313784577);

INSERT INTO Auxiliares 
VALUES('Cristobal','Sotelo','Aguilar',313464577);

INSERT INTO Auxiliares 
VALUES('Lida','Guillen','Benavides',314567892);


SET IDENTITY_INSERT Auxiliares ON;

INSERT INTO Auxiliares (idAuxiliar,nombre, apellido_p, apellido_m, telefono)
					VALUES(103,'Carla','Leon','Blanco',NULL);

INSERT INTO Auxiliares (idAuxiliar,nombre, apellido_p, apellido_m, telefono)
					VALUES(107,'Fernanda','Ortiz','Sanz',NULL);

SET IDENTITY_INSERT Auxiliares OFF;


--MULTIPLES REGISTROS

INSERT INTO Auxiliares (nombre, apellido_p, apellido_m, telefono)
					VALUES('Gabriel','Parra','Bravo',31489067),
						  ('Jorge','Moya','Soler',56738982),
						  ('Martha','Nieto','Diez',87838292),
						  ('Raquel','Hidalgo','Iglesias',NULL);


INSERT INTO Colegiatura (monto, fecha, estado)
				VALUES   (400, '01-01-2024', 1),
						 (400, '01-02-2024', 1),
						 (400, '01-03-2024', 1),
						 (400, '01-04-2024', 1),
						 (400, '01-05-2024', 1),
						 (400, '01-06-2024', 1),
						 (400, '01-07-2024', 1),
						 (400, '01-08-2024', 1),
						 (400, '01-09-2024', 1),
						 (400, '01-10-2024', 1),
						 (400, '01-11-2024', 1),
						 (400, '01-12-2024', 1);


--INSERTAR REGISTROS A UNA TABLA CON FOREIGN KEY

INSERT INTO Alumnos(idAuxiliar,idColegiatura,codigoAlumno,nombre,apellido_p,apellido_m,fechaNacimiento,direccion)
VALUES(101,101,'A-100','Felipe','Mondalgo','Perez','01/01/2000','Av. Brasil 520');

INSERT INTO Alumnos
(idAuxiliar,idColegiatura,codigoAlumno,nombre,apellido_p,apellido_m,fechaNacimiento,direccion)
VALUES
(102, 100, 'A-102', 'Margarita', 'Martín', 'Sánchez', '01/01/2000', 'Av. Brasil 130'),
(103, 102, 'A-103', 'Leticia', 'González', 'Jimenez', '01/01/2000', 'Av. Peru 237'),
(104, 103, 'A-104', 'Alberto', 'Romero', 'Navarro', '01/01/2007', 'Jr. Historia 485'),
(105, 104, 'A-105', 'Alejandro', 'Ramos', 'Gil', '01/11/2010', 'Av. España 333'),
(106, 105, 'A-106', 'Daniel', 'Morales', 'Blanco', '01/01/2005', 'Av. Historia 247'),
(107, 106, 'A-107', 'Felipe', 'Molina', 'Castro', '01/11/2008', 'Av. España 652'),
(108, 107, 'A-108', 'Antonia', 'Rubio', 'Iglesias', '01/01/2002', 'Av. Peru 742'),
(109, 108, 'A-109', 'Isabel', 'Santos', 'Garrido', '01/01/2004', 'Av. Brasil 658'),
(110, 109, 'A-110', 'Luisa', 'Lozano', 'Cruz', '01/01/2009', 'Av. Brasil 347');


INSERT INTO Asignaturas (idProfesor, nombre, horaInicio, horaFin)
				 VALUES (1, 'Matemática', '09:30:00', '10:30:00'),
				        (2, 'Ingles', '11:00:00', '13:00:00'),
						(3, 'Comunicación', '08:30:00', '09:30:00'),
						(4, 'Química', '10:30:00', '12:30:00'),
						(5, 'Ingles', '12:30:00', '14:00:00'),
						(6, 'Matemática', '08:30:00', '09:30:00'),
						(7, 'Ingles', '10:00:00', '12:00:00'),
						(8, 'Comunicación', '12:00:00', '14:00:00'),
						(9, 'Química', '08:00:00', '09:30:00'),
						(10, 'Matemática', '09:30:00', '11:00:00'),
						(11, 'Ingles', '11:00:00', '14:00:00');

INSERT INTO Parentescos(tipo)
VALUES('Madre');

INSERT INTO Parentescos(tipo)
VALUES('Padre');


INSERT INTO Tutores (idParentesco, nombre, apellido_p, apellido_m, telefono)
			 VALUES (2, 'Manuel', 'Mondalgo', 'Guerrero', 900000001),
					(1, 'Juana', 'Perez', 'Garrido', 900000002),
					(2, 'Oscar', 'Martín', 'Cano', 900000003),
					(1, 'Luz', 'Sánchez', 'Rubio', 900000004),
					(2, 'Alejandro', 'González', 'Navarro', 900000005),
					(1, 'Sara', 'Jimenez', 'Torres', 900000006),
					(2, 'Ivan', 'Romero', 'Vázquez', 900000007),
					(1, 'Nora', 'Navarro', 'Moreno', 900000008),
					(2, 'Leo', 'Ramos', 'Garcia', 900000009),
					(1, 'Mar', 'Mondalgo', 'Lopez', 900000010);

INSERT INTO Profesores_Alumnos(idProfesor,idAlumno)
						VALUES(1,1000),(1,1001),(1,1002),
							  (2,1003),(2,1004),(2,1005),
							  (3,1006),(3,1007),(3,1008),
							  (4,1009);

INSERT INTO Calificaciones (idAsignatura, idAlumno, calificacion)
					VALUES (100, 1001, 17), (101, 1001, 16), (102, 1001, 15), (103, 1001, 17),
						   (100, 1002, 16), (101, 1002, 15), (102, 1002, 17), (103, 1002, 18),
						   (100, 1003, 18), (101, 1003, 14), (102, 1003, 19), (103, 1003, 16);


INSERT INTO Alumnos_Tutores (idAlumno, idTutor)
					 VALUES (1001, 100), (1001, 101),
							(1002, 102), (1002, 103),
							(1003, 104), (1003, 105),
							(1004, 106), (1004, 107),
							(1005, 108), (1005, 109);

--EJERCICIO TABLA CLIENTES

INSERT INTO Clientes (nombre,apellido_p,apellido_m,edad,fechaNacimiento)
			  VALUES ('Pablo', 'Valera', 'Valero',20, '10/28/1983');



INSERT INTO Clientes (nombre,apellido_p,apellido_m,edad,fechaNacimiento)
			  VALUES('Camila', 'Rodríguez', 'Vargas', 30, '08/15/1995'),
					('Sebastián', 'Gómez', 'Ortiz', 28, '11/22/1996'),
					('Valeria', 'Mendoza', 'Castro', 27, '05/03/1997'),
					('Julián', 'Reyes', 'Silva', 26, '02/09/1998'),
					('Isabella', 'Torres', 'Luna', 25, '12/19/1999'),
					('Martín', 'Cárdenas', 'Soto', 29, '04/07/1994'),
					('Laura', 'Fernández', 'Camargo', 31, '06/25/1993'),
					('Emilio', 'Vega', 'Quintero', 24, '03/13/2001'),
					('Renata', 'Peña', 'Salazar', 23, '09/30/2002'),
					('Tomás', 'Delgado', 'Mejía', 22, '01/01/2003');


--Peliculas

INSERT INTO Peliculas (titulo, presupuesto, fechaLanzamiento, ganancia, tiempoDuracion, calificacion)
			VALUES  ('Avatar', 237000000, '03/12/2015', 55000000, 120, 7.8),
					('Titanic', 200000000, '06/22/2019', 24000000, 98, 6.5),
					('The Avengers', 250000000, '11/05/2021', 92000000, 132, 8.2),
					('Jurassic World', 180000000, '07/14/2014', 47000000, 110, 7.1),
					('Furius 7', 600000000, '02/18/2017', 16500000, 94, 6.3),
					('Avengers: Age of Ultron', 12000000, '10/01/2020', 40000000, 108, 7.4),
					('Frozen', 950000000, '05/03/2016', 32000000, 99, 7.0),
					('Iron Man 3', 300000000, '09/27/2022', 105000000, 140, 8.7),
					('Minions', 700000000, '04/15/2013', 21000000, 95, 6.8),
					('Capitan America: Civil War', 230000000, '08/20/2018', 74000000, 125, 7.9),
					('Transformers: Dark of The Moon', 110000000, '01/10/2016', 39000000, 104, 7.2),
					('The Lord of The Rings: The Return of The King', 850000000, '12/05/2017', 27000000, 97, 6.6),
					('Skyfall', 140000000, '07/30/2015', 50000000, 115, 7.5),
					('Transformers: Age of Extinction', 950000000, '03/08/2020', 31000000, 102, 6.9),
					('The Dark Knight Rises', 160000000, '06/16/2011', 43000000, 117, 7.3),
					('Toy Story 3', 200000000, '11/25/2014', 67000000, 130, 7.6),
					('The Thing', 100000000, '08/12/2019', 33000000, 100, 6.7),
					('Total Recall', 220000000, '02/02/2023', 98000000, 136, 8.4),
					('Rocky 3', 130000000, '09/19/2018', 44000000, 113, 7.0),
					('Lethal Weapon ', 380000000, '05/29/2021', 31000000, 99, 6.4),
					('Die Hard ', 250000000, '05/29/2021', 31000000, 99, 6.4);
