#!/bin/bash

az extension add --name aks-preview
az feature register -n WindowsPreview --namespace Microsoft.ContainerService
az feature register -n AKSLockingDownEgressPreview --namespace Microsoft.ContainerService
az feature register -n MultiAgentpoolPreview --namespace Microsoft.ContainerService
az feature register -n APIServerSecurityPreview --namespace Microsoft.ContainerService
az feature register -n VMSSPreview --namespace Microsoft.ContainerService
az feature register --name AKSAuditLog --namespace Microsoft.ContainerService
az feature register --name PodSecurityPolicyPreview --namespace Microsoft.ContainerService
az feature register --namespace "Microsoft.ContainerService" --name "AKSAzureStandardLoadBalancer"
az provider register -n Microsoft.ContainerService

