@echo off
echo ============================================================
echo   Smart Emergency Alert System — Build Tool
echo ============================================================
echo.

:: Create bin directory
if not exist "bin" mkdir "bin"

echo [1/2] Compiling all Java source files...
:: Using lib\* to include all Twilio and Jackson dependencies
javac -cp "lib\*" ^
      -d bin ^
      src\com\alertsystem\db\*.java ^
      src\com\alertsystem\util\*.java ^
      src\com\alertsystem\service\*.java ^
      src\com\alertsystem\ui\*.java ^
      src\com\alertsystem\main\*.java

if %ERRORLEVEL% EQU 0 (
    echo.
    echo [2/2] Compilation SUCCESSFUL!
    echo.
    :: Copy resources (logo, icons, etc.) to bin
    if exist "src\resources" (
        xcopy /E /I /Y "src\resources" "bin\resources" >nul
        echo [OK] Resources copied to bin.
    )
    echo  To run the application, execute:  run.bat
    echo ============================================================
) else (
    echo.
    echo [ERROR] Compilation FAILED. Check the errors above.
    echo ============================================================
)
pause
