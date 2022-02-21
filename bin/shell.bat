@echo off
:: Create an alias to work with git configurations
:: DOSKEY config=git --git-dir="%USERPROFILE%\.cfg" --work-tree="%USERPROFILE%" $* 
:: Run visual studio development environment

set VS_Path=%ProgramFiles(x86)%\Microsoft Visual Studio\2019
set Community_Path="%VS_Path%\Community\Common7\Tools\VsDevCmd.bat"
set BuildTools_Path="%VS_Path%\BuildTools\Common7\Tools\VsDevCmd.bat"

if exist %Community_Path% (
	echo Loading Community environment
	call %Community_Path%
) else (
  	if exist %BuildTools_Path% (
	       	echo Loading Buildtools environment
    		call %BuildTools_Path%
	) else (
		echo WARNING. NO VS TOOLS FOUND
	)
)

set Desktop=%userprofile%\Desktop
set Work=%userprofile%\Projects
set path=%path%;%USERPROFILE%\AppData\Local\JetBrains\Toolbox\apps\Rider\ch-0\203.6682.13\bin;d:\bin
