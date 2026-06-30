#!/bin/bash

echo "===================================="
echo "Deploying Staging Environment..."
echo "===================================="

kubectl apply -f namespaces/staging.yaml
kubectl apply -f configmaps/staging-config.yaml
kubectl apply -f secrets/staging-secret.yaml
kubectl apply -f resourcequotas/staging-quota.yaml
kubectl apply -f deployments/staging-deployment.yaml

echo ""
echo "Resources in staging namespace:"
kubectl get all -n staging

echo ""
echo "Deployment completed successfully!"
