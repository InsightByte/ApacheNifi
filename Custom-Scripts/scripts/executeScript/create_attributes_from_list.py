import json
flowFile = session.get()
if flowFile != None:
    # Get attributes
    attributes_payload = json.loads(flowFile.getAttribute("attributes_payload"))
    
    # Set multiple attributes
    flowFile = session.putAllAttributes(flowFile, attributes_payload)

session.transfer(flowFile, REL_SUCCESS)
