# Exercícios para Certificação CKA

---

## 1. Crie um POD com as seguintes características utilizando kubectl:
- **nome:** ex-1
- **image:** nginx
- **port:** 80
**R:**
```sh
k run ex-1 --image nginx --port 80
```

---

## 2. Crie um POD com as seguintes características utilizando yaml:
- **nome:** ex-2
- **image:** nginx:latest
- **port:** 80
**R:**
```sh
k run ex-1 --image nginx:latest --port 80
```

---

## 3. Crie um POD com as seguintes características:
- **nome:** ex-3
- **container 1:** nginx (porta 80)
- **container 2:** redis (porta 6379)

**R:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: ex-3
  labels:
    run: ex-3
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
    - name: redis
      image: redis
      ports:
        - containerPort: 6379
  dnsPolicy: ClusterFirst
  restartPolicy: Always
```

---

## 4. Liste o nome de todos os pods no namespace default.
**R:**
```sh
k get pods
```

---

## 5. Liste o nome de todos os pods no namespace default e salvar os nomes no arquivo /tmp/pods.
**R:**
```sh
k get pods | awk {'print $1'} > /tmp/pods
```

---

## 6. Utilizando o pod criado no exercício 3 fazer um teste do conexão entre os containers nginx e redis.
**R:**
```sh
k exec -it ex-3 -c redis -- sh
```

---

## 7. Obtenha todos os detalhes do pod criado no exercício 1 e também direcione a saída do comando para o arquivo /tmp/pod1.
**R:**
```sh
k get po ex-1 -o yaml > /tmp/pod1
```

---

## 8. Delete o pod criado no exercício 1.
**R:**
```sh
k delete pod ex-1
```

---

## 9. Delete o pod criado no exercício 3 sem nenhum delay.
**R:**
```sh
k delete pod ex-3 --grace-period=0 --force
```

---

## 10. Altere a imagem do pod criado no exercício 2 para nginx:alpine
**R:**
```sh
k edit pod ex-2
# editar image:latest para alpine
```

---

## 11. Obtenha a versão do imagem do container do CoreDNS localizado no namespace kube-system e salve em /tmp/core-image.
**R:**
```sh
k get deployment coredns -n kube-system -o yaml | grep image: > /tmp/core-image
```

---

## 12. Crie um POD com as seguintes características:
- **nome:** ex-12
- **image:** nginx
- **port:** 80
Após isso obtenha todas as variáveis de ambiente desse container e salve em /tmp/env-12
**R:**
```sh
k run ex-12 --image nginx --port 80
k exec -it ex-12 -- env > /tmp/env-12
```

---

## 13. Crie um POD com as seguintes características:
- **nome:** ex-13
- **image:** nginx
- **port:** 80
- **env:** tier=web, environment=dev
Após isso obtenha todas as variáveis de ambiente desse container e salve em /tmp/env-13
**R:**
```sh
k run ex-13 --image nginx --port 80 --env="tier=web" --env="environment=dev"
k exec -it ex-12 -- env > /tmp/env-12
```

---

## 14. Crie um POD com as seguintes características:
- **nome:** ex-14
- **image:** busybox
- **args:** sleep 3600
Obtenha todas as variáveis de ambiente desse container e salve em /tmp/env-14
**R:**
```sh
k run ex-14 --image busybox -- sleep 3600
k exec -it ex-14 -- env > /tmp/env-14
```
---

## 15. Crie um POD com as seguintes características:
- **nome:** ex-15
- **image:** busybox
- **args:** sleep 3600
Após isso acesse o shell desse container e execute o comando ID
**R:**
```sh
k run ex-15 --image busybox -- sleep 3600
k exec -it ex-15 --sh
id
uid=0(root) gid=0(root) groups=0(root),10(wheel)
```
---

## 16. Delete todos os pods no namespace default
**R:**
```sh
kubectl delete pods --all 
```
---

## 17. Crie um Deployment com as seguintes características:
- **nome:** deploy-1
- **image:** nginx
- **port:** 80
- **replicas:** 1
**R:**
```sh
k create deployment deploy-1 --image nginx --port 80 --replicas 1 
```
---

## 18. Consulte o status do Deployment criado anteriormente.
**R:**
```sh
k get deployment deploy-1 
```
---

## 19. Altere a image do deployment para nginx:alpine.
**R:**
```sh
k set image deployment/deploy-1 nginx=nginx:alpine
```
---

## 20. Consulte todos os ReplicaSet criados por esse deployment.
**R:**
```sh
k get rs -l app=deploy-1
```
---

## 21. Altere a image do deployment para nginx:latest e adicione um motivo de causa.
**R:**
```sh
kubectl set image deployment/deploy-1 nginx=nginx:latest
kubectl annotate deployment deploy-1 kubernetes.io/change-cause="Task 21 CKA Exam"
```
---

## 22. Agora volte esse deployment para "revison 1".
**R:**
```sh
k rollout undo deployment/deploy-1 --to-revision 1
```
---

## 23. Verifique qual imagem o deployment está utilizando e grave em /tmp/deploy-image.
**R:**
```sh
k get deployment deploy-1 -o yaml | grep image: > /tmp/deploy-image
```
---

## 24. Escale esse deployment para 5 replicas utilizando o kubectl.
**R:**
```sh
k scale deployment/deploy-1 --replicas 5
```
---

## 25. Escale esse deployment para 2 replicas utilizando o kubectl edit.
**R:**
```sh
k edit deployment deploy-1
replicas: 2
```
---

## 26. Pause o deployment.
**R:**
```sh
k rollout pause deployment/deploy-1
```
---

## 27. Altere a image do deployment para nginx:alpine.
**R:**
```sh
k set image deployment/deploy-1 nginx=nginx:alpine
k get pods -o yaml | grep image: 
```
---

## 28. Agora tire o pause deste deployment.
**R:**
```sh
k rollout resume deployment/deploy-1 
k get pods -o yaml | grep image:  
```
---

## 29. Verifique qual imagem o deployment está utilizando e grave em /tmp/deploy-image-pause.
**R:**
```sh
kubectl describe deployment deploy-1 | grep Image: > /tmp/deploy-image
```
---

## 30. Crie um Deployment com as seguintes características utilizando um yaml:
- **nome:** deploy-30
- **replicas:** 5
- **container 1:**
	- name: web
	- image: nginx
	- port: 80
	- env: tier=web, environment=prod
- **container 2:**
	- name: sleep
	- image: busybox
	- command: sleep 3600
**R:**
```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: deploy-30
  name: deploy-30
spec:
  replicas: 1
  selector:
    matchLabels:
      app: deploy-30
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: deploy-30
    spec:
      containers:
      - image: nginx
        name: web
        ports:
        - containerPort: 80
        env:
          - name: tier
            value: "web"
          - name: environment
            value: "prod"
      - image: busybox
        name: sleep
        command: ["sleep"]
        args: ["3600"]
```
---

## 31. Delete todos deployments no namespace default
**R:**
```sh
k delete deployments -n default --all 
```
---

## 32. Criar um ConfigMap com as seguintes características utilizando um yaml:
- **nome:** env-configs
- **IP:** 10.0.0.1
- **SERVER:** nginx
**R:**
```sh
k create configmap env-configs \
--from-literal=IP=10.0.0.1 \
--from-literal=SERVER=nginx \
-o yaml --dry-run=client > env-configs.yaml
k apply -f env-configs.yaml
```
---

## 33. Verifique o ConfigMap criado.
**R:**
```sh
k get configmap env-configs -o yaml
```
---

## 34. Obtenha todos os dados do ConfigMap criado para /tmp/configmap.
**R:**
```sh
k get configmap env-configs -o yaml > /tmp/configmap
```
---

## 35. Crie um ConfigMap com as seguintes características utilizando o kubectl:
- **nome:** env-configs-kubectl
- **tier:** web
- **server:** homolog
**R:**
```sh
k create configmap env-configs-kubectl \
--from-literal=tier=web \
--from-literal=server=homolog \
```
---

## 36. Crie um POD com as seguintes características:
- **nome:** ex-cm-pod1
- **image:** nginx
- **port:** 80
Agora monte o configMap env-configs-kubectl como volume em /data
**R:**
```sh
kubectl run ex-cm-pod1 --image=nginx --port=80 --dry-run=client -o yaml > pod36.yaml

apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: ex-cm-pod1
  name: ex-cm-pod1
spec:
  containers:
  - image: nginx
    name: ex-cm-pod1
    ports:
    - containerPort: 80
    volumeMounts:
    - name: cm-volume
      mountPath: /data
  volumes:
  - name: cm-volume
    configMap:
      name: env-configs-kubectl
  dnsPolicy: ClusterFirst
  restartPolicy: Always
```
---

## 37. Altere o pod ex-cm-pod1, agora montando somente o item tier agora com o nome ambiente.conf em /data.
**R:**
```sh

```
---

## 38. Altere o pod ex-cm-pod1, remove todos os volumes e exporte o configMap completo como variáveis de ambiente. Após isso execute o comando ENV.
**R:**
```sh

```
---

## 39. Altere o pod ex-cm-pod1, agora exporte somente o valor do item server para variável ENVIRONMENT. Após isso execute o comando ENV.
**R:**
```sh

```
---

## 40. Altere o configMap env-configs-kubectl mude o valor de server para prod e faça essa alteração refletir no pod criado anteriormente.
**R:**
```sh

```
---

## 41. Altere o configMap env-configs-kubectl para imutável.
**R:**
```sh

```
---

## 42. Delete todos os pods e configmaps criados anteriormente.
**R:**
```sh
k delete pods --all
k delete configmaps --all (kube-root-ca.crt vai ser deletado, mas para testes não tem problema)
```
---

## 43. Crie uma Secret com as seguintes características utilizando um yaml:
- **nome:** user-secret
- **user:** superadmin
- **pass:** minhasenhasupersegura
**R:**
```sh
k create secret generic user-secret \
--from-literal=user=superadmin \
--from-literal=pass=minhasenhasupersegura \
-o yaml --dry-run=client > user-secret.yaml

k apply -f user-secret.yaml
```
---

## 44. Verifique a Secret criada.
**R:**
```sh
k get secrets user-secret -o yaml 
```
---

## 45. Obtenha os dados da Secret criada para /tmp/secret e descriptografe seus valores em /tmp/decrypt
**R:**
```sh
k get secrets user-secret -o yaml > /tmp/secret
```
---

## 46. Crie uma Secret com as seguintes características utilizando o kubectl:
- **nome:** user-secret-kubectl
- **user:** newuser
- **pass:** agoraeseguraem
**R:**
```sh

```
---

## 47. Crie um POD com as seguintes características:
- **nome:** ex-secret-pod1
- **image:** nginx
- **port:** 80
Agora monte a secret user-secret-kubectl como volume em /secret
**R:**
```sh

```
---

## 48. Altere o pod ex-secret-pod1, montando somente o item user agora com o nome user.conf em /secret
**R:**
```sh

```
---

## 49. Altere o pod ex-secret-pod1, remove todos os volumes e exporte a secret completa como variáveis de ambiente, após isso execute o comando ENV
**R:**
```sh

```
---

## 50. Altere o pod ex-secret-pod1, agora exporte somente o valor do item pass para variável SENHA, após isso execute o comando ENV
**R:**
```sh

```
---

## 51. Altere a secret user-secret-kubectl e mude o valor de pass para minhanovasenhasegura e faça essa alteração refletir no pod criado anteriormente
**R:**
```sh

```
---

## 52. Altere a secret user-secret-kubectl para imutável
**R:**
```sh

```
---