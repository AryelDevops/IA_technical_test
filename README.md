# Overview

Create the infrastructure to deploy a simple website (helloworld!) with
monitoring using kubernetes + prometheus + grafana

[documentation](doc.md)

## Table of contents

* [How to use](#How-to-use)
* [Requirements for run this project](#Requirements-for-run-this-project)
* [Cloning the project](#Cloning-the-project)
* [Creating infrastructure with terraform](#Creating-infrastructure-with-terraform)
* [Configuring kubeconfig](#Configuring-kubeconfig)
* [Installing prometheus helm chart](#Installing-prometheus-helm-chart)
* [Installing grafana helm chart](#Installing-grafana-helm-chart)
* [Integration between grafana and prometheus](#Integration-between-grafana-and-prometheus)
* [Pipeline with github actions](Pipeline-with-github-actions)
* [Contributing](#Contributing)

## How to use

### Requirements for run this project

* [Docker](https://docs.docker.com/engine/install/)
* [Doctl](https://docs.digitalocean.com/reference/doctl/how-to/install/)
* [Git](https://git-scm.com/)
* [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
* [Helm](https://helm.sh/)

### Cloning the project

```sh
$ git clone https://github.com/AryelDevops/IA_technical_test.git
$ cd IA_technical_test
$ code . (or other ide of your preference)
```

### Creating infrastructure with terraform

```sh
$ cd k8s_terraform/k8s-do
$ docker run -it -v $PWD:/app -w /app --entrypoint "" hashicorp/terraform:light sh
$ export AWS_ACCESS_KEY_ID=(your_id)
$ export AWS_SECRET_ACCESS_KEY=(your_secret)
$ export DO_TOKEN=(your_digitalocean_token)
$ terraform init
$ terraform plan -var=${DO_TOKEN} -out plan
$ terraform apply -var=${DO_TOKEN} plan
```

### Configuring kubeconfig

```sh
$ doctl auth init 
$ doctl kubernetes cluster kubeconfig save hello-world 
```

### Installing prometheus helm chart

```sh
$ cd prometheus
$ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
$ helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics
$ helm repo update
$ helm install prometheus prometheus-community/prometheus --values prometheus-values.yaml
```

### Installing grafana helm chart

```sh
$ cd grafana
$ helm repo add grafana https://grafana.github.io/helm-charts
$ helm repo update
$ helm install grafana grafana/grafana --values grafana-values.yaml
```

### Integration between grafana and prometheus

1. Login in grafana
2. configuration > datasources > add datasource > prometheus > url=<http://prometheus-server> > save and test
3. import dashboard: + > import > Upload Json file > grafana/dashboard.json

### Pipeline with github actions for deploy app in k8s

* Create secrets in github (repository > settings > secrets > new repository secrets)
* K8S_CONFIG: kubeconfig cluster created
* DOCKER_USERNAME: (your_dockerhub_username)
* DOCKER_PASSWD: (your_dockerhub_password)

### Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push -u origin my-new-feature`
5. Submit a pull request - cheers!
