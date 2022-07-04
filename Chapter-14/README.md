# Apache NiFi Site-to-Site


### In this chapter will go over Apache NiFi Site-to-Site.

- What is Apache NiFi S2S ? 
- We will cover what is used for.
- What are the benefits of using S2S.
- How to configure S2S.
- Run a full Demo of Apache NiFi S2S in action.

#### What is Apache NiFi S2S ? 

S2S is an internal NiFi data exchange protocol. This allows NiFi Instances to communicate in a bidirectional way. 


#### We will cover what is used for.
S2S enables use to build multi-region and multi-tier distributed NiFi architectures.
S2S also enabled MiNiFi agents to exchange data with a NiFi instance. 

#### What are the benefits of using S2S.
- Easy to configure

After entering the URL of the remote NiFi instance, the available ports (endpoints) are automatically discovered and provided in a drop-down list

- Secure

Site-to-Site optionally makes use of Certificates in order to encrypt data and provide authentication and authorization. Each port can be configured to allow only specific users, and only those users will be able to see that the port even exists.

- Scalable

As nodes in the remote cluster change, those changes are automatically detected and data is scaled out across all nodes in the cluster.

- Efficient

Site-to-Site allows batches of FlowFiles to be sent at once in order to avoid the overhead of establishing connections and making multiple round-trip requests between peers.

- Reliable

Checksums are automatically produced by both the sender and receiver and compared after the data has been transmitted, in order to ensure that no corruption has occurred. If the checksums don't match, the transaction will simply be canceled and tried again.

- Automatically load balanced

As nodes come online or drop out of the remote cluster, or a node's load becomes heavier or lighter, the amount of data that is directed to that node will automatically be adjusted.

- FlowFiles maintain attributes

When a FlowFile is transferred over this protocol, all of the FlowFile's attributes are automatically transferred with it. This can be very advantageous in many situations, as all of the context and enrichment that has been determined by one instance of NiFi travels with the data, making for easy routing of the data and allowing users to easily inspect the data.

- Adaptable

As new technologies and ideas emerge, the protocol for handling Site-to-Site communications are able to change with them. When a connection is made to a remote NiFi instance, a handshake is performed in order to negotiate which protocol and which version of the protocol will be used. This allows new capabilities to be added while still maintaining backward compatibility with all older instances. Additionally, if a vulnerability or deficiency is ever discovered in a protocol, it allows a newer version of NiFi to forbid communication over the compromised versions of the protocol.


#### How to configure S2S

See Video tutorial covering this topic.

#### Run a full Demo of Apache NiFi S2S in action.

See Video tutorial covering this topic.


### Available NiFi properies for s2s
```
# Site to Site properties
nifi.remote.input.host=
nifi.remote.input.secure=false
nifi.remote.input.socket.port=
nifi.remote.input.http.enabled=true
nifi.remote.input.http.transaction.ttl=30 sec
nifi.remote.contents.cache.expiration=30 secs
```