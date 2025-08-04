#!/bin/bash
kubectl apply -f sample-manifest.yaml
kubectl get namespace sample-app
kubectl get deployments -n sample-app
kubectl get services -n sample-app
kubectl describe services sample-app-service -n sample-app
sleep 5
kubectl get pods -o wide -n sample-app
