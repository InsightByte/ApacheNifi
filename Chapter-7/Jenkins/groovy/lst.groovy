//Create buffer to capture command's Standard Out
def sout = new StringBuffer(), serr = new StringBuffer()

//Define here the shell command you would like to execute
// def proc = 'sudo /opt/nifi-toolkit/bin/cli.sh registry list-buckets'.execute()
def proc = 'list.sh'.execute()

//Capture command output into buffer
proc.consumeProcessOutput(sout, serr)

//Time to wait for command to complete
proc.waitForOrKill(1000)

//Converts command output to a list of choices, split by whitespace
println sout.tokenize()
