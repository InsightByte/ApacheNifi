
## Apache NiFi Parameter Context


### What is Parameter Context in Apache NiFi ?


This parameters act as replacement for values of properties in the flow.
They are globally defined.

**Parameter Context must follow this conditions:**

    A sensitive property can only reference a Sensitive Parameter

    A non-sensitive property can only reference a Non-Sensitive Parameter

    Properties that reference Controller Services can not use Parameters

    Parameters cannot be referenced in Reporting Tasks or in controller-level Controller Services


### How to create a Parameter Context ?

1 - Using the NiFi UI
2 - Using the NiFi Toolkit cli.sh


**Import New Parameter Context**
```
nifi import-param-context -i '/Users/adrianoprea/Desktop/InsightByte/GitRepo/ApacheNifi/Nifi toolkit/parameters/paramer_02.json' -u http://localhost:8081
```


**Add a new Parameter & Value**
```
nifi set-param --paramContextId  8398806d-722c-3733-fe40-4df543e59f8b --paramName param1 --paramValue values
```

**Delete Parameter from Parameter Context**
```
nifi delete-param --paramContextId  8398806d-722c-3733-fe40-4df543e59f8b --paramName param1
```


**Export Parameter Context**
```
nifi export-param-context --paramContextId 2e4d387e-564c-1f46-9cd0-b5ef0967dfe1 --outputFile /opt/param_export.json
```

**Read a Parameter Context**
```
nifi  get-param-context --paramContextId 2e4d387e-564c-1f46-9cd0-b5ef0967dfe1
```


**Set Parameter Context to a Process Group**
```
nifi pg-set-param-context --paramContextId 2e4d387e-564c-1f46-9cd0-b5ef0967dfe1 --processGroupId 2e4d3880-564c-1f46-caa0-70def7f47841
```

**GET Parameter Context used by a Process Group**
```
nifi pg-set-param-context --processGroupId 
```




3 - Importing Flow from NiFi Registry



### How to use a Parameter Context once is created ? 


### How to Update a Parameter Context ? 


### How to add new parameters to a Parameter Context ? 


### Inheritence 
