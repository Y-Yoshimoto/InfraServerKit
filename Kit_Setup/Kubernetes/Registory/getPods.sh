#!/bin/sh
kubectl get nodes
kubectl get pods -o wide
# kubectl describe deployments local-registory
# kubectl describe services local-registory
kubectl get deployments local-registory
kubectl get services local-registory