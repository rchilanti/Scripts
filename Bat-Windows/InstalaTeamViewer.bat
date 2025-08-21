@echo off
set "hostsFile=C:\Temp\NovoTeamViewer\IPs_TeamViewer.txt"

:: Loop por cada hostname/IP do arquivo
for /f "tokens=*" %%H in (%hostsFile%) do (
    echo Processando o host %%H...

    REM Desinstala Teamviewer x86 do destino
	echo Desinstalando o TeamViewer x86...
    C:\Temp\NovoTeamViewer\PSTools\PsExec64.exe \\%%H "C:\Program Files (x86)\TeamViewer\uninstall.exe" /S >nul 2>&1
	timeout /t 10 /nobreak

    REM Desinstala Teamviewer do destino
	echo Desinstalando o TeamViewer sem senha...
    C:\Temp\NovoTeamViewer\PSTools\PsExec64.exe \\%%H wmic product where "name='TeamViewer Host'" call uninstall /nointeractive >nul 2>&1
	timeout /t 10 /nobreak


    REM Cria pasta Temp\NovoTeamViewer no destino
	echo Criando pasta Temp\NovoTeamViewer...
    C:\Temp\NovoTeamViewer\PSTools\PsExec64.exe \\%%H cmd /c "mkdir c:\Temp\NovoTeamViewer\" >nul 2>&1
	timeout /t 10 /nobreak


    REM Copia o TeamViewerHost15 para a pasta Temp\NovoTeamViewer do destino
	echo Copiando Instalador do TeamViewer...
    copy /B /Y C:\Temp\NovoTeamViewer\TeamViewerHost1559.msi \\%%H\c$\Temp\NovoTeamViewer >nul 2>&1
    timeout /t 10 /nobreak
	
	REM Copia o arquivo de config para a pasta Temp\NovoTeamViewer do destino
	echo Copiando Arquivo de config do TeamViewer...
    copy /B /Y C:\Temp\NovoTeamViewer\TeamViewerHost1559_conf.tvopt \\%%H\c$\Temp\NovoTeamViewer >nul 2>&1
    timeout /t 10 /nobreak


    REM Executa a instalação do TeamViewerHost15 com a senha padrao
	echo Instalando o TeamViewer...
    C:\Temp\NovoTeamViewer\PSTools\PsExec64.exe \\%%H msiexec /i "C:\Temp\NovoTeamViewer\TeamViewerHost1559.msi" /quiet /norestart SETTINGSFILE="C:\Temp\NovoTeamViewer\TeamViewerHost1559_conf.tvopt" >nul 2>&1
	timeout /t 10 /nobreak


    REM Verifica se o TeamViewer foi instalado
	echo Verificando instalacao do TeamViewer...
    C:\Temp\NovoTeamViewer\PSTools\PsExec64.exe \\%%H wmic product get name, version | findstr "TeamViewer"
)

echo Finalizado.
pause
