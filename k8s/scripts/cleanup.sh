#!/bin/bash

echo "===================================="
echo "Cleaning up Kubernetes Resources..."
echo "===================================="

kubectl delete namespace dev --ignore-not-found
kubectl delete namespace staging --ignore-not-found
kubectl delete namespace prod --ignore-not-found

echo ""
echo "Cleanup completed."
