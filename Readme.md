# Hugging Face Chat UI Deployment on AKS

This project demonstrates how to deploy the Hugging Face Chat UI on Azure Kubernetes Service (AKS). The Kubernetes cluster is set up using Terraform, and the deployment leverages Helm charts for managing the application components.

## Project Structure

- **/infra**: Contains Terraform configuration files. Running `terraform apply` in this folder will provision a 2-node AKS cluster:
    - **Node 1**: Hosts general workloads, including the Hugging Face Chat UI pods and MongoDB pods.
    - **Node 2**: Dedicated to running the `qwen2.5:0.5b` model, wrapped with Ollama as the model's API interface. It leverages on kubernetes taints and tolerations to ensure only ollama pods are provisioned in that node.

- **/k8s**: Contains three Helm charts for deploying:
    - **Ollama**: Wraps the `qwen2.5:0.5b` model for programmatic interaction.
    - **Hugging Face Chat UI**: The user interface for interacting with the model.
    - **MongoDB**: The database used by the application.

- **docker-compose.yml**: A Docker Compose file in the root directory for local development. It spins up the workload in Docker containers, simulating the Kubernetes setup.

## Features

- Automated AKS cluster provisioning with Terraform.
- Segregated workloads across nodes for optimized performance.
- Helm-based deployment for modular and reusable configurations.
- Local development support using Docker Compose.

## Usage

1. **Provision the AKS Cluster**:
     - Navigate to the `/infra` folder.
     - Run `terraform apply` to create the AKS cluster.

2. **Deploy to AKS**:
     - Navigate to the `/k8s` folder.
     - Use Helm to deploy the components:
         ```bash
         helm install ollama ./ollama
         helm install huggingface-ui ./huggingface-ui
         helm upgrade --install mongodb oci://registry-1.docker.io/bitnamicharts/mongodb --values ./mongodb/mongodb.yaml
         ```

3. **Local Development**:
     - Run `docker-compose up` in the root directory to start the application locally.

4. **Destroy All Resources**:
     - To clean up all resources, follow these steps:
         - Navigate to the `/k8s` folder and uninstall the Helm charts:
             ```bash
             helm uninstall ollama
             helm uninstall huggingface-ui
             helm uninstall mongodb
             ```
         - Navigate to the `/infra` folder and destroy the AKS cluster:
             ```bash
             terraform destroy
             ```

This project provides a scalable and modular solution for deploying Hugging Face Chat UI on AKS with a dedicated model interface.