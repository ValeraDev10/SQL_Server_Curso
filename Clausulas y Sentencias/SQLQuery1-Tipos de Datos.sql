

-- Usar la Base de Datos tempdb
USE tempdb
GO


--NUMERICOS ENTEROS




-- Crear la Tabla Numeros
CREATE TABLE Numeros(
	col_tinyint		TINYINT,
	col_smallint	SMALLINT,
	col_int			INT,
	col_bigint		BIGINT
)
GO


-- Insertar registro Decimal en la Tabla Numeros
INSERT INTO Numeros VALUES(47.69, 47.69, 47.69, 47.69)
GO


-- Consultat la Tabla Numeros
SELECT * FROM Numeros --Unicamente toma la parte entera
GO


-- Insertvar un valor negativo en TINYINT
INSERT INTO Numeros (col_tinyint) VALUES(-50)
GO--ERROR DE DESBORDAMIENTO ARITMETICO


-- Insertvar un valor correcto en TINYINT
INSERT INTO Numeros (col_tinyint) VALUES(100)
GO


-- Consultat la Tabla Numeros
SELECT * FROM Numeros
GO


-- Insertvar un valor fuera de rango en TINYINT
INSERT INTO Numeros (col_tinyint) VALUES(300)
GO--ERROR DE DESBORDAMIENTO ARITMETICO


-- Consultat la Tabla Numeros
SELECT * FROM Numeros
GO


-- Insertar el Máximo valor positivo permitido en SMALLINT
INSERT INTO Numeros (col_smallint) VALUES(32767)
GO


-- Consultat la Tabla Numeros
SELECT * FROM Numeros
GO


-- Aumentar en 1 el Máximo valor positivo permitido en SMALLINT
INSERT INTO Numeros (col_smallint) VALUES(32768)
GO--FUERA DE RANGO PERMITIDO


-- Consultat la Tabla Numeros
SELECT * FROM Numeros
GO


-- Consultar el Número de Bytes usados
SELECT DATALENGTH(col_tinyint) AS col_tinyint, 
	   DATALENGTH(col_smallint) AS col_smallint,
	   DATALENGTH(col_int) AS col_int,
	   DATALENGTH(col_bigint) AS col_bigint
FROM Numeros
GO


--NUMERICOS DECIMALES



-- Usar la Base de Datos tempdb
USE tempdb
GO


-- Crear la Tabla Decimales
CREATE TABLE Decimales(
	col_decimal1	DECIMAL(7,2),
	col_decimal2	DECIMAL(15,4),
	col_decimal3	DECIMAL(20,8),
	col_decimal4	DECIMAL(38,10),
	col_numeric1	NUMERIC(7,2),
	col_numeric2	NUMERIC(15,4),
	col_numeric3	NUMERIC(20,8),
	col_numeric4	NUMERIC(38,10)
)
GO


-- Insertar registros Enteros y Decimal en la Tabla Decimales
INSERT INTO Decimales 
VALUES(100, 200.20, 300, 400.4444, 500, 600.666666, 700, 800.88888888)
GO


-- Consultar la Tabla Decimales
SELECT * FROM Decimales --Agrega ceros a la parte decimal
GO


--=========== Trabajar con la Columna con 2 decimales ===========--
-- Insertar un valor con 2 decimales
INSERT INTO Decimales(col_decimal1) VALUES(49.98)
GO

-- Consultar la Tabla Decimales
SELECT * FROM Decimales
GO


-- Insertar un valor con 3 decimales
INSERT INTO Decimales(col_decimal1) VALUES(49.987)
GO

-- Consultar la Tabla Decimales
SELECT * FROM Decimales -- Redondea el valor decimal
GO


-- Insertar otro valor con 3 decimales
INSERT INTO Decimales(col_decimal1) VALUES(49.999)
GO

-- Consultar la Tabla Decimales
SELECT * FROM Decimales -- Redondea el valor entero
GO


-- Insertar un valor que supere los 7 d gitos
INSERT INTO Decimales(col_decimal1) VALUES(99999.999) --100000.00
GO--ERROR DESBORDAMIENTO ARITMETICO

-- Consultar la Tabla Decimales
SELECT * FROM Decimales
GO


--=========== Agregar una nueva columna ===========--
ALTER TABLE Decimales
ADD col_decimal DECIMAL(4,5); --La escala debe ser menor o igual a la precisi n



-- Consultar los Bytes usados
SELECT DATALENGTH(col_decimal1) AS decimal1, 
	   DATALENGTH(col_decimal2) AS decimal2,
	   DATALENGTH(col_decimal3) AS decimal3,
	   DATALENGTH(col_decimal4) AS decimal4,
	   DATALENGTH(col_numeric1) AS numeric1,
	   DATALENGTH(col_numeric2) AS numeric2,
	   DATALENGTH(col_numeric3) AS numeric3,
	   DATALENGTH(col_numeric4) AS numeric4
FROM Decimales
GO


-- Insertar valores
INSERT INTO Decimales
VALUES(99999.99, 99999999999.9999, 
		999999999999.99999999, 9999999999999999999999999999.9999999999,
	   99999.99, 99999999999.9999, 
		999999999999.99999999, 9999999999999999999999999999.9999999999)
GO

-- Consultar la Tabla Decimales
SELECT * FROM Decimales
GO



-- Volver a consultar los Bytes usados
SELECT DATALENGTH(col_decimal1) AS decimal1, 
	   DATALENGTH(col_decimal2) AS decimal2,
	   DATALENGTH(col_decimal3) AS decimal3,
	   DATALENGTH(col_decimal4) AS decimal4,
	   DATALENGTH(col_numeric1) AS numeric1,
	   DATALENGTH(col_numeric2) AS numeric2,
	   DATALENGTH(col_numeric3) AS numeric3,
	   DATALENGTH(col_numeric4) AS numeric4
FROM Decimales
GO


--NUMERICOS LOGICOS


-- Usar la Base de Datos tempdb
USE tempdb
GO


-- Crear la Tabla Binario
CREATE TABLE Binario(
	col_binario1	BIT,
	col_binario2	BIT
)
GO


-- Insertar registro en la Tabla Binario
INSERT INTO Binario VALUES(1, 0)
GO


-- Consultar la Tabla Binario
SELECT * FROM Binario
GO


-- Insertar valores como TRUE y FALSE
INSERT INTO Binario VALUES('TRUE', 'FALSE')
GO
INSERT INTO Binario VALUES('true', 'false')
GO


-- Consultar la Tabla Binario
SELECT * FROM Binario
GO


-- Insertar valores de tipo caracter
INSERT INTO Binario VALUES('t', 'f')
GO
INSERT INTO Binario VALUES('Hola', 'mundo')
GO



-- Consultar la Tabla Binario
SELECT * FROM Binario
GO


-- Insertar valores Enteros negativos y positivos
INSERT INTO Binario VALUES(-123, 123)
GO


-- Consultar la Tabla Binario
SELECT * FROM Binario
GO


-- Insertar valores Decimales negativos y positivos
INSERT INTO Binario VALUES(-1.1415, 456.78910)
GO


-- Consultar la Tabla Binario
SELECT * FROM Binario
GO


-- Consultar el N mero de Bytes usados
SELECT DATALENGTH(col_binario1) AS binario1, 
	   DATALENGTH(col_binario2) AS binario2
FROM Binario
GO


--NUMERICOS MONEDA


-- Usar la Base de Datos tempdb
USE tempdb
GO


-- Crear la Tabla Monedas
CREATE TABLE Monedas(
	col_smallmoney	SMALLMONEY, -- -214,748.3648 a 214,748.3647
	col_money		MONEY		-- -922,337,203,685,477.5808 a 922,337,203,685,477.5807
)
GO


-- Insertar registro en la Tabla Monedas
INSERT INTO Monedas VALUES(215000, 215000) -- Error fuera de rango SMALLMONEY
GO


-- Insertar registro correcto en la Tabla Monedas
INSERT INTO Monedas VALUES(205000.1234, 1250000.1234)
GO


-- Consultar la Tabla Monedas
SELECT * FROM Monedas
GO


-- Insertar valores con varios decimales
INSERT INTO Monedas VALUES(249.99987654321, 99.9999999999)
GO


-- Consultar la Tabla Monedas
SELECT * FROM Monedas -- Hace un redondeo del valor
GO


-- Insertar valores con simbolos monetarios
INSERT INTO Monedas VALUES($199.99, €990.90)
GO


-- Consultar la Tabla Monedas
SELECT * FROM Monedas -- No muestra el simbolo monetario
GO



-- Consultar el Número de Bytes usados
SELECT DATALENGTH(col_smallmoney) AS col_smallmoney, 
	   DATALENGTH(col_money) AS col_money
FROM Monedas
GO


--NUMERICO APROXIMADO


-- Usar la Base de Datos tempdb
USE tempdb
GO


-- Crear la Tabla Aproximados
CREATE TABLE Aproximados(
	col_float1		FLOAT(24),	-- 7 dígitos
	col_float2		FLOAT(53),	-- 15 dígitos
	col_real		REAL		-- Notación cientifica
)
GO


-- Insertar registro en la Tabla Aproximados
INSERT INTO Aproximados 
VALUES(123.12345678901234567890123456789012345, -- 38 dígitos en total
	   123.12345678901234567890123456789012345,	-- 38 dígitos en total
	   12312345678901234567890123456789012345)	-- 38 dígitos en total
GO


-- Consultar la Tabla Aproximados
SELECT * FROM Aproximados
GO


-- Validar la cantidad de dígitos
col_float1	-> 123.1235
col_float2	-> 123.123 456 789 012
col_real	-> 1.231235E+37
		


-- Consultar la Tabla Aproximados
SELECT * FROM Aproximados
WHERE col_float1 = 123.1235
GO


-- Volver a consultar la Tabla Aproximados
SELECT * FROM Aproximados
WHERE col_float1 = 123.12345678901234567890123456789012345
GO



-- Consultar el Número de Bytes usados
SELECT DATALENGTH(col_float1) AS col_float1, 
	   DATALENGTH(col_float2) AS col_float2,
	   DATALENGTH(col_real) AS col_real
FROM Aproximados
GO


--CADENAS DE CARACTERES UNICODE Y NO UNICODE


-- Usar la Base de Datos tempdb
USE tempdb
GO


-- Crear la Tabla Caracteres
CREATE TABLE Caracteres(
	col_char		CHAR(50),		-- 8001 Error
	col_varchar		VARCHAR(50),	-- 8001 Error
	col_nchar		NCHAR(50),		-- 4001 Error
	col_nvarchar	NVARCHAR(50)	-- 4001 Error
)
GO


-- Insertar registro en la Tabla Caracteres
INSERT INTO Caracteres 
VALUES( 'Hola', 'Hola', 'Hola', 'Hola' )
GO


-- Consultar la Tabla Caracteres
SELECT * FROM Caracteres
GO



-- Consultar el Número de Bytes usados
SELECT * FROM Caracteres
GO

SELECT DATALENGTH(col_char) AS col_char,
	   DATALENGTH(col_varchar) AS col_varchar,
	   DATALENGTH(col_nchar) AS col_nchar,
	   DATALENGTH(col_nvarchar) AS col_nvarchar
FROM Caracteres
GO




-- Insertar más registros
INSERT INTO Caracteres 
VALUES('¿Cómo estas?', '¿Cómo estas?', '¿Cómo estas?', '¿Cómo estas?'),
	  ('udatademy', 'udatademy', 'udatademy', 'udatademy'),
	  ('こんにちは世界', 'こんにちは世界', 'こんにちは世界', 'こんにちは世界'), --Japones(Hola Mundo)
	  (N'こんにちは世界', N'こんにちは世界', N'こんにちは世界', N'こんにちは世界') --Japones(Hola Mundo)
GO
	

-- Consultar la Tabla Caracteres
SELECT * FROM Caracteres
GO



-- Consultar el Número de Bytes usados
SELECT DATALENGTH(col_char) AS col_char,
	   DATALENGTH(col_varchar) AS col_varchar,
	   DATALENGTH(col_nchar) AS col_nchar,
	   DATALENGTH(col_nvarchar) AS col_nvarchar
FROM Caracteres
GO


--CADENAS DE CARACTERES UNICODE Y NO UNICODE PARTE 2


-- Usar la Base de Datos Master
Use master
GO


-- Crear una Base de Datos Japan
CREATE DATABASE Japan
ON
(	
	NAME = Japan_dat,
	FILENAME = 'C:\Master en SQL Server\Japan_dat.mdf',
	SIZE = 10MB,  -- La unidad de medida puede ser [ KB | MB | GB | TB ]
	MAXSIZE = 50MB,  -- La unidad de medida puede ser [ KB | MB | GB | TB ] | UNLIMITED
	FILEGROWTH = 5MB  -- La unidad de medida puede ser [ KB | MB | GB | TB | % ]
)
LOG ON
(
	NAME = Japan_log,
	FILENAME = 'C:\Master en SQL Server\Japan_log.ldf',
	SIZE = 10MB,  -- La unidad de medida puede ser [ KB | MB | GB | TB ]
	MAXSIZE = 25MB,  -- La unidad de medida puede ser [ KB | MB | GB | TB ] | UNLIMITED
	FILEGROWTH = 5MB  -- La unidad de medida puede ser [ KB | MB | GB | TB | % ]
)
COLLATE Japanese_CI_AS;
GO


-- Usar la Base de Datos Japan
Use Japan
GO


-- Crear la Tabla Caracteres
CREATE TABLE Caracteres(
	col_char		CHAR(50),		-- 8001 Error
	col_varchar		VARCHAR(50),	-- 8001 Error
	col_nchar		NCHAR(50),		-- 4001 Error
	col_nvarchar	NVARCHAR(50)	-- 4001 Error
)
GO


-- Consultar la Tabla Caracteres
SELECT * FROM Caracteres
GO


-- Insertar registros en la Tabla Caracteres
INSERT INTO Caracteres 
VALUES('¿Cómo estas?', '¿Cómo estas?', '¿Cómo estas?', '¿Cómo estas?'),
	  ('udatademy', 'udatademy', 'udatademy', 'udatademy'),
	  ('こんにちは世界', 'こんにちは世界', 'こんにちは世界', 'こんにちは世界'), --Japones(Hola Mundo)
	  (N'こんにちは世界', N'こんにちは世界', N'こんにちは世界', N'こんにちは世界') --Japones(Hola Mundo)
GO


-- Consultar la Tabla Caracteres
SELECT * FROM Caracteres
GO


-- Consultar el Número de Bytes usados
SELECT DATALENGTH(col_char) AS col_char,
	   DATALENGTH(col_varchar) AS col_varchar,
	   DATALENGTH(col_nchar) AS col_nchar,
	   DATALENGTH(col_nvarchar) AS col_nvarchar
FROM Caracteres
GO


-- Usar la Base de Datos Master
Use master
GO


-- Eliminar la Base de Datos Japan
DROP DATABASE Japan
GO



--DATOS FECHA Y HORA


-- Usar la Base de Datos tempdb
USE tempdb
GO


-- Crear la Tabla Fechas
CREATE TABLE Fechas(
	col_time				TIME,
	col_date				DATE,
	col_smalldatetime		SMALLDATETIME,
	col_datetime			DATETIME,
	col_datetime2			DATETIME2(4),	--Precisión 4
	col_datetimeoffset		DATETIMEOFFSET
)
GO


-- Insertar registro en la Tabla Fechas
INSERT INTO Fechas 
VALUES('13:20:10.1234567',
	   '2024-06-01',
	   '2024-06-01 13:20:10',
	   '2024-06-01 13:20:10.123',
	   '2024-06-01 13:20:10.1234567',
	   '2024-06-01 13:20:10.1234567-05:00')
GO


-- Consultar la Tabla Fechas
SELECT * FROM Fechas
GO





-- Consultar el Número de Bytes usados
SELECT DATALENGTH(col_time) AS col_time,
	   DATALENGTH(col_date) AS col_date,
	   DATALENGTH(col_smalldatetime) AS col_smalldatetime,
	   DATALENGTH(col_datetime) AS col_datetime,
	   DATALENGTH(col_datetime2) AS col_datetime2,
	   DATALENGTH(col_datetimeoffset) AS col_datetimeoffset
FROM Fechas
GO



-- Función GETDATE() y SYSDATETIMEOFFSET()
SELECT GETDATE() -- 3 NANOSEGUNDOS
GO
SELECT SYSDATETIMEOFFSET() -- 7 NANOSEGUNDOS Y UTC
GO


-- Insertar registro a partir de la Fecha del Sistema
INSERT INTO Fechas 
VALUES(GETDATE(), GETDATE(), GETDATE(), GETDATE(), GETDATE(), GETDATE()),
	  (SYSDATETIMEOFFSET(), SYSDATETIMEOFFSET(), SYSDATETIMEOFFSET(), 
	   SYSDATETIMEOFFSET(), SYSDATETIMEOFFSET(), SYSDATETIMEOFFSET())
GO


-- Consultar la Tabla Fechas
SELECT * FROM Fechas
GO


--CADENAS BINARIAS


-- Usar la Base de Datos tempdb
USE tempdb
GO


-- Crear la Tabla Binarias
CREATE TABLE Binarias(
	col_binary		BINARY(20),		-- 8001 Error
	col_varbinary	VARBINARY(20),	-- 8001 Error
	col_image		IMAGE
)
GO


-- Insertar registro en la Tabla Binarias
INSERT INTO Binarias 
VALUES(0x12345,
	   0x12345,
	   0x12345)
GO


-- Consultar la Tabla Binarias
SELECT * FROM Binarias
GO





-- Consultar el Número de Bytes usados
SELECT DATALENGTH(col_binary) AS col_binary,
	   DATALENGTH(col_varbinary) AS col_varbinary,
	   DATALENGTH(col_image) AS col_image
FROM Binarias
GO