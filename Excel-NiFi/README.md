## In this chapter we are going to learn How to Automate Excel Data Extraction/Migration to MySQL with Apache NiFi

![conn](https://github.com/InsightByte/ApacheNifi/blob/main/Excel-NiFi/assets/image.png)


## Part 1
### Find the Full Youtube Tutorial here [How to Read Excel data with Apache NiFi](https://youtu.be/bn08IL_UHsQ)

## Part 2 
### Find the Full Youtube Tutorial here [How to Read Multi sheet Excel with Apache NiFi](https://youtu.be/39HPMQrK9RA)

## Part 3 
### Find the Full Youtube Tutorial here [How to Read Multi sheet Excel with Apache NiFi](https://youtu.be/VhGHRYateqg)


### Create the Parameter Context for the MySQL Database (optional via Toolkit)
See how to setup NiFi toolkit here [Setup NiFi Env](https://youtu.be/A3fVJehWGzk?list=PLkp40uss1kSI66DA_aDCfx02gXipoRQHc])

```
cd ApacheNifi
nifi import-param-context -i 'Excel-NiFi/parameter_context/mysql-config.json' -u http://localhost:8081
nifi import-param-context -i 'Excel-NiFi/parameter_context/excell-tracker-config.json' -u http://localhost:8081
```


### Import the templates from the templates folder. See video tutorial on how to do this.
