

--PRINT

PRINT 'HOLA MUNDO';

PRINT HOLA MUNDO;

PRINT ('HOLA MUNDO');

PRINT 10;

PRINT 10.776877;

PRINT 10.334 AS DECIMALES; --NO ES POSIBLE DEFINIR ALIAS


--SELECT

SELECT 'HOLA MUNDO';

SELECT HOLA MUNDO;

SELECT ('HOLA MUNDO');

SELECT 10;

SELECT 10.776877;

SELECT 10.334 AS DECIMALES;



-- Podemos ubicarnos en cualquier Base de Datos --

-- Instrucción BEGIN ... END
BEGIN
	PRINT 'Hola mundo';
	PRINT 'Hola mundo2';
	SELECT 'Hola mundo3';
END
GO

BEGIN
	PRINT 'Pablo';
	PRINT 'Valera';
	SELECT 'Pablo Valera';
END
GO


--VARIABLES

DECLARE @nombre VARCHAR(20)='PABLO'
DECLARE @apellido VARCHAR(20)
BEGIN
	SET @apellido ='VALERA'

	PRINT(@nombre)
	PRINT(@apellido)
	PRINT(@nombre+' '+@apellido)
END
GO


--BLOQUE DE EJECUCION ANIDADO

-- Podemos ubicarnos en cualquier Base de Datos --

-- Bloques de Ejecución Anidados
BEGIN
	PRINT('Bloque de Ejecución Padre')

	DECLARE @numero TINYINT = 10

	BEGIN

		PRINT('Bloque de Ejecución Hijo')
		PRINT(@numero)

	END

END
GO


--VARIABLES DE BLOQUE DE EJECUCION


-- Podemos ubicarnos en cualquier Base de Datos --

-- Ámbito de las Variables en Bloques de Ejecución

DECLARE @variableGlobal SMALLINT = 100  -- Variable Global
PRINT('Variable Global:')
PRINT(@variableGlobal)

BEGIN -- Bloque de Ejecución Padre

	DECLARE @variablePrimario SMALLINT = 200  -- Variable Local Primario
	PRINT('Variable Primario:')
	PRINT(@variablePrimario)

	BEGIN -- Bloque de Ejecución Hijo
		
		DECLARE @variableSegundario SMALLINT = 300  -- Variable Local Segundario
		PRINT('Variable Segundario:')
		PRINT(@variableSegundario)

	END

END
GO

--USO DE VARIABLE GLOBAL DENTRO DEL BLOQUE

DECLARE @variableGlobal SMALLINT = 100  -- Variable Global
PRINT('Variable Global:')
PRINT(@variableGlobal)

BEGIN -- Bloque de Ejecución Padre

	DECLARE @variablePrimario SMALLINT = 200  -- Variable Local Primario
	PRINT('Variable Primario:')
	PRINT(@variablePrimario)

	PRINT('Variable Global:')
	PRINT(@variableGlobal)

	BEGIN -- Bloque de Ejecución Hijo
		
		DECLARE @variableSegundario SMALLINT = 300  -- Variable Local Segundario
		PRINT('Variable Segundario:')
		PRINT(@variableSegundario)

		PRINT('Variable Global:')
		PRINT(@variableGlobal)

	END

END
GO

--VARIABLE DE BLOQUE PADRE EN BLOQUE HIJO

DECLARE @variableGlobal SMALLINT = 100  -- Variable Global
PRINT('Variable Global:')
PRINT(@variableGlobal)

BEGIN -- Bloque de Ejecución Padre

	DECLARE @variablePrimario SMALLINT = 200  -- Variable Local Primario
	PRINT('Variable Primario:')
	PRINT(@variablePrimario)

	PRINT('Variable Global:')
	PRINT(@variableGlobal)

	BEGIN -- Bloque de Ejecución Hijo
		
		DECLARE @variableSegundario SMALLINT = 300  -- Variable Local Segundario
		PRINT('Variable Segundario:')
		PRINT(@variableSegundario)

		PRINT('Variable Global:')
		PRINT(@variableGlobal)

		PRINT('Variable Primario:')
		PRINT(@variablePrimario)

	END

END
GO

--INSTRUCCION IF...ELSE

-- Puedes ubicarte en cualquier Base de Datos

 USE NORTHWND
 GO
/*
Crear una variable "edad" y le debes asignar un valor
para mostrar un mensaje indicando si es mayor o menor de edad.
Nota: Para ser mayor de edad debes tener una edad mayor o igual a 18 años
*/
DECLARE @edad TINYINT = 20

IF @edad >= 18
	PRINT('Eres mayor de edad.') -- Solo una instrucción
ELSE
	PRINT('Eres menor de edad.')
GO

-- Utilizando Bloque de Ejecución
DECLARE @edad TINYINT = 20

IF @edad >= 18
BEGIN
	PRINT('Eres mayor de edad.')
	PRINT('Eres mayor de edad.')
END
ELSE
BEGIN
	PRINT('Eres menor de edad.')
END
GO



/*
Crear dos dos variables "venta" y "bono"
Si las ventas son mayores a 20 000 el bono es 500
Si las ventas son mayores a 50 000 el bono es 900
De lo contrario el bono es 100
*/
DECLARE @venta INT = 70000
DECLARE @bono SMALLINT = 0

IF @venta > 50000
BEGIN
	SET @bono = 900
	PRINT('Venta:')
	PRINT(@venta)
	PRINT('Bono:')
	PRINT(@bono)
END
ELSE
	BEGIN
	IF @venta > 20000
	BEGIN
		SET @bono = 500
		PRINT('Venta:')
		PRINT(@venta)
		PRINT('Bono:')
		PRINT(@bono)
	END
	ELSE
	BEGIN
		SET @bono = 100
		PRINT('Venta:')
		PRINT(@venta)
		PRINT('Bono:')
		PRINT(@bono)
	END
END
GO


-- Ejercicio Propuesto 1
/*
Crear una variable que contendrá un valor Entero asignado por nosotros
Se debe indicar un mensaje si el valor asignado es PAR o IMPAR.
Nota: Debes utilizar el Operador Aritmético "MOD(%)"
*/
DECLARE @numero SMALLINT = 10

IF @numero % 2 = 0
BEGIN
	PRINT('El número es PAR.')
END
ELSE
BEGIN
	PRINT('El número es IMPAR.')
END
GO


-- Ejercicio Propuesto 2
/*
Crear una Variable llamado "caracter" de tipo CHAR(1)
la cual va a aceptar un valor de la letra "A" hasta la letra "E"
Y dependiendo de la letra asignada se debe mostrar el siguiente mensaje:
"A" -> "País de Argentina".
"B" -> "País de Brasil".
"C" -> "País de Colombia".
"D" -> "País de Dinamarca".
"E" -> "País de Ecuador".
Si se ingresa una letra fuera de la lista, mostrar el mensaje:
"País fuera de la lista"
*/
DECLARE @caracter CHAR(1) = 'A'

IF @caracter = 'A'
	PRINT('País de Argentina.')
ELSE
	IF @caracter = 'B'
		PRINT('País de Brasil.')
	ELSE
		IF @caracter = 'C'
			PRINT('País de Colombia.')
		ELSE
			IF @caracter = 'D'
				PRINT('País de Dinamarca.')
			ELSE
				IF @caracter = 'E'
					PRINT('País de Ecuador.')
				ELSE
					PRINT('País fuera de la lista.')
GO



--INSTRUCCION CASE



-- Puedes ubicarte en cualquier Base de Datos

/*
Crer dos dos variables "venta" y "bono"
Si las ventas son mayores a 20 000 el bono es 500
Si las ventas son mayores a 50 000 el bono es 900
De lo contrario el bono es 100
*/
DECLARE @venta INT = 40000
DECLARE @bono SMALLINT = 0

BEGIN
	SET @bono = (CASE
					WHEN @venta > 50000 THEN 900
					WHEN @venta > 20000 THEN 500
					ELSE 100
				 END)
	PRINT('Venta:')
	PRINT(@venta)
	PRINT('Bono:')
	PRINT(@bono)
END
GO



-- Utilizar la Base de Datos NORTHWND
USE NORTHWND
GO


-- Consultar la Tabla Productos(Products)
SELECT * FROM Products
GO


/*
Consultar las columnas "ProductID, ProductName, CategoryID y UnitPrice" 
de la Tabla Productos(Products) y crear otra columna para definir lo siguiente:
Si el valor de CategoryID es 1 el nuevo valor será "Bebidas"
Si el valor de CategoryID es 2 el nuevo valor será "Condimentos"
Si el valor de CategoryID es 3 el nuevo valor será "Dulces"
Si el valor de CategoryID es 4 el nuevo valor será "Productos lácteos"
De lo contrario el valor será "Otros"
*/
SELECT ProductID, ProductName, CategoryID,
	CASE
		WHEN CategoryID = 1 THEN 'Bebidas'
		WHEN CategoryID = 2 THEN 'Condimentos'
		WHEN CategoryID = 3 THEN 'Dulces'
		WHEN CategoryID = 4 THEN 'Productos lácteos'
		ELSE 'Otros'
	END AS Categoria,
	UnitPrice
FROM Products
GO

--SI NO SE ESPECIFICA LA INTRUCCION ELSE MARCARA NULL EN LOS VALORES DE CATEGORIA SIN CONDICION CASE 

SELECT ProductID, ProductName, CategoryID,
	CASE
		WHEN CategoryID = 1 THEN 'Bebidas'
		WHEN CategoryID = 2 THEN 'Condimentos'
		WHEN CategoryID = 3 THEN 'Dulces'
		WHEN CategoryID = 4 THEN 'Productos lácteos'
		--ELSE 'Otros'
	END AS Categoria,
	UnitPrice
FROM Products
GO


SELECT * FROM Customers

--CONSULTAR LAS COLUMNAS "CustomerID, CompanyName, ContactName y Country" DE LA TABLA CUSTOMERS
--CREAR UNA COLUMNA LLAMADA PAIS PARA DEFINIR LO SIGUIENTE
--SI EL VALOR DE COUNTRY ES GERMANY EL NUEVO VALOR SERA ALEMANIA
--SI EL VALOR DE COUNTRY ES UK EL NUEVO VALOR SERA REINO UNIDO
--SI EL VALOR DE COUNTRY ES FRANCE EL NUEVO VALOR SERA FRANCIA
--SI EL VALOR DE COUNTRY ES SPAIN EL NUEVO VALOR SERA ESPAÑA
--DE LO CONTRARIO EL VALOR DEL CAMPO SERA COUNTRY
--ORDENAR DE MANERA ASCENDENTE POR LA COLUMNA PAIS


SELECT CustomerID, CompanyName, ContactName, Country,
	CASE
		WHEN Country = 'Germany' THEN 'Alemania'
		WHEN Country = 'UK' THEN 'Reino Unido'
		WHEN Country = 'France' THEN 'Francia'
		WHEN Country = 'Spain' THEN 'España'
		ELSE 'Otros'
	END AS Pais 
FROM Customers
ORDER BY Pais
GO


--OPERADOR LOGICO EXISTS


USE NORTHWND
GO

/*
Crear una variable llamado "idEmpleado" y le debes asignar un valor
para mostrar los datos del empleado 
y si el "idEmpleado" no existe se debe mostrar el mensaje:
"El empleado no existe!"
*/

SELECT * FROM Employees
GO

DECLARE @idEmpleado TINYINT = 7

IF EXISTS (SELECT * FROM Employees WHERE EmployeeID = @idEmpleado)
BEGIN
	PRINT 'EL EMPLEADO EXISTE!'
	PRINT ''
	SELECT * FROM Employees WHERE EmployeeID = @idEmpleado
END
ELSE
BEGIN
	PRINT 'EL EMPLEADO NO EXISTE!'
END
GO

-- Ejercicio Propuesto

SELECT * FROM Products
GO

/*
Crear una variable llamado "precio" y le debes asignar un valor
para mostrar los Productos(Products) donde el valor de la
variable "precio" debe ser mayor o igual al valor del campo "UnitPrice"
Si el "precio" no existe se debe mostrar el mensaje:
"No se ha encontrado ningún producto!"
Ordenar de manera Descendente por el campo "UnitPrice"
*/


DECLARE @Precio INT = 10

IF EXISTS (SELECT * FROM Products WHERE UnitPrice >= @Precio)
BEGIN
	PRINT 'PRODUCTOS: !'
	PRINT ''
	SELECT * FROM Products WHERE UnitPrice >= @Precio ORDER BY UnitPrice
END
ELSE
BEGIN
	PRINT 'PRODUCTO NO ENCONTRADO!'
END
GO

--EJERCICIO MEJORADO RESUELTO 

DECLARE @Precio DECIMAL(7,2) = 50

IF EXISTS (SELECT * FROM Products WHERE UnitPrice >= @Precio)
BEGIN
	PRINT 'PRODUCTOS: !'
	PRINT ''
	SELECT * FROM Products WHERE UnitPrice >= @Precio ORDER BY UnitPrice DESC
END
ELSE
BEGIN
	PRINT 'PRODUCTO NO ENCONTRADO!'
END
GO


--INSTRUCCION WHILE


/*
Utilizando el bucle WHILE debes mostrar
los números del 1 al 10
*/
DECLARE @contador INT
SET @contador = 1

WHILE @contador <= 10
BEGIN
	PRINT('El valor de la Variable Contador es: ' + CAST( @contador AS VARCHAR(10) ) )
	-- SET @contador = @contador + 1
	SET @contador += 1
END
GO


/*
Calcular la Suma de los números PARES 
del 1 hasta el valor que le asignemos a una variable.
*/


DECLARE @numero INT = 10
DECLARE @contador INT = 1
DECLARE @suma INT = 0

WHILE @contador <=  @numero
BEGIN
	IF @contador % 2 = 0
	BEGIN
		--SET @suma = @suma + @contador
		SET @suma += @contador
	END
	
	SET @contador += 1
END

PRINT('LA SUMA DE LOS NUEMROS PARES DEL 1 HASTA '+ CAST(@numero AS VARCHAR(10)) +
		' ES: ' + CAST(@suma AS VARCHAR(10)))
GO


-- Ejercicio Propuesto
/*
Crear una Variable en la cual se le asignará un valor numérico
y se debe crear la Tabla de Multiplicar del 1 al 12
*/

DECLARE @num INT = 5
DECLARE @contador INT = 1
DECLARE @mult INT = 0
PRINT('TABLA MULTIPLICAR DEL: '+CAST(@num AS VARCHAR(10)))
WHILE @contador <= 12
BEGIN
	SET @mult = @contador * @num	
	PRINT( CAST(@contador AS VARCHAR(10)) + ' * ' + CAST(@num AS VARCHAR(10)) +  ' = ' + CAST( @mult  AS VARCHAR(10)))
	-- SET @contador = @contador + 1
	SET @contador += 1	
END
GO

--EJERCICIO RESUELTO EN VIDEO

DECLARE @numero INT = 9
DECLARE @contador INT = 1

PRINT('Tabla de Multiplicar del ' + CAST(@numero AS VARCHAR(10)) )
PRINT('-----------------------------')
WHILE @contador <= 12
BEGIN
	PRINT( CAST(@numero AS VARCHAR(10)) + ' * ' + CAST(@contador AS VARCHAR(10)) + 
			' = ' + CAST(@numero * @contador AS VARCHAR(10)) )
	-- SET @contador = @contador + 1
	SET @contador += 1
END
GO


--INSTRUCCION BREAK 

-- Puedes ubicarte en cualquier Base de Datos

/*
Escribe un script que imprima los números del 1 al 10 
utilizando un bucle WHILE. 
Si el contador alcanza el valor 5, 
se debe salir del bucle usando BREAK.
*/
DECLARE @contador TINYINT = 1

WHILE @contador <= 10
BEGIN
    PRINT 'El valor de la Variable Contador es: ' + CAST(@contador AS VARCHAR(3))
    IF @contador = 5
    BEGIN
        BREAK -- Salir del bucle si el contador es 5
    END
    SET @contador = @contador + 1
END
GO

-- Ejercicio Propuesto
/*
Escribe un script que sume los números impares del 1 al 20
utilizando un bucle WHILE. 
Si la suma supera el valor 50, 
se debe salir del bucle usando BREAK.
*/

DECLARE @contador INT = 1
DECLARE @suma INT = 0

WHILE @contador <= 20
BEGIN
    IF @contador % 2 <> 0
     BEGIN
        SET @suma += @contador 
	 END
	IF  @suma > 50 
	BEGIN
		PRINT 'La suma ha superado el límite de 50.'
        BREAK -- Salir del bucle si la suma supera 50
	END
	SET @contador += 1
END
PRINT'La suma Total es: ' + CAST(@suma AS VARCHAR(5))
GO