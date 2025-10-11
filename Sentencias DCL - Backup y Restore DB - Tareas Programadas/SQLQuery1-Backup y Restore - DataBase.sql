

--BACKUP Y RESTORE BASE DE DATOS

--🛡️ ¿Qué es un Backup?
--Un Backup (copia de seguridad) es una copia de los datos de una base de datos que se guarda en un archivo externo. 
--Sirve para proteger la información ante fallos, errores humanos, ataques o desastres.

--Tipos comunes de Backup en SQL Server:

-- Full Backup: copia completa de toda la base de datos.
-- Differential Backup: copia de los cambios desde el último Full Backup.
-- Transaction Log Backup: copia del registro de transacciones, útil para restaurar hasta un punto exacto en el tiempo.
-- Copy Only Backup  (copia de seguridad solo de copia) es un tipo especial de respaldo en sistemas de bases de datos,
--		que no afecta la secuencia de respaldos regulares ni interfiere con las operaciones de restauración normales
-- Filegroup Backup (respaldo por grupo de archivos) en SQL Server es una estrategia avanzada de respaldo que permite respaldar solo 
--		ciertos grupos de archivos dentro de una base de datos, en lugar de respaldar toda la base de datos
-- Tail-Log Backup (respaldo del final del log de transacciones) en SQL Server es un tipo especial de respaldo que se 
--		realiza justo antes de restaurar una base de datos, especialmente cuando ha ocurrido una falla y 
--		se quiere evitar la pérdida de datos recientes



--Ejemplo práctico:
BACKUP DATABASE [Ventas] TO DISK = 'C:\Backups\Ventas.bak'

BACKUP DATABASE [Ventas] TO DISK = 'C:\Backups\Ventas.bak' WITH DIFFERENTIAL,[OPTIONS];

BACKUP LOG [Ventas] TO DISK = 'C:\Backups\Ventas.bak' WITH [OPTIONS];

BACKUP DATABASE MiBaseDatos TO DISK = 'C:\Backups\MiBackup.bak' WITH COPY_ONLY,[OPTIONS];;

BACKUP DATABASE MiBaseDatos FILEGROUP = 'FG_Ventas' TO DISK = 'C:\Backups\Ventas.bak';

BACKUP LOG MiBaseDatos TO DISK = 'C:\Backups\MiBaseDatos_TailLog.trn' WITH NORECOVERY;







--🔄 ¿Qué es un Restore?
--El Restore (restauración) es el proceso de recuperar una base de datos desde un archivo de Backup. 
--Se usa cuando necesitas:

-- Recuperar datos perdidos.
-- Migrar a otro servidor.
-- Volver a un estado anterior.
--Ejemplo práctico:
RESTORE DATABASE [Ventas] FROM DISK = 'C:\Backups\Ventas.bak'
WITH REPLACE


--🧠 Buenas prácticas:
-- Automatiza backups con SQL Agent o PowerShell.
-- Usa CHECKSUM y VERIFYONLY para validar integridad.
-- Almacena backups en ubicaciones seguras y externas.
-- Documenta políticas de retención y recuperación




---- Estrategia de Backups ----
USE NORTHWND
GO

-- FULL BACKUP
BACKUP DATABASE NORTHWND
TO DISK = 'C:\Master en SQL Server\Backup\BackupNorthwnd.bak'
WITH NAME = 'fullBackupNorthwnd'
GO

-- Insert Data
INSERT INTO Customers(CustomerID, CompanyName, ContactName, Country)
				VALUES('AAA01', 'Tesla', 'Elon Musk', 'USA'),
					  ('AAA02', 'Google', 'Sundar Pichai', 'USA');
GO

-- TRANSACTION LOG BACKUP
BACKUP LOG NORTHWND
TO DISK = 'C:\Master en SQL Server\Backup\BackupNorthwnd.bak'
WITH NAME = 'logBackupNorthwnd1'
GO

-- Insert Data
INSERT INTO Customers(CustomerID, CompanyName, ContactName, Country)
				VALUES('AAA03', 'Paypal', 'Alex Chriss', 'USA'),
					  ('AAA04', 'Intel', 'Pat Gelsinger', 'USA');
GO

-- DIFFERENTIAL BACKUP
BACKUP DATABASE NORTHWND
TO DISK = 'C:\Master en SQL Server\Backup\BackupNorthwnd.bak'
WITH DIFFERENTIAL, NAME = 'differentialBackupNorthwnd'
GO

-- Insert Data
INSERT INTO Customers(CustomerID, CompanyName, ContactName, Country)
				VALUES('AAA05', 'IBM', 'Arvind Krishna', 'USA'),
					  ('AAA06', 'Facebook', 'Mark Zuckerberg', 'USA');
GO

-- TRANSACTION LOG BACKUP
BACKUP LOG NORTHWND
TO DISK = 'C:\Master en SQL Server\Backup\BackupNorthwnd.bak'
WITH NAME = 'logBackupNorthwnd2'
GO



--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- Información de los archivos Backups dentro del archivo .bak
RESTORE HEADERONLY
FROM DISK = 'C:\Master en SQL Server\Backup\BackupNorthwnd.bak'
GO


-- Eliminar la Base de Datos NORTHWND
USE master
DROP DATABASE NORTHWND
GO

-- Restore de Backup completo, diferencial y log
RESTORE DATABASE NORTHWND
FROM DISK = 'C:\Master en SQL Server\Backup\BackupNorthwnd.bak'
WITH FILE = 1, NORECOVERY
GO

RESTORE DATABASE NORTHWND
FROM DISK = 'C:\Master en SQL Server\Backup\BackupNorthwnd.bak'
WITH FILE = 3, NORECOVERY
GO

RESTORE LOG NORTHWND
FROM DISK = 'C:\Master en SQL Server\Backup\BackupNorthwnd.bak'
WITH FILE = 4, RECOVERY
GO


-- Usar la Base de Datos NORTHWND
USE NORTHWND
GO

-- Consultar la Tabla Customers
SELECT * FROM Customers
GO






