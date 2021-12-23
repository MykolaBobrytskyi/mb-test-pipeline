#!/bin/bash
# In case of ClusterIP type usage
set -ex
pod_name=`kubectl get po -n default |grep Running |awk '{ print $1 }' |grep show-secrets-service`
kubectl port-forward $pod_name 5000
