#!/bin/bash

echo "===================================="
echo "Deploying Production Environment..."
echo "===================================="

kubectl apply -f namespaces/prod.yaml
kubectl apply -f configmaps/prod-config.yaml
kubectl apply -f secrets/prod-secret.yaml
kubectl apply -f resourcequotas/prod-quota.yaml
kubectl apply -f deployments/prod-deployment.yaml

echo ""
echo "Resources in prod namespace:"
kubectl get all -n prod

echo ""
echo "Deployment completed successfully!"
