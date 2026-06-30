#!/bin/bash

echo "===================================="
echo "Deploying Development Environment..."
echo "===================================="

kubectl apply -f namespaces/dev.yaml
kubectl apply -f configmaps/dev-config.yaml
kubectl apply -f secrets/dev-secret.yaml
kubectl apply -f resourcequotas/dev-quota.yaml
kubectl apply -f deployments/dev-deployment.yaml

echo ""
echo "Resources in dev namespace:"
kubectl get all -n dev

echo ""
echo "Deployment completed successfully!"
