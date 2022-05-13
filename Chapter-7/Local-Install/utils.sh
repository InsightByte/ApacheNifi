
echo " Start NiFi PRD"
/opt/nifi-prd/bin/nifi.sh start
echo " Start NiFi STG"
/opt/nifi-stg/bin/nifi.sh start
echo " Start NiFi DEV"
/opt/nifi-dev/bin/nifi.sh start


echo " Start NiFi PRD"
/opt/nifi-prd/bin/nifi.sh stop
echo " Start NiFi STG"
/opt/nifi-stg/bin/nifi.sh stop
echo " Start NiFi DEV"
/opt/nifi-dev/bin/nifi.sh stop


echo " Remove all NiFi Setup"
# rm -rf /opt/nifi-prd/ /opt/nifi-stg/ /opt/nifi-dev/ /opt/nifi-registry/ /opt/nifi-toolkit/ 
