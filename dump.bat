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