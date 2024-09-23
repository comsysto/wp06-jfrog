Ngnix Ingress MTLS
=========

Configures Nginx Ingress controller routing to specified artifactory instances using mTLS.

Requirements
------------

Access to Kubernetes cluster as default profile in kubectl. 

Role Variables
--------------
```
artifactory_instances:
  - name: artifactory1
    namespace: artifactory-instance1
    host: artifactory1.example.com
    ingress_class: nginx-1
  - name: artifactory2
    namespace: artifactory-instance2
    host: artifactory2.example.com
    ingress_class: nginx-2

ca_namespace: certificates
ca_secret_name: root-ca-secret
```

Dependencies
------------

- ca_certificate
- tls_certificate
- artifactory_deploy


Example Playbook
----------------

    - hosts: localhost  
      roles:
        - nginx_ingress_mtls   

