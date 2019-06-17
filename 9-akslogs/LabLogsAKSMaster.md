# Hands-on Objectif K2 - Activer la preview des Logs du control plane d'AKS

## activer la nouvelle fonctionnalité 
```
az feature register --name AKSAuditLog --namespace Microsoft.ContainerService
```

## Attendre que le status de l'enregistrement de la feature soit à Registered (peut prendre une grosse dizaine de minutes)
```
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/AKSAuditLog')].{Name:name,State:properties.state}"
```

## Réenregistrer le provider AKS pour prendre en compte de la nouvelle fonctionnalité
```
az provider register --namespace Microsoft.ContainerService
```
