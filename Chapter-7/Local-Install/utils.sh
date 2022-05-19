
echo " Start NiFi PRD"
/opt/nifi-prd/bin/nifi.sh start
echo " Start NiFi STG"
/opt/nifi-stg/bin/nifi.sh start
echo " Start NiFi DEV"
/opt/nifi-dev/bin/nifi.sh start
echo " Start NiFi Registry"
/opt/nifi-registry/bin/nifi-registry.sh start
echo " Start Jenkins"
brew services start jenkins-lts


echo " Stop NiFi PRD"
/opt/nifi-prd/bin/nifi.sh stop
echo " Stop NiFi STG"
/opt/nifi-stg/bin/nifi.sh stop
echo " Stop NiFi DEV"
/opt/nifi-dev/bin/nifi.sh stop
echo " Stop NiFi Registry"
/opt/nifi-registry/bin/nifi-registry.sh stop
echo " Stop Jenkins"
brew services stop jenkins-lts

echo " Remove all NiFi Setup"
# rm -rf /opt/nifi-prd/ /opt/nifi-stg/ /opt/nifi-dev/ /opt/nifi-registry/ /opt/nifi-toolkit/ 