Artifactory Deploy
=========

Deploys multiple instances of Artifactory OSS version on Kubernetes cluster. 

Requirements
------------
- configured access to Kubernetes cluster (kubectl should access the cluster on designated host) 
- internet access to Helm charts

Role Variables
--------------

```
# List of instances with name, namespace and hostname
artifactory_instances:
  - name: artifactory1
    namespace: artifactory-instance1
    host: artifactory1.example.com
  - name: artifactory2
    namespace: artifactory-instance2
    host: artifactory2.example.com
```

Example Playbook
----------------

    - hosts: localhost 
      roles:
         - artifactory_deploy 

