

--FUNCION CHOOSE

--La función CHOOSE() en SQL Server es una herramienta lógica que te permite seleccionar 
--un valor de una lista según un índice especificado. 
--Es útil para simplificar expresiones condicionales y hacer que el código sea más legible

--CHOOSE(index, value1, value2, ..., valueN)

-- index: Un número entero (basado en 1) que indica la posición del valor que se desea devolver.
-- value1, value2, ..., valueN: Lista de valores de cualquier tipo de datos.
-- Si el índice está fuera del rango (por ejemplo, menor que 1 o mayor que la cantidad de valores), 
-- la función devuelve NULL.

-- 1. Selección simple
SELECT CHOOSE(3, 'Gerente', 'Director', 'Desarrollador', 'Tester') AS Resultado;
-- Resultado: 'Desarrollador'

-- 2. Basado en columna
SELECT ProductCategoryID,
       CHOOSE(ProductCategoryID, 'A', 'B', 'C', 'D', 'E') AS Categoria
FROM Production.ProductCategory;

--Ejemplo Udemy

SELECT CHOOSE(3,'PYTHON','REDES','SQL SERVER','C#') AS Cursos;
-- devuelve SQL SERVER PORQUE ESTA EN LA POSICION 3

SELECT CHOOSE(4,100,200,300,400,500) AS Numero;
-- devuelve 400 PORQUE ESTA EN LA POSICION 4

SELECT CHOOSE(0,100,200,300,400,500) AS Numero;
-- devuelve NULL PORQUE INICIA EN LA POSICION 1

SELECT CHOOSE(1,' ') AS Item;
SELECT CHOOSE(2,' ') AS Item;

--en el priemero devuelve un espacio vacio 
--en el segundo devuelve null porque no existe la posicion 2

SELECT CHOOSE(1,NULL) AS Item;

--DEVUELVE CORRECTAMENTE LO QUE HAY EN LA POSICION 1


--FUNCION COALESCE
--La función COALESCE() en SQL es una herramienta poderosa para manejar valores nulos (NULL). 
--Su propósito principal es devolver el primer valor no nulo de una lista de expresiones

--COALESCE(valor1, valor2, ..., valorN)

-- Evalúa cada valor de izquierda a derecha.
-- Devuelve el primer valor que no sea NULL.
-- Si todos los valores son NULL, devuelve NULL

--1. Sustituir valores nulos por un texto
SELECT first_name, last_name, COALESCE(marital_status, 'Desconocido') AS estado_civil
FROM persons;
--Si marital_status es NULL, se mostrará 'Desconocido'.


--2. Combinar columnas alternativas
SELECT user_id,
       COALESCE(work_email, personal_email, 'sin correo') AS email
FROM usuarios;
--Esto mostrará el work_email si existe, si no el personal_email, 
--y si ambos son NULL, mostrará 'sin correo'.


--3. Uso con constantes y expresiones
SELECT COALESCE(NULL, NULL, 5 + 3, 'Texto') AS resultado;
-- Resultado: 8


--EJEMPLO UDEMY

SELECT COALESCE(NULL,100,200,'NO DISPONIBLE') AS RESULTADO
--DEVUELVE 100
SELECT COALESCE(NULL,200,300,'NO DISPONIBLE') AS RESULTADO
--DEVUELVE 200

SELECT COALESCE(NULL,'NO DISPONIBLE',200,100) AS RESULTADO
--LOS VALORES NUMERICOS DEBE IR PRIMERO QUE LOS VALORES DE CADENA

SELECT COALESCE(NULL,'HUGO','PACO','LUIS') AS RESULTADO
--DEVUELVE HUGO



--FUNCION GREATEST

--La función GREATEST() en SQL se utiliza para obtener el valor máximo entre una lista de expresiones. 
--Es especialmente útil cuando quieres comparar múltiples columnas o valores en una misma fila

--SELECT GREATEST(valor1, valor2, valor3, ..., valorN);

-- Devuelve el mayor valor entre todos los argumentos.
-- Puede aceptar hasta 254 expresiones.
-- Ignora los valores NULL si hay al menos un valor no nulo.
-- Si todos los valores son NULL, devuelve NULL.


SELECT GREATEST ('6.6', 3.152,20)AS RESUELTADO
--DEVUELVE 20 PORQUE ES EL MAXIMO VALOR

SELECT GREATEST ('30.8', 3.152,20)AS RESUELTADO
--DEVUELVE 30.8 PORQUE ES EL MAXIMO VALOR Y SQL LO CONVIERTE EN FLOTANTE

SELECT GREATEST ('BIENVENIDO', 'HASTA LUEGO','HOLA')AS RESUELTADO
--DEVUELVE HOLA PORQUE TIENE EL MAYOR CARACTER LEXICOGRAFICO EN ESTE CASO H


--FUNCION LEAST
--La función LEAST() en SQL se utiliza para obtener el valor mínimo entre una lista de expresiones. 
--Es el complemento perfecto de GREATEST().

--SELECT LEAST(valor1, valor2, valor3, ..., valorN);

-- Devuelve el menor valor entre todos los argumentos.
-- Admite hasta 254 expresiones.
-- Si todos los valores son NULL, devuelve NULL.
-- Si hay al menos un valor no nulo, ignora los NULL.


SELECT LEAST('90.3',3.152,20)AS RESULTADO
--DEVUELVE 3.152 PORQUE ES EL MENOR VALOR

SELECT LEAST('1.1',3.152,20)AS RESULTADO
--DEVUELVE 1.1 PORQUE ES EL MENOR VALOR SQL LO CONVIERTE EN FLOAT

SELECT LEAST('BIENVENIDO', 'HASTA LUEGO','HOLA')AS RESUELTADO
--DEVUELVE BIENVENIDO PORQUE B ES EL MENOR VALOR LEXICOGRAFICO 


--FUNCION IIF
--Devuelve uno de dos valores dependiendo de si una expresión booleana se evalúa 
--como verdadera (TRUE) o falsa (FALSE). Es útil para realizar evaluaciones condicionales 
--directamente en una consulta

--IIF(expresión_booleana, valor_si_verdadero, valor_si_falso)

-- expresión_booleana: condición que se evalúa.
-- valor_si_verdadero: valor que se devuelve si la condición es verdadera.
-- valor_si_falso: valor que se devuelve si la condición es falsa.

SELECT IIF(500 < 1000, 'Sí', 'No') AS Resultado;
-- Resultado: 'Sí'


--EJEMPLO UDEMY

DECLARE @n1 INT = 45, @n2 INT = 40;

SELECT IIF(@n1 > @n2, 'TRUE','FALSE')AS RESULTADO;
--DEVUELVE TRUE @n1 si es mayor


DECLARE @n1 INT = 35, @n2 INT = 40;

SELECT IIF(@n1 > @n2, 'TRUE','FALSE')AS RESULTADO;
--DEVUELVE FALSE @n1 NO es mayor


DECLARE @n1 INT = 35, @n2 INT = 40;

SELECT IIF(@n1 > @n2, NULL,NULL)AS RESULTADO;
--NO SE PUEDEN USAR NULOS COMO RESULTADO FALSO O VERDADERO


--FUNCION NULLIF
--La función NULLIF() en SQL es una herramienta muy útil para manejar comparaciones y evitar errores 
--como divisiones por cero. Aquí te explico cómo funciona y cuándo usarla:
--¿Qué hace NULLIF()?
--La función NULLIF(expr1, expr2) compara dos expresiones:
-- Si son iguales, devuelve NULL.
-- Si son diferentes, devuelve la primera expresión (expr1).
--Es equivalente a una expresión CASE que evalúa si dos valores son iguales y retorna NULL si lo son.

--NULLIF(expression1, expression2)

-- expression1: Primera expresión a evaluar.
-- expression2: Segunda expresión con la que se compara.


SELECT NULLIF(100, 100);  -- Devuelve NULL
SELECT NULLIF(100, 200);  -- Devuelve 100
SELECT NULLIF('Hola', 'Hola');  -- Devuelve NULL
SELECT NULLIF('Hola', 'Mundo'); -- Devuelve 'Hola'

--Evitar divisiones por cero:
SELECT cantidad / NULLIF(precio, 0) FROM productos;
-- Si precio es 0, NULLIF lo convierte en NULL, evitando el error de división por cero.
-- Limpiar datos: Puedes usarlo para convertir ciertos valores repetidos o no deseados en NULL, 
-- facilitando el análisis.


--EJEMPLO UDEMYS

SELECT NULLIF(25,25)AS RESULTADO
SELECT NULLIF(50,25)AS RESULTADO
SELECT NULLIF('AMIGO','AMIGO')AS RESULTADO
SELECT NULLIF('HOLA AMIGO','HOLA MUNDO')AS RESULTADO


--EJERCICIOS COMPLEJOS

-- Usar la Base de Datos AdventureWorks2022
USE AdventureWorks2022
GO


-- Consultar la Tabla Sales.Customer
SELECT * FROM Sales.Customer
GO

-- Ejercicio 1
/*
Mostrar el idCliente(CustomerID), idTerritorio(TerritoryID) de la Tabla Cliente(Customer) y
también crear una nueva columna llamada 'Continente' en base a las siguientes condiciones:
Si el valor del campo TerritoryID es 1 debe reemplazar el valor a "America"
Si el valor del campo TerritoryID es 2 debe reemplazar el valor a "Europa"
Si el valor del campo TerritoryID es 3 debe reemplazar el valor a "África"
Si el valor del campo TerritoryID es 4 debe reemplazar el valor a "Asia"
Si el valor del campo TerritoryID es 5 debe reemplazar el valor a "Oceanía"
Si el valor del campo TerritoryID es 6 debe reemplazar el valor a "America"
Si el valor del campo TerritoryID es 7 debe reemplazar el valor a "Europa"
Si el valor del campo TerritoryID es 8 debe reemplazar el valor a "África"
Si el valor del campo TerritoryID es 9 debe reemplazar el valor a "Asia"
Si el valor del campo TerritoryID es 10 debe reemplazar el valor a "Oceanía"
*/

SELECT CustomerID,TerritoryID, 
		CHOOSE(TerritoryID,
		'AMERICA','EUROPA','AFRICA','ASIA','OCEANIA',
		'AMERICA','EUROPA','AFRICA','ASIA','OCEANIA')AS CONTINENTE
FROM Sales.Customer
GO	

-- Consultar la Production.Product
SELECT * FROM Production.Product
GO

-- Ejercicio 2
/*
De la Tabla Producto(Product) consultar las columnas nombre(Name),
clase(Class), color(Color), numero del producto(ProductNumber) y
también crear una nueva columna llamada 'primerNoNull' en base a las siguientes condiciones:
Como primera prioridad mostrar el valor de la columna 'Class' siempre que no sea NULL
Como segunda prioridad mostrar el valor de la columna 'Color' siempre que no sea NULL
Como tercera prioridad mostrar el valor de la columna 'ProductNumber' siempre que no sea NULL
*/

SELECT Name,Class,Color,productNumber,
		COALESCE(Class,Color,ProductNumber,'Desconocido') AS primerNoNull		
FROM Production.Product
GO



-- Consultar la Production.Product
SELECT * FROM Production.Product
GO

-- Ejercicio 3
/*
De la Tabla Producto(Product) consultar las columnas idProducto(ProductID),
marca bandera(MakeFlag), marca bandera terminado(FinishedGoodsFlag)
Donde el valor de la columna 'ProductID' sea menor a 320 y
también crear una nueva columna llamada 'verificado' en base a las siguientes condiciones:
Si los valores de las columnas 'MakeFlag' y 'FinishedGoodsFlag' son iguales, asignar el valor de NULL
Si los valores de las columnas 'MakeFlag' y 'FinishedGoodsFlag' son diferentes, asignar el valor de la columna 'MakeFlag'
Ordenar de manera Ascendente por la columna "ProductID"
*/

SELECT ProductID,MakeFlag,FinishedGoodsFlag,
		IIF(MakeFlag = FinishedGoodsFlag,NULL,MakeFlag) AS VERIFICADO		
FROM Production.Product
WHERE ProductID < 320
ORDER BY ProductID
GO

SELECT ProductID,MakeFlag,FinishedGoodsFlag,
		NULLIF(MakeFlag,FinishedGoodsFlag) AS VERIFICADO		
FROM Production.Product
WHERE ProductID < 320
ORDER BY ProductID
GO



--Ejercicio 1:
--Trabajar con la Tabla “Employee” que pertenece al esquema “HumanResources” y resolver lo siguiente:
--Realizar un Script que muestre el Estado Civil (MaritalStatus) y Genero (Género), 
--también crear columnas adicionales que cumplan con la siguiente condición:
--Si el valor del campo “MaritalStatus” es “M” se debe reemplazar el valor a “Married” 
--sino el valor será “Single”.
--Si el valor del campo “Gender” es “M” se debe reemplazar el valor a “Male” 
--sino el valor será “Female”.

SELECT * FROM HumanResources.Employee
GO

SELECT MaritalStatus,Gender,
			IIF(MaritalStatus = 'M','MARRIED','SINGLE') AS ESTADO_CIVIL,
			IIF(Gender = 'M','MALE','FEMALE') AS GENERO
FROM HumanResources.Employee
GO


--Ejercicio 2:
--Trabajar con la Tabla “Product” que pertenece al esquema “Production” y resolver lo siguiente:
--Realizar un Script que muestre el Nombre (Name), Fecha de inicio de venta (SellStartDate), 
--Fecha de discontinuación (DiscontinuedDate) y Fecha de modificación (ModifiedDate), 
--también crear una columna adicional que cumplan con la siguiente condición:
--Mostrar la última fecha comparando el valor de las columnas “SellStartDate, DiscontinuedDate y ModifiedDate”.
--Mostrar la fecha más reciente comparando el valor de las columnas “SellStartDate, 
--DiscontinuedDate y ModifiedDate”.
SELECT * FROM Production.Product
GO

SELECT Name,SellStartDate,DiscontinuedDate,ModifiedDate,
		GREATEST(SellStartDate,DiscontinuedDate,ModifiedDate) AS ULTIMA_FECHA,		
		GREATEST(SellStartDate) AS MAS_RECIENTE	
FROM Production.Product
GO






