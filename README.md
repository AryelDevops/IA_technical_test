#Step by step to complete this test

#Tecnology applyeds:
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


#CREATING INFRASTRUCTURE IN DIGITAL OCEAN WITH TERRAFORM;

- cd k8s_terraform/k8s_do
- docker run -it -v $PWD:/app -w /app --entrypoint "" hashicorp/terraform:light sh //terraform official docker image 
- auth in aws s3 bucket with env Vars
- terraform init
- terraform plan -out plan
- terraform apply plan

#CONFIGURING KUBECONFIG;

- doctl auth init //insert digitalocean token
- doctl kubernetes cluster kubeconfig save hello-world //save cluster kubeconfig locally in ~/.kube/config

#APPLYING MANIFESTS IN THE K8S CLUSTER;

- kubectl apply -f k8s/deployment.yaml

#INSTALLING HELM CHART PROMETHEUS;

- helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
- helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics
- helm repo update
- helm install prometheus prometheus-community/prometheus --values prometheus/prometheus-values.yaml

#INSTALLING HELM CHART GRAFANA;

- helm repo add grafana https://grafana.github.io/helm-charts
- helm repo update
- helm install grafana grafana/grafana --values grafana/grafana-values.yaml

#INTEGRATION BETWEEN GRAFANA AND PROMETHEUS
- Login in grafana
- configuration > datasources > add datasource > prometheus > url=http://prometheus-server > save and test
- import dashboard: + > import > Upload Json file > grafana/dashboard.json
