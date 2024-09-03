# GCP Infrastructure Setup and API Deployment

This project demonstrates how to develop a simple API, containerize it using Docker, and deploy it to a Google Kubernetes Engine (GKE) cluster using Terraform. The setup includes network security configurations and a CI/CD pipeline using GitHub Actions.

## Prerequisites

- Google Cloud Platform (GCP) account
- Terraform installed
- Docker installed
- GitHub account
- gcloud CLI installed and authenticated
- Service Account key file for GCP

## Setup Instructions

### 1. Clone the Repository

Clone the repository to your local machine:

```sh
git clone https://github.com/PreciousEddy/ShortletAppTest.git
cd ShortletAppTest
```

### 2. Set Environment Variables

Set the necessary environment variables:

```sh
export GCP_SA_KEY_PATH="/path/to/your/service-account-key.json"
export GCP_PROJECT_ID="your-gcp-project-id"
```

### 3. Initialize and Apply Terraform

Initialize Terraform and apply the configuration:

```sh
terraform init
terraform plan -var="GCP_SA_KEY_PATH=$GCP_SA_KEY_PATH" -out=tfplan
terraform apply tfplan
```

### 4. Verify the API

Retrieve the external IP of the deployed service and verify the API:

```sh
external_ip=$(kubectl get svc flask-api -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
curl http://$external_ip/time
```

## CI/CD Pipeline

The project includes a GitHub Actions workflow that automates the deployment process. The workflow:

- Builds and pushes the Docker image to Google Container Registry (GCR).
- Provisions the infrastructure using Terraform.
- Deploys the API to the GKE cluster.
- Verifies the API endpoint.

## Network Security

The setup includes a NAT gateway and firewall rules to manage and secure outbound traffic from the GKE cluster.

---

## How to get the Service Account Key

Generate the Service Account Key:

1. Go to the Google Cloud Console.
2. Navigate to **IAM & Admin > Service Accounts**.
3. Select your project.
4. Click on the **Create Service Account** button.
5. Fill in the service account details and click **Create**.
6. Assign the necessary roles to the service account (e.g., Editor, Viewer, or specific roles like Kubernetes Engine Admin).
7. Click **Continue** and then **Done**.
8. Find the newly created service account in the list, click on the three dots on the right, and select **Manage keys**.
9. Click on **Add Key > Create New Key**.
10. Choose **JSON** and click **Create**. This will download the key file to your computer.

---

This README provides a concise guide to setting up and deploying your API on GCP using Terraform, along with a CI/CD pipeline using GitHub Actions.

