%~d0
cd %~dp0
rem Using Java: %JAVA_CMD%

set "JAVA_CMD=java"


if not "%JAVA_HOME_17%" == "" (
    
   set "JAVA_CMD=%JAVA_HOME_17%/bin/java"
     
)
"%JAVA_CMD%" -jar ${project}-${bboss_version}.jar --conf=resources/application.properties  stop