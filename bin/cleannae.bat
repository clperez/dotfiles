@echo off
setlocal EnableDelayedExpansion

echo Find where NAE is installed
set firstline=0
for /f "usebackq tokens=1,2,* delims= " %%a in (`reg query "HKLM\SOFTWARE\Nlyte Software\ICM" /v ApplicationPath`) do (
	if !firstline! EQU 0 (
		set firstline=1
	) else (
		set naedir=%%~c
	)
)

if "!naedir!" EQU "" (
	echo ApplicationPath not found in registry.
	set naedir="!ProgramFiles(x86)!\Nlyte Software\Asset Explorer"
)

echo AplicationPath = !naedir!

rem echo Uninstalling NAE --it takes a while, so don't panic--
rem wmic product where "description='Nlyte Asset Explorer' " uninstall

rem echo Uninstalling BLT --it takes a while, so don't panic--
rem wmic product where "name='Asset Explorer BLT DLL' " uninstall

echo Removing programfiles folder
if exist "!naedir!" ( rmdir /S /Q  !naedir! )
echo Removing programdata folder
if exist "%ProgramData%\Nlyte Software\Asset Explorer" ( rmdir /S /Q  "%ProgramData%\Nlyte Software\Asset Explorer" )

pushd "%systemroot%\system32\inetsrv"
 
echo Deleting the webapps from iis: Default Web Site/AssetExplorer
appcmd delete app "Default Web Site/AssetExplorer"
echo Deleting the webapps from iis: Default Web Site/ICws
appcmd delete app "Default Web Site/ICws"
echo Deleting the webapps from iis: Default Web Site/ODataApi
appcmd delete app "Default Web Site/ODataApi"
echo Deleting the webapps from iis: Default Web Site/ICMReports
appcmd delete app "Default Web Site/ICMReports"
echo Deleting the webapps from iis: Default Web Site/SAM
appcmd delete app "Default Web Site/SAM"
echo Deleting the webapps from iis: Default Web Site/SingleSignOn
appcmd delete app "Default Web Site/SingleSignOn"

echo Deleting the apppools --only present once NET6 is out-- singlesignonapppool
appcmd delete apppool singlesignonapppool
echo Deleting the apppools --only present once NET6 is out-- odataapiapppool
appcmd delete apppool odataapiapppool
popd
 
echo Clean the registry keys: HKLM\SOFTWARE\Nlyte Software\ICM /reg:64
reg delete "HKLM\SOFTWARE\Nlyte Software\ICM" /reg:64 /f
echo Clean the registry keys: HKLM\SOFTWARE\Nlyte Software\ICM /reg:32
reg delete "HKLM\SOFTWARE\Nlyte Software\ICM" /reg:32 /f
echo Clean the registry keys: HKLM\SOFTWARE\Nlyte Software\Nlyte Asset Explorer /reg:32
reg delete "HKLM\SOFTWARE\Nlyte Software\Nlyte Asset Explorer" /reg:32 /f

endlocal