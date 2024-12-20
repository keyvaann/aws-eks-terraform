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
    - Automatically generate an Age key for encrypting the application's secrets. The Age private key is created on the root directory of the repository and it is ignored by Git. Ideally this file should be stored securely in user's computer or the CD server.
    - Prompt you to enter values for the application's secrets, which can be modified later.
    - Initialize the Terraform module.
3. **Customize Variables (Optional)**: Review the `terraform/variables.tf` file. Provide any custom values in the `terraform.tfvars` file to override the defaults. You can run `sops flask_app_secrets.enc.json` to edit the secrets.
4. **Run `devbox install`** to deploy the Terraform code to your AWS environment. Since building the Docker image might require root access, the script first executes a simple command with sudo. This avoids the need to enter the sudo password during the actual deployment, ensuring a seamless Terraform execution.
5. **Check results**: If everything is installed succesfully, you should be to see output of the `/config` route in your terminal. You can also run `devbox output` to get the URL that you can access the app on your browser.

## Next steps
- Create an AWS profile for the role that is crated. You can find the role by running `devbox role`,
- Commit `.sops.yaml` and `flask_app_secrets.enc.json` files to git.

## To do
- General polish and testing of the process and documentation
- Enhance the security of the EKS cluster and Helm chart.
  - Either cert-manager or AWS ACM should be used to provide TLS certificates.
- Improve documentation for the Terraform module and Helm chart.
- Integrate kube-prometheus-stack into the EKS cluster.
  - Add metrics to the Python application.
- Add health checks to the Helm chart.
- Add a sample IAM policy that allows all of the components in this repository to be installed.

## Known issues
- **Docker Image Building with Terraform**: Building and pushing Docker images via Terraform is not ideal. This process should be handled by a CI pipeline on push, as Terraform is not suited for this task.
- **Insecure state files**: The secrets are stored in the state file as plaintext.

## Design
The Terraform script is in charge of creating the EKS cluster, ECR repository, VPC and IAM polcities on AWS and containising the Python application and installing it to the Kubernetes cluster via the Helm chart. Both the Terraform code and the Helm chart have a respective README.md file that documents the configuration that can changed.

There has been an effort to minimize hardcoding the configuration as much as possible and you can install this code on a different environment with just changing the `.tfvars` and the secrets. In a more proper set up, the state is stored on a backend and the configuration is stored seperately. This way there is no need to fork the repository to for each environment.

For a production ready deployment, AWS WAF and Network Firwall can be used to protect against the attacks to web applications. The EKS endpoint should be limited to a whitelist of IP addresses instead of being publicly accessible.

### Challenges and trade offs
- Ideally the Python application, the Helm chart and the Terraform code are in their own repositories and have their own CI/CD pipelines.
  - Only the Helm chart for the Ingress controller would be installed via Terraform, this is to let the Terraform track all of the resources created on AWS and cleanly destroy everything when needed.
  - Rest of the Helm charts will be managed via ArgoCD or another pipeline.
- Secrets are managed locally via `sops` and `age`. Instead of using AWS KMS, local options have been perferred to keep all of the deployment data in one place and ease the installation.