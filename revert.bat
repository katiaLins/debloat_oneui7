@echo off
setlocal enabledelayedexpansion
REM Ativa a expansao de variavel tardia, necessaria para o loop de desinstalacao.

REM --- SECAO 1: VERIFICACAO DE ADB E DISPOSITIVO ---

REM Verifica se o comando adb existe no sistema.
where adb >nul 2>nul
if %ERRORLEVEL% neq 0 (
    cls
    echo +-------------------------------------------------------------+
    echo ^| ERRO: O comando 'adb' nao foi encontrado.                 ^|
    echo ^|                                                             ^|
    echo ^| Por favor, instale o Android SDK Platform-Tools e adicione  ^|
    echo ^| a pasta ao PATH do sistema para continuar.                  ^|
    echo +-------------------------------------------------------------+
    pause
    exit /b 1
)

REM Inicia o servidor adb (nao ha problema em executar isso mesmo que ja esteja ativo).
adb start-server >nul

cls
echo +---------------------------------------------+
echo ^| Checando os dispositivos conectados...      ^|
echo +---------------------------------------------+

REM Usa um loop para verificar se ha algum dispositivo listado.
set "DEVICES_FOUND="
for /f "skip=1 tokens=*" %%a in ('adb devices') do (
    if not "%%a"=="" set DEVICES_FOUND=true
)

REM Se nenhum dispositivo foi encontrado, exibe erro e sai.
if not defined DEVICES_FOUND (
    echo.
    echo Nao encontrei nenhum dispositivo.
    echo Verifique se o celular esta conectado e com a Depuracao USB ativada.
    echo.
    pause
    exit /b 1
)

echo ^| Dispositivo(s) encontrado(s):
REM Lista os dispositivos de forma limpa.
for /f "skip=1 tokens=1" %%i in ('adb devices') do (
    if not "%%i"=="" echo ^| ---^> %%i
)
echo +---------------------------------------------+
echo.
echo Tudo pronto! Pressione qualquer tecla para ir ao menu de debloat...
pause >nul

REM Script de Reversão para Samsung OneUI 7.0 (Windows)
REM --- SECAO 2: MENU PRINCIPAL DEBLOAT ---

:MENU
cls
echo Selecione o nível de reversão:
echo 1) Básico
echo 2) Leve
echo 3) Pesado
echo 4) Reinstalar Galaxy AI e Google Gemini
set /p choice="Escolha uma opção: "
echo.

if "%choice%"=="1" goto BASIC
if "%choice%"=="2" goto LIGHT
if "%choice%"=="3" goto HEAVY
if "%choice%"=="4" goto AI_GEMINI
echo Opção inválida!
pause
goto MENU

:BASIC
call :REVERT "packages\basic_oneui7.txt"
goto END

:LIGHT
call :REVERT "packages\light_oneui7.txt"
goto END

:HEAVY
call :REVERT "packages\heavy_oneui7.txt"
goto END

:AI_GEMINI
call :REVERT "packages\ai_gemini_oneui7.txt"
goto END

:REVERT
set list_file=%1
echo Lendo a lista de pacotes de %list_file% para reinstalar...
echo.

if not exist "%list_file%" (
    echo Arquivo de lista de pacotes não encontrado!
    pause
    exit /b 1
)

for /f "tokens=* delims=" %%a in (%list_file%) do (
    set line=%%a
    set line=!line: =!
    if not "!line:~0,1!"=="#" if not "!line!"=="" (
        echo Reinstalando !line!...
        adb shell cmd package install-existing "!line!"
    )
)

echo.
echo Reversão concluída!
pause
exit /b 0

:END
exit /b 0


