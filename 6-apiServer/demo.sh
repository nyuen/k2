#!/bin/bash

#restrict the IP range allowed for the API server
az aks update \
    --resource-group specialK-RG \
    --name specialk \
    --api-server-authorized-ip-ranges 167.220.197.62/32,40.115.15.190/32,13.80.176.149/32

#to allow all ip
az aks update \
    --resource-group myResourceGroup \
    --name myAKSCluster \
    --api-server-authorized-ip-ranges ""

