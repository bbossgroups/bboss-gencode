#!/bin/sh
cd `dirname \$0`

JAVA_CMD="\${JAVA_HOME_17:-}/bin/java"
if [ ! -x "\$JAVA_CMD" ]; then
  JAVA_CMD="java"
fi

\$JAVA_CMD -jar ${project}-${bboss_version}.jar stop --conf=resources/application.properties  --shutdownLevel=9
