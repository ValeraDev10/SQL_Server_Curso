


--FUNCION ABS
--La función ABS() en SQL se utiliza para obtener el valor absoluto de una expresión numérica, 
--es decir, convierte cualquier número negativo en positivo y deja los positivos y ceros sin cambios.

--SELECT ABS(expresión_numérica);


DECLARE @numero SMALLINT = -100
PRINT ABS(@numero)
GO

DECLARE @numero SMALLINT = 0
PRINT ABS(@numero)
GO

DECLARE @numero SMALLINT = 100
PRINT ABS(@numero)
GO


--FUNCION SIGN
--La función SIGN() en SQL se utiliza para determinar el signo de un número. 
--Es una función matemática que devuelve:
-- 1 si el número es positivo
-- 0 si el número es cero
-- -1 si el número es negativo

--SIGN(número)


DECLARE @numero SMALLINT = -100
PRINT SIGN(@numero)
GO

DECLARE @numero SMALLINT = 0
PRINT SIGN(@numero)
GO

DECLARE @numero SMALLINT = 100
PRINT SIGN(@numero)
GO


--FUNCION ROUND
--La función ROUND() en SQL se utiliza para redondear un número a una cantidad específica 
--de decimales o posiciones enteras

--ROUND(número, decimales [, operación])

-- Redondear a 2 decimales
SELECT ROUND(235.415, 2);  -- Resultado: 235.42

-- Redondear a 0 decimales (entero más cercano)
SELECT ROUND(235.415, 0);  -- Resultado: 235

-- Truncar a 2 decimales
SELECT ROUND(235.415, 2, 1);  -- Resultado: 235.41

-- Redondear a la decena más cercana
SELECT ROUND(235.415, -1);  -- Resultado: 240


SELECT ROUND(123.12345, 2)

SELECT ROUND(123.12345, 0)

SELECT ROUND(123.12345, -2)

SELECT ROUND(123.9994, 3), ROUND(123.9995, 3)

SELECT ROUND(150.75, 0)



--FUNCION SQUARE
--La función SQUARE() en SQL se utiliza para calcular el cuadrado de un número. 

--SQUARE(float_expression)

SELECT SQUARE(5);  -- Resultado: 25

PRINT SQUARE(25); --625
PRINT SQUARE(12.36); --152.77




--FUNCION POWER
--La función POWER() en SQL se utiliza para elevar un número a una potencia específica. 

--POWER(base, exponente)

SELECT POWER(4, 2);  -- Resultado: 16
SELECT POWER(2, 3);  -- Resultado: 8

SELECT POWER(5, 2);  -- Resultado: 25
SELECT POWER(22.3, 3);  -- Resultado: 11089



--FUNCION SQRT
--La función SQRT() en SQL se utiliza para calcular la raíz cuadrada de un número positivo. 

--SQRT(float_expression)


SELECT SQRT(25);  -- Resultado: 5
SELECT SQRT(2.25);  -- Resultado: 1.5

SELECT SQRT(625);  -- Resultado: 25
SELECT SQRT(130);  -- Resultado: 11.40175
SELECT SQRT(200.90);  -- Resultado: 14.173919


--FUNCION CEILING
--La función CEILING() en SQL devuelve el entero más pequeño que sea mayor o igual al número especificado. 
--Es útil cuando quieres redondear hacia arriba, sin importar los decimales.

--CEILING(numeric_expression)

SELECT CEILING(25.75) AS Resultado;  -- Devuelve: 26
SELECT CEILING(-13.5) AS Resultado;  -- Devuelve: -13
SELECT CEILING(0.0) AS Resultado;    -- Devuelve: 0


PRINT CEILING(25.15) -- 26





--FUNCION FLOOR
--La función FLOOR() en SQL devuelve el entero más grande que sea menor o igual al número especificado. 
--Es decir, redondea hacia abajo, sin importar los decimales

--FLOOR(numeric_expression)




SELECT FLOOR(27.35) AS Resultado;   -- Devuelve: 27
SELECT FLOOR(-123.45) AS Resultado; -- Devuelve: -124
SELECT FLOOR(0.99) AS Resultado;    -- Devuelve: 0


PRINT FLOOR(25.95)-- 25



--FUNCION LOG
--La función LOG() en SQL se utiliza para calcular el logaritmo natural 
--(base e) de un número, o el logaritmo en una base específica si se proporciona

-- Logaritmo natural (base e)
--LOG(float_expression)

-- Logaritmo en base específica (solo en SQL Server 2012+)
--LOG(float_expression, base)

-- Logaritmo natural de 10
SELECT LOG(10);  -- Resultado: 2.302585

-- Logaritmo de 8 en base 2
SELECT LOG(8, 2);  -- Resultado: 3


PRINT LOG(10)--2.30259
PRINT LOG(10.8)--2.37955
PRINT LOG(50,3)
PRINT LOG(100,10)



--FUNCION LOG10
--La función LOG10() en SQL devuelve el logaritmo en base 10 de un número positivo. 
--Es útil para análisis matemáticos, escalado de datos, o detección de outliers

--LOG10(float_expression)


-- Logaritmo base 10 de un número literal
SELECT LOG10(100);  -- Resultado: 2

-- Usando una variable
DECLARE @x FLOAT = 145.175643;
SELECT LOG10(@x);   -- Resultado: aproximadamente 2.16189

-- Combinado con POWER para verificar la inversa
SELECT POWER(10, LOG10(5));  -- Resultado: 5


PRINT LOG10(5) --0.698
PRINT LOG10(10) --1
PRINT LOG10(100) --2
PRINT LOG10(1000) --3
PRINT LOG10(10.50) --1.02119


--FUNCION PI
--La función PI() en SQL se utiliza para obtener el valor de la constante matemática π (pi), 
--que es aproximadamente 3.14159265358979

--SELECT PI();

-- Calcular el área de un círculo con radio 5
SELECT PI() * POWER(5, 2) AS Area;  -- Resultado: ~78.5398


PRINT PI() --3.1416


--FUNCION SIN(SENO)
--La función SIN() en SQL se utiliza para calcular el seno de un número, 
--una operación trigonométrica común en cálculos matemáticos y científicos

--SELECT SIN(ángulo_en_radianes);

SELECT SIN(PI()/2);  -- Resultado: 1
SELECT SIN(0);       -- Resultado: 0
SELECT SIN(-1);      -- Resultado: -0.8414709848


PRINT SIN(45); --0.85090
PRINT SIN(90); --0.89399
PRINT SIN(25.5); --0.35905



--FUNCION COS(COSENO)
--La función COS() en SQL se utiliza para calcular el coseno trigonométrico de un número, 
--el cual debe estar expresado en radianes

--COS(float_expression)

SELECT COS(0);         -- Resultado: 1
SELECT COS(PI());      -- Resultado: -1
SELECT COS(PI()/2);    -- Resultado: ~0
SELECT COS(45);        -- Resultado: 0.52532198881
SELECT COS(-45);       -- Resultado: -0.52532198881


PRINT COS(45); --0.5253
PRINT COS(90); -- -0.4480
PRINT COS(25.5); --0.9333


--FUNCION TAN(TANGENTE)
--La función TAN() en SQL se utiliza para calcular la tangente de un número, 
--que debe estar expresado en radianes.

--TAN(float_expression)

SELECT TAN(PI()/4);     -- Resultado: 1
SELECT TAN(0);          -- Resultado: 0
SELECT TAN(1.55);       -- Resultado: ~48.078
SELECT TAN(-3);         -- Resultado: ~0.1425

PRINT TAN(45); --1.619
PRINT TAN(90); -- -1.9952
PRINT TAN(25.5); --0.384713


--FUNCION DEGREES
--La función DEGREES() en SQL se utiliza para convertir un valor en radianes a grados. 
--Es especialmente útil cuando trabajas con cálculos trigonométricos y necesitas expresar 
--ángulos en grados en lugar de radianes.

--DEGREES(numeric_expression)

SELECT DEGREES(PI()/2) AS Grados; --90

SELECT DEGREES(PI()/5) --36


--EJERCICIOS PROPUESTOS

-- Ejercicio 1
/*
Realizar un script que calcule el Área y el Perímetro de un Círculo, teniendo en cuenta que: 
La fórmula del Área es: Pi por Radio al cuadrado y
La fórmula del Perímetro es: 2 por Pi por Radio
El radio nosotros debemos de asignarle un valor.
*/

BEGIN
	DECLARE @area DECIMAL (7,2)
	DECLARE @perimetro DECIMAL (7,2)
	DECLARE @Radio DECIMAL = 20

	SET @area = POWER(@Radio, 2) * PI()
	SET @perimetro = 2 * PI() * @Radio

	SELECT @area AS AREA_CIRCULO
	SELECT @perimetro AS PERIMETRO_CIRCULO
END
GO

-- Ejercicio 2
/*
Realizar un script que calcule el Volumen de un Cilindro, teniendo en cuenta que: 
La fórmula del Volumen es: Pi por Radio al cuadrado por la altura
El radio y la altura nosotros debemos de asignarle un valor.
*/

BEGIN
    DECLARE @volumen DECIMAL (7,2)
	DECLARE @altura DECIMAL (7,2) = 10
	DECLARE @Radio DECIMAL (7,2) = 5

	SET @volumen = PI() * POWER(@Radio,2) * @altura

	PRINT 'El Volumen del Cilindro es: ' + CAST(@volumen AS VARCHAR (10))
END
GO

-- Ejercicio 3
/*
Realizar un script que calcule la Distancia entre dos puntos de coordenadas, teniendo en cuenta que: 
La fórmula para calcular la distancia es:
Raíz Cuadrada de x2 - x1 al cuadrado + y2 - y1 al cuadrado
los puntos de coordenada X y Y nosotros le debemos asignar.
*/

BEGIN 
	DECLARE @distancia DECIMAL (7,2)
	DECLARE @x1 DECIMAL (7,2) = 10
	DECLARE @x2 DECIMAL (7,2) = 20
	DECLARE @y1 DECIMAL (7,2) = 5
	DECLARE @y2 DECIMAL (7,2) = 10

	SET @distancia = SQRT( POWER(@x2 - @x1 ,2) + POWER(@y2 - @y1,2))

	PRINT 'La Distancia entre los dos puntos es: ' + CAST(@distancia AS VARCHAR (10))

END
GO



--EJERCICIOS 

--Ejercicio 1:
--Realizar un script que calcule el Volumen de una Esfera


BEGIN
    DECLARE @volumen DECIMAL (7,2)
	DECLARE @Radio DECIMAL (7,2) = 5

	SET @volumen = 4/3 * (PI() * POWER(@Radio,3))

	PRINT 'El Volumen de la  Esfera es: ' + CAST(@volumen AS VARCHAR (10))
END
GO

--Ejercicio 2:
--Realizar un script que calcule la hipotenusa del teorema de Pitágoras

BEGIN 
	DECLARE @hipotenusa DECIMAL (7,2)
	DECLARE @H DECIMAL (7,2) 
	DECLARE @Ca DECIMAL (7,2) = 5
	DECLARE @Cb DECIMAL (7,2) = 8	

	SET @H = POWER(@Ca, 2) + POWER(@Cb, 2)
	
	SET @hipotenusa = POWER(@H, 2)

	PRINT 'La hipotenusa del triangulo de pitagoras es: ' + CAST(@hipotenusa AS VARCHAR (10))

END
GO

--Ejercicio 3:
--Realizar un script que calcule las siguientes funciones trigonométricas:

PRINT SIN(PI()/6) 
PRINT SIN(PI()/4) 
PRINT SIN(PI()/3)

PRINT COS(PI()/6)
PRINT COS(PI()/4)
PRINT COS(PI()/3)

PRINT TAN(PI()/6)
PRINT TAN(PI()/4)
PRINT TAN(PI()/3)


--Ejercicio 4:
--Realizar un script que calcule las siguientes funciones logarítmicas:
--Nota: Si no se especifica la Base por defecto es 10.
SELECT LOG(4) / LOG(2) AS EJ_1
SELECT LOG(9) / LOG(3) AS EJ_2
SELECT LOG(32) / LOG(2) AS EJ_3

SELECT LOG10(1000) AS EJ_4
SELECT LOG(0.8) / LOG(2) AS EJ_5
SELECT LOG(SQRT(7)) / LOG(7) AS EJ_6


--CORRECCION EJERCICIOS
--Ejercicio 1:

BEGIN
		DECLARE @radio DECIMAL(7,2) = 10
		DECLARE @volumen DECIMAL(7,2)
		SET @volumen = ( 4 * PI() * POWER(@radio, 3) ) / 3
		PRINT('El Volumen de la Esfera es: ')
		PRINT(@volumen)
END
GO

--Ejercicio 2:

BEGIN
		DECLARE @cateto_a DECIMAL(7,2) = 6
		DECLARE @cateto_b DECIMAL(7,2) = 8
		DECLARE @hipotenusa DECIMAL(7,2)
		SET @hipotenusa = SQRT( POWER(@cateto_a, 2) + POWER(@cateto_B, 2) )
		PRINT('La hipotenusa es: ')
		PRINT(@hipotenusa)
END
GO


--Ejercicio 3:

PRINT SIN( PI() / 6 )
PRINT SIN( PI() / 4 )
PRINT SIN( PI() / 3 )
PRINT COS( PI() / 6 )
PRINT COS( PI() / 4 )
PRINT COS( PI() / 3 )
PRINT TAN( PI() / 6 )
PRINT TAN( PI() / 4 )
PRINT TAN( PI() / 3 )

--Ejercicio 4:

PRINT LOG( 4, 2 )
PRINT LOG( 9, 3 )
PRINT LOG( 32, 2 )

PRINT LOG10( 1000 ) 
PRINT LOG( 1000, 10 )

PRINT LOG( 0.8, 2 )
PRINT LOG( SQRT(7), 7 )





























