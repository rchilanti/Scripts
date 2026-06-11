@echo off
REM Arquivo com a lista de hosts
set "hostsFile=C:\Temp\UpdateAgentVDI\ListaAtualizaVDI.txt"

:: Loop por cada hostname/IP do arquivo
for /f "tokens=*" %%H in (%hostsFile%) do (
    echo Processando o host %%H...

   
    REM Cria pasta Temp\UpdateAgentVDI no destino
	echo Criando pasta Temp\UpdateAgentVDI...
    C:\Temp\PSTools\PsExec64.exe \\%%H -u usuario -p "senha" cmd /c "mkdir C:\Temp\UpdateAgentVDI" >nul 2>&1
	timeout /t 10 /nobreak


    REM Copia o Omnissa-Horizon-Agent-8.18 para a pasta Temp\UpdateAgentVDI do destino
	echo Copiando Instalador Omnissa-Horizon-Agent-8.18...
    C:\Temp\PSTools\PsExec64.exe \\%%H -u usuario -p "senha" cmd /c "copy \\fileserver\temp\renan\VDI\UpdateAgentVDI\Omnissa-Horizon-Agent-8.18.exe C:\Temp\UpdateAgentVDI\" >nul 2>&1
    timeout /t 10 /nobreak

	
    REM Copia o Script para a pasta Temp\UpdateAgentVDI do destino
	echo Copiando Script de instalacao...
    C:\Temp\PSTools\PsExec64.exe \\%%H -u usuario -p "senha" cmd /c "copy \\fileserver\temp\renan\VDI\UpdateAgentVDI\Install.bat C:\Temp\UpdateAgentVDI\" >nul 2>&1
    timeout /t 10 /nobreak

	
    REM Executa a instalação do Omnissa-Horizon-Agent-8.18 com a senha padrao
	echo Instalando o Omnissa-Horizon-Agent-8.18...
    C:\Temp\PSTools\PsExec64.exe \\%%H -u usuario -p "senha" cmd /c "C:\Temp\UpdateAgentVDI\Install.bat" >nul 2>&1
	timeout /t 10 /nobreak


    REM Remove pasta C:\Temp\UpdateAgentVDI
	echo Removendo pasta C:\Temp\UpdateAgentVDI...
    C:\Temp\PSTools\PsExec64.exe \\%%H -u usuario -p "senha" cmd /c "del /f /q C:\Temp\UpdateAgentVDI\Omnissa-Horizon-Agent-8.18.exe" >nul 2>&1
    C:\Temp\PSTools\PsExec64.exe \\%%H -u usuario -p "senha" cmd /c "del /f /q C:\Temp\UpdateAgentVDI\Install.bat" >nul 2>&1
	timeout /t 10 /nobreak
)

echo Finalizado.
pause
