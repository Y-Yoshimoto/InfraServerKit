#!/bin/bash
kubectl apply -f redis-service.yaml
kubectl get pods -o wide -l datastore=redis
kubectl get deployments -l datastore=redis
kubectl get services -l datastore=redis
kubectl describe services -l datastore=redis
