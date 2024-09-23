# Artifactory Deployment with mTLS Enforcement using Ansible and Kubernetes
## Introduction
This repository contains Ansible playbooks and roles for deploying multiple JFrog Artifactory OSS instances on a Kubernetes cluster with mutual TLS (mTLS) enforcement using the Nginx Ingress Controller. The setup leverages Helm charts to deploy Artifactory and configures mTLS at the ingress level to ensure secure communication between clients and the Artifactory services.

## Architecture Overview
The deployment consists of:
 - Terraform module and configuration for Azure Kubernetes Service on which the Artifactory OSS is deployed.
 - Artifactory Instances: Multiple instances of JFrog Artifactory OSS deployed using the official Helm chart.
 - Nginx Sidecar Containers: Each Artifactory Pod includes an Nginx sidecar container that handles mTLS on port 8443 and proxies traffic to the Artifactory application on port 8081.
 - Custom Kubernetes Services: Separate Kubernetes Services are created for the Nginx sidecars.
 - Ingress Resources: Ingress resources are configured to route traffic to the Nginx sidecars and enforce mTLS using the Nginx Ingress Controller.

 Our solution involves deploying multiple Artifactory instances in a Kubernetes cluster, each with its own Nginx sidecar container to handle mTLS. We automate the deployment and configuration using Ansible playbooks and roles.

 ### Key Components:
 - Artifactory Instances: Deployed using the JFrog Artifactory Helm chart.
 - Nginx Sidecar Containers: Added to each Artifactory Pod to handle mTLS on port 8443 and proxy requests to Artifactory on `localhost` 
 - Custom Kubernetes Services: Exposing the Nginx sidecars.
 - Ingress Resources: Configured to route traffic to the Nginx sidecars and enforce mTLS using the Nginx Ingress Controller.
 - Ansible Automation: Automating the entire deployment and configuration process.

## Repository Structure
 - `terraform`: Contains terraform module and configuration for deploying Azure Kubernetes Service cluster
 - `roles`: Contains Ansible roles for deploying Artifactory, NGNIX Ingress controllers and creation of mTLS certificates
 - `playbook.yml`: Main Ansible playbook which includes all roles.
 - `playbook-storage.yml`: A helper Ansible playbook that setups the state storage for Terraform on Azure

 ## Prerequisites 
 - Azure subscription
 - An Azure service principal with federated credentials for GitHub OpenID Connect
 - GitHub Actions secrets and variables configured in repo

 ### Repository secrets
 - `AZ_CLIENT_ID`: Client ID of the Azure service principal.
 - `AZ_SUBSCRIPTION_ID`: Subscription ID for the Azure account.
 - `AZ_TENANT_ID`: Tenant ID of the Azure service principal. 
 - `AZ_STORAGE_ACCOUNT_NAME`: Storage account name which will be created for state file.
 - `AZ_RESOURCE_GROUP`: New resource group will be created for Terraform state file. 
 - `AZ_CONTAINER_NAME`: Name of container which will be created and holds state file. 

 ## Playform deployment
 The deployment of Azure Kubernetes Cluster is managed trough `.github/workflows/terraform.yml` GitHub workflow which setups all the required software (such as Ansible) and executes Ansible and Terraform to provision the cluster. Provisioning can be also previewed by creating a pull request, which is handled with `.github/workflows/terraform-pull-request.yml`. Mentioned workflow will output a Terraform plan in the pull requests comment section.

 Detailed information about the Terraform configuration and scripts can be found in the `terraform` folder. 

 ## Platform configuration
 The solution is implemented with Ansible and the main playbook which utilises all roles is called in `.github/workflows/configure-cluster` workflow. 

The following roles are used: 
- `nginx_ingress`: Deploys NGINX Ingress controllers on cluster. Two controllers are deployed with seperate namespace and class name. 
- `ca_certificate`: Creates private root Certificate Authority certificate and key. On cluster they are stored in specified namespace as a secret.
- `tls_certificate`: Generates and stores server certificate for Artifactory instances.
- `artifactory_deploy`: Deploys multiple Artifactory OSS instances using Helm chart with NGINX side-car.
- `nginx_ingress_mtls`: Configures NGINX Ingress Controller routing to side-car instances using mTLS.

Role `azure_storage` is a helper role used to configure Terraform state storage on Azure. It is only used by Terraform workflow.

### Verification
In order to verify the setup one should use Azure CLI to obtain Kubernetes credentials and instance certificates with `kubectl`.
As DNS wasn't utilized one has to also override host files with matching IP address to NGINX Ingress Controller external load balancer IP. 

mTLS can be verified using `curl` and passing the matching certificates (client certificate and key) with CA certificate.

