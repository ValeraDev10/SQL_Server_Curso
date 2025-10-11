

--SENTENCIAS DCL
--Las sentencias DCL (Data Control Language) en SQL se utilizan para gestionar los permisos y el 
--acceso a los objetos de la base de datos. Son fundamentales para la seguridad y el control de usuarios. 
--Aquí te explico las principales:

--🛡️ Sentencias DCL en SQL

--1. GRANT - Otorga permisos
--Otorga permisos a usuarios o roles para realizar acciones específicas sobre objetos de la base de datos

GRANT SELECT, INSERT ON empleados TO usuario1;

--Permite a usuario1 consultar e insertar datos en la tabla empleados.
--También puedes otorgar permisos para crear objetos o conectarse

GRANT CONNECT TO usuario1;
GRANT CREATE TABLE TO usuario1;

--2. REVOKE - Quita permisos otorgados, pero no impide que se hereden por roles
--Revoca permisos previamente otorgados

--🔐 Consideraciones adicionales
-- Estas sentencias no modifican datos ni estructuras, solo controlan quién puede hacer qué.
-- En sistemas como SQL Server, Oracle o PostgreSQL, puedes usar roles para agrupar permisos y asignarlos más fácilmente.
-- Algunos sistemas permiten GRANT OPTION, que permite a un usuario otorgar permisos a otros


--3. DENY - Bloquea el permiso explícitamente, incluso si se hereda por otros medios
--En SQL Server, la sentencia DENY se utiliza para rechazar explícitamente permisos a un usuario o rol, 
--incluso si otros permisos se han otorgado indirectamente (por ejemplo, a través de roles). 
--Es más fuerte que REVOKE, porque impide el acceso aunque haya otros permisos activos.

DENY permiso ON objeto TO usuario;

Ejemplos:
-- Denegar SELECT sobre la tabla empleados
DENY SELECT ON empleados TO usuario1;

-- Denegar ejecución de un procedimiento almacenado
DENY EXECUTE ON PROCEDURE sp_ReporteVentas 


--🧠 Consideraciones
-- Si un usuario tiene GRANT por un rol, pero también tiene DENY directo, el DENY prevalece.
-- Es útil para aplicar restricciones de seguridad más estrictas.
-- Se puede usar en tablas, vistas, procedimientos, funciones, esquemas, etc


--USUARIO SA

--El usuario sa (System Administrator) en SQL Server es la cuenta de administrador predeterminada 
--del motor de base de datos cuando se utiliza el modo de autenticación mixto (Windows + SQL Server).

--🔐 Características del usuario sa
-- Tiene permisos totales sobre todas las bases de datos y objetos del servidor.
-- Puede crear, modificar, eliminar cualquier objeto, usuario o configuración.
-- Se utiliza principalmente para administración y mantenimiento del servidor.
-- Está deshabilitado por defecto si se usa solo autenticación de Windows.

--⚙️ Activar y configurar el usuario sa
-- Habilitar el modo de autenticación mixta:
-- En SQL Server Management Studio (SSMS):
--Propiedades del servidor > Seguridad > Autenticación de SQL Server y Windows
-- Habilitar el usuario sa:
ALTER LOGIN sa ENABLE;
- Establecer una contraseña segura:
ALTER LOGIN sa WITH PASSWORD = 'TuContraseñaSegura123!';
- Verificar que el usuario sa esté desbloqueado:
ALTER LOGIN sa WITH CHECK_POLICY = OFF;



--⚠️ Recomendaciones de seguridad
-- No uses sa para aplicaciones o conexiones regulares.
-- Desactívalo si no lo necesitas:
ALTER LOGIN sa DISABLE;
-- Usa roles personalizados y usuarios con permisos mínimos necesarios.
-- Cambia la contraseña regularmente y evita nombres de usuario predecibles


--LOGIN
--En SQL Server, un login es una cuenta de acceso al servidor. Es el primer paso para autenticar 
--a un usuario antes de que pueda acceder a las bases de datos. 
--Los logins se gestionan a nivel de servidor, mientras que los usuarios se gestionan a nivel 
--de base de datos.

--🔐 Tipos de Login en SQL Server
-- Login de Windows
-- Usa credenciales del sistema operativo.
-- Ejemplo: DOMINIO\usuario
-- Login de SQL Server
-- Usa nombre de usuario y contraseña definidos en SQL Server.
-- Requiere que el servidor esté en modo de autenticación mixta.

--🛠️ Crear un Login con SQL
--1. Login de SQL Server
CREATE LOGIN usuarioSQL WITH PASSWORD = 'ContraseñaSegura123!';


--2. Login de Windows
CREATE LOGIN [DOMINIO\usuarioWindows] FROM WINDOWS;



--👤 Asociar Login a un Usuario de Base de Datos
--Después de crear el login, debes crear un usuario en la base de datos y vincularlo:
USE NombreBaseDatos;
CREATE USER usuarioSQL FOR LOGIN usuarioSQL;



--🔧 Asignar Roles o Permisos
ALTER ROLE db_datareader ADD MEMBER usuarioSQL;
ALTER ROLE db_datawriter ADD MEMBER usuarioSQL;


--También puedes usar GRANT, DENY o REVOKE para permisos más específicos.

--🧠 Buenas prácticas
-- Usa logins de Windows cuando sea posible (más seguros).
-- No uses el login sa para aplicaciones.
-- Aplica el principio de mínimos privilegios.
-- Revisa y audita los logins regularmente


--/////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////


--CREAR LOGIN


USE [master]
GO
CREATE LOGIN [ana] 
WITH PASSWORD=N'12345' 
MUST_CHANGE, 
DEFAULT_DATABASE=[master], 
CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO


SELECT session_id
FROM sys.dm_exec_sessions
WHERE login_name = 'ana'
GO

KILL 84

DROP LOGIN ana
GO



--ROLES A NIVEL SERVIDOR

--En SQL Server, los roles a nivel servidor son grupos de seguridad que controlan permisos 
--sobre toda la instancia, no solo sobre bases de datos individuales. 
--Existen roles fijos y roles personalizados.
--🛡️ Roles fijos de servidor
--SQL Server incluye roles fijos con permisos predefinidos que no se pueden modificar. 
--Estos roles permiten administrar la instancia completa:

--ROL FIJO				PERMISOS PRINCIPALES

--sysadmin				Acceso total al servidor. No se le pueden denegar permisos.
--serveradmin			Cambiar configuraciones del servidor y apagarlo.
--securityadmin			Administrar inicios de sesión y permisos a nivel servidor.
--setupadmin			Instalar procedimientos almacenados extendidos.
--processadmin			Finalizar procesos que se estén ejecutando.
--diskadmin				Administrar discos.
--dbcreator				Crear, alterar, eliminar y restaurar bases de datos.
--bulkadmin				Ejecutar operaciones de importación masiva (bulk insert).
--public				Permisos mínimos que todo inicio de sesión tiene por defecto.


--🧩 Roles personalizados de servidor
--Desde SQL Server 2012, puedes crear roles de servidor definidos por el usuario para 
--adaptar los permisos a tus necesidades específicas:

		CREATE SERVER ROLE [MiRolPersonalizado];
		GRANT CONNECT ANY DATABASE TO [MiRolPersonalizado];
		GRANT VIEW SERVER STATE TO [MiRolPersonalizado];
		ALTER SERVER ROLE [MiRolPersonalizado] ADD MEMBER [MiUsuario];


--Esto permite aplicar el principio de privilegios mínimos, otorgando solo los permisos necesarios.
--🔐 Roles especiales en SQL Server 2022
--SQL Server 2022 introdujo roles especiales con el prefijo ##MS_ y sufijo ##, como:

	 ##MS_ServerStateReader##: Permite ver el estado del servidor.
	 ##MS_DatabaseConnector##: Concede acceso CONNECT a todas las bases de datos.
	 ##MS_LoginManager##: Administra inicios de sesión.	 

--Estos roles están diseñados para facilitar la administración segura y granular


--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



DROP DATABASE BLIBLIOTECA
GO

DROP LOGIN jose
GO


--CREAR ROL DE SERVIDOR

USE master
GO

CREATE SERVER ROLE ServerSetupAdmin
GO

ALTER SERVER ROLE serveradmin ADD MEMBER ServerSetupAdmin;
ALTER SERVER ROLE setupadmin ADD MEMBER ServerSetupAdmin;
ALTER SERVER ROLE ##MS_DatabaseConnector## ADD MEMBER ServerSetupAdmin;


--asignar permisos

GRANT VIEW STATE TO ServerSetupAdmin;
DENY CREATE LOGIN TO ServerSetupAdmin;

--DESMARCAR EL PERMISO ASGNADO
REVOKE DENY CREATE LOGIN TO ServerSetupAdmin;




--USERS
--En SQL Server, los usuarios son entidades que representan personas o procesos 
--que pueden conectarse a una base de datos y ejecutar acciones según los permisos asignados.

--🧑‍💻 Tipos de usuarios en SQL Server
-- Login (Inicio de sesión):
-- Se crea a nivel de servidor.
-- Permite autenticarse en SQL Server.
-- Puede ser de tipo SQL Server (CREATE LOGIN) o Windows (CREATE LOGIN [DOMAIN\user]).

-- Usuario de base de datos (USER):
-- Se crea dentro de una base de datos específica.
-- Está vinculado a un login (aunque puede existir sin uno).
-- Se usa para asignar permisos dentro de esa base de datos.

--Crear un login
CREATE LOGIN usuario_sql WITH PASSWORD = 'TuContraseñaSegura';


--Crear un usuario en una base de datos
CREATE USER usuario_sql FOR LOGIN usuario_sql;


--Ver usuarios de una base de datos
SELECT name, type_desc FROM sys.database_principals WHERE type IN ('S', 'U');


--Ver logins del servidor
SELECT name, type_desc FROM sys.server_principals WHERE type IN ('S', 'U');



--🔐 Roles y permisos
-- Roles de base de datos: db_datareader, db_datawriter, db_owner, etc.
-- Roles de servidor: sysadmin, serveradmin, securityadmin, etc.

--Ejemplo para agregar un usuario a un rol

EXEC sp_addrolemember 'db_datareader', 'usuario_sql';



--ROLES A NIVEL DE BASE DE DATOS
--Los roles a nivel de base de datos son conjuntos de permisos que se asignan a usuarios 
--para controlar lo que pueden hacer dentro de una base de datos específica. 
--En sistemas como SQL Server, PostgreSQL, Oracle o MySQL, los roles permiten una administración 
--más eficiente de la seguridad y los privilegios

--🧱 ¿Qué es un rol?
--Un rol es una entidad que agrupa permisos. En lugar de asignar permisos directamente a cada usuario, 
--se asignan a roles, y luego los usuarios se agregan a esos roles

--🔐 Tipos comunes de roles
--1. Roles predefinidos del sistema
--Estos vienen por defecto y tienen permisos estándar:

--ROL						DESCRIPCION

--db_owner					Control total sobre la base de datos
--db_datareader				Puede leer todos los datos
--db_datawriter				Puede escribir en todas las tablas
--db_ddladmin				Puede ejecutar comandos DDL (crear, modificar objetos)
--db_securityadmin			Administra roles y permisos dentro de la base de datos
--db_backupoperator			Puede hacer backups de la base de datos
--db_accsessadmin			Puede agregar o eliminar accseso a la base de datos, asignar usuarios a la BD
--db_denydatareader			Denega explicitamente permisos de lectura en todas las tablas y vistas
--db_denydatawriter			Denega explicitamente permisos de escritura en todas las tablas y vistas
--public					Es un rol por defecto con permisos minimos, generalmente solo de lectura

--SINTAXIS

USE DATABASENAME;

ALTER ROLE DATA_BASE_ROL_NAME

{
	[ADD MEMBER USER_NAME]
	[DROP MEMBER USER_NAME]
}


--ROLES BASE DE DATOS PERSONALIZADOS
--Los roles personalizados son entidades de seguridad que agrupan permisos específicos. 
--A diferencia de los roles fijos (como db_datareader o db_owner), los roles personalizados 
--te permiten definir exactamente qué acciones puede realizar un grupo de usuarios dentro de una base de datos

--⚙️ Cómo crear un rol personalizado
--Puedes hacerlo con T-SQL usando CREATE ROLE, y luego asignar permisos con GRANT, DENY o REVOKE. Aquí tienes un ejemplo básico:
-- Crear el rol
CREATE ROLE GerenteVentas;

-- Agregar un usuario al rol
ALTER ROLE GerenteVentas ADD MEMBER JuanPerez;

-- Otorgar permisos específicos
GRANT SELECT, INSERT ON Ventas TO GerenteVentas;


--También puedes usar DROP ROLE para eliminarlo o DROP MEMBER para quitar usuarios del rol

--✅ Ventajas
-- Modularidad: Puedes agrupar permisos por función (por ejemplo, "Analista", "Supervisor").
-- Seguridad: Evitas otorgar permisos directamente a usuarios individuales.
-- Escalabilidad: Fácil de mantener en entornos con muchos usuarios.

--🔐 Buenas prácticas
-- Usa nombres descriptivos para los roles (por ejemplo, ReportesFinancieros).
-- Documenta qué permisos tiene cada rol.
-- Revisa periódicamente los miembros de cada rol y sus permisos





















