#Step by step to complete this challenge

Description:
Create the infrastructure to deploy a simple website (helloworld!) with
monitoring.

- Simple website/app using Docker (you can use an existing docker image);
- Use Kubernetes to deploy the applications (you can use a local kubernetes);
- Deploy that website/app and monitoring tools of your choice in kubernetes;
- Present the monitoring/status of the website/app;
- Write documentation clearly and objectively all the steps necessary to run the challenge;

Bonus:
- Provisioning the infrastructure you needed to accomplish this challenge, using your
preferred tool. (terraform, cloud formation or ansible);
- Use Grafana integrated with the monitoring tool of your choice;

#Tecnologys applyeds:
- Linux Ubuntu 20.04 => https://ubuntu.com/download
- Visual Studio Code => https://visualstudio.microsoft.com/pt-br/
- Docker => https://docs.docker.com/engine/install/
- DockerHUb => https://hub.docker.com/
- Git => https://git-scm.com/
- GitHub => https://github.com
- Terraform => https://www.terraform.io/
- Digital Ocean Cloud Provider (for cluster k8s) => https://cloud.digitalocean.com/
- doctl => https://docs.digitalocean.com/reference/doctl/how-to/install/
- Kubernetes => https://kubernetes.io/pt-br/
- kubectl => https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
- Helm => https://helm.sh/
- Prometheus => https://prometheus.io/
- Grafana => https://grafana.com/

#CREATING PROJECT ON GITHUB;

- your repositories > new > Repository name > create repository

#CREATING THE PROJECT FOLDER;
- mkdir IA_technical_test
- git clone https://github.com/AryelDevops/IA_technical_test.git
- cd IA_technical_test
- code .

#CREATING APP AND DOCKERFILE;
- mkdir app && cd app
- touch index.js //app nodejs with route '/hello' return helloworld and '/metrics' return prometheus metrics
- touch Dockerfile 
- docker build -t aryeldevops/hello-world-ia-prom:v1 .
- docker build -t aryeldevops/hello-world-ia-prom:latest .
- docker scan aryeldevops/hello-world-ia-prom:v1
- docker push aryeldevops/hello-world-ia-prom:v1

#CREATING INFRASTRUCTURE IN DIGITAL OCEAN WITH TERRAFORM;

- mkdir -p k8s_terraform/k8s-do && cd k8s_terraform/k8s-do
- touch k8s.tf, main.tf, variables.tf //creation of a K8s cluster with 2 nodes in the digital ocean
- docker run -it -v $PWD:/app -w /app --entrypoint "" hashicorp/terraform:light sh //terraform official docker image 
- auth in aws
    - export AWS_ACCESS_KEY_ID= 
    - export AWS_SECRET_ACCESS_KEY=
- terraform init
- terraform plan -out plan
- terraform apply plan

#CONFIGURING KUBECONFIG;

- doctl auth init //insert digitalocean token
- doctl kubernetes cluster kubeconfig save hello-world //save cluster kubeconfig locally in ~/.kube/config

#APPLYING MANIFESTS IN THE K8S CLUSTER;

- mkdir k8s && cd k8s
- touch deployment.yaml //app deploy on node on k8s
- kubectl apply -f deployment.yaml

#INSTALLING HELM CHART PROMETHEUS;

- mkdir prometheus && cd prometheus
- touch prometheus-values.yaml //config personality
- helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
- helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics
- helm repo update
- helm install prometheus prometheus-community/prometheus --values prometheus-values.yaml

#INSTALLING HELM CHART GRAFANA;

- mkdir grafana && cd grafana
- touch grafana-values.yaml //config personality
- touch dashboard.json //grafana dashboard for app 
- helm repo add grafana https://grafana.github.io/helm-charts
- helm repo update
- helm install grafana grafana/grafana --values grafana-values.yaml

#INTEGRATION BETWEEN GRAFANA AND PROMETHEUS
- Login in grafana
- configuration > datasources > add datasource > prometheus > url=http://prometheus-server > save and test
- import dashboard: + > import > Upload Json file > grafana/dashboard.json

#PIPELINE CI/CD FOR DEPLOY APP IN K8S USING GITHUB ACTIONS;
- mkdir -p .github/workflows && cd .github/workflows
- touch main.yaml
- Create secrets in github
    - repository > settings > secrets > new repository secrets
        - K8S_CONFIG: kubeconfig cluster created 
        - DOCKER_USERNAME: dockerhub username
        - DOCKER_PASSWD: dockerhub password
#ALL THE IMAGES IN images_results
