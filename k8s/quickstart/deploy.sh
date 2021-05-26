#/bin/bash

kubectl apply -f spire-namespace.yaml

# PersistentVolume for spire-server
kubectl apply -f kubeadmin.yaml

kubectl apply \
    -f server-account.yaml \
    -f spire-bundle-configmap.yaml \
    -f server-cluster-role.yaml

kubectl apply \
    -f server-configmap.yaml \
    -f server-statefulset.yaml \
    -f server-service.yaml

kubectl apply \
    -f agent-account.yaml \
    -f agent-cluster-role.yaml

kubectl apply \
    -f agent-configmap.yaml \
    -f agent-daemonset.yaml
