# Dapr Back-End Web Api

## Build and Push Docker Images
```shell-session
$ docker build -t thara0402/dapr-backend:0.1.0 ./
$ docker run --rm -it -p 8000:80 --name backend thara0402/dapr-backend:0.1.0
$ docker push thara0402/dapr-backend:0.1.0
```

## Create Azure Container Apps environment
```shell-session
$ az group create -n <ResourceGroup Name> -l canadacentral
$ az deployment group create -f ./deploy/main.bicep -g <ResourceGroup Name>
```

## Create Azure Container Apps
```shell-session
$ az containerapp create -n dapr-backend -g <ResourceGroup Name> \
     -e <Environment Name> -i thara0402/dapr-backend:0.1.0 \
     --ingress external --target-port 80 \
     --revisions-mode single --scale-rules ./deploy/httpscaler.json \
     --max-replicas 10 --min-replicas 1
```
## Dapr - Service to Service calls

### Create Azure Container Apps for backend
```shell-session
$ az containerapp create -n dapr-backend -g <ResourceGroup Name> \
     -e <Environment Name> -i thara0402/dapr-backend:0.1.0 \
     --ingress internal --target-port 80 \
     --revisions-mode single --scale-rules ./deploy/httpscaler.json \
     --max-replicas 10 --min-replicas 1 \
     --enable-dapr --dapr-app-id dapr-backend --dapr-app-port 80
```

### Create Azure Container Apps for frontend
[Dapr Front-End Web Application](https://github.com/thara0402/dapr-frontend)