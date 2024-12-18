# Terraform AWS EKS Infrastructure Setup
This repository contains the infrastructure code to containerize a Python application, create an AWS EKS cluster, and deploy the application to the cluster using a Helm chart. The goal is to enable the setup with minimal input and intervention from the user.

## Prerequisite 
Before running the Terraform scripts, ensure you have the following:
- **AWS Credentials**: A valid AWS access key and secret key. These can be provided via environment variables, .tfvars files, or an AWS CLI profile. The AWS account must have sufficient permissions to create all required resources.
- **Docker**: Docker must be installed on your system. Terraform will handle building and pushing the Docker image for simplicity.
- **Operating System**: This script has been tested on Linux and should work with minimal adjustments on macOS. Windows is not supported.

## Deployment steps
1. **Install Devbox**: Ensure that [Devbox](https://jetify-com.vercel.app/docs/devbox/installing_devbox/#install-devbox) is installed. Devbox provides reproducible and isolated development environments, eliminating the need to install dependencies as system packages (except Docker).
2. **Run `devbox shell`** command from the root directory of the repository. This will:
    - Install required CLI dependencies locally, such as Terraform and Helm.
    - Automatically generate an Age key for encrypting the application's secrets.
    - Prompt you to enter values for the application's secrets, which can be modified later.
    - Initialize the Terraform module.
3. **Customize Variables (Optional)**: Review the `terraform/variables.tf` file. Provide any custom values in the `terraform.tfvars` file to override the defaults.
4. **Run `devbox install`** to deploy the Terraform code to your AWS environment. Since building the Docker image might require root access, the script first executes a simple command with sudo. This avoids the need to enter the sudo password during the actual deployment, ensuring a seamless Terraform execution.

## To do
- Enhance the security of the EKS cluster and Helm chart.
- Improve documentation for the Terraform module and Helm chart.
- Integrate a monitoring system into the EKS cluster.
- Add health checks to the Helm chart.

## Known issues
- **Docker Image Building with Terraform**: Building and pushing Docker images via Terraform is not ideal. This process should be handled by a CI pipeline on push, as Terraform is not suited for this task.