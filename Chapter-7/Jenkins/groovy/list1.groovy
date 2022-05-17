import groovy.json.JsonSlurper
import jenkins.model.* 
import hudson.model.*

//Pull in credentials, filter out the secret containing the tenancy OCID, and return the secret text.
// def tenancy_ocid = com.cloudbees.plugins.credentials.CredentialsProvider.lookupCredentials(
//         com.cloudbees.plugins.credentials.Credentials.class,
//         Jenkins.instance,
//         null,
        
// ).find {it.id == 'tenancy_ocid'}.secret;


// def oci = '/var/lib/jenkins/bin/oci' //oci command shortcut
def sout = new StringBuilder(), serr = new StringBuilder() //standard out and error strings

//Assemble OCI CLI command to fetch compartments
def cmd = '/Users/adrianoprea/Desktop/InsightByte/GitRepo/ApacheNifi/Chapter-7/Jenkins/groovy/list.sh'


def proc = cmd.execute() //Execute OS command
proc.waitForProcessOutput(sout, serr) //Wait for command to complete
proc.waitForOrKill(10000) //Set timeout

//Catch errors and return error text
if (serr) {
	return ['Error $serr']
}


//Process JSON output from CLI command
def parser = new JsonSlurper()
def Object jsonResp = parser.parseText(sout.toString())
def compartments = new HashMap() //A HashMap is list of key/value pairs
def comps =  jsonResp.data

//Assemble Hash Map of compartments with return and display values
comps.each {cmp ->
 compartments.put("$cmp.identifier","$cmp.name")
}

//Return Hash Map. This populates the select list.
return compartments
