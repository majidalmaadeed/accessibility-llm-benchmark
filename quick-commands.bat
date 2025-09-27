@echo off
REM Accessibility LLM Benchmark - Quick Command Runner
REM Usage: quick-commands.bat [command] [platform] [complexity]

set COMMAND=%1
set PLATFORM=%2
set COMPLEXITY=%3

if "%COMMAND%"=="" (
    echo Usage: quick-commands.bat [install^|build^|test^|start] [web^|mobile^|desktop] [basic^|moderate^|advanced]
    echo.
    echo Examples:
    echo   quick-commands.bat install web advanced
    echo   quick-commands.bat build mobile moderate
    echo   quick-commands.bat test web basic
    echo   quick-commands.bat start web advanced react
    goto :eof
)

echo 🚀 Running %COMMAND% for %PLATFORM% %COMPLEXITY%

if "%COMMAND%"=="install" (
    echo 📦 Installing dependencies...
    if "%PLATFORM%"=="web" (
        cd scenarios\%COMPLEXITY%\web
        for /d %%i in (*) do (
            echo Installing %%i...
            cd %%i
            call npm install
            cd ..
        )
    )
)

if "%COMMAND%"=="build" (
    echo 🔨 Building projects...
    if "%PLATFORM%"=="web" (
        cd scenarios\%COMPLEXITY%\web
        for /d %%i in (*) do (
            echo Building %%i...
            cd %%i
            call npm run build
            cd ..
        )
    )
)

if "%COMMAND%"=="test" (
    echo 🧪 Running tests...
    if "%PLATFORM%"=="web" (
        cd scenarios\%COMPLEXITY%\web
        for /d %%i in (*) do (
            echo Testing %%i...
            cd %%i
            call npm test
            cd ..
        )
    )
)

if "%COMMAND%"=="start" (
    echo 🚀 Starting development servers...
    if "%PLATFORM%"=="web" (
        cd scenarios\%COMPLEXITY%\web
        if "%4"=="" (
            echo Starting all web frameworks...
            for /d %%i in (*) do (
                start "%%i" cmd /k "cd %%i && npm start"
            )
        ) else (
            echo Starting %4...
            cd %4
            call npm start
        )
    )
)

echo ✅ Command completed!
pause
