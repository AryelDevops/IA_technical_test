# Description

Create the infrastructure to deploy a simple website (helloworld!) with
monitoring.

[documentation] (<https://github.com/AryelDevops/IA_technical_test/blob/main/doc.md>)

## How to use

### Requirements

* [Docker] `https://docs.docker.com/engine/install/`
* [Doctl] `https://docs.digitalocean.com/reference/doctl/how-to/install/`
* [Git] `https://git-scm.com/`
* [Kubectl] `https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/`
* [Helm] `https://helm.sh/`
* [Terraform] `https://www.terraform.io/`

### Cloning the project

```sh
git clone https://github.com/AryelDevops/IA_technical_test.git
$ cd IA_technical_test
$ code . (or other ide of your preference)
```

## Creating infrastructure with terraform in digital ocean

```sh
$ cd k8s_terraform/k8s-do
$ docker run -it -v $PWD:/app -w /app --entrypoint "" hashicorp/terraform:light sh //terraform official docker image 
$ export AWS_ACCESS_KEY_ID=(your_id)
$ export AWS_SECRET_ACCESS_KEY=(your_secret)
$ terraform init
$ terraform plan -out plan
terraform apply plan
```

### Configuring kubeconfig of cluster created before in your ~/.kube using doctl

```sh
 doctl auth init 
 doctl kubernetes cluster kubeconfig save hello-world 
```

### Installing prometheus helm chart

```sh
cd prometheus
$ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
$ helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics
$ helm repo update
$ helm install prometheus prometheus-community/prometheus --values prometheus-values.yaml
```

### Installing grafana helm chart

```sh
cd grafana
$ helm repo add grafana https://grafana.github.io/helm-charts
$ helm repo update
$ helm install grafana grafana/grafana --values grafana-values.yaml
```

### Integration between grafana and prometheus

1. Login in grafana
2. configuration > datasources > add datasource > prometheus > url=http://prometheus-server > save and test
3. import dashboard: + > import > Upload Json file > grafana/dashboard.json

### Pipeline with github actions for deploy app in k8s

1. Create secrets in github (repository > settings > secrets > new repository secrets)
2. K8S_CONFIG: kubeconfig cluster created
3. DOCKER_USERNAME: (your_dockerhub_username)
4. DOCKER_PASSWD: (your_dockerhub_password)
