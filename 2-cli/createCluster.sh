#!/bin/bash

az group create -n Demo-RGAKS-RG --location eastus2

az aks create \
    --resource-group Demo-RGAKS-RG \
    --name AKS-fulloption \
    --node-count 2 \
    --kubernetes-version 1.14.0 \
    --generate-ssh-keys \
    --enable-vmss \
    --network-plugin azure \
    --load-balancer-sku standard \
    --enable-pod-security-policy \
    --location eastus2