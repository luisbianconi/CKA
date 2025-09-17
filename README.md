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

---

## 20. Consulte todos os ReplicaSet criados por esse deployment.
**R:**

---

## 21. Altere a image do deployment para nginx:latest e adicione um motivo de causa.
**R:**

---

## 22. Agora volte esse deployment para "revison 1".
**R:**

---

## 23. Verifique qual imagem o deployment está utilizando e grave em /tmp/deploy-image.
**R:**

---

## 24. Escale esse deployment para 5 replicas utilizando o kubectl.
**R:**

---

## 25. Escale esse deployment para 2 replicas utilizando o kubectl edit.
**R:**

---

## 26. Pause o deployment.
**R:**

---

## 27. Altere a image do deployment para nginx:alpine.
**R:**

---

## 28. Agora tire o pause deste deployment.
**R:**

---

## 29. Verifique qual imagem o deployment está utilizando e grave em /tmp/deploy-image-pause.
**R:**

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

---

## 31. Delete todos deployments no namespace default
**R:**

---

## 32. Criar um ConfigMap com as seguintes características utilizando um yaml:
- **nome:** env-configs
- **IP:** 10.0.0.1
- **SERVER:** nginx
**R:**

---

## 33. Verifique o ConfigMap criado.
**R:**

---

## 34. Obtenha todos os dados do ConfigMap criado para /tmp/configmap.
**R:**

---

## 35. Crie um ConfigMap com as seguintes características utilizando o kubectl:
- **nome:** env-configs-kubectl
- **tier:** web
- **server:** homolog
**R:**

---

## 36. Crie um POD com as seguintes características:
- **nome:** ex-cm-pod1
- **image:** nginx
- **port:** 80
Agora monte o configMap env-configs-kubectl como volume em /data
**R:**

---

## 37. Altere o pod ex-cm-pod1, agora montando somente o item tier agora com o nome ambiente.conf em /data.
**R:**

---

## 38. Altere o pod ex-cm-pod1, remove todos os volumes e exporte o configMap completo como variáveis de ambiente. Após isso execute o comando ENV.
**R:**

---

## 39. Altere o pod ex-cm-pod1, agora exporte somente o valor do item server para variável ENVIRONMENT. Após isso execute o comando ENV.
**R:**

---

## 40. Altere o configMap env-configs-kubectl mude o valor de server para prod e faça essa alteração refletir no pod criado anteriormente.
**R:**

---

## 41. Altere o configMap env-configs-kubectl para imutável.
**R:**

---

## 42. Delete todos os pods e configmaps criados anteriormente.
**R:**

---

## 43. Crie uma Secret com as seguintes características utilizando um yaml:
- **nome:** user-secret
- **user:** superadmin
- **pass:** minhasenhasupersegura
**R:**

---

## 44. Verifique a Secret criada.
**R:**

---

## 45. Obtenha os dados da Secret criada para /tmp/secret e descriptografe seus valores em /tmp/decrypt
**R:**

---

## 46. Crie uma Secret com as seguintes características utilizando o kubectl:
- **nome:** user-secret-kubectl
- **user:** newuser
- **pass:** agoraeseguraem
**R:**

---

## 47. Crie um POD com as seguintes características:
- **nome:** ex-secret-pod1
- **image:** nginx
- **port:** 80
Agora monte a secret user-secret-kubectl como volume em /secret
**R:**

---

## 48. Altere o pod ex-secret-pod1, montando somente o item user agora com o nome user.conf em /secret
**R:**

---

## 49. Altere o pod ex-secret-pod1, remove todos os volumes e exporte a secret completa como variáveis de ambiente, após isso execute o comando ENV
**R:**

---

## 50. Altere o pod ex-secret-pod1, agora exporte somente o valor do item pass para variável SENHA, após isso execute o comando ENV
**R:**

---

## 51. Altere a secret user-secret-kubectl e mude o valor de pass para minhanovasenhasegura e faça essa alteração refletir no pod criado anteriormente
**R:**

---

## 52. Altere a secret user-secret-kubectl para imutável
**R:**

---