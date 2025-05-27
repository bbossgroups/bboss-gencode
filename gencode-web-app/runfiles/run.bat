%~d0
cd %~dp0
@echo off
rem Using Java: %JAVA_CMD%

set "JAVA_CMD=java"


if not "%JAVA_HOME_17%" == "" (
    
   set "JAVA_CMD=%JAVA_HOME_17%/bin/java"
     
)

setlocal enabledelayedexpansion
setlocal enableextensions
set "JVM_OPTIONS_FILE=jvm.options"

@setlocal
rem extract the options from the JVM options file %JVM_OPTIONS_FILE%
rem such options are the lines beginning with '-', thus "findstr /b"
for /F "usebackq delims=" %%a in (`findstr /b \\- "%JVM_OPTIONS_FILE%"`) do set JVM_OPTIONS=!JVM_OPTIONS! %%a
@endlocal & set RT_JAVA_OPTS=%JVM_OPTIONS% %RT_JAVA_OPTS%
@echo JVM argements %RT_JAVA_OPTS%
if ""%1""==""start"" goto start
if ""%1""==""stop"" goto stop
if ""%1""==""restart"" goto restart
if ""%1""=="""" goto info
:info

echo Usage:
echo   ${project} keyword
echo   ----------------------------------------------------------------
echo   start                            -- Start ${project}
echo   stop                             -- stop ${project}
echo   restart                          -- Restart ${project}
echo   ----------------------------------------------------------------

goto end


:start
    "%JAVA_CMD%" %RT_JAVA_OPTS% -jar ${project}-${bboss_version}.jar --conf=resources/application.properties
goto end
:stop
    "%JAVA_CMD%" -jar ${project}-${bboss_version}.jar stop --conf=resources/application.properties
goto end
:restart
    "%JAVA_CMD%" %RT_JAVA_OPTS% -jar ${project}-${bboss_version}.jar restart --conf=resources/application.properties
goto end

:end
echo end
endlocal
endlocal