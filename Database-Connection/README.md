## In this chapter we are going to learn How to connect Apache NiFi to different types of databases.


![conn](https://github.com/InsightByte/ApacheNifi/blob/main/Database-Connection/assets/dbconn.png)


### Find the Full Youtube Tutorial here [Connect NiFi to any Database](https://www.youtube.com/watch?v=ahc6IXlXwU8)

### Connect Apache NiFi to Mysql Database.

```jdbc:mysql://#{db_host}:#{db_port}/#{db_name}```
### Driver Class
```com.mysql.jdbc.Driver```

### JDBC Driver location 
[MySQL Driver](https://dbschema.com/jdbc-drivers/MySqlJdbcDriver.zip)


### Connect Apache NiFi to PostgreSQL Database.
```jdbc:postgresql://#{db_host}:#{db_port}/#{db_name}```
### Driver Class
```com.mysql.jdbc.Driver```
### JDBC Driver location 
[PostgreSQL Driver](https://jdbc.postgresql.org/download/postgresql-42.4.0.jar)


### Follow this link for more DB Driver and their jdbc url config.
[DBSchema](https://dbschema.com/databases.html)


### Download the drivers into folder drivers on the NiFi host
``` mkdir -p /<nifi home directory>/drivers```


### Create the Parameter Context for the MySQL Database (optional via Toolkit)
See how to setup NiFi toolkit here [Setup NiFi Env](https://youtu.be/A3fVJehWGzk?list=PLkp40uss1kSI66DA_aDCfx02gXipoRQHc])
```
cd ApacheNifi
nifi import-param-context -i 'Database-Connection/parameter-context/mysql-config.json' -u http://localhost:8081
nifi import-param-context -i 'Database-Connection/parameter-context/postgres-config.json' -u http://localhost:8081
```

Note: - make sure you don`t commit your passwords :) 


