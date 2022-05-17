# Chapter 7 - NiFi Development Environment Setup


EC2-Env - if you are on a Mac M1 silicone(Docker acts realy strange on it)


## EC2-Env Setup
**This is going to be our target setup for EC2-Env.**
![Chapter 7 - NiFi Development Environment Setup](https://github.com/InsightByte/ApacheNifi/blob/main/Chapter-7/images/NIFI%20DEVELOPMENT.png)

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



## Local Docker Setup 

This setup requires that you hoave docker installed locally. 
![Chapter 7 - NiFi Local Docker Environment Setup](https://github.com/InsightByte/ApacheNifi/blob/main/Chapter-7/images/NIFI-docker.png)
** To run all images run the script bellow**
```
ApacheNifi/Chapter-7/Local-Docker/Setup-Local-Docker.sh

```

Will create one Jenkins container, one NiFi Registry container, three NiFi Containers (PRD/DEV/STG)

**Note:**
You must complete Jenkins plugin installation in Web Browser.


## Local Installation Setup
This setup requires you to run on Mac or Linux, it will download NiFi, NiFi Registry & NiFi Toolkit version 1.16.1, but you can change the version. (Edit script to fit your needs.)

![Chapter 7 - NiFi Local Installation Development Environment Setup](https://github.com/InsightByte/ApacheNifi/blob/main/Chapter-7/images/NIFI-local.png)

### To setup all services run the script:
```
ApacheNifi/Chapter-7/Local-Install/Setup-Local.sh
```

Will install in /opt NiFi Registry, NiFi Toolkit and three NiFi Containers (PRD/DEV/STG)
