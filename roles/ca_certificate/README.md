CA Certificate
=========

This role handles the creation and management of the Root CA certificate. It checks if the CA exists and creates it if it doesn't. It also stores the CA certificate in a dedicated namespace.

Requirements
------------

- configured access to Kubernetes cluster (kubectl should access the cluster on designated host) 
- permissions to read and create secrets in specified namespace

Role Variables
--------------
```
ca_namespace: certificates # namespace where the secret is stored
ca_secret_name: root-ca-secret # name of the secret resource
root_ca_key: rootCA.key # CA key filename 
root_ca_cert: rootCA.crt # CA certificate filename
```

Dependencies
------------

- kubernetes.core

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: localhost 
      roles:
         - ca_certificate 

