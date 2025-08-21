@echo off
set "hostsFile=C:\Temp\DellUpdate\IPs_DellUpdate.txt"

:: Loop por cada hostname/IP do arquivo
for /f "tokens=*" %%H in (%hostsFile%) do (
    echo Processando o host %%H...


    REM Cria pasta Temp\DellUpdate no destino
	echo Criando pasta Temp\DellUpdate...
    C:\Temp\PSTools\PsExec64.exe \\%%H cmd /c "mkdir c:\Temp\DellUpdate\" >nul 2>&1
	timeout /t 10 /nobreak


    REM Copia o Dell_Command_Update para a pasta Temp\DellUpdate do destino
	echo Copiando Instalador do Dell_Command_Update...
    copy /B /Y C:\Temp\DellUpdate\Dell_Command_Update.exe \\%%H\c$\Temp\DellUpdate >nul 2>&1
    timeout /t 10 /nobreak
	
	REM Copia o arquivo de config para a pasta Temp\DellUpdate do destino
	echo Copiando Arquivo de config do Dell_Command_Update...
    copy /B /Y C:\Temp\DellUpdate\Settings.xml \\%%H\c$\Temp\DellUpdate >nul 2>&1
    timeout /t 10 /nobreak


    REM Executa a instalação do Dell_Command_Update
	echo Instalando o Dell_Command_Update...
    C:\Temp\PSTools\PsExec64.exe \\%%H C:\Temp\DellUpdate\Dell_Command_Update.exe /s >nul 2>&1
	timeout /t 30 /nobreak
	
	
	REM Executa a cofiguracao do Dell_Command_Update
	echo Configurando o Dell_Command_Update...
    C:\Temp\PSTools\PsExec64.exe \\%%H "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe" /configure -importSettings=C:\Temp\DellUpdate\Settings.xml >nul 2>&1
	timeout /t 10 /nobreak


    REM Verifica se o Dell_Command_Update foi instalado
	echo Verificando instalacao do Dell_Command_Update...
    C:\Temp\PSTools\PsExec64.exe \\%%H wmic product get name, version | findstr "Command"
)

echo Finalizado.
pause
