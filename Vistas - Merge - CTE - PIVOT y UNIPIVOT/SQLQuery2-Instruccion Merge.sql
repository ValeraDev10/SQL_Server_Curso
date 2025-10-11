

--INSTRUCCION MERGE
--La instrucción MERGE en SQL Server (también conocida como upsert) permite realizar operaciones de 
--INSERT, UPDATE o DELETE en una tabla destino según la coincidencia con una tabla origen. 
--Es muy útil para sincronizar datos entre tablas
--SINTAXIS BASICA

MERGE INTO tabla_destino AS destino
USING tabla_origen AS origen
ON destino.id = origen.id
WHEN MATCHED THEN
    UPDATE SET destino.columna1 = origen.columna1,
               destino.columna2 = origen.columna2
WHEN NOT MATCHED THEN
    INSERT (columna1, columna2)
    VALUES (origen.columna1, origen.columna2)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- ON: define la condición de coincidencia entre las filas de origen y destino.
-- WHEN MATCHED: si hay coincidencia, se actualiza la fila en destino.
-- WHEN NOT MATCHED: si no hay coincidencia en destino, se inserta una nueva fila.
-- WHEN NOT MATCHED BY SOURCE: si hay una fila en destino que no existe en origen, se puede eliminar

-- Es recomendable usar MERGE con precaución, especialmente si hay triggers o concurrencia.
-- Puedes usar la cláusula OUTPUT para ver qué filas fueron afectadas



-- Ubicarnos en la Base de Datos master
USE master
GO


-- Validar si existe la Base de Datos Retail
DROP DATABASE IF EXISTS Retail
GO


-- Crear la Base de Datos Retail
CREATE DATABASE Retail
GO


-- Usar la Base de Datos Retail
USE Retail
GO


-- Crear la Tabla Product
CREATE TABLE Products(
	productID		INT,
	productName		VARCHAR(50),
	price			DECIMAL(9,2)
)
GO


-- Insertar registros en la Tabla ProductSource
INSERT INTO Products(productID, productName, price)
			  VALUES(1, 'Mouse', 100),
					(2, 'Keyboard', 10),
					(5, 'Ram', 50),
					(6, 'Micro SD', 70);
GO


-- Crear la Tabla ProductSource(
CREATE TABLE ProductsSource(
	productID		INT,
	productName		VARCHAR(50),
	price			DECIMAL(9,2)
)
GO


-- Insertar registros en la Tabla ProductSource
INSERT INTO ProductsSource(productID, productName, price)
					VALUES(1, 'Mouse', 100),
						  (2, 'Keyboard', 150),
						  (3, 'Monitor', 800),
						  (4, 'SSD', 80);
GO


-- Consultar la Tabla Product y ProductSource
SELECT * FROM Products;
SELECT * FROM ProductsSource;
GO



--MERGE DE INSERCION

-- Usar la Base de Datos Retail
USE Retail
GO


-- Consultar las Tablas Products y ProductsSource
SELECT * FROM Products;
SELECT * FROM ProductsSource;
GO


-- Query con Merge
MERGE Products AS tgt
USING ProductsSource AS src
ON tgt.productID = src.productID
-- Inserts
WHEN NOT MATCHED BY TARGET THEN
	INSERT (productID, productName, price)
	VALUES (src.productID, src.productName, src.price);
GO


-- Consultar las Tablas Products y ProductsSource
SELECT * FROM Products;
SELECT * FROM ProductsSource;
GO


-- Insertar registros en la Tabla ProductsSource
INSERT INTO ProductsSource(productID, productName, price)
					VALUES(7, 'Motherboard', 300),
						  (8, 'USB Cable', 15)
GO


-- Consultar las Tablas Products y ProductsSource
SELECT * FROM Products;
SELECT * FROM ProductsSource;
GO


-- Query con Merge
MERGE Products AS tgt
USING ProductsSource AS src
ON tgt.productID = src.productID
-- Inserts
WHEN NOT MATCHED BY TARGET THEN
	INSERT (productID, productName, price)
	VALUES (src.productID, src.productName, src.price)
	
-- Comprobar las acciones de la sentencia Merge
OUTPUT $action,
INSERTED.ProductID AS SourceProductID, 
INSERTED.ProductName AS SourceProductName, 
INSERTED.Price AS SourcePrice,
DELETED.ProductID AS TargetProductID, 
DELETED.ProductName AS TargetProductName, 
DELETED.Price AS TargetPrice;
GO

-- Consultar las Tablas Products y ProductsSource
SELECT * FROM Products;
SELECT * FROM ProductsSource;
GO


--MERGE DE ACTUALIZACION





-- Usar la Base de Datos Retail
USE Retail
GO


-- Query con Merge
MERGE Products AS tgt
USING ProductsSource AS src
ON tgt.productID = src.productID

-- Inserts
WHEN NOT MATCHED BY TARGET THEN
	INSERT (productID, productName, price)
	VALUES (src.productID, src.productName, src.price)

-- Updates
WHEN MATCHED THEN
	UPDATE
	SET tgt.productName = src.productName,
		tgt.price = src.price;
GO


-- Consultar las Tablas Products y ProductsSource
SELECT * FROM Products;
SELECT * FROM ProductsSource;
GO




--MERGE DE ELIMINACION

-- Usar la Base de Datos Retail
USE Retail
GO


-- Query con Merge
MERGE Products AS tgt
USING ProductsSource AS src
ON tgt.productID = src.productID

-- Inserts
WHEN NOT MATCHED BY TARGET THEN
	INSERT (productID, productName, price)
	VALUES (src.productID, src.productName, src.price)

-- Updates
WHEN MATCHED THEN
	UPDATE
	SET tgt.productName = src.productName,
		tgt.price = src.price

-- Delete
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
GO
-- Comprobar las acciones de la sentencia Merge
OUTPUT $action, 
DELETED.ProductID AS TargetProductID, 
DELETED.ProductName AS TargetProductName, 
DELETED.Price AS TargetPrice, 
INSERTED.ProductID AS SourceProductID, 
INSERTED.ProductName AS SourceProductName, 
INSERTED.Price AS SourcePrice;
GO


-- Consultar las Tablas Products y ProductsSource
SELECT * FROM Products;
SELECT * FROM ProductsSource;
GO




