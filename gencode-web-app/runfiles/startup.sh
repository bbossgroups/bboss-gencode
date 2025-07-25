#!/bin/sh
cd `dirname \$0`

parse_jvm_options() {
  if [ -f "\$1" ]; then
    echo "`grep "^-" "\$1" | tr '\n' ' '`"
  fi
}

JVM_OPTIONS_FILE=jvm.options

JAVA_CMD="\${JAVA_HOME_17:-}/bin/java"
if [ ! -x "\$JAVA_CMD" ]; then
  JAVA_CMD="java"
fi
RT_JAVA_OPTS="`parse_jvm_options "\$JVM_OPTIONS_FILE"` \$RT_JAVA_OPTS"
echo \$RT_JAVA_OPTS
nohup \$JAVA_CMD \$RT_JAVA_OPTS -jar ${project}-${bboss_version}.jar --conf=resources/application.properties >/dev/null 2>&1 &
if [  "\$1" == "auto" ];then
  tail ${project}.log
else
  tail -fn200 ${project}.log
fi
