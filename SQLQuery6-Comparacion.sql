

USE NORTHWND;

SELECT * FROM Customers;
--Es igual a >
--MOSTRAR LOS CLIENTES QUE SEAN DE ALEMANIA

SELECT * FROM Customers
WHERE Country ='Germany';

SELECT * FROM Customers
WHERE Country ='Spain';

SELECT CompanyName,ContactName,Address
FROM Customers
WHERE Country ='Mexico';

--Es mayor que >

SELECT * FROM Products;


SELECT * FROM Products
WHERE UnitPrice > 97;

--MOSTRAR EL NOMBRE,PRECIOY STOCK DE LOS PRODUCTOS CON UN STOCK MAYOR A 50
SELECT ProductName,UnitPrice,UnitsInStock 
FROM Products
WHERE UnitsInStock > 50;

--Mayor o igual a que >=

SELECT * FROM Products;

SELECT * FROM Products
WHERE UnitPrice >=97;

--MOSTRAR EL NOMBRE, EL PRECIO, Y EL STOCK DE LOS PRODUCTOS QUE TENGAN UN STOCK MAYOR O IGUAL 115
--ORDENANDO DE MANERA ASCENDENTE POR EL STOCK

SELECT ProductName,UnitPrice,UnitsInStock 
FROM Products
WHERE UnitsInStock >= 115
ORDER BY UnitsInStock ASC;


--Menor que <

SELECT * FROM Products;

SELECT * FROM Products
WHERE UnitPrice < 10;


--MOSTRAR EL NOMBRE,PRECIO,STOCK DE LOS PRODUCTIS QUE TENGAN UN STOCK MENOR A 10

SELECT ProductName,UnitPrice,UnitsInStock 
FROM Products
WHERE UnitsInStock < 10;


--Menor o igual que

SELECT * FROM Products;

SELECT * FROM Products
WHERE UnitPrice <= 10;


--MOSTRAR EL NOMBRE,PRECIO,STOCK DE LOS PRODUCTOS QUE TENGAN UN STOCK MENOR O IGUAL A 10 
--ORDENANDO DE MANERA DESCENDENTE POR EL STOCK

SELECT ProductName,UnitPrice,UnitsInStock 
FROM Products
WHERE UnitsInStock <= 10
ORDER BY UnitsInStock DESC;


--No es igual a <> !=

SELECT * FROM Products;

SELECT * FROM Products
WHERE Discontinued <> 0;

SELECT * FROM Products
WHERE Discontinued != 0;


--MOSTRAR EL CONTACTO, EL PAIS, LA DIRECCION, Y EL TELEFONO DE LOS CLIENTES
--DONDE EL PAIS ES DIFERENTE DE USA, ORDENANDO DE MANERA ASCENDENTE POR EL PAIS

SELECT * FROM Customers;

SELECT ContactName,Address,Country,Phone 
FROM Customers
WHERE Country <> 'USA'
ORDER BY Country ASC;


--No es menor que !<

SELECT * FROM Products;

SELECT * FROM Products
WHERE UnitPrice !< 100;

--MOSTRAR EL NOMBRE, EL PRECIO,EL STOCK DE LOS PRODUCTOS DONDE EL STOCK NO ES MENOR QUE 100 ORDENANDO 
--DE MANERA ASCENDENTE POR EL STOCK


SELECT ProductName,UnitPrice,UnitsInStock 
FROM Products
WHERE UnitsInStock !< 100
ORDER BY UnitsInStock ASC;

--No es mayor que !>

SELECT * FROM Products;

SELECT * FROM Products
WHERE UnitPrice !> 10;

--MOSTRAR EL NOMBRE,PRECIO Y STOCK DE LOS PRODUCTOS DONDE EL STOCK NO ES MAYOR QUE 100
--ORDENANDO DE FORMA DESCENDENTE POR EL STOCK

SELECT ProductName,UnitPrice,UnitsInStock 
FROM Products
WHERE UnitsInStock !> 100
ORDER BY UnitsInStock DESC;

--PUBS

USE pubs;

SELECT * FROM authors;

SELECT * FROM authors
WHERE state ='UT';

SELECT * FROM titles
WHERE price >=20;

SELECT * FROM titles
WHERE price <=7;