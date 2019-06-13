az aks enable-addons \
    --resource-group K2Demo-RG \
    --name AKSK2 \
    --addons virtual-node \
    --subnet-name aks_subnet
