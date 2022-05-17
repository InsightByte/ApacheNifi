#!/bin/bash

## This script returns the list of nifi registry buckets

# /opt/nifi-toolkit/bin/cli.sh registry list-buckets | tail -n +4  | awk '{print $2}' | sed '$ d'
/opt/nifi-toolkit/bin/cli.sh registry list-buckets -ot json