echo Starting project setup...
REM This script sets up the environment for a Django application with a MySQL database.
REM Ensure Docker is running before executing this script.

docker-compose up --build -d
if %ERRORLEVEL% neq 0 (
    echo Error: Failed to start Docker containers.
    exit /b %ERRORLEVEL%
)
REM Wait for the MySQL container to be ready
echo Waiting for MySQL container to be ready...
timeout /t 10 /nobreak > NUL
REM Execute MySQL dump command to restore the database
REM Ensure the dump file exists before attempting to restore
if not exist "dump.sql" (
    echo Error: dump.sql file not found.
    exit /b 1
)
REM Execute the MySQL dump command
REM This assumes you have a MySQL container named 'mysql_evaluation' running
REM and a dump file named 'dump.sql' in the current directory.
REM Adjust the container name, user, password, and database as necessary.

@echo off
setlocal
set "MYSQL_CONTAINER=mysql_evaluation"
set "MYSQL_USER=root"
set "MYSQL_PASSWORD=Hitema2025"
set "MYSQL_DATABASE=sakila"
set "DUMP_FILE=dump.sql"
set "MYSQL_CMD=docker exec -i %MYSQL_CONTAINER% mysql -u%MYSQL_USER% -p%MYSQL_PASSWORD% %MYSQL_DATABASE% < %DUMP_FILE%"
echo Running MySQL dump command...
%MYSQL_CMD%
if %ERRORLEVEL% neq 0 (
    echo Error: Failed to execute MySQL dump command.
    exit /b %ERRORLEVEL%
)
echo MySQL dump command executed successfully.

@REM Restart the django application
echo Restarting Django application...
docker restart django_app
if %ERRORLEVEL% neq 0 (
    echo Error: Failed to restart Django application.
    exit /b %ERRORLEVEL%
)
echo Django application restarted successfully.
endlocal