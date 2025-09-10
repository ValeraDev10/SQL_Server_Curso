

--FUNCION CAST
--La función CAST en SQL se utiliza para convertir un valor de un tipo de dato a otro. 
--Es especialmente útil cuando necesitas asegurarte de que los datos estén en el formato 
--correcto para realizar operaciones, comparaciones o insertar en una tabla.

--CAST(expresión AS tipo_de_dato)

-- expresión: el valor que quieres convertir.
-- tipo_de_dato: el tipo de dato al que deseas convertirlo (por ejemplo, INT, VARCHAR, DATE, etc.).

--1. Convertir texto a número

SELECT CAST('123' AS INT) AS numero;

--2. Convertir número a texto

SELECT CAST(456 AS VARCHAR(10)) AS texto;

--3. Convertir fecha a texto

SELECT CAST(GETDATE() AS VARCHAR(20)) AS fecha_texto;

--4. Convertir decimal a entero

SELECT CAST(123.45 AS INT) AS entero;

--EJEMPLOS UDEMY

SELECT GETDATE();

SELECT CAST(GETDATE() AS CHAR);--POR DEFECTO ES 30
SELECT CAST(GETDATE() AS VARCHAR);--POR DEFECTO ES 30


SELECT CAST(GETDATE() AS NCHAR);
SELECT CAST(GETDATE() AS NVARCHAR);

SELECT CAST(GETDATE() AS VARCHAR(6));
SELECT CAST(GETDATE() AS VARCHAR(30));

SELECT 'La Fecha de hoy es: ' + CAST(GETDATE()AS VARCHAR(40));

SELECT 'La Fecha de hoy es: ' + CAST(123 AS CHAR(3));

SELECT 'El numero es: ' + CAST(123.456 AS CHAR(7));

SELECT CAST(10.6496 AS INT) AS TRUNCAR1,
			CAST(-10.6496 AS INT) AS TRUNCAR2,
				CAST(10.6496 AS DECIMAL) AS REDONDEO1,
					CAST(-10.6496 AS DECIMAL) AS REDONDEO2;




--FUNCION TRY_CAST
--La función TRY_CAST en SQL es una herramienta muy útil cuando necesitas convertir 
--un valor de un tipo de datos a otro, pero sin que se genere un error si la conversión falla. 
--En lugar de lanzar una excepción, TRY_CAST devuelve NULL si la conversión no es posible

--TRY_CAST(valor AS tipo_de_dato)

-- valor: el dato que quieres convertir.
-- tipo_de_dato: el tipo al que deseas convertir el valor.

--1. Convertir texto a entero
SELECT TRY_CAST('123' AS INT) AS resultado;  -- Devuelve 123
SELECT TRY_CAST('abc' AS INT) AS resultado;  -- Devuelve NULL

--2. Convertir fecha en texto a tipo DATE
SELECT TRY_CAST('2023-08-17' AS DATE) AS fecha_valida;  -- Devuelve 2023-08-17
SELECT TRY_CAST('fecha inválida' AS DATE) AS fecha_invalida;  -- Devuelve NULL


--EJEMPLO UDEMY

SELECT CAST('TEXT' AS FLOAT);

SELECT TRY_CAST('TEXT' AS FLOAT);


--FUNCION CONVERT
--Sirve para convertir un valor de un tipo de datos a otro. 
--Es muy útil cuando necesitas transformar fechas, 
--números o cadenas entre distintos formatos

--CONVERT(tipo_de_dato, expresión [, estilo])

-- tipo_de_dato: El tipo al que quieres convertir (por ejemplo, VARCHAR, INT, DATE, etc.).
-- expresión: El valor que estás convirtiendo.
-- estilo: (Opcional) Solo se usa cuando conviertes fechas o números a cadenas, para definir el formato.

--Convertir fecha a cadena
SELECT CONVERT(VARCHAR, GETDATE(), 103) AS FechaEnFormatoBritánico;

-- GETDATE() devuelve la fecha actual.
-- 103 es el estilo británico: dd/mm/yyyy.

--Convertir cadena a número
SELECT CONVERT(INT, '123') AS Numero;

--Convertir número a cadena
SELECT CONVERT(VARCHAR, 456) AS Texto;


--EJEMPLO UDEMY

SELECT GETDATE()
GO

SELECT CONVERT(VARCHAR, GETDATE() );

SELECT CONVERT(VARCHAR, GETDATE(),2 );
SELECT CONVERT(VARCHAR, GETDATE(),102 );
SELECT CONVERT(VARCHAR, GETDATE(),127 );
SELECT CONVERT(VARCHAR, GETDATE(),10 );


SELECT 'LA HORA EN UN FORMATO DE 24 HORAS ES: '+CONVERT(VARCHAR(40),GETDATE(),114);


SELECT 'EL NUMERO ES: ' + CONVERT(CHAR(3),123);

SELECT 'EL NUMERO ES: ' + CONVERT(CHAR(7),123.456);

SELECT CONVERT(INT,10.6496) AS TRUNCARR1,
			CONVERT(INT,-10.6496) AS TRUNCARR2,
				CONVERT(DECIMAL,10.6496) AS REDONDEOO1,
					CONVERT(DECIMAL,-10.6496) AS REDONDEOO2;


--FUNCION TRY_CONVERT
--La función TRY_CONVERT en SQL Server es una herramienta muy útil para convertir 
--datos de un tipo a otro de forma segura, es decir, sin generar errores si la conversión falla. 
--En lugar de lanzar una excepción como lo haría CONVERT o CAST, TRY_CONVERT 
--simplemente devuelve NULL si la conversión no es posible

--TRY_CONVERT(tipo_de_dato, expresión [, estilo])
-- tipo_de_dato: El tipo al que quieres convertir (por ejemplo, INT, DATE, VARCHAR, etc.).
-- expresión: El valor que deseas convertir.
-- estilo (opcional): Solo se usa cuando conviertes a tipos de fecha o número con formato específico.

--1. Convertir texto a entero
SELECT TRY_CONVERT(INT, '123') AS Resultado;  -- Devuelve 123
SELECT TRY_CONVERT(INT, 'abc') AS Resultado;  -- Devuelve NULL

--2. Convertir texto a fecha
SELECT TRY_CONVERT(DATE, '2023-08-17') AS FechaValida;  -- Devuelve 2023-08-17
SELECT TRY_CONVERT(DATE, 'fecha inválida') AS FechaInvalida;  -- Devuelve NULL

--3. Usar con estilo para fechas
SELECT TRY_CONVERT(DATETIME, '17/08/2023', 103) AS FechaEstilo;  -- Estilo 103 = dd/mm/yyyy


--EJEMPLO UDEMY

SELECT CONVERT(FLOAT,'TEXT');
SELECT TRY_CONVERT(FLOAT,'TEXT');


--FUNCION PARSE
--la función PARSE se utiliza para convertir una cadena de texto en un tipo de dato específico, 
--como DATE, DATETIME, INT, FLOAT, etc., respetando el formato regional o de cultura.

--PARSE(string_expression AS data_type USING culture)

-- string_expression: La cadena que quieres convertir.
-- data_type: El tipo de dato al que deseas convertir la cadena.
-- culture: El código de cultura (por ejemplo, 'en-US', 'es-CO', 'fr-FR') que define el formato de la cadena.

--1. Convertir una fecha en formato español
SELECT PARSE('17/08/2025' AS DATETIME USING 'es-CO') AS FechaConvertida;

--2. Convertir un número con formato francés
SELECT PARSE('1234,56' AS FLOAT USING 'fr-FR') AS NumeroConvertido;

--3. Convertir texto a entero
SELECT PARSE('1234' AS INT USING 'en-US') AS EnteroConvertido;


--EJEMPLO UDEMY

SELECT CAST('MONDAY, 23 DECEMBER 2024' AS DATETIME);

SELECT PARSE('MONDAY, 23 DECEMBER 2024' AS DATETIME);

SELECT PARSE('MONDAY, 23 DECEMBER 2024' AS DATETIME USING 'EN-US');

SET LANGUAGE 'English';
SELECT PARSE('12/16/2024' AS DATETIME);



--FUNCION TRY_PARSE
--La función TRY_PARSE en SQL Server se utiliza para convertir una cadena de texto 
--a un tipo de datos específico, como INT, DATE, DECIMAL, etc., de forma segura. 
--Si la conversión falla, en lugar de lanzar un error, devuelve NULL

--TRY_PARSE ( string_value AS data_type [ USING culture ] )

-- string_value: El valor en texto que deseas convertir.
-- data_type: El tipo de datos al que quieres convertir (por ejemplo, INT, DATE, DECIMAL).
-- culture (opcional): Cultura específica para interpretar el formato (por ejemplo, 'en-US', 'es-CO')

--1. Convertir texto a entero
SELECT TRY_PARSE('123' AS INT) AS Resultado;  -- Devuelve 123
SELECT TRY_PARSE('abc' AS INT) AS Resultado;  -- Devuelve NULL

--2. Convertir texto a fecha
SELECT TRY_PARSE('2025-08-17' AS DATE) AS FechaValida;  -- Devuelve 2025-08-17
SELECT TRY_PARSE('17/08/2025' AS DATE USING 'es-CO') AS FechaColombiana;  -- Devuelve 2025-08-17
SELECT TRY_PARSE('fecha inválida' AS DATE) AS FechaInvalida;  -- Devuelve NULL

--3. Convertir texto a decimal
SELECT TRY_PARSE('123.45' AS DECIMAL(10,2)) AS Numero;  -- Devuelve 123.45
SELECT TRY_PARSE('123,45' AS DECIMAL(10,2) USING 'es-CO') AS NumeroColombiano;  -- Devuelve 123.45


--Ventajas
-- Evita errores de conversión que interrumpen la ejecución.
-- Útil en validaciones de datos antes de insertar o procesar.
-- Compatible con formatos regionales usando USING culture


--EJEMPLO UDEMY

SELECT PARSE('Monday 25 December 2024' AS DATETIME) AS Resultado;
SELECT TRY_PARSE('Monday 25 December 2024' AS DATETIME) AS Resultado;


-- Usar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


-- Consultar la Tabla Production.Product
SELECT * FROM Production.Product
GO

-- Ejercicio
/*
Trabajar con la Tabla "Production.Product" y realizar un script 
con las siguientes especificaciones:
Poner la constante "Nombre: " y concatenar con la columna Name
Poner la constante ", Seguridad del Nivel de Stock: " y concatenar con la columna SafetyStockLevel
Poner la constante ", Puntos de Pedido: " y concatenar con la columna ReorderPoint
Poner la constante ", Fecha de inicio de Venta: " y concatenar con la columna SellStartDate
El valor de la columna SellStartDate debe estar en un formato de "dd/mm/yyyy"
Poner el nombre a la columna de "Descripcion"
*/

SELECT 
		'Nombre: '+ Name + 
		', Seguridad del Nivel de Stock: '+ TRY_CAST(SafetyStockLevel AS VARCHAR(10))+
		', Puntos de Pedido: '+ TRY_CAST(ReorderPoint AS VARCHAR (10))+
		', Fecha de inicio de Venta '+ CONVERT(VARCHAR, SellStartDate, 103) AS DESCRPCION

FROM Production.Product
GO


--EJERCICIOS PROPUESTOS

USE NORTHWND
GO

SELECT * FROM Products
GO

--EJERCICIO 1
--Trabajar con la Tabla “Products” y resolver las siguientes especificaciones:
--El valor de la columna “ProductName” concatenar con una constante dos puntos y un espacio (“: ”).
--Luego concatenar con el valor de la columna “UnitPrice”
--Poner el nombre a la columna de "ProductWithPrice"

SELECT 
	ProductName +': '+ CONVERT(VARCHAR,UnitPrice) AS ProductWithPrice
FROM Products
GO

SELECT * FROM Employees
GO

--Ejercicio 2
--Trabajar con la Tabla “Employees” y resolver las siguientes especificaciones:
--Poner la constante "De " y concatenar con la columna FirstName
--Poner un espacio y concatenar con la columna LastName
--Poner la constante “ nació el: ” y concatenar con la columna BirthDate, 
--poner la fecha en un formato de “dd/mm/yyyy”
--Poner la constante “ y su fecha de contratación es: ” 
--y concatenar con la columna HireDate, poner la fecha en un formato de “dd/mm/yyyy”
--Poner el nombre a la columna de " Descripcion"
SELECT 
		'De '+ FirstName + 
		'  '+ LastName +
		' nacio  el: '+ CONVERT(VARCHAR, BirthDate, 103)+
		' y su fecha de contratación es: ' + CONVERT(VARCHAR, HireDate, 103)AS DESCRIPCION
FROM Employees
GO





