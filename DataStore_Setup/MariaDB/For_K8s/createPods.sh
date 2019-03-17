#!/bin/bash
kubectl apply -f mariadb-service.yaml
kubectl get pods -o wide --namespace=default
kubectl get deployments --namespace=default
kubectl get services --namespace=default
kubectl describe services --namespace=default
