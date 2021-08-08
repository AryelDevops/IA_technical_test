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
- doctl
- Kubernetes
- kubectl
- Helm
- Prometheus
- Grafana

# Step by step from code to deploy with monitoring
1. Create a public repository in GitHub;
2. Clone public repository in local machine;
3. Create a simple app in node;
4. Create Dockerfile(clean) for app;
    - Image base clean
    - Copy and paste app for image 
    - Workdir /app
    - Expose port 9091 for external access
    - docker build -t repo-name/image-name:tag
    - docker scan repo-name/image-name:tag
    - docker login
    - docker push repo-name/image-name:tag 
5. Create a k8s cluster in digital ocean using terraform
    - terraform init
    - terraform plan -out plan
    - terraform apply plan
6. Get kubeconfig of digital ocean cluster
    - doctl auth init 
    - doctl kubernetes cluster kubeconfig save hello-world
7. Create a k8s deployment/service for deploy app in a k8s cluster
    - deployment.yaml and service.yaml
    - kubectl apply -f deployment.yaml 
