def p = sh(returnStdout: true, script: "/opt/nifi-toolkit/bin/cli.sh registry list-buckets")
p.waitFor()
println p

// def my_choices = sh script: "ls -l /home", returnStdout:true
//        // make a list out of it - I haven't tested this!
// my_choices_list = my_choices.trim().split("\n")


def command = ['aws', 'elasticbeanstalk', 'describe-application-versions', '--application-name', "'${appName}'", '--region', "'${region}'"]


def command = ['/bin/sh',  '-c',  'ssh user@host \'find /tmp/files/*pattern* \' ']

def my_choices_list = []

node('master') {
   stage('prepare choices') {
       // read the folder contents
       def my_choices = sh script: "ls -l /", returnStdout:true
       // make a list out of it - I haven't tested this!
       my_choices_list = my_choices.trim().split("\n")
   }
}

pipeline {
   parameters { 
        choiceParam('OPTION', my_choices_list)