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

REM --- SECAO 2: MENU PRINCIPAL DEBLOAT ---

:MENU
cls
echo.
echo  ================================
echo  =   SCRIPT DEBLOAT - OneUI 7   =
echo  ================================
echo.
echo  Selecione o nivel de debloat:
echo.
echo  1) Basico   (Remove apenas bloatware seguro)
echo  2) Leve     (Remove mais alguns apps nao essenciais)
echo  3) Pesado   (Remove quase tudo que nao e do sistema principal)
echo  4) Remover Galaxy AI e Google Gemini
echo.
set /p choice="  Escolha uma opcao: "
echo.

if "%choice%"=="1" goto BASIC
if "%choice%"=="2" goto LIGHT
if "%choice%"=="3" goto HEAVY
if "%choice%"=="4" goto AI_GEMINI

cls
echo Opcao invalida!
echo Pressione qualquer tecla para tentar novamente.
pause >nul
goto MENU

:BASIC
call :DEBLOAT "packages\basic_oneui7.txt"
goto END

:LIGHT
call :DEBLOAT "packages\light_oneui7.txt"
goto END

:HEAVY
call :DEBLOAT "packages\heavy_oneui7.txt"
goto END

:AI_GEMINI
call :DEBLOAT "packages\ai_gemini_oneui7.txt"
goto END

:DEBLOAT
cls
set list_file=%1
echo +---------------------------------------------+
echo ^| Lendo a lista de pacotes de %list_file%
echo +---------------------------------------------+
echo.

if not exist "%list_file%" (
    echo Arquivo de lista '%list_file%' nao encontrado!
    pause
    exit /b 1
)

REM Loop para ler cada linha do arquivo de pacotes
for /f "tokens=* delims=" %%a in (%list_file%) do (
    set line=%%a
    REM Remove espacos em branco (nao necessario com "tokens=* delims=" mas e uma boa pratica)
    set line=!line: =!
    REM Ignora linhas vazias ou que comecam com # (comentarios)
    if not "!line:~0,1!"=="#" if not "!line!"=="" (
        echo Removendo o pacote: !line!
        adb shell pm uninstall -k --user 0 "!line!"
    )
)

echo.
echo +-----------------------+
echo ^| Debloat concluido!    ^|
echo +-----------------------+
pause
goto END

:END
exit /b 0