# IA_technical_test
Create the infrastructure to deploy a simple website (helloworld!) with monitoring.
# Tecnologys applyed
- GitHub
- Git
- Vscode
- Docker
- DockerHub
- Terraform
- Digital Ocean Cloud Provider (for cluster k8s)
- Kubernetes
- Helm
- Prometheus
- Grafana

# Step by step from code to deploy with monitoring

1. Create a public repository in GitHub;
2. Clone public repository in local machine;
3. Create a simple app in html;
4. Create Dockerfile for app (clean and with security practices);
- Image base clean
- User and group without root privileged
- Copy and paste app for image 
- Workdir
- Expose port 80 for external access
