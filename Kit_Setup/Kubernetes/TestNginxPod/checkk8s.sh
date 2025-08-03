#!/bin/bash
# kubectlのバージョンを確認
kubectl version
## Nodeの情報を取得
kubectl get nodes
## Podの情報を取得
kubectl get pods -o wide