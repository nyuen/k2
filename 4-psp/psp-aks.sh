#!/bin/bash

kubectl create namespace psp-aks
kubectl create serviceaccount --namespace psp-aks nonadmin-user

#list privileges for the clusterrole edit
kubectl describe clusterrole edit
#create a role binding for with the edit role
kubectl create rolebinding \
    --namespace psp-aks \
    psp-aks-editor \
    --clusterrole=edit \
    --serviceaccount=psp-aks:nonadmin-user

#you can now run a command using the service account with kubectl --as=system:serviceaccount:psp-aks:nonadmin-user --namespace psp-aks
kubectl --as=system:serviceaccount:psp-aks:nonadmin-user --namespace psp-aks apply -f nginx-privileged.yaml

#now testing the same image but with unprivileged access, the test will also fail because we do not have route privilege and try to request port 80
kubectl --as=system:serviceaccount:psp-aks:nonadmin-user --namespace psp-aks apply -f nginx-unprivileged.yaml

#deleting the existing pod
kubectl --as=system:serviceaccount:psp-aks:nonadmin-user --namespace psp-aks delete -f nginx-unprivileged.yaml

# testing with a non root user
kubectl --as=system:serviceaccount:psp-aks:nonadmin-user --namespace psp-aks apply -f nginx-unprivileged.yaml

#again the test will fail
kubectl --as=system:serviceaccount:psp-aks:nonadmin-user --namespace psp-aks describe pods nginx-unprivileged
kubectl --as=system:serviceaccount:psp-aks:nonadmin-user --namespace psp-aks logs nginx-unprivileged-nonroot --previous
#deleting the pod before moving to the next step
kubectl --as=system:serviceaccount:psp-aks:nonadmin-user --namespace psp-aks delete -f nginx-unprivileged-nonroot.yaml

#let's install a custom PSP
kubectl apply -f psp-deny-privileged.yaml

#in order to use the PSP we need to create a cluster role 
kubectl apply -f psp-deny-privileged-clusterrole.yaml
#and then a cluster role binding for service account users
kubectl apply -f psp-deny-privileged-clusterrolebinding.yaml

#let's try again the nginx-unprivileged image
kubectl --as=system:serviceaccount:psp-aks:nonadmin-user --namespace psp-aks apply -f nginx-unprivileged.yaml
# the pod should now work
kubectl-nonadminuser get pods

#clean up resources and remove PSP on the cluster
#az aks update  --resource-group myResourceGroup --name myAKSCluster --disable-pod-security-policy
#kubectl delete -f psp-deny-privileged-clusterrolebinding.yaml
#kubectl delete -f psp-deny-privileged-clusterrole.yaml
#kubectl delete -f psp-deny-privileged.yaml
#kubectl delete namespace psp-aks


