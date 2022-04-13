#!/bin/sh -e

# 1 - value to search for
# 2 - value to replace
# 3 - file to perform replacement inline

# Help per funcitons
prop_replace () {
  target_file=${3:-${nifi_props_file}}
  echo 'replacing target file ' ${target_file}
  sed -i -e "s|^$1=.*$|$1=$2|"  ${target_file}
}

uncomment() {
	target_file=${2}
	echo "Uncommenting ${target_file}"
	sed -i -e "s|^\#$1|$1|" ${target_file}
}



# NIFI_HOME is defined by an ENV command in the backing Dockerfile
export nifi_bootstrap_file=${NIFI_HOME}/conf/bootstrap.conf
export nifi_props_file=${NIFI_HOME}/conf/nifi.properties
export nifi_toolkit_props_file=${HOME}/.nifi-cli.nifi.properties
export hostname='0.0.0.0'
# IS_SECURE Must be true/false, if set to true then you must provide values for ADMIN_USER,ADMIN_PASSWORD as well.
# As of 1.14.0 NiFi will by default start the instance in https mode - generating a user and password as first run time
export IS_SECURE='false'
export ADMIN_USER='admin'
export ADMIN_PASSWORD='admin1admin1'
# default will be 8443, but you provide new port 
export HTTPS_PORT=
# default will be 8080, but you provide new port 
export HTTP_PORT=

if [ -z ${HTTPS_PORT} ] || [ ${IS_SECURE}=='true' ]; then 
        echo " Set default HTTP to 8443"
        export HTTPS_PORT='8443'
fi

if [ -z ${HTTP_PORT} ] || [ ${IS_SECURE}=='false' ]; then
        echo " Set default HTTP_PORt to 8080"
        export HTTP_PORT='8080'
fi

#Validate Pass Lenght

if [ ${IS_SECURE}=='true' ]; then
      if [ -z "$ADMIN_USER" ] || [ -z "$ADMIN_PASSWORD" ] ; then
        echo "ADMIN_USER, ADMIN_PASSWORD must be set when IS_SECURE='true'"
        echo "admin user: "$ADMIN_USER
        echo "admin password: "$ADMIN_PASSWORD
        # exit
        else
        if [ ${#ADMIN_PASSWORD} -lt 12 ]; then 
            echo "Password must have at least 12 characters" ;
            exit
            else echo "Password validation passed"
        fi
        echo "Will set admin initial password for user: "$ADMIN_USER " set to  "$ADMIN_PASSWORD
      fi
else
echo "Is not a Secure setup, no credentials required."
fi
