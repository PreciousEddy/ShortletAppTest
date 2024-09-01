# Flask API with Kubernetes and Google Cloud

## Project Overview

This project sets up a Flask API application using Docker and deploys it on Kubernetes. It includes integration with Google Cloud Platform (GCP) for container registry and deployment.

## Prerequisites

- **Docker**: To build and manage container images.
- **Kubernetes**: For container orchestration.
- **Google Cloud SDK**: For interacting with GCP services.
- **kubectl**: Command-line tool for Kubernetes.
- **Terraform**: For Infrastructure as Code (IaC) if using for Kubernetes deployment.
- **VS Code**: (Optional) for development and configuration.

## Project Structure

- `Flask-Api/`
  - `api/` - Contains the Flask application code and Dockerfile.
  - `kubernetes/` - Contains Kubernetes manifests and configurations.
  - `terraform/` - Contains Terraform configurations for infrastructure setup (optional).

## Setup Instructions

### 1. Configure Google Cloud

1. **Set up a Google Cloud project** and enable the required APIs (e.g., Kubernetes Engine API, Artifact Registry API).
2. **Create a service account** with roles: `Kubernetes Engine Developer`, `Artifact Registry Admin`, and `Viewer`.

   ```bash
   gcloud iam service-accounts create <SA_NAME> --display-name "Service Account"
   gcloud projects add-iam-policy-binding <PROJECT_ID> \
       --member "serviceAccount:<SA_NAME>@<PROJECT_ID>.iam.gserviceaccount.com" \
       --role "roles/artifactregistry.admin"
   gcloud projects add-iam-policy-binding <PROJECT_ID> \
       --member "serviceAccount:<SA_NAME>@<PROJECT_ID>.iam.gserviceaccount.com" \
       --role "roles/container.developer"
   gcloud projects add-iam-policy-binding <PROJECT_ID> \
       --member "serviceAccount:<SA_NAME>@<PROJECT_ID>.iam.gserviceaccount.com" \
       --role "roles/viewer"
   ```

3. **Generate a JSON key file** for the service account:

   ```bash
   gcloud iam service-accounts keys create ~/key.json \
       --iam-account <SA_NAME>@<PROJECT_ID>.iam.gserviceaccount.com
   ```

4. **Authenticate Docker to Google Container Registry (GCR)**:

   ```bash
   gcloud auth configure-docker
   ```

### 2. Build and Push Docker Image

1. Navigate to the directory containing your Dockerfile:

   ```bash
   cd Flask-Api/api
   ```

2. Build the Docker image:

   ```bash
   docker build -t flask-api .
   ```

3. Push the Docker image to Google Container Registry:

   ```bash
   docker tag flask-api gcr.io/<PROJECT_ID>/flask-api:latest
   docker push gcr.io/<PROJECT_ID>/flask-api:latest
   ```

### 3. Deploy to Kubernetes

1. **Create a Kubernetes cluster** in Google Cloud:

   ```bash
   gcloud container clusters create <CLUSTER_NAME> \
       --zone <ZONE> --num-nodes 3
   ```

2. **Configure kubectl to use your new cluster**:

   ```bash
   gcloud container clusters get-credentials <CLUSTER_NAME> --zone <ZONE>
   ```

3. **Apply Kubernetes manifests**:

   ```bash
   kubectl apply -f kubernetes/
   ```

   Make sure your `kubernetes` directory contains the necessary YAML files for deployment, service, and ingress.

### 4. Test the Deployment

1. Get the Ingress address:

   ```bash
   kubectl get ingress -n <namespace>
   ```

2. Use `curl` to test the endpoint:

   ```bash
   curl -f http://<YOUR-INGRESS-ADDRESS>/time
   ```

## Configuration

### GitHub Actions

- Add your `GCP_SA_KEY` as a GitHub secret named `GCP_SA_KEY` in your repository settings.

### Terraform (Optional)

- Configure your Terraform files for the required GCP and Kubernetes resources if used.

## Troubleshooting

- Ensure Docker and kubectl are correctly configured.
- Verify GCP IAM roles and permissions.
- Check Kubernetes logs for deployment issues:

  ```bash
  kubectl logs -f <pod-name> -n <namespace>
  ```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Google Cloud Platform
- Kubernetes
- Docker

```

Feel free to customize this README to better suit your specific project setup and requirements!