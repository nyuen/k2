#create a demo nginx back end + a service

kubectl run backend --image=nginx --labels app=webapp,role=backend --namespace development --expose --port 80 --generator=run-pod/v1

# create a new pod and connect using an interactive command
kubectl run --rm -it --image=alpine network-policy --namespace development --generator=run-pod/v1
#on the shell execute the following command : wget -qO- http://backend

# create a newtwork policy to deny access to the nginx backend
kubectl apply -f backend-policy.yaml

#validate that the network policy has been deployed
kubectl get netpol --namespace=development

#test the network policy again, the request to the backend should be denied
kubectl run --rm -it --image=alpine network-policy --namespace development --generator=run-pod/v1
#execute the following command in the interactive shell wget -qO- --timeout=2 http://backend

#apply the policy allowing access to backend from pods labeled as frontend
kubectl apply -f backend-policy-allow.yaml

# retry accessing to the backend
kubectl run --rm -it frontend --image=alpine --labels app=webapp,role=frontend --namespace development --generator=run-pod/v1
#execute a get on the backend: wget -qO- http://backend

#test a pod without matching label
kubectl run --rm -it --image=alpine network-policy --namespace development --generator=run-pod/v1
#execute again the command:  wget -qO- --timeout=2 http://backend

#allow traffic from a defined namespace
kubectl create namespace production
kubectl label namespace/production purpose=production

#create a pod within the new namespace and test the access to the backend in development
kubectl run --rm -it frontend --image=alpine --labels app=webapp,role=frontend --namespace production --generator=run-pod/v1
#execute the wget command : wget -qO- http://backend.development
#the command works because the label matches the network policy

#update the namespace policy to restrict access to the development namespace only, productions won't be able to acces the backend even with the right labels
kubectl apply -f backend-policy.yaml

#run the pod in production again
kubectl run --rm -it frontend --image=alpine --labels app=webapp,role=frontend --namespace production --generator=run-pod/v1

#notice that the pod can't access the backend: wget -qO- --timeout=2 http://backend.development

#clean up resources
#kubectl delete namespace production
#kubectl delete namespace development


