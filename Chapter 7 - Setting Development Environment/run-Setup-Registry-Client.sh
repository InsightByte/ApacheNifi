#!/bin/bash

sudo docker cp /opt/scripts/Setup-Registry-Client.sh jenkins:/opt/.
sudo docker exec -u 0 jenkins /opt/Setup-Registry-Client.sh