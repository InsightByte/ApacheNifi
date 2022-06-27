flowFile = session.get()
if flowFile != None:
    # Get attributes
    attribute = flowFile.getAttribute("my_attribute")
    # Create new Attribute using captured attribute value 
    message = "My attribute " + attribute + " updated"
    # Add the new attribute message  to our flow
    flowFile = session.putAttribute(flowFile, "message", message)


session.transfer(flowFile, REL_SUCCESS)