#!/bin/bash
kubectl apply -f mariadb-service.yaml
kubectl get pods -o wide -l datastore=mariadb
kubectl get deployments -l datastore=mariadb
kubectl get services -l datastore=mariadb
kubectl describe services -l datastore=mariadb
