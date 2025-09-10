

--INSTRUCCION CONTINUE

-- Puedes ubicarte en cualquier Base de Datos

/*
Escribe un script que sume los números del 1 al 20,
pero omite los múltiplos de 5 utilizando CONTINUE.
*/
DECLARE @contador SMALLINT = 1
DECLARE @suma SMALLINT = 0

WHILE @contador <= 20
BEGIN
    IF @contador % 5 = 0
    BEGIN
        SET @contador = @contador + 1
        CONTINUE -- Omitir los múltiplos de 5
    END

    SET @suma = @suma + @contador
    SET @contador = @contador + 1;

END

PRINT 'La suma de los números del 1 al 20, excepto los múltiplos de 5, es: ' + CAST(@suma AS VARCHAR(6));
GO


-- Ejercicio Propuesto
/*
Escribe un script que multiplique los números del 1 al 10,
pero omite el número 5 utilizando CONTINUE.
*/

DECLARE @contador INT = 1
DECLARE @mult INT = 1

WHILE @contador <= 10
BEGIN
    IF @contador = 5
    BEGIN
        SET @contador = @contador + 1
        CONTINUE -- Omitir los múltiplos de 5
    END

    SET @mult = @mult * @contador
    SET @contador = @contador + 1;

END

PRINT 'La Multiplicacion de los números del 1 al 10, excepto el  5, es: ' + CAST(@mult AS VARCHAR(6));
GO


--INSTRUCCION RETURN


-- Puedes ubicarte en cualquier Base de Datos

/*
Escribe un script que sume los números del 1 al 20,
pero cuando la suma sea mayor a 100 debe de terminar el procedimiento.
*/
DECLARE @contador SMALLINT = 1
DECLARE @suma SMALLINT = 0

WHILE @contador <= 20
BEGIN
    IF @suma > 100
    BEGIN
		PRINT 'La suma total mayor a 100 es: ' + CAST(@suma AS VARCHAR(6));
        RETURN -- Omitir los múltiplos de 5
    END

    SET @suma = @suma + @contador
    SET @contador = @contador + 1;

END
GO


--INSTRUCCION GO TO

-- Puedes ubicarte en cualquier Base de Datos

DECLARE @contador TINYINT = 1
WHILE @contador < 10  
BEGIN   
    
    IF @contador = 4 GOTO etiqueta_uno	-- Salta a la primera etiqueta.
    IF @contador = 5 GOTO etiqueta_dos  -- Esto nunca se ejecutará.
	SET @contador = @contador + 1  
END  
etiqueta_uno:
    PRINT 'Saltando a la etiqueta Uno.'
    GOTO etiqueta_tres	-- Esto evitará que Etiqueta Dos se ejecute.
etiqueta_dos:
    PRINT 'Saltando a la etiqueta Dos.'
etiqueta_tres:  
    PRINT 'Saltando a la etiqueta Tres.'



--INSTRUCCION TRY -CATCH


-- Puedes ubicarte en cualquier Base de Datos

-- Dividir 50/2
SELECT 50/2
GO
--PRINT 50/2
--GO


-- Dividir 50/0
SELECT 50/0
GO
--PRINT 50/0
--GO


-- Dividir 50/0 utilizando TRY...CATCH
BEGIN TRY
	PRINT 50/0 -- Con otro divisor devuelve el resultado correcto
END TRY
BEGIN CATCH
	PRINT('No es posible realizar la división entre cero.')
END CATCH
GO



-- Declarar una variable con errores
DECLARE @numero INT = 'Texto'
GO


-- Declarar una variable con errores utilizando TRY...CATCH
BEGIN TRY
	DECLARE @numero INT = 'Texto'
END TRY
BEGIN CATCH
	PRINT('No es posible asignar un valor de cadena a un tipo de dato entero.');
END CATCH
GO


--INSTRUCCION THROW


-- Puedes ubicarte en cualquier Base de Datos

-- Utilizar la instrucción THROW
THROW 50001, 'Ha ocurrido un error', 10
GO


-- Utilizar la instrucción THROW en el ejemplo del capítulo anterior
BEGIN TRY
	DECLARE @numero INT = 'Texto'
END TRY
BEGIN CATCH
	PRINT('No es posible asignar un valor de cadena a un tipo de dato entero.');
 	THROW 50001, 'Ha ocurrido un error', 10
END CATCH
GO


-- Utilizar la instrucción THROW sin Argumentos
BEGIN TRY
	DECLARE @numero INT = 'Texto'
END TRY
BEGIN CATCH
	PRINT('No es posible asignar un valor de cadena a un tipo de dato entero.');
 	THROW
END CATCH
GO