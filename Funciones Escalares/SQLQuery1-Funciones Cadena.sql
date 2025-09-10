

--FUNCION CHARINDEX
--La función CHARINDEX en SQL Server se utiliza para buscar la posición de una subcadena 
--dentro de una cadena. Es muy útil cuando necesitas localizar un texto específico dentro de otro texto

--CHARINDEX ( expressionToFind , expressionToSearch [ , startLocation ] )

-- expressionToFind: La subcadena que quieres buscar.
-- expressionToSearch: La cadena donde se va a buscar.
-- startLocation (opcional): La posición inicial desde donde comenzar la búsqueda.


SELECT CHARINDEX('SQL', 'Aprendiendo SQL con Copilot')
-- Resultado: 13

--Usar con startLocation
SELECT CHARINDEX('o', 'Copilot es  poderoso', 10)
-- Resultado: 14 (busca la letra 'o' desde la posición 10)

--Usar con SUBSTRING para extraer texto
SELECT SUBSTRING('Nombre: Juan', CHARINDEX(':', 'Nombre: Juan') + 2, 4)
-- Resultado: Juan



--EJEMPLO UDEMY

SELECT CHARINDEX('t','Cliente')AS Posicion
GO

DECLARE @texto VARCHAR(100)
DECLARE @BUSCAR VARCHAR(20)
SET @texto = 'Aprende SQL Server con el curso Master en SQL Server'
SET @BUSCAR = 'SQL'
SELECT CHARINDEX(@BUSCAR,@texto)AS Posicion
GO
--posicion 9

DECLARE @texto VARCHAR(100)
DECLARE @BUSCAR VARCHAR(20)
SET @texto = 'Aprende SQL Server con el curso Master en SQL Server'
SET @BUSCAR = 'SQL'
SELECT CHARINDEX(@BUSCAR,@texto,32)AS Posicion
GO
--posicion 43

DECLARE @texto VARCHAR(100)
DECLARE @BUSCAR VARCHAR(20)
SET @texto = 'Aprende SQL Server con el curso Master en SQL Server'
SET @BUSCAR = 'Excel'
SELECT CHARINDEX(@BUSCAR,@texto,32)AS Posicion
GO
--posicion 0



--FUNCION PAXINDEX

--La función PATINDEX en SQL Server se utiliza para encontrar la posición inicial 
--de un patrón dentro de una cadena de texto. Si el patrón no se encuentra, devuelve 0.

--PATINDEX('%patrón%', expresión)
--%patrón%: El patrón que deseas buscar, rodeado por % para indicar que puede haber cualquier 
--número de caracteres antes o después.
--expresión: La cadena donde se busca el patrón.

-- La búsqueda no distingue entre mayúsculas y minúsculas.
-- La posición inicial en la cadena es 1 (no 0).
-- Si el patrón o la expresión es NULL, el resultado también será NULL.
-- Puedes usar comodines como:
-- % → cualquier cadena de cualquier longitud
-- _ → un solo carácter
-- [abc] → cualquier carácter dentro de los corchetes
-- [^abc] → cualquier carácter que no esté dentro de los corchetes


SELECT PATINDEX('%ter%', 'interesting data') AS position;
-- Resultado: 3


--EJEMPLO UDEMY

SELECT PATINDEX('%t%','Cliente')AS Posicion
GO

DECLARE @texto VARCHAR(100)
DECLARE @BUSCAR VARCHAR(20)
SET @texto = 'Aprende SQL Server con el curso Master en SQL Server'
SET @BUSCAR = '%SQL%'
SELECT PATINDEX(@BUSCAR,@texto)AS Posicion
GO
--POSICION 9

DECLARE @texto VARCHAR(100)
DECLARE @BUSCAR VARCHAR(20)
SET @texto = 'Aprende SQL Server con el curso Master en SQL Server'
SET @BUSCAR = '%M_ster%'
SELECT PATINDEX(@BUSCAR,@texto)AS Posicion
GO
--POSICION 33

DECLARE @texto VARCHAR(100)
DECLARE @BUSCAR VARCHAR(20)
SET @texto = 'Aprende SQL Server con el curso Master en SQL Server'
SET @BUSCAR = '%Excel%'
SELECT PATINDEX(@BUSCAR,@texto)AS Posicion
GO
--POSICION 0


--FUNCION CONCAT
--La función CONCAT en SQL se utiliza para unir (concatenar) cadenas de texto 
--en una sola. Es especialmente útil cuando quieres combinar valores de diferentes 
--columnas o agregar texto adicional a los datos.

--SELECT CONCAT(cadena1, cadena2, ..., cadenaN) AS resultado
--FROM nombre_tabla;

-- cadena1, cadena2, ..., cadenaN: pueden ser columnas, literales de texto o expresiones.
-- resultado: es el alias que le das a la columna resultante.

--1. Concatenar nombre y apellido
SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo
FROM empleados;

--2. Agregar texto personalizado
SELECT CONCAT('ID: ', id, ' - Cliente: ', nombre) AS descripcion
FROM clientes;

--3. Concatenar múltiples columnas
SELECT CONCAT(ciudad, ', ', pais, ' (', codigo_postal, ')') AS direccion
FROM ubicaciones;


--EJEMPLO UDEMY

SELECT CONCAT('Pablo','Valera')AS Resultado
GO

SELECT 'Pablo' + 'Valera' AS Resultado
GO

SELECT CONCAT('Navidad ', 'es: ',25,'/','12')AS Resultado
GO


--FUNCION CONCAT_WS
--La función CONCAT_WS en SQL es similar a CONCAT, pero con una ventaja clave: 
--te permite especificar un separador entre los valores que estás concatenando. 
--El "WS" significa With Separator (con separador).

--SELECT CONCAT_WS(separador, valor1, valor2, ..., valorN) AS resultado
--FROM nombre_tabla;

-- separador: es la cadena que se insertará entre cada valor (por ejemplo, una coma, espacio, guion, etc.).
-- valor1, valor2, ..., valorN: pueden ser columnas, literales o expresiones.

--1. Concatenar nombre completo con espacio
SELECT CONCAT_WS(' ', nombre, apellido) AS nombre_completo
FROM empleados;

--2. Dirección con comas
SELECT CONCAT_WS(', ', calle, ciudad, pais) AS direccion
FROM ubicaciones;

--Crear una cadena CSV
SELECT CONCAT_WS(',', id, nombre, correo) AS fila_csv
FROM clientes;


--EJEMPLO UDEMY

SELECT CONCAT_WS(' : ','Curso','SQL Server')
GO

SELECT CONCAT_WS(' . ','WWW','UDATADEMY','COM')AS Resultado
GO



--FUNCION FORMAT
--la función FORMAT se utiliza para dar formato a valores, especialmente fechas y números, 
--según una cadena de formato específica. Es muy útil cuando quieres presentar datos de forma legible o personalizada

--FORMAT(valor, formato [, cultura])

-- valor: el valor que quieres formatear (por ejemplo, una fecha o número).
-- formato: una cadena que define el formato deseado.
-- cultura (opcional): especifica la configuración regional (como 'en-US', 'es-CO', etc.).


--Ejemplos con fecha
SELECT FORMAT(GETDATE(), 'dd/MM/yyyy') AS FechaFormateada;
-- Resultado: 15/08/2025

SELECT FORMAT(GETDATE(), 'dddd, MMMM dd yyyy', 'es-CO') AS FechaLarga;
-- Resultado: viernes, agosto 15 2025


--Ejemplos con número
SELECT FORMAT(1234567.89, 'N', 'en-US') AS NumeroFormateado;
-- Resultado: 1,234,567.89

SELECT FORMAT(1234567.89, 'C', 'es-CO') AS MonedaFormateada;
-- Resultado: $1.234.567,89

-- FORMAT está disponible en SQL Server 2012 y versiones posteriores.
-- Puede afectar el rendimiento si se usa en grandes volúmenes de datos, 
--ya que es más costosa que otras funciones como CONVERT.


--EJEMPLO UDEMY

SET DATEFORMAT dmy
GO

DECLARE @date DATE = '22/11/2024'
SELECT FORMAT(@date,'d','en-US')AS 'US English',
		 FORMAT(@date,'d','en-GB')AS 'British English',
		  FORMAT(@date,'d','en-DE')AS 'German',
		   FORMAT(@date,'d','zh-cn')AS 'Chinese Simplified';

SELECT FORMAT(@date,'D','en-US')AS 'US English',
		 FORMAT(@date,'D','en-GB')AS 'British English',
		  FORMAT(@date,'D','en-DE')AS 'German',
		   FORMAT(@date,'D','zh-cn')AS 'Chinese Simplified';
GO

DECLARE @date DATE = '22/11/2024'
SELECT FORMAT(@date,'dd/MM/yyyy','en-US')AS 'US English',
		FORMAT(123456789,'###-##-####','en-US')AS 'Custom Number'
GO


DECLARE @N1 DECIMAL(5,4) = 1.0002
SELECT @N1,
FORMAT(@N1,'N','en-US')AS 'Numeric Format',
FORMAT(@N1,'G','en-US')AS 'General Format',
FORMAT(@N1,'C','en-US')AS 'Currency Format'
GO

DECLARE @N1 DECIMAL(5,4) = 1.0002
SELECT @N1,
FORMAT(@N1,'N','en-DE')AS 'Numeric Format',
FORMAT(@N1,'G','en-DE')AS 'General Format',
FORMAT(@N1,'C','en-DE')AS 'Currency Format'
GO



--FUNCION LEFT
--La función LEFT en SQL se utiliza para extraer una cantidad específica de caracteres 
--desde el inicio (lado izquierdo) de una cadena de texto

--LEFT(cadena, número_de_caracteres)
-- cadena: el campo o texto del cual quieres extraer caracteres.
-- número_de_caracteres: cuántos caracteres deseas obtener desde la izquierda.

--1. Extraer los primeros 3 caracteres de un nombre
SELECT LEFT(nombre, 3) AS iniciales
FROM empleados;

--2. Usar con texto literal
SELECT LEFT('Colombia', 4) AS pais_corto;

--3. En combinación con otras funciones
SELECT LEFT(UPPER(nombre), 2) AS abreviatura
FROM clientes;


--EJEMPLO UDEMY

SELECT LEFT('Hola Amigos', 4)
GO

SELECT LEFT(123456789.123, 8)
GO



--FUNCION RIGHT
--La función RIGHT en SQL es el complemento de LEFT: se utiliza para extraer una cantidad 
--específica de caracteres desde el final (lado derecho) de una cadena de texto.

--RIGHT(cadena, número_de_caracteres)

-- cadena: el texto o campo del cual quieres extraer caracteres.
-- número_de_caracteres: cuántos caracteres deseas obtener desde la derecha.


--1. Extraer los últimos 4 caracteres de un código

SELECT RIGHT(codigo_producto, 4) AS sufijo
FROM productos;

--2. Usar con texto literal
SELECT RIGHT('Colombia', 3) AS final_pais;

--3. Extraer el dominio de un correo electrónico (simplificado)
SELECT RIGHT(email, LEN(email) - CHARINDEX('@', email)) AS dominio
FROM usuarios;


--EJEMPLO UDEMY

SELECT RIGHT('Hola Amigos', 5)
GO

SELECT RIGHT(123456789.123, 5)
GO



--FUNCION LEN

--La función LEN en SQL se utiliza para obtener la longitud de una cadena de texto, 
--es decir, cuántos caracteres contiene

--LEN(cadena)

SELECT nombre, LEN(nombre) AS longitud
FROM empleados;


--2. Usar con texto literal
SELECT LEN('Colombia') AS caracteres;

--3. Filtrar registros por longitud
SELECT *
FROM clientes
WHERE LEN(nombre) > 10;

--EJEMPLO UDEMY

SELECT LEN('Hola amigos     ')
--no cuenta espacios finales



--FUNCION UPPER Y LOWER
--las funciones LOWER() y UPPER() se utilizan para convertir el texto a minúsculas o mayúsculas, 
--respectivamente. Son muy útiles cuando necesitas hacer comparaciones de texto sin importar el caso, 
--o simplemente estandarizar la presentación de datos.

--Convierte todos los caracteres de una cadena a minúsculas.
SELECT LOWER('Hola Mundo');
-- Resultado: 'hola mundo'



--Convierte todos los caracteres de una cadena a mayúsculas.
SELECT UPPER('Hola Mundo');
-- Resultado: 'HOLA MUNDO'


--FUNCIONES LTRIM - RTRIM - TRIM
--Funciones para eliminar espacios en sql
--LTRIM - Elimina los espacios en blanco al inicio de una cadena.
--RTRIM - Elimina los espacios en blanco al final de una cadena.
--TRIM - Elimina los espacios en blanco al inicio y al final de una cadena.

-- Estas funciones no eliminan espacios dentro de la cadena, solo al principio o al final.
-- TRIM() es más moderno y está disponible en versiones recientes de SQL Server, PostgreSQL, MySQL, Oracle, etc.
-- En algunos motores como Oracle, TRIM() también puede eliminar caracteres específicos, no solo espacios.

-- Ejemplo en Oracle para eliminar guiones
SELECT TRIM('-' FROM '---Texto---') AS limpio;
-- Resultado: 'Texto'


SELECT '     HOLA MUNDO', LTRIM('   Hola Mundo')
GO

SELECT '123.HOLA MUNDO', LTRIM( '123.Hola Mundo','123.')
GO

SELECT 'HOLA MUNDO     ', RTRIM('Hola Mundo     ')
GO

SELECT 'HOLA MUNDO.123', RTRIM( 'Hola Mundo.123','.123')
GO

SELECT '     HOLA MUNDO     ', TRIM('   Hola Mundo     ')
GO

SELECT '!#.  Hola Mundo #,', TRIM( '.!,#' FROM '!#.  Hola Mundo #,')
GO

SELECT '!#.  Hola Mundo #,', TRIM(LEADING '.!,#' FROM '!#.  Hola Mundo #,')
GO

SELECT '!#.  Hola Mundo #,', TRIM(TRAILING '.!,#' FROM '!#.  Hola Mundo #,')
GO


--FUNCION REPLACE
--La función REPLACE en SQL se utiliza para reemplazar una parte de una cadena de texto por otra. 
--Es muy útil cuando necesitas modificar valores dentro de columnas de texto sin cambiar toda la cadena

--REPLACE(cadena_original, cadena_a_reemplazar, nueva_cadena)

-- cadena_original: el texto donde se va a buscar.
-- cadena_a_reemplazar: el texto que quieres sustituir.
-- nueva_cadena: el texto nuevo que reemplazará al anterior.

SELECT 'HOLA MUNDO', REPLACE('HOLA MUNDO', 'MUNDO', 'ESTUDIANTE')
GO


--FUNCION REPLACE
--La función REPLICATE en SQL se utiliza para repetir una cadena de texto un número específico de veces. 
--Es especialmente útil cuando necesitas generar patrones de texto, rellenar espacios o construir cadenas dinámicas

--REPLICATE(string_expression, integer_expression)
-- string_expression: La cadena que quieres repetir.
-- integer_expression: El número de veces que quieres repetir la cadena.

--1. Repetir una palabra
SELECT REPLICATE('Hola ', 3) AS Resultado;
-- Resultado: 'Hola Hola Hola '

--2. Rellenar con ceros a la izquierda
SELECT REPLICATE('0', 5 - LEN('42')) + '42' AS NumeroFormateado;
-- Resultado: '00042'

--3. Crear una línea de guiones
SELECT REPLICATE('-', 20) AS Separador;
-- Resultado: '--------------------'

--EJEMPLO UDEMY

SELECT REPLICATE('AMIGO ', 5)
GO


--FUNCION REVERSE
--En SQL Server, puedes usar REVERSE() para invertir 
--el orden de los caracteres en una cadena

SELECT REVERSE('Hola Mundo') AS CadenaInvertida;
-- Resultado: 'odnuM aloH'



--FUNCION SPACE
--la función SPACE() se utiliza para generar una cadena que contiene un número específico de espacios en blanco. 
--Es muy útil cuando necesitas formatear texto o concatenar espacios entre valores

--SPACE(n)

SELECT SPACE(5) AS espacios;
--espacios
---------
SELECT 'Hola' + SPACE(3) + 'Mundo' AS saludo;

--3. Usar en combinación con otras funciones
SELECT RTRIM('Texto') + SPACE(2) + 'Adicional' AS resultado;
--Esto elimina espacios al final de 'Texto', agrega 2 espacios, y luego concatena 'Adicional'.

--EJEMPLO UDEMY

SELECT 'HOLA,' + SPACE(1) + 'MUNDO'
GO

SELECT 'HOLA,' + SPACE(10) + 'MUNDO'
GO

SELECT 'HOLA,' + '   ' + 'MUNDO'
GO

--FUNCION SUBSTRING
--La función SUBSTRING en SQL se utiliza para extraer una parte específica de una cadena de texto. 
--Es muy útil cuando necesitas obtener solo una sección de un valor de texto, 
--como los primeros caracteres de un nombre o una parte de una fecha en formato texto

--SUBSTRING(cadena FROM inicio FOR longitud)
--SUBSTRING(cadena, inicio, longitud)

-- cadena: la cadena de texto de la que quieres extraer una parte.
-- inicio: la posición inicial (comienza en 1).
-- longitud: el número de caracteres que quieres extraer.

SELECT SUBSTRING('Alejandro', 1, 5) AS nombre_corto;
-- Resultado: 'Aleja'


SELECT SUBSTRING('2025-08-17', 1, 4) AS año;
-- Resultado: '2025'


--EJEMPLO UDEMY

SELECT SUBSTRING('HOLA MUNDO',1,4)
GO

SELECT SUBSTRING('HOLA MUNDO',1,15)
GO

SELECT SUBSTRING('HOLA MUNDO',5,15)
GO


--EJERCICIOS PROPUESTOS

-- Usar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


-- Consultar la Tabla Sales.Store
SELECT * FROM Person.EmailAddress
GO

-- Ejercicio 1
/*
Realizar un script que muestre las columnas BusinessEntityID, 
EmailAddress de la Tabla "EmailAddress" y
también crear una nueva columna llamada "userName" donde
se va a obtener el "nombre de usuario" del valor de la columna "EmailAddress".
*/

SELECT BusinessEntityID,EmailAddress,
        TRIM(
				'0123456789' FROM
		SUBSTRING(EmailAddress,1,CHARINDEX('@',EmailAddress) -1)
		)AS UserName
FROM Person.EmailAddress
GO


-- Consultar la Person.Person
SELECT * FROM Person.Person
GO

-- Ejercicio 2
/*
Realizar un script que muestre las columnas BusinessEntityID,
PersonType, Title, FirstName, MiddleName, LastName, Suffix y
también crear una nueva columna llamada "Person" donde
se van a unir los valores de las colummnas 
PersonType, Title, FirstName, MiddleName, LastName y Suffix,
teniendo en cuenta lo siguiente:
Debe haber un espacio entre la unión de cada columna
El valor de la columna PersonType y Title deben unirse por un guión(-)
El valor de la columna Title se debe mostrar en MAYUSCULA
Luego unir también la columna FirstName
Si el valor de la columna MiddleName es NULL, se debe reemplazar por ''
Si el valor de la columna MiddleName NO es NULL, se debe poner un punto al final(.)
Unir también la columna LastName y se debe mostrar en MINUSCULA
Si el valor de la columna Suffix es NULL, se debe reemplazar por ''
sino unir el valor de la columna Suffix
*/

SELECT BusinessEntityID,PersonType,Title,FirstName,MiddleName,LastName,Suffix,	
		CONCAT_WS(SPACE(1),
			CONCAT_WS('-',PersonType,UPPER(Title)),FirstName,
			IIF(
			    LEN(MiddleName)>0,
			    CONCAT(MiddleName, '.'),
			    COALESCE(MiddleName, '')
			),
			LOWER(LastName),
			IIF(
				LEN(Suffix) > 0,
				Suffix,
				COALESCE(Suffix, '')
			)
		)AS Person
FROM Person.Person
GO

-- Consultar la Sales.CurrencyRate
SELECT * FROM Sales.CurrencyRate
GO

-- Ejercicio 3
/*
Realizar un script que muestre las columnas CurrencyRateID, EndOfDayRate y
también crear las siguientes columnas:
Numeric Format: va a convertir el valor de la columna EndOfDayRate
				a un formato Numeric donde la cultura sea Germany.
General Format: va a convertir el valor de la columna EndOfDayRate
				a un formato General donde la cultura sea Germany.
Currency Format: va a convertir el valor de la columna EndOfDayRate
				a un formato Currency donde la cultura sea Germany.
Ordenar de manera Ascendente por la columna CurrencyRateID
*/
SELECT CurrencyRateID, EndOfDayRate  
      ,FORMAT(EndOfDayRate, 'N', 'de-de') AS 'Numeric Format'  
      ,FORMAT(EndOfDayRate, 'G', 'de-de') AS 'General Format'  
      ,FORMAT(EndOfDayRate, 'C', 'de-de') AS 'Currency Format'  
FROM Sales.CurrencyRate  
ORDER BY CurrencyRateID
GO


--EJERCICIOS PROPUESTOS 

--EJERCICIO 1

USE NORTHWND
GO

SELECT * FROM Customers
GO

SELECT CustomerID,CompanyName,
		SUBSTRING(ContactName, 1, CHARINDEX(' ',ContactName) -1) AS FirstName,
		SUBSTRING(ContactName, CHARINDEX(' ',ContactName),10) AS LastName,
		SUBSTRING(ContactTitle, 1, 20) AS ContactTitle
FROM Customers
GO

--EJERCICIO 2

SELECT * FROM Employees
GO

SELECT EmployeeID,
		CONCAT_WS(' ',FirstName,LastName) AS FullName,
		SUBSTRING(Title, 1, 20) AS Title,
		LOWER(Address)AS Address,
		
		CONCAT_WS('-',Country,
		CONCAT_WS(',',Region,City,PostalCode)
		) AS Location
FROM Employees
GO





















