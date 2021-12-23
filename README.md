# mb-test-pipeline

Repo contains several parts of Python application pipeline.

### 1. Terraform
Terraform folder contains modules and env-related files.
Modules folder contains files to deploy
  - DO k8s cluster
  - DO Docker registry
To successfully deploy the infrastructure you need to generate an API token within the DO account to create and manage resources.
Simply add a ```.tfvars``` file to the corresponding env folder containing the ```do_token``` variable.
This will allow to deploy infrastructure.
```
terraform init
terraform plan
terraform apply
```

Once the cluster will be deployed you need to download the kubeconfig file from the DO account.
It is required to connect to your created cluster.

### 2. Docker
This is the part where the application image is built.
It is a simple Python app that queries the k8s cluster and provides list of secrets and their type.
The app is served via /show-secrets URI on the port 5000.

To login to the Docker registry for image pushing you need to copy its address from the DO account and use the DO token for user and password.

### 3. Helm
This folder contains a chart for the show-secrets-service and templates to deploy it.
Values file contains env var required for proper app functioning.
```
helm install show-secrets-service ./show-secrets-service
```

### 4. Jenkins
This part contains Jenkinsfile for application update within the deployed cluster.
It builds an image and pushes it to the DO docker registry created previously.
The job is triggered via pollSCM strategy.

### 5. Other
- I've used a locally installed Jenkins and configured kubectl and docker additionally to connect to the DO resources properly.
- The app is started within the cluster with ClusterIP service, you should use a ```start_app.sh``` script for port forwarding.
