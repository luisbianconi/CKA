#!/bin/bash

# 1. Limpeza total
echo "Excluindo cluster antigo..."
kind delete cluster

# 2. Criar arquivo de configuração do Kind
cat <<EOF > kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  disableDefaultCNI: true # Desativa o kindnetd básico
  podSubnet: "192.168.0.0/16" # Força o Kind a usar a rede que o Calico gosta
nodes:
- role: control-plane
- role: worker
EOF

echo "Criando cluster Kind..."
kind create cluster --config kind-config.yaml

# 3. Instalar o Tigera Operator (Calico)
echo "Instalando Calico Operator..."
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/tigera-operator.yaml

# 4. Instalar Custom Resources
echo "Instalando Calico Custom Resources..."
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/custom-resources.yaml

# 5. Remover Taint do Control Plane (pra você poder usar o nó master como quiser no lab)
echo "Removendo taints do control-plane..."
kubectl paint nodes --all node-role.kubernetes.io/control-plane- --overwrite 2>/dev/null

echo "--------------------------------------------------------"
echo "Aguardando os pods do Calico subirem (isso leva ~1 min)..."
echo "--------------------------------------------------------"

# Loop de espera simples
kubectl wait --namespace calico-system \
  --for=condition=ready pod \
  --selector=k8s-app=calico-node \
  --timeout=90s

echo "Feito! Seus nós devem estar Ready agora."
kubectl get nodes
