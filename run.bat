@echo off
echo Starting Smart Emergency Alert System...

:: Verify if it's compiled
if not exist "bin\com\alertsystem\main\Application.class" (
    echo System not compiled. Please run compile.bat first!
    pause
    exit /b
)

:: Run the Application with all JARs in lib folder
java -cp "bin;lib\*" com.alertsystem.main.Application
pause
