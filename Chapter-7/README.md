# ApacheNifi

Chapter 7 - NiFi Development Environment Setup

I have to go thru this because my localhost is a Mac M1 - and Docker acts realy strange on it. 

If you are on Windows or Intel Mac you can setup Docker locally. 
This is going to be our target setup.


![Chapter 7 - NiFi Development Environment Setup](https://github.com/InsightByte/ApacheNifi/blob/main/Chapter%207%20-%20Setting%20Development%20Environment/images/NIFI%20DEVELOPMENT.png)

**How to build the Environment**

You must have an AWS account and AWs CLI installed and setup [Follow link here to see how you do it](link to vid)


**Edit the config.sh file to match your AWS Environment**
```
ApacheNifi/Chapter-7/EC2-Env/config.sh
# Ubuntu image we will use
export ami='ami-0672b175139a0f8f4'
# My VPC 
export vpc_id='vpc-d2af15b7' 
# Instance Type/Size
export instance_type='t3.xlarge'
# My Key name
export key_name='InsightByte_demo'

```

**Clone the repo onto your localhost and run:**
```
ApacheNifi/Chapter-7/EC2-Env/setup.sh

```

**Or you could run it step by step.**

**Note:**
You must complete Jenkins plugin installation in Web Browser.

