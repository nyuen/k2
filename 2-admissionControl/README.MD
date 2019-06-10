#Setting up an admission control
This admission control rejects any pod leveraging env variables. the admission control is split in two parts:
* The node.JS code deployed in an Azure functionb
* The admission control as a YAML file

## check your cluster
Run 
```
kubectl api-versions
````

make sure that you have admissionregistration.k8s.io/v1beta1 or similar

## deploy the node.js
we are using Azure function to deploy the index.js. Once deployed, take note of the URL

## update the YAML
input the URL from the Azure Function

## deploy the admission control
```
kubectl apply -f envAdmissionControl.yaml
```
create a namespace called Sample
```
kubectl create namespace sample
kubectl label ns sample admission-webhook-example=enabled
```

## Test
try to deploy a pod with env variables
```
kubectl run nginx-with-env --namespace=sample --image=nginx --env="PASSWORD=fail"
```

check the K8s events to see what happened
```
kubectl get events
```

you should see
```
Warning   FailedCreate  replicaset-controller Error creating: admission webhook "mywebhookurl" denied the request: nginx-with-env is using env vars

```
