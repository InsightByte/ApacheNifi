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
- Create New Attribute [ExecuteScript Apache NiFi](https://github.com/InsightByte/ApacheNifi/blob/main/Custom-Scripts/scripts/executeScript/create_new_attribute.py)
- Create New Attribute from existing Attribute[Create New Attribute from existing Attribute](https://github.com/InsightByte/ApacheNifi/blob/main/Custom-Scripts/scripts/executeScript/create_new_attribute_from_existing.py)
- Create Attributes from a Json List [Create Attributes from a Json List](https://github.com/InsightByte/ApacheNifi/blob/main/Custom-Scripts/scripts/executeScript/create_attributes_from_list.py)
- Append to a Flow File Content [Append](https://github.com/InsightByte/ApacheNifi/blob/main/Custom-Scripts/scripts/executeScript/append_to_flow_content.py)
- Overwrite Flow Content [Overwrite Flow](https://github.com/InsightByte/ApacheNifi/blob/main/Custom-Scripts/scripts/executeScript/overwrite_flow_content.py)
- Read Transform and Write Flow Content [Read Transform](https://github.com/InsightByte/ApacheNifi/blob/main/Custom-Scripts/scripts/executeScript/read_transform_write.py)
- Remove Element from Flow Content [Remove Element](https://github.com/InsightByte/ApacheNifi/blob/main/Custom-Scripts/scripts/executeScript/read_remove_element_write.py)
  





