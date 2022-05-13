#!/bin/bash

docker cp /opt/scripts/Setup-Registry-Client.sh jenkins:/opt/.
docker exec -u 0 jenkins /opt/Setup-Registry-Client.sh