@echo off
title Local Deep Research - Windows Setup
color 0A

echo ============================================
echo   Local Deep Research - Easy Setup (Windows)
echo ============================================
echo.

:: -----------------------------------------------
:: Step 0: Check prerequisites
:: -----------------------------------------------
echo [1/5] Checking prerequisites...
echo.

:: Check Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python not found!
    echo Please install Python 3.10+ from https://www.python.org/downloads/
    echo Make sure to check "Add Python to PATH" during installation.
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('python --version 2^>^&1') do set PYVER=%%i
echo   [OK] %PYVER%

:: Check pip
pip --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] pip not found!
    echo Please reinstall Python with pip enabled.
    pause
    exit /b 1
)
echo   [OK] pip is available

:: Check Docker
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker not found!
    echo Please install Docker Desktop from https://www.docker.com/products/docker-desktop/
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('docker --version 2^>^&1') do set DOCKERVER=%%i
echo   [OK] %DOCKERVER%

:: Check Ollama
ollama --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Ollama not found!
    echo Please install Ollama from https://ollama.ai
    pause
    exit /b 1
)
echo   [OK] Ollama is available

echo.
echo All prerequisites found!
echo.
pause

:: -----------------------------------------------
:: Step 1: Install LDR
:: -----------------------------------------------
echo.
echo [2/5] Installing Local Deep Research...
echo.
pip install local-deep-research
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install LDR. Check your internet connection.
    pause
    exit /b 1
)
echo.
echo   [OK] LDR installed successfully!
echo.

:: -----------------------------------------------
:: Step 2: Run SearXNG
:: -----------------------------------------------
echo [3/5] Starting SearXNG search engine...
echo.

:: Stop and remove existing container if any
docker stop searxng >nul 2>&1
docker rm searxng >nul 2>&1

:: Run new container
docker run -d -p 8080:8080 --name searxng searxng/searxng
if %errorlevel% neq 0 (
    echo [ERROR] Failed to start SearXNG. Is Docker running?
    pause
    exit /b 1
)
echo   [OK] SearXNG is running on http://localhost:8080
echo.

:: -----------------------------------------------
:: Step 3: Pull Ollama model
:: -----------------------------------------------
echo [4/5] Setting up Ollama model...
echo.
echo Choose a model to download:
echo   1) qwen3:8b         (Fast, ~5GB, good for most tasks)
echo   2) qwen3:14b        (Balanced, ~9GB)
echo   3) qwen3:32b        (Smart, ~20GB, needs 16GB+ RAM)
echo   4) gemma3:12b       (Google, ~8GB)
echo   5) llama3.1:8b      (Meta, ~5GB)
echo   6) Skip - I already have a model
echo.
set /p MODEL_CHOICE="Enter choice (1-6): "

if "%MODEL_CHOICE%"=="1" set MODEL=qwen3:8b
if "%MODEL_CHOICE%"=="2" set MODEL=qwen3:14b
if "%MODEL_CHOICE%"=="3" set MODEL=qwen3:32b
if "%MODEL_CHOICE%"=="4" set MODEL=gemma3:12b
if "%MODEL_CHOICE%"=="5" set MODEL=llama3.1:8b
if "%MODEL_CHOICE%"=="6" (
    echo   Skipping model download.
    echo.
    goto :skip_model
)

if not defined MODEL (
    echo   Invalid choice, skipping model download.
    echo.
    goto :skip_model
)

echo.
echo Downloading %MODEL%... This may take a few minutes.
echo.
ollama pull %MODEL%
if %errorlevel% neq 0 (
    echo [WARNING] Model download failed. You can pull it later with: ollama pull %MODEL%
) else (
    echo   [OK] %MODEL% ready!
)

:skip_model

:: -----------------------------------------------
:: Step 4: Start LDR Web UI
:: -----------------------------------------------
echo.
echo [5/5] Starting Local Deep Research...
echo.

:: Skip encryption for simplicity
set LDR_BOOTSTRAP_ALLOW_UNENCRYPTED=true

echo ============================================
echo   Starting LDR Web UI...
echo   Open http://localhost:5000 in your browser
echo ============================================
echo.
echo   SearXNG:   http://localhost:8080
echo   Ollama:    http://localhost:11434
echo   LDR Web:   http://localhost:5000
echo.
echo   Press Ctrl+C to stop
echo.

ldr-web
