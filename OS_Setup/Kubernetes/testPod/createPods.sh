#!/bin/bash
kubectl create -f test-nginx-deployment.yaml
kubectl create -f test-nginx-service.yaml
kubectl get deployments
kubectl get services
kubectl get pods -o wide
