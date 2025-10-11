
--TAREAS PROGRAMADAS

--Una tarea programada en SQL Server es una acción automatizada que se ejecuta en momentos específicos 
--o bajo ciertas condiciones, utilizando el componente llamado SQL Server Agent. 
--Es ideal para tareas repetitivas como respaldos, mantenimiento, ejecución de scripts, o envío de reportes.

--🛠️ ¿Qué incluye una tarea programada?
--Una tarea programada (o job) está compuesta por:
-- Pasos: Cada paso puede ejecutar un comando T-SQL, un paquete SSIS, un script PowerShell, etc.
-- Horario (Schedule): Define cuándo se ejecuta la tarea (diario, semanal, cada hora, etc.).
-- Alertas y notificaciones: Puedes configurar correos o alertas si falla o termina exitosamente.
-- Historial: SQL Server guarda registros de ejecución para diagnóstico y auditoría


--📌 Ejemplos comunes
-- Respaldar la base de datos cada noche a las 2 AM.
-- Ejecutar un procedimiento almacenado que limpia datos antiguos cada semana.
-- Generar y enviar reportes por correo cada lunes.


--🧠 ¿Cómo se crea?
--Puedes hacerlo desde SQL Server Management Studio (SSMS):
-- Ir a SQL Server Agent → Jobs → clic derecho → New Job.
-- Definir nombre, pasos, horarios y alertas.
-- Guardar y habilitar.
--También puedes usar T-SQL para crear tareas programadas con sp_add_job, sp_add_jobstep, sp_add_schedule, 
--y sp_attach_schedule


--SQL Server Agent 

--Es un componente de Microsoft SQL Server diseñado para automatizar tareas administrativas 
--y operativas dentro del entorno de base de datos. Es como el "motor de programación" 
--que permite ejecutar trabajos (jobs) en momentos específicos o bajo ciertas condiciones.

--🔧 ¿Para qué sirve SQL Server Agent?
-- Ejecutar tareas programadas como respaldos, mantenimiento de índices, limpieza de datos, etc.
-- Automatizar la ejecución de procedimientos almacenados, scripts T-SQL, paquetes SSIS, o comandos PowerShell.
-- Enviar notificaciones por correo en caso de éxito o error.
-- Monitorear el estado de la base de datos y generar alertas.

--🧩 Componentes clave
-- Jobs (trabajos): Conjunto de pasos que definen qué se va a ejecutar.
-- Steps (pasos): Cada uno ejecuta una acción específica (T-SQL, SSIS, etc.).
-- Schedules (horarios): Define cuándo se ejecuta el job (por ejemplo, cada noche a las 2 AM).
-- Alerts (alertas): Reaccionan a eventos o errores específicos.
-- Operators (operadores): Personas o correos que reciben notificaciones.

--📌 Ejemplo práctico
--Supón que quieres que cada noche se respalde la base de datos y se envíe un correo si falla. Puedes crear un job con:
-- Paso 1: Ejecutar BACKUP DATABASE.
-- Paso 2: Verificar éxito y enviar correo si falla.
-- Horario: Diario a las 2 AM


---- Estrategia de Backups ----
USE NORTHWND
GO


-- FULL BACKUP
DECLARE @date VARCHAR(30)
DECLARE @path VARCHAR(100)
DECLARE @name VARCHAR(50)

SET @date = REPLACE(CONVERT(VARCHAR(30), GETDATE(), 120), ':','')
SET @path = 'C:\Master en SQL Server\Backup\FullBKNorthwnd_'+@date+'.bak'
SET @name = 'FullBKNorthwnd_' + @date

BACKUP DATABASE NORTHWND
TO DISK = @path
WITH NAME = @name
GO




-- DIFFERENTIAL BACKUP
DECLARE @date VARCHAR(30)
DECLARE @path VARCHAR(100)
DECLARE @name VARCHAR(50)

SET @date = REPLACE(CONVERT(VARCHAR(30), GETDATE(), 120), ':','')
SET @path = 'C:\Master en SQL Server\Backup\DifferentialBKNorthwnd_'+@date+'.bak'
SET @name = 'DifferentialBKNorthwnd_' + @date

BACKUP DATABASE NORTHWND
TO DISK = @path
WITH DIFFERENTIAL, NAME = @name
GO




-- TRANSACTION LOG BACKUP
DECLARE @date VARCHAR(30)
DECLARE @path VARCHAR(100)
DECLARE @name VARCHAR(50)

SET @date = REPLACE(CONVERT(VARCHAR(30), GETDATE(), 120), ':','')
SET @path = 'C:\Master en SQL Server\Backup\LogBKNorthwnd_'+@date+'.bak'
SET @name = 'LogBKNorthwnd_' + @date

BACKUP LOG NORTHWND
TO DISK = @path
WITH NAME = @name
GO