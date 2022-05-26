
### See Complete Video explanation here
https://youtu.be/7SzqKeX1y9w

### Download the used template from here


### What is NiFi Expression Language ? 

Is the ability to reference attributes, compare them to other values, and manipulate their values while they are linked to a flow file.


### Why do we need NiFi Expression Language?

 NiFi is very rich in attributes that are present in all Flow files and the flow files are the core componenet of nifi. 


### How do we use this Expresion Language ? 

It always starts with a dollar sign and an opening curly brace(```“${“```) and ends with a closing curly brace(```“}”```). The first variable would be either an attribute from the FlowFile(first priority) or from the Variable Registry. Then we can add a colon and a function. 
#### Example: 
```${variable:function()}```



