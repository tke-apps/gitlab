#! /bin/bash

set -ex

replicas=${1:-"0"}

export NAMESPACE="gitlab"

kubectl get deployments.v1.apps | grep -v NAME | awk '{print $1}' | xargs -I {} kubectl scale deployments.v1.apps/{} --replicas=$replicas
kubectl get sts | grep -v NAME | awk '{print $1}' | xargs -I {} kubectl scale sts/{} --replicas=$replicas