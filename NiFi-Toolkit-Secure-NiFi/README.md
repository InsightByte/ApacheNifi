


# How to connect to a Secure Apache NiFi with NiFi Toolkit
![](https://i.imgur.com/waxVImv.png)
#### 💬 If you have Questions or wanna have a chat - Join Me on Discord at:
[Apache NiFi Topics Q&A](https://discord.gg/qymAvnZqmQ)

[Data Engineering Topics Q&A](https://discord.gg/YykpUT5Wt2)

[Data Engineering  Compass Q&A](https://discord.gg/XR3JqUrA74)

![](https://i.imgur.com/waxVImv.png)

![Connect to a Secure Apache NiFi with NiFi Toolkit](https://github.com/InsightByte/ApacheNifi/blob/main/NiFi-Toolkit-Secure-NiFi/assets/toolkt-secure.png)

##### Find the video version of this article at [Connect to a Secure Apache NiFi with NiFi Toolkit]()

#### Install NiFi Toolkit if you have not done so.
**Download NiFi toolkit & unzip**
```
wget https://dlcdn.apache.org/nifi/1.16.3/nifi-toolkit-1.16.3-bin.zip
cd /opt
unzip nifi-toolkit-1.16.3-bin.zip -d /opt/nifi-toolkit && cd  /opt/nifi-toolkit/nifi-toolkit-1.16.3 &&  mv * .. && cd .. && rm -rf nifi-toolkit-1.16.3
```

#### Once installed create the cli.properties files.
This files is used a connection configuration to our secure niFi Instance.

```
cp /opt/nifi-toolkit/conf/cli.properties.example /opt/nifi-toolkit/conf/cli.properties
```

#### Edit the new file
```
baseUrl=https://localhost:9443
keystore=/opt/nifi-prd-3/certs/localhost/keystore.jks
keystoreType=jks
keystorePasswd=FQTXPIbcXHPG8PgJNzmDC5gbcMo0WtxMscX+5B1adUY
keyPasswd=FQTXPIbcXHPG8PgJNzmDC5gbcMo0WtxMscX+5B1adUY
truststore=/opt/nifi-prd-3/certs/localhost/truststore.jks
truststoreType=jks
truststorePasswd=5SqAT2xZcGdOMnJhvmTg5K+ttY7F/HA2XCpO+rJzaTo
proxiedEntity=
```

#### Add your `CN=localhost, OU=NIFI` user to your NiFi Instance.
This is the CN that was generated as part of the certificate generation that we have done in [Apache NiFi Secure Standalone Setup](https://youtu.be/j-JXo3xPxOk)

See how to add the user here [Connect to a Secure Apache NiFi with NiFi Toolkit]()


#### Test access to NiFi Secure instance 

##### Open your cli.sh or cli.bat if on Windows and set your session session variables.

```
/opt/nifi-toolkit/bin/cli.sh
          _     ___  _
 Apache   (_)  .' ..](_)   ,
 _ .--.   __  _| |_  __    )\
[ `.-. | [  |'-| |-'[  |  /  \
|  | | |  | |  | |   | | '    '
[___||__][___][___] [___]',  ,'
                           `'
          CLI v1.16.3

Type 'help' to see a list of available commands, use tab to auto-complete.

Session loaded from /var/root/.nifi-cli.config

#> session set nifi.props=/opt/nifi-toolkit/conf/cli.properties

#> session show
Current Session:
nifi.reg.props = /opt/nifi-toolkit/nifi-envs/registry-PRD
nifi.props = /opt/nifi-toolkit/conf/cli.properties


#> nifi get-root-id
35829cc3-0182-1000-abc4-e53a54a1ce58
```








