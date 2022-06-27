from org.apache.commons.io import IOUtils
from java.nio.charset import StandardCharsets
from org.apache.nifi.processor.io import OutputStreamCallback
 
# Define a subclass of OutputStreamCallback for use in session.write()
class PyOutputStreamCallback(OutputStreamCallback):
  def __init__(self):
        pass
  def process(self, outputStream):
    outputStream.write(bytearray('Hello World!'.encode('utf-8')))
# end class
flowFile = session.get()
if(flowFile != None):
    flowFile = session.write(flowFile, PyOutputStreamCallback())
session.transfer(flowFile, REL_SUCCESS)
