## In this chapter we are going to learn How to run Custom Scripts in Apache NiFi

![Run Custom Scripts](https://github.com/InsightByte/ApacheNifi/blob/main/Custom-Scripts/assets/Custom_scripts.png)


### Find the Full Youtube Tutorial here [How to run Custom Scripts in Apache NiFi](https://youtu.be/bn08IL_UHsQ)





#### ExecuteStreamCommand

Download Template from [ExecuteScremCommand Apache NiFi](https://github.com/InsightByte/ApacheNifi/blob/main/Custom-Scripts/templates/executeSteam.xml)

This processor demonstrate how we can run custom Bash,Python,Java and Ruby scripts from Apache NiFi

- run Bash
- run Python
- run Java
- run Ruby

##### Note: you must have them installed on your NiFi instance in order for the script to run with sucess.

#### ExecuteScript

Download Template from [ExecuteScript Apache NiFi](https://github.com/InsightByte/ApacheNifi/blob/main/Custom-Scripts/templates/executeScript.xml)

This processor demonstrate how we can run custom scripts using the incoming Flow File and a Process Session.
The action we are performing 
- Create New Attribute
- Create New Attribute from existing Attribute
- Create Attributes from a Json List
- Append to a Flow File Content
- Overwrite Flow Content
- Write to Flow Content
- Read Transform and Write Flow Content
- Remove Element from Flow Content
  





