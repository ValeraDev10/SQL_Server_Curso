

--VISTAS EN SQL
-- Una vista es UN OBJETO que actua como una consulta almacenada que se comporta como tabla virtual. 
-- No guarda datos físicamente, sino que muestra el resultado de una consulta cada vez que se accede a ella.
-- Se define con CREATE VIEW nombre_vista AS SELECT ...
-- Puedes consultarla como si fuera una tabla: SELECT * FROM nombre_vista
-- Ideal para ocultar columnas sensibles, simplificar reportes, y evitar repetir JOINs complejos

-- Seguridad: ocultas columnas sensibles (como tarjetas de crédito o emails)
-- Reutilización: evitas repetir JOINs o filtros complejos
-- Mantenimiento: si cambia la lógica, solo actualizas la vista
-- Reportes: puedes crear vistas por mes, por región, por producto, etc
--SINTAXIS BASICA
CREATE VIEW clientes_activos 
AS
SELECT id, nombre, email
FROM clientes
WHERE estado = 'activo';

SELECT * FROM clientes_activos;


-- Usar la Base de Datos NORTHWND
USE NORTHWND
GO



-- Crear una Vista
--	Mostrar la compra del cliente y el empleado que lo atendió
CREATE OR ALTER VIEW V_CustomerInformation
AS
	SELECT C.CompanyName, C.ContactName, C.Address,
			O.OrderDate, O.RequiredDate, O.ShippedDate,
			P.ProductName, OD.UnitPrice, OD.Quantity, OD.Discount,
			CA.CategoryName,
			E.FirstName + ' ' + E.LastName Name, E.Title
	FROM Customers C
	INNER JOIN Orders O ON C.CustomerID = O.CustomerID
	INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
	INNER JOIN Employees E ON O.EmployeeID = E.EmployeeID
	INNER JOIN Products P ON OD.ProductID = P.ProductID
	INNER JOIN Categories CA ON P.CategoryID = CA.CategoryID
GO


-- Consultar la Vista
SELECT * FROM V_CustomerInformation
GO

--Columnas especificas que se quieren ver
SELECT CompanyName, ContactName, Address,
		UnitPrice, Quantity, Discount
FROM V_CustomerInformation
GO


--VISTA CREADA DESDE ENTORNO GRAFICO

USE NORTHWND
GO

SELECT * FROM V_InformationEmployees
GO






