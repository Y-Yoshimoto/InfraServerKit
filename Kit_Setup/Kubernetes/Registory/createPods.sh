#!/bin/bash
kubectl apply -f registory-manifest.yaml
kubectl get deployments
kubectl get services
sleep 5
kubectl get pods -o wide -n 
