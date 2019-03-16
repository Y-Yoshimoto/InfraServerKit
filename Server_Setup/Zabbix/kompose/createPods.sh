#!/bin/bash
kubectl apply -f zabbix-kube.yaml
kubectl get pods -o wide --namespace=zabbix-k8s
kubectl get deployments --namespace=zabbix-k8s
kubectl get services --namespace=zabbix-k8s
