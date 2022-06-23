## In this chapter we are going to learn How to connect Apache NiFi to different types of databases.


![conn](https://github.com/InsightByte/ApacheNifi/blob/main/Excel-NiFi/assets/image.png)


### Find the Full Youtube Tutorial here [Connect NiFi to any Database](https://www.youtube.com/watch?v=ahc6IXlXwU8)


### Create the Parameter Context for the MySQL Database (optional via Toolkit)

See how to setup NiFi toolkit here [Setup NiFi Env](https://youtu.be/A3fVJehWGzk?list=PLkp40uss1kSI66DA_aDCfx02gXipoRQHc])

```
cd ApacheNifi
nifi import-param-context -i 'Excell-NiFi/parameter_context/mysql-config.json' -u http://localhost:8081
nifi import-param-context -i 'Excell-NiFi/parameter_context/excell-tracker-config.json' -u http://localhost:8081
```


### Import the templates from the templates folder. See video tutorial on how to do this.
