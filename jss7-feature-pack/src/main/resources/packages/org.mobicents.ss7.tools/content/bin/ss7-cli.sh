JAVA_OPTS="-Dss7.connect -Dss7.username=admin -Dss7.password=admin"
java $JAVA_OPTS -cp `dirname $0`'/client/*' org.mobicents.ss7.management.console.Shell
