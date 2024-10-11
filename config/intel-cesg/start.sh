#!/bin/bash
# Kustomize:
# 	( cd /usr/local/bin/ && curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash )

# Minikube:
# 	minikube delete && minikube start --kubernetes-version=v1.23.17 --driver=none --addons=ingress,storage-provisioner


# git clone https://github.com/Fiooodooor/awx.git awx
# git clone https://github.com/Fiooodooor/awx-operator.git awx-operator

AWX_K8S_NAMESPACE="awx"
AWX_K8S_SECRET_NAME="awx-fqdn-secret-tls"
AWX_CESG_INTEL_WEB="awx.vsval.intel.com"
openssl req -x509 -nodes -days 1460 -newkey rsa:2048 -out tls-cert.pem -keyout tls-key.pem -subj "/CN=${AWX_CESG_INTEL_WEB}/O=${AWX_CESG_INTEL_WEB}" -addext "subjectAltName = DNS:${AWX_CESG_INTEL_WEB}"

kubectl -n "${AWX_K8S_NAMESPACE}" create secret tls "${AWX_K8S_SECRET_NAME}" --cert=./tls-cert.pem --key=./tls-key.pem --dry-run=client -o yaml >> 01-secret.yaml

# kubectl -n automation create secret tls awx-fqdn-secret-tls --cert=./tls-cert.pem --key=./tls-key.pem --dry-run=client -o yaml >> 01-secret.yaml

# kubectl apply -f 01-secret.yaml

# mkdir -p /etc/data/postgres
# mkdir -p /etc/data/projects
# chmod 755 -R /etc/data/
# kubectl apply -f 02-pv.yaml
