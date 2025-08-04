#!/bin/sh
kubectl get nodes
kubectl get pods -o wide
kubectl get deployments -n sample-app
kubectl get services -n sample-app
kubectl get pods -n sample-app
kubectl describe pods -n sample-app


# ログ
# kubectl get pods -n sample-app -l app=sample-app
# kubectl logs -f -n sample-app -l app=sample-app --all-containers=true