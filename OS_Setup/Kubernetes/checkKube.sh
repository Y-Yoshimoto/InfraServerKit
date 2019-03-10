#!/bin/sh
kubectl run test-nginx --image=nginx --replicas=2 --port=80
kubectl get pods -o wide
kubectl expose deployment test-nginx --type="NodePort" --port=80
kubectl describe service test-nginx
kubectl get deployment
kubectl get services
kubectl get endpoints


kubectl delete deployment test-nginx
kubectl delete service test-nginx

