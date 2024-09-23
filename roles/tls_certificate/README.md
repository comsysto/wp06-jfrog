Role Name
=========

This role handles the generation of server certificates for each Artifactory instance. It checks if the certificates exist and creates them if they don't.

Requirements
------------

Access to Kubernetes cluster is configured (current kubectl profile is used). 
Permissions to create (modify) and read secrets in designated namespaces.

Role Variables
--------------
```
# Artifactory instances. Each element should define name, namespace and host.
artifactory_instances:
  - name: artifactory1
    namespace: artifactory-instance1
    host: artifactory1.example.com
  - name: artifactory2
    namespace: artifactory-instance2
    host: artifactory2.example.com

ca_namespace: certificates # Namespace where CA certificate is stored
ca_secret_name: root-ca-secret # Name of Secret resource where CA certificate is stored
root_ca_key: rootCA.key # CA key filename
root_ca_cert: rootCA.crt # CA certificate filename

client_cert_key: client.key  # TLS certificate key filename for artifactory instance
client_cert_crt: client.crt # TLS certificate filename for artifactory instance
```

Dependencies
------------

- kubernetes.core 
- ca_certificate

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: localhost 
      roles:
         - tls_certificate 

