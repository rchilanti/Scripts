@echo off
set "hostsFile=C:\Temp\LenovoVantage\IPs_LenovoVantage.txt"

:: Loop por cada hostname/IP do arquivo
for /f "tokens=*" %%H in (%hostsFile%) do (
    echo Processando o host %%H...


    REM Cria pasta Temp\LenovoVantage no destino
	echo Criando pasta Temp\LenovoVantage...
    C:\Temp\PSTools\PsExec64.exe \\%%H cmd /c "mkdir c:\Temp\LenovoVantage\" >nul 2>&1
	C:\Temp\PSTools\PsExec64.exe \\%%H cmd /c "mkdir c:\Temp\LenovoVantage\LenovoCommercialVantage\" >nul 2>&1
	timeout /t 5 /nobreak


    REM Copia o LenovoVantage para a pasta Temp\LenovoVantage do destino
	echo Copiando PastaZIP do LenovoVantage...
    copy /B /Y C:\Temp\LenovoVantage\LenovoCommercialVantage.zip \\%%H\c$\Temp\LenovoVantage\ >nul 2>&1
    timeout /t 5 /nobreak
	
	
	REM Descompacta Zip
	echo Descompactando Zip do LenovoVantage...
	C:\Temp\PSTools\PsExec64.exe \\%%H cmd /c "tar -xf C:\Temp\LenovoVantage\LenovoCommercialVantage.zip -C C:\Temp\LenovoVantage\LenovoCommercialVantage\"
    timeout /t 5 /nobreak

    REM Executa a instalação do LenovoVantage
	echo Instalando o LenovoVantage...
	C:\Temp\PSTools\PsExec64.exe -i -s \\%%H "C:\Temp\LenovoVantage\LenovoCommercialVantage\setup-commercial-vantage.bat"
    timeout /t 5 /nobreak

)

echo Finalizado.
pause
