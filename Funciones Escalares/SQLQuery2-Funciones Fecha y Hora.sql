
--FUNCIONES SYSDATETIME, SYSDATETIMEOFFSET Y SYSUTCDATETIME
--Las funciones SYSDATETIME, SYSDATETIMEOFFSET y SYSUTCDATETIME 
--en SQL Server se utilizan para obtener la fecha y hora actuales del sistema, 
--cada una con características específicas según el tipo de dato y la zona horaria


--1. SYSDATETIME()
--Devuelve la fecha y hora actual del sistema en formato datetime2, 
--con una precisión de fracciones de segundo.
-- Tipo de dato: datetime2
-- Zona horaria: Hora local del servidor
-- Precisión: Hasta 100 nanosegundos
SELECT SYSDATETIME() AS FechaHoraLocal;
--Ejemplo de salida: 2025-08-18 00:42:15.1234567

--2. SYSUTCDATETIME()
--Devuelve la fecha y hora actual en formato UTC (Tiempo Universal Coordinado), también como datetime2.
-- Tipo de dato: datetime2
-- Zona horaria: UTC
-- Precisión: Alta (igual que SYSDATETIME)
SELECT SYSUTCDATETIME() AS FechaHoraUTC;
--Ejemplo de salida: 2025-08-18 05:42:15.1234567 (dependiendo de la diferencia horaria con UTC)

--3. SYSDATETIMEOFFSET()
--Devuelve la fecha y hora actual con información de zona horaria en formato datetimeoffset.
-- Tipo de dato: datetimeoffset
-- Zona horaria: Incluye el desplazamiento respecto a UTC
-- Precisión: Alta
SELECT SYSDATETIMEOFFSET() AS FechaHoraConZona;
--Ejemplo de salida: 2025-08-18 00:42:15.1234567 -05:00


SELECT SYSDATETIME(),SYSDATETIMEOFFSET(),SYSUTCDATETIME()
GO

--FUNCIONES CURRENT_TIMESTAMP, GETDATE, Y GETUTCDATE
--Las funciones CURRENT_TIMESTAMP, GETDATE() y GETUTCDATE() en SQL Server 
--se utilizan para obtener la fecha y hora actuales


--1. CURRENT_TIMESTAMP
-- Descripción: Devuelve la fecha y hora actuales del sistema.
-- Tipo de dato: datetime
-- Equivalente a: GETDATE()
-- Uso típico:
SELECT CURRENT_TIMESTAMP;
-- Notas:
-- No requiere paréntesis.
-- Es parte del estándar SQL.

-- 2. GETDATE()
-- Descripción: Devuelve la fecha y hora actuales según la zona horaria del servidor.
-- Tipo de dato: datetime
-- Uso típico:
SELECT GETDATE();
-- Notas:
-- Muy común en aplicaciones que dependen de la hora local del servidor.
-- Incluye milisegundos.

--3. GETUTCDATE()
-- Descripción: Devuelve la fecha y hora actuales en formato UTC (Tiempo Universal Coordinado).
-- Tipo de dato: datetime
-- Uso típico:
SELECT GETUTCDATE();
-- Notas:
-- Útil para aplicaciones distribuidas globalmente.
-- Evita problemas de zona horaria


SELECT CURRENT_TIMESTAMP, GETDATE(),GETUTCDATE()
GO



--FUNCIONES DATENAME, DATEPART, DATETRUNC, DAY, MONTH, YEAR

--1. DATENAME() devuelve palabras.

-- DATENAME(parte, fecha)
--- parte: puede ser weekday, month, year, etc.
-- fecha: cualquier valor de tipo DATETIME, DATE, etc.

SELECT DATENAME(weekday, '2025-08-26') AS DiaSemana; -- Resultado: Tuesday
SELECT DATENAME(month, '2025-08-26') AS MesNombre;   -- Resultado: August
SELECT DATENAME(year, '2025-08-26') AS AñoTexto;     -- Resultado: 2025



--2. DATEPART()
-- Extrae una parte específica de una fecha (día, mes, año, hora, etc.).
SELECT DATEPART(year, '2025-08-26') AS Año;     -- Resultado: 2025
SELECT DATEPART(month, '2025-08-26') AS Mes;    -- Resultado: 8
SELECT DATEPART(day, '2025-08-26') AS Día;      -- Resultado: 26
SELECT DATEPART(weekday, '2025-08-26') AS DíaSemana; -- Resultado: 3 (martes)


--3. DATETRUNC() (Disponible en SQL Server 2022+)
--Trunca una fecha al inicio de una unidad de tiempo (mes, año, día, etc.).
SELECT DATETRUNC(month, '2025-08-26 20:59:00') AS InicioMes;
-- Resultado: 2025-08-01 00:00:00



--4. DAY(), MONTH(), YEAR()
-- Funciones simples para extraer partes de la fecha.
SELECT DAY('2025-08-26') AS Día;       -- Resultado: 26
SELECT MONTH('2025-08-26') AS Mes;     -- Resultado: 8
SELECT YEAR('2025-08-26') AS Año;      -- Resultado: 2025



--EJEMPLOS UDEMY

-- Podemos estar ubicados en cualquier Base de Datos

-- Funciones DATENAME, DATEPART, DATETRUNC, DAY, MONTH y YEAR
-- Función DATENAME
DECLARE @fecha DATETIME2 = '2024-07-07 11:30:15.1234567'
SELECT 'Year', DATENAME(year, @fecha);
SELECT 'Quarter', DATENAME(quarter, @fecha);
SELECT 'Month', DATENAME(month, @fecha);
SELECT 'dayofyear', DATENAME(dayofyear, @fecha);
SELECT 'Day', DATENAME(day, @fecha);
SELECT 'Week', DATENAME(week, @fecha);
SELECT 'weekday', DATENAME(weekday, @fecha);
SELECT 'Hour', DATENAME(hour, @fecha);
SELECT 'Minute', DATENAME(minute, @fecha);
SELECT 'Second', DATENAME(second, @fecha);
SELECT 'Millisecond', DATENAME(millisecond, @fecha);
SELECT 'Microsecond', DATENAME(microsecond, @fecha);
SELECT 'nanosecond', DATENAME(nanosecond, @fecha);
SELECT 'tzoffset', DATENAME(tzoffset, @fecha);
SELECT 'Iso_week', DATENAME(iso_week, @fecha);
GO


-- Función DATEPART
DECLARE @fecha DATETIME2 = '2024-07-07 11:30:15.1234567'
SELECT 'Year', DATEPART(year, @fecha);
SELECT 'Quarter', DATEPART(quarter, @fecha);
SELECT 'Month', DATEPART(month, @fecha);
SELECT 'dayofyear', DATEPART(dayofyear, @fecha);
SELECT 'Day', DATEPART(day, @fecha);
SELECT 'Week', DATEPART(week, @fecha);
SELECT 'weekday', DATEPART(weekday, @fecha);
SELECT 'Hour', DATEPART(hour, @fecha);
SELECT 'Minute', DATEPART(minute, @fecha);
SELECT 'Second', DATEPART(second, @fecha);
SELECT 'Millisecond', DATEPART(millisecond, @fecha);
SELECT 'Microsecond', DATEPART(microsecond, @fecha);
SELECT 'nanosecond', DATEPART(nanosecond, @fecha);
SELECT 'tzoffset', DATEPART(tzoffset, @fecha);
SELECT 'Iso_week', DATEPART(iso_week, @fecha);
GO



-- Función DATETRUNC
DECLARE @fecha DATETIME2 = '2024-07-07 11:30:15.1234567'
SELECT 'Year', DATETRUNC(year, @fecha);
SELECT 'Quarter', DATETRUNC(quarter, @fecha);
SELECT 'Month', DATETRUNC(month, @fecha);
SELECT 'DayOfYear', DATETRUNC(dayofyear, @fecha);
SELECT 'Day', DATETRUNC(day, @fecha);
SELECT 'Week', DATETRUNC(week, @fecha);
SELECT 'Hour', DATETRUNC(hour, @fecha);
SELECT 'Minute', DATETRUNC(minute, @fecha);
SELECT 'Second', DATETRUNC(second, @fecha);
SELECT 'Millisecond', DATETRUNC(millisecond, @fecha);
SELECT 'Microsecond', DATETRUNC(microsecond, @fecha);
SELECT 'Iso_week', DATETRUNC(iso_week, @fecha);
GO



-- Función DAY
DECLARE @fecha DATETIME2 = '2024-07-07 11:30:15.1234567'
SELECT 'Day', DAY(@fecha);
GO



-- Función MONTH
DECLARE @fecha DATETIME2 = '2024-07-07 11:30:15.1234567'
SELECT 'Month', MONTH(@fecha);
GO



-- Función YEAR
DECLARE @fecha DATETIME2 = '2024-07-07 11:30:15.1234567'
SELECT 'Year', YEAR(@fecha);




--FUNCIONES TIMEFROMPARTS, DATEFROMPARTS, SMALLDATEFROMPARTS


-- TIMEFROMPARTS
--Propósito: Crea un valor TIME a partir de partes individuales.
--Sintaxis: TIMEFROMPARTS(hour, minute, seconds, fractions, precision)

SELECT TIMEFROMPARTS(14, 30, 15, 0, 0) AS HoraExacta;
-- Resultado: 14:30:15.0000000

-- fractions representa fracciones de segundo.
-- precision define cuántos decimales se usan para las fracciones (0 a 7).

--DATEFROMPARTS
--Propósito: Crea un valor DATE a partir de año, mes y día.
--Sintaxis:DATEFROMPARTS(year, month, day)


--Ejemplo:
SELECT DATEFROMPARTS(2025, 8, 26) AS FechaHoy;
-- Resultado: 2025-08-26

-- Muy útil para evitar errores de formato al construir fechas.

--SMALLDATETIMEFROMPARTS
--Propósito: Crea un valor SMALLDATETIME (menos preciso que DATETIME) desde año, mes, día, hora y minuto.
--Sintaxis: SMALLDATETIMEFROMPARTS(year, month, day, hour, minute)


--Ejemplo:
SELECT SMALLDATETIMEFROMPARTS(2025, 8, 26, 21, 13) AS FechaHora;
-- Resultado: 2025-08-26 21:13:00

-- No incluye segundos ni fracciones.
-- Redondea los segundos al minuto más cercano.


--EJEMPLO UDEMY

-- Podemos estar ubicados en cualquier Base de Datos

/*
Funciones TIMEFROMPARTS, DATEFROMPARTS,SMALLDATETIMEFROMPARTS 
		  DATETIMEFROMPARTS, DATETIME2FROMPARTS y DATETIMEOFFSETFROMPARTS
*/
-- Función TIMEFROMPARTS( hour, minute, seconds, fractions, precision )
SELECT TIMEFROMPARTS( 14, 23, 44, 5, 1 );
SELECT TIMEFROMPARTS( 14, 23, 44, 50, 2 );
SELECT TIMEFROMPARTS( 14, 23, 44, 500, 3 );
GO



-- Función DATEFROMPARTS( year, month, day ) 
SELECT DATEFROMPARTS( 2024, 12, 31 );
GO



-- Función SMALLDATETIMEFROMPARTS( year, month, day, hour, minute )
SELECT SMALLDATETIMEFROMPARTS( 2024, 12, 31, 14, 23 );
GO



-- Función DATETIMEFROMPARTS( year, month, day, hour, minute, seconds, milliseconds )
SELECT DATETIMEFROMPARTS( 2024, 12, 31, 14, 23, 30, 0 );
SELECT DATETIMEFROMPARTS( 2024, 12, 31, 14, 23, 30, 3 );
SELECT DATETIMEFROMPARTS( 2024, 12, 31, 14, 23, 30, 7 );
SELECT DATETIMEFROMPARTS( 2024, 12, 31, 14, 23, 30, 10 );
SELECT DATETIMEFROMPARTS( 2024, 12, 31, 14, 23, 30, 13 );
SELECT DATETIMEFROMPARTS( 2024, 12, 31, 14, 23, 30, 17 );
GO



-- Función DATETIME2FROMPARTS( year, month, day, hour, minute, seconds, fractions, precision )
SELECT DATETIME2FROMPARTS( 2024, 12, 31, 14, 23, 30, 0, 0 );  
SELECT DATETIME2FROMPARTS( 2024, 12, 31, 14, 23, 30, 5, 1 );  
SELECT DATETIME2FROMPARTS( 2024, 12, 31, 14, 23, 30, 50, 2 );  
SELECT DATETIME2FROMPARTS( 2024, 12, 31, 14, 23, 30, 500, 3 ); 
GO



-- Función DATETIMEOFFSETFROMPARTS( year, month, day, hour, minute, seconds, fractions, hour_offset, minute_offset, precision )
SELECT DATETIMEOFFSETFROMPARTS( 2024, 12, 31, 14, 23, 30, 0, 12, 0, 7 );
SELECT DATETIMEOFFSETFROMPARTS( 2024, 12, 31, 14, 30, 30, 5, 12, 30, 1 );  
SELECT DATETIMEOFFSETFROMPARTS( 2024, 12, 31, 14, 30, 30, 50, 12, 30, 2 );  
SELECT DATETIMEOFFSETFROMPARTS( 2024, 12, 31, 14, 30, 30, 500, 12, 30, 3 );  
GO  



--FUNCIONES DATEDIFF Y DATEDIFF_BIG
-- Las funciones DATEDIFF y DATEDIFF_BIG en SQL Server son herramientas esenciales 
--para calcular diferencias entre fechas.
--Ambas funciones calculan la diferencia entre dos fechas (startdate y enddate) en una unidad 
--de tiempo específica (datepart), como años, días, segundos, etc.
--Sintaxis general: DATEDIFF(datepart, startdate, enddate) DATEDIFF_BIG(datepart, startdate, enddate)


--Ejemplos prácticos
--Diferencia en días
SELECT DATEDIFF(DAY, '2020-01-01', '2020-01-10'); -- Devuelve 9

--Diferencia en milisegundos (puede exceder el rango de int)
SELECT DATEDIFF_BIG(MILLISECOND, '2020-01-01', '2021-01-01'); -- Devuelve 31,536,000,000

--Usa DATEDIFF_BIG cuando:
-- Necesitas calcular diferencias en unidades muy pequeñas (como nanosegundos).
--Las fechas están muy separadas en el tiempo.
-- Quieres evitar errores de desbordamiento por exceder el rango de int.


--EJEMPLO UDEMY

-- Podemos estar ubicados en cualquier Base de Datos

-- Funciones DATEDIFF y DATEDIFF_BIG
-- Función DATEDIFF
DECLARE @fechaInicio DATETIME2 = '2023-12-31 23:59:59.9999999'
DECLARE @fechaFin DATETIME2 = '2025-01-01 00:00:00.0000000'
SELECT 'Year',		  DATEDIFF(year,        @fechaInicio, @fechaFin);
SELECT 'Quarter',	  DATEDIFF(quarter,     @fechaInicio, @fechaFin);
SELECT 'Month',		  DATEDIFF(month,       @fechaInicio, @fechaFin);
SELECT 'DayOfYear',   DATEDIFF(dayofyear,   @fechaInicio, @fechaFin);
SELECT 'Day',		  DATEDIFF(day,         @fechaInicio, @fechaFin);
SELECT 'Week',		  DATEDIFF(week,        @fechaInicio, @fechaFin);
SELECT 'Hour',		  DATEDIFF(hour,        @fechaInicio, @fechaFin);
SELECT 'Minute',	  DATEDIFF(minute,      @fechaInicio, @fechaFin);
SELECT 'Second',	  DATEDIFF(second,      @fechaInicio, @fechaFin);
SELECT 'Millisecond', DATEDIFF(millisecond, @fechaInicio, @fechaFin);
SELECT 'Microsecond', DATEDIFF(microsecond, @fechaInicio, @fechaFin);
SELECT 'Nanosecond',  DATEDIFF(nanosecond,  @fechaInicio, @fechaFin);
SELECT 'Bytes', DATALENGTH(DATEDIFF(year,   @fechaInicio, @fechaFin)); -- Espacio en Bytes que ocupa
GO



-- Función DATEDIFF_BIG
DECLARE @fechaInicio DATETIME2 = '2023-12-31 23:59:59.9999999'
DECLARE @fechaFin DATETIME2 = '2025-01-01 00:00:00.0000000'
SELECT 'Year',		  DATEDIFF_BIG(year,        @fechaInicio, @fechaFin);
SELECT 'Quarter',	  DATEDIFF_BIG(quarter,     @fechaInicio, @fechaFin);
SELECT 'Month',		  DATEDIFF_BIG(month,       @fechaInicio, @fechaFin);
SELECT 'DayOfYear',   DATEDIFF_BIG(dayofyear,   @fechaInicio, @fechaFin);
SELECT 'Day',		  DATEDIFF_BIG(day,         @fechaInicio, @fechaFin);
SELECT 'Week',		  DATEDIFF_BIG(week,        @fechaInicio, @fechaFin);
SELECT 'Hour',		  DATEDIFF_BIG(hour,        @fechaInicio, @fechaFin);
SELECT 'Minute',	  DATEDIFF_BIG(minute,      @fechaInicio, @fechaFin);
SELECT 'Second',	  DATEDIFF_BIG(second,      @fechaInicio, @fechaFin);
SELECT 'Millisecond', DATEDIFF_BIG(millisecond, @fechaInicio, @fechaFin);
SELECT 'Microsecond', DATEDIFF_BIG(microsecond, @fechaInicio, @fechaFin);
SELECT 'Nanosecond',  DATEDIFF_BIG(nanosecond,  @fechaInicio, @fechaFin);
SELECT 'Bytes', DATALENGTH(DATEDIFF_BIG(year,   @fechaInicio, @fechaFin)); -- Espacio en Bytes que ocupa
GO



--FUNCIONES DATEADD Y EOMONTH
--Las funciones DATEADD y EOMONTH en SQL son súper útiles para manipular fechas, 
--especialmente en reportes y análisis de datos


--DATEADD: Agrega o resta unidades de tiempo a una fecha
--Sintaxis: DATEADD(intervalo, número, fecha)


-- intervalo: Tipo de unidad de tiempo (YEAR, MONTH, DAY, HOUR, etc.)
-- número: Cuántas unidades agregar (puede ser negativo para restar)
-- fecha: La fecha base
--Ejemplos:
-- Sumar 3 meses a una fecha
SELECT DATEADD(MONTH, 3, '2025-08-26') AS FechaFutura;

-- Restar 10 días
SELECT DATEADD(DAY, -10, '2025-08-26') AS FechaPasada;



-- EOMONTH: Devuelve el último día del mes de una fecha
--Sintaxis:EOMONTH(fecha [, desplazamiento])


-- fecha: Fecha base
-- desplazamiento (opcional): Número de meses a mover desde la fecha base
--Ejemplos:
-- Último día del mes actual
SELECT EOMONTH('2025-08-26') AS FinDeMes;

-- Último día del mes siguiente
SELECT EOMONTH('2025-08-26', 1) AS FinDelMesSiguiente;

--Tip práctico para entrevistas
--Si te piden calcular el último día hábil del mes o generar rangos de fechas para reportes mensuales, 
--puedes combinar ambas funciones:
-- Primer y último día del mes siguiente
SELECT 
  DATEADD(MONTH, 1, EOMONTH('2025-08-26', -1)) AS PrimerDiaMesSiguiente,
  EOMONTH('2025-08-26', 1) AS UltimoDiaMesSiguiente;



--EJEMPLO UDEMY

-- Podemos estar ubicados en cualquier Base de Datos

-- Funciones DATEADD y EOMONTH
-- Función DATEADD
DECLARE @fechaActual DATETIME2 = CURRENT_TIMESTAMP;
SELECT 'Year',		  @fechaActual, DATEADD(year,        4, @fechaActual);
SELECT 'Quarter',	  @fechaActual, DATEADD(quarter,     4, @fechaActual);
SELECT 'Month',		  @fechaActual, DATEADD(month,      13, @fechaActual);
SELECT 'DayOfYear',	  @fechaActual, DATEADD(dayofyear, 365, @fechaActual);
SELECT 'Day',		  @fechaActual, DATEADD(day,	   365, @fechaActual);
SELECT 'Week',		  @fechaActual, DATEADD(week,        5, @fechaActual);
SELECT 'WeekDay',	  @fechaActual, DATEADD(weekday,    31, @fechaActual);
SELECT 'Hour',		  @fechaActual, DATEADD(hour,       23, @fechaActual);
SELECT 'Minute',	  @fechaActual, DATEADD(minute,     59, @fechaActual);
SELECT 'Second',	  @fechaActual, DATEADD(second,     59, @fechaActual);
SELECT 'Millisecond', @fechaActual, DATEADD(millisecond, 1, @fechaActual);
SELECT 'Microsecond', @fechaActual, DATEADD(microsecond, 3, @fechaActual);
SELECT 'Nanosecond',  @fechaActual, DATEADD(nanosecond, 17, @fechaActual);
GO




DECLARE @fechaActual DATETIME2 = CURRENT_TIMESTAMP;
SELECT 'Year',		  @fechaActual, DATEADD(year,        -4, @fechaActual);
SELECT 'Quarter',	  @fechaActual, DATEADD(quarter,     -4, @fechaActual);
SELECT 'Month',		  @fechaActual, DATEADD(month,      -13, @fechaActual);
SELECT 'DayOfYear',	  @fechaActual, DATEADD(dayofyear, -365, @fechaActual);
SELECT 'Day',		  @fechaActual, DATEADD(day,	   -365, @fechaActual);
SELECT 'Week',		  @fechaActual, DATEADD(week,        -5, @fechaActual);
SELECT 'WeekDay',	  @fechaActual, DATEADD(weekday,    -31, @fechaActual);
SELECT 'Hour',		  @fechaActual, DATEADD(hour,       -23, @fechaActual);
SELECT 'Minute',	  @fechaActual, DATEADD(minute,     -59, @fechaActual);
SELECT 'Second',	  @fechaActual, DATEADD(second,     -59, @fechaActual);
SELECT 'Millisecond', @fechaActual, DATEADD(millisecond, -1, @fechaActual);
SELECT 'Microsecond', @fechaActual, DATEADD(microsecond, -3, @fechaActual);
SELECT 'Nanosecond',  @fechaActual, DATEADD(nanosecond, -17, @fechaActual);
GO



-- Función EOMONTH
DECLARE @fechaActual DATETIME2 = CURRENT_TIMESTAMP;
SELECT @fechaActual, EOMONTH(@fechaActual);
SELECT @fechaActual, EOMONTH(@fechaActual, 1);
SELECT @fechaActual, EOMONTH(@fechaActual, -1);
GO


--Funciones SET DATEFORMAT, sp_helplanguage, SET LANGUAGE y @@LANGUAGE
--Estas funciones y comandos de SQL Server son clave para manejar el formato de fechas y el idioma 
--en tus sesiones de base de datos.

--SET DATEFORMAT
-- Propósito: Define el orden en que se interpretan las partes de una fecha (mes, día, año).
-- Sintaxis: SET DATEFORMAT {mdy | dmy | ymd | ydm | myd | dym}
-- Ejemplo:
SET DATEFORMAT dmy;
SELECT CAST('31/12/2024' AS DATETIME);
-- Nota: Afecta solo la interpretación de cadenas de texto como fechas, no cómo se almacenan ni se muestran.

--SET LANGUAGE
-- Propósito: Cambia el idioma de la sesión actual, lo que afecta mensajes del sistema y el formato de fecha predeterminado.
-- Sintaxis: SET LANGUAGE Español;
-- Ejemplo:
SET LANGUAGE us_english;
SELECT GETDATE();
-- Efecto: Cambia el formato de fecha implícito (por ejemplo, mm/dd/yyyy para inglés, dd/mm/yyyy para español).

-- sp_helplanguage
--- Propósito: Muestra todos los idiomas disponibles en SQL Server y sus configuraciones.
-- Uso:
EXEC sp_helplanguage;
-- Resultado: Lista con nombre del idioma, alias, formato de fecha, primer día de la semana, etc.

-- @@LANGUAGE
-- Propósito: Devuelve el idioma actual de la sesión.
-- Uso:
SELECT @@LANGUAGE;
-- Ejemplo: Si el servidor está en inglés, devuelve us_english.

-- ¿Cómo se combinan?
-- Puedes usar SET LANGUAGE para cambiar el idioma de la sesión.
-- Luego, si necesitas un formato de fecha específico, puedes usar SET DATEFORMAT 
-- para anular el formato predeterminado del idioma.
-- Usa @@LANGUAGE para verificar el idioma actual.
-- Consulta sp_helplanguage para ver todos los idiomas disponibles y sus formatos.


--EJEMPLO UDEMY

-- Podemos estar ubicados en cualquier Base de Datos

-- Funciones SET DATEFORMAT, sp_helplanguage, SET LANGUAGE y @@LANGUAGE
-- Función SET DATEFORMAT
SET DATEFORMAT dmy
GO

SELECT '01/01/2024' AS fecha
GO



-- Procedimiento almacenado 'sp_helplanguage'
EXEC sp_helplanguage;

EXEC sp_helplanguage English;

SELECT * FROM sys.syslanguages;

SELECT * FROM sys.syslanguages
WHERE alias = 'English';
GO



-- Función SET LANGUAGE
SET LANGUAGE 'English';
SELECT '01/01/2024' AS fecha,
		DATENAME(weekday, '01/01/2024') AS nombre;
GO

SET LANGUAGE 'Spanish';
SELECT '01/01/2024' AS fecha,
		DATENAME(weekday, '01/01/2024') AS nombre;
GO



-- Función @@LANGUAGE
SELECT @@LANGUAGE AS Idioma
GO




--EJERCICIOS COMPLEJOS

-- Usar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


-- Establecer el formato de día, mes y año para las Fechas
SET DATEFORMAT dmy
GO


-- Establecer el idioma Español(Spanish) para la sesión actual
SET LANGUAGE Spanish;
SELECT @@LANGUAGE AS Idioma;
GO


-- Consultar la Tabla Production.Product
SELECT * FROM Production.Product
GO


-- Ejercicio 1
/*
Trabajar con la Tabla "Production.Product" y realizar un script 
con las siguientes especificaciones:
Mostrar las columnas ProductID, Name, ProductNumber y SellStartDate
Obtener año, mes y día de la Fecha de inicio de venta(SellStartDate)
*/
SELECT ProductID, Name, ProductNumber, SellStartDate,
		YEAR(SellStartDate) AS Year, MONTH(SellStartDate) AS Month, DAY(SellStartDate) AS Day
FROM Production.Product
GO


-- Consultar la Tabla Sales.SalesOrderHeader
SELECT * FROM Sales.SalesOrderHeader
GO


-- Ejercicio 2
/*
Trabajar con la Tabla "Sales.SalesOrderHeader" y realizar un script 
con las siguientes especificaciones:
Mostrar las columnas SalesOrderID y OrderDate
Crear una nueva columna llamada 'SpanishOrderDate' 
que va a tener el siguiente formato:
[Nombre Día de la semana] [dia] de [nombre del Mes] del [Año]
*/
SELECT SalesOrderID, OrderDate,
		DATENAME(weekday, OrderDate) + ' ' +
		CAST(DAY(OrderDate) AS CHAR(2)) + ' de ' +
		DATENAME(month, OrderDate) + ' del ' +
		CAST(YEAR(OrderDate) AS CHAR(4)) AS SpanishOrderDate
FROM Sales.SalesOrderHeader
GO


-- Consultar la Tabla Sales.SalesOrderHeader
SELECT * FROM Sales.SpecialOffer
GO


-- Ejercicio 3
/*
Trabajar con la Tabla "Sales.SalesOrderHeader" y realizar un script 
con las siguientes especificaciones:
Mostrar las columnas SpecialOfferID, Description, Type, StartDate y EndDate
Crear nuevas columnas que van calcular 
el tiempo de la oferta en Años, Meses, Semanas y Días
del valor de las columnas 'StartDate' y 'EndDate'
*/
SELECT SpecialOfferID, Description, Type, StartDate, EndDate,
		DATEDIFF(year, StartDate, EndDate) AS Year,
		DATEDIFF(month, StartDate, EndDate) AS Month,
		DATEDIFF(week, StartDate, EndDate) AS Week,
		DATEDIFF(day, StartDate, EndDate) AS Day
FROM Sales.SpecialOffer
GO


-- Consultar la Tabla HumanResources.Employee
SELECT * FROM HumanResources.Employee
GO


-- Ejercicio 3
/*
Trabajar con la Tabla "HumanResources.Employee" y realizar un script 
con las siguientes especificaciones:
Mostrar las columnas BusinessEntityID y HireDate
Crear una nueva columna 'CurrentDate' que va a mostrar la Fecha Actual del Sistema
Crear una nueva columna 'WorkYears' que van calcular en Años
los Años de Trabajo hasta la Actualidad
*/
SELECT BusinessEntityID, HireDate, CAST( GETDATE() AS DATE ) CurrentDate,
		DATEDIFF( year, HireDate, GETDATE() ) AS WorkYears,
		( ( (365 * YEAR( getdate() ) ) - ( 365 * ( YEAR( HireDate ) ) ) ) + 
		  ( MONTH( getdate() ) - MONTH( HireDate ) ) * 30 +
		  ( DAY( getdate() ) -  DAY( HireDate ) ) )/365 AS WorkYears2
FROM HumanResources.Employee
GO


--EJERCICIOS


USE NORTHWND
GO
-- Establecer el formato de día, mes y año para las Fechas
SET DATEFORMAT dmy
GO
-- Establecer el idioma Español(Spanish) para la sesión actual
SET LANGUAGE Spanish;
SELECT @@LANGUAGE AS Idioma;
GO

SELECT * FROM Employees
GO

--EJERCICIO 3

SELECT EmployeeID,FirstName,LastName,BirthDate,HireDate,
			CAST( GETDATE() AS DATE ) CurrentDate,
			--DATEDIFF( year, BirthDate, GETDATE() ) AS YEAR,
		( ( (365 * YEAR( getdate() ) ) - ( 365 * ( YEAR( BirthDate ) ) ) ) + 
		  ( MONTH( getdate() ) - MONTH( BirthDate ) ) * 30 +
		  ( DAY( getdate() ) -  DAY( BirthDate ) ) )/365 AS YEAR,
		( ( (365 * YEAR( getdate() ) ) - ( 365 * ( YEAR( HireDate ) ) ) ) + 
		  ( MONTH( getdate() ) - MONTH( HireDate ) ) * 30 +
		  ( DAY( getdate() ) -  DAY( HireDate ) ) )/365 AS WorkYears
FROM Employees
GO



--EJERCICIO 4

SELECT * FROM Orders
GO

SELECT OrderID,OrderDate,ShippedDate,
		DATENAME(weekday, OrderDate) + ' ' +
		CAST(DAY(OrderDate) AS CHAR(2)) + ' de ' +
		DATENAME(month, OrderDate) + ' del ' +
		CAST(YEAR(OrderDate) AS CHAR(4)) AS SpanishOrderDate,
		DATEDIFF(day, OrderDate,ShippedDate)AS Day,		
		DATEDIFF(minute, OrderDate,ShippedDate)AS Minute,
		DATEDIFF(second, OrderDate,ShippedDate) AS Second
FROM Orders
GO

