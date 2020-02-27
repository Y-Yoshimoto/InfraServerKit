#!/bin/sh
kubectl get nodes
kubectl get pods -o wide
# kubectl describe deployments test-nginx
# kubectl describe services test-nginx
kubectl get deployments test-nginx
kubectl get services test-nginx
