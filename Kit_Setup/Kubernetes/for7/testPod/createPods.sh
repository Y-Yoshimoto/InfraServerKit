#!/bin/bash
kubectl apply -f test-nginx-manifest.yaml
kubectl get namespace test-nginx
kubectl get deployments -n test-nginx
kubectl get services -n test-nginx
kubectl describe services test-nginx-service -n test-nginx
sleep 5
kubectl get pods -o wide -n test-nginx
