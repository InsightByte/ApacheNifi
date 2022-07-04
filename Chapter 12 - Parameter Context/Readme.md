
# How to use NiFi toolkit client.



### Start by installing the NiFi toolkit

**Set some parameters that will be used in the install & config script**
```
export version='1.16.1'
export nifi_registry_port='18080'
export nifi_prd_port='8081'
export nifi_stg_port='8082'
export nifi_dev_port='8083'
```

**Download NiFi toolkit & unzip**
```
wget https://dlcdn.apache.org/nifi/${version}/nifi-toolkit-${version}-bin.zip
cd /opt
unzip nifi-toolkit-${version}-bin.zip -d /opt/nifi-toolkit && cd  /opt/nifi-toolkit/nifi-toolkit-${version} &&  mv * .. && cd .. && rm -rf nifi-toolkit-${version}
```


**Create Toolkit config files for all of our NiFi assets**
```
prop_replace () {
  target_file=${3:-${nifi_props_file}}
  echo 'replacing target file ' ${target_file}
  sed -i -e "s|^$1=.*$|$1=$2|"  ${target_file}
}



echo "Create NiFi Toolkit Client configuration"
mkdir -p /opt/nifi-toolkit/nifi-envs
cp /opt/nifi-toolkit/conf/cli.properties.example /opt/nifi-toolkit/nifi-envs/nifi-PRD
cp /opt/nifi-toolkit/conf/cli.properties.example /opt/nifi-toolkit/nifi-envs/nifi-STG
cp /opt/nifi-toolkit/conf/cli.properties.example /opt/nifi-toolkit/nifi-envs/nifi-DEV
cp /opt/nifi-toolkit/conf/cli.properties.example /opt/nifi-toolkit/nifi-envs/registry-PRD

prop_replace baseUrl http://localhost:${nifi_prd_port} /opt/nifi-toolkit/nifi-envs/nifi-PRD
prop_replace baseUrl http://localhost:${nifi_stg_port} /opt/nifi-toolkit/nifi-envs/nifi-STG
prop_replace baseUrl http://localhost:${nifi_dev_port} /opt/nifi-toolkit/nifi-envs/nifi-DEV
prop_replace baseUrl http://localhost:${nifi_registry_port} /opt/nifi-toolkit/nifi-envs/registry-PRD
```


### Not that all is set let's explore the NiFi toolkit

#### NiFi CLI 

This utility is used to automate NiFi or NiFi Registry tasks.

The utility is located at
```
/opt/nifi-toolkit/bin/cli.sh 
```


**How to interact with NiFi using the toolkit ? **

The toolkit provides us with 2 session properties called keys

```
#> session  keys                              
        nifi.props
        nifi.reg.props
```

This properties receive the location/path to the nifi/registry configuration files. 

The config files has the following properties
```
baseUrl=http://localhost:8083
keystore=
keystoreType=
keystorePasswd=
keyPasswd=
truststore=
truststoreType=
truststorePasswd=
proxiedEntity=% 
```

**How do we set this properies ?**

```
session set nifi.props /opt/nifi-toolkit/nifi-envs/nifi-DEV 
```

**To see the session set prop keys**
```
#> session show

Current Session:

nifi.reg.props = /opt/nifi-toolkit/nifi-envs/registry-PRD
nifi.props = /opt/nifi-toolkit/nifi-envs/nifi-DEV
```

## NiFi Toolkit CLI commands

**How to find the root PG Id**

```
#> nifi get-root-id

d090bc40-0180-1000-f1dc-2b64efc5a2ab
```

**How to list all Process Groups**

```
#> nifi pg-list
#   Name      Id                                     Running   Stopped   Disabled   Invalid   
-   -------   ------------------------------------   -------   -------   --------   -------   
1   test_pg   eea42f76-0180-1000-f302-f5a6ea827049   0         1         1          0  
```

**Find current used user**
```
#> nifi current-user                                   
anonymous
```

**List all available templates*
```
#> nifi list-templates 
#   Name                                       ID                                     Group ID                               
-   ----------------------------------------   ------------------------------------   ------------------------------------   
1   Chapter 9 - Write-and-Read-with-NiFi-processors   d63b2569-6c2b-44c6-83b9-5085a5766357   d090bc40-0180-1000-f1dc-2b64efc5a2ab   
2   temp1                                      c48fb66d-07f1-4333-b28a-af4761ecb640   d090bc40-0180-1000-f1dc-2b64efc5a2ab   
```

**Download a template**
```
#> nifi download-template --templateId c48fb66d-07f1-4333-b28a-af4761ecb640 --outputFile /opt/temp.xml
```

**Upload a template**
```
#> nifi upload-template --input /opt/temp.xml --processGroupId d090bc40-0180-1000-f1dc-2b64efc5a2ab                                                                 
```


**List all NiFi Registry clients**
```
#> nifi list-reg-clients
#   Name   Id                                     Uri                      
-   ----   ------------------------------------   ----------------------   
1   PRD    d0a13e27-0180-1000-7d41-9e38685ff79b   http://localhost:18080   
```

**Get the summary of your Cluster**
```
#> nifi cluster-summary                                  
Total node count: 0
Connected node count: 0
Clustered: false
Connected to cluster: false    
```


