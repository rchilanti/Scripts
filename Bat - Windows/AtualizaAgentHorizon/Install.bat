@echo off

C:\Temp\UpdateAgentVDI\Omnissa-Horizon-Agent-8.18.exe /s /v"/qn /l*v "C:\Temp\UpdateAgentVDI\HorizonAgentInstall.log" SUPPRESS_RUNONCE_CHECK=1 REBOOT=Force ADDLOCAL=Core,USB,RTAV,ClientDriveRedirection,ScannerRedirection,SmartCard,HznVaudio,SdoSensor,GEOREDIR,PerfTracker,PrintRedir,HelpDesk"


exit /b %errorlevel%