Exercícios P/ Certificação  CKA
•	1 Crie um POD com as seguintes características utilizando kubectl:
•	nome: ex-1
•	image: nginx
•	port: 80

R: k run ex-1 --image nginx --port 80
________________________________________
•	2 Crie um POD com as seguintes características utilizando yaml:
•	nome: ex-2
•	image: nginx:latest
•	port: 80

k run ex-1 --image nginx:latest --port 80
________________________________________
•	3 Crie um POD com as seguintes características:
•	nome: ex-3
•	container 1
•	image: nginx
•	port: 80
•	container 2
•	image: redis
•	port: 6379

apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: ex-3
  name: ex-3
spec:
  containers:
  - image: nginx
    name: nginx
    ports:
    - containerPort: 80
  - image: redis
    name: redis
    ports:
    - containerPort: 6379
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
________________________________________
•	4 Liste o nome de todos os pods no namespace default.
k get pods
________________________________________
•	5 Liste o nome de todos os pods no namespace default e salvar os nomes no arquivo /tmp/pods.
k get pods | awk {'print $1'} > /tmp/pods
________________________________________
•	6 Utilizando o pod criado no exercício 3 fazer um teste do conexão entre os containers nginx e redis.
k exec -it ex-3 -c redis -- sh
________________________________________
•	7 Obtenha todos os detalhes do pod criado no exercício 1 e também direcione a saída do comando para o arquivo /tmp/pod1.
k get  po ex-1 -o yaml > /tmp/pod1
________________________________________
•	8 Delete o pod criado no exercício 1.
k delete pod ex-1
________________________________________
•	9 Delete o pod criado no exercício 3 sem nenhum delay.
k delete pod ex-3 --grace-period=0 --force
________________________________________
•	10 Altere a imagem do pod criado no exercício 2 para nginx:alpine
k edit pod ex-2
editar image:latest para alpine
________________________________________
•	11 Obtenha a versão do imagem do container do CoreDNS localizado no namespace kube-system e salve em /tmp/core-image.
k get deployment coredns -n kube-system -o yaml | grep image: > /tmp/core-image
________________________________________
•	12 Crie um POD com as seguintes características:
•	nome: ex-12
•	image: nginx
•	port: 80
Após isso obtenha todas as variáveis de ambiente desse container e salve em /tmp/env-12
k exec -it ex-12 -- env > /tmp/env-12
________________________________________
•	13 Crie um POD com as seguintes características:
•	nome: ex-13
•	image: nginx
•	port: 80
•	env: tier=web
•	env: enrironment=dev
Após isso obtenha todas as variáveis de ambiente desse container e salve em /tmp/env-13
________________________________________
•	14 Crie um POD com as seguintes características:
•	nome: ex-14
•	image: busybox
•	args: sleep 3600
Obtenha todas as variáveis de ambiente desse container e salve em /tmp/env-14
________________________________________
•	15 Crie um POD com as seguintes características:
•	nome: ex-15
•	image: busybox
•	args: sleep 3600
Após isso acesse o shell desse container e execute o comando ID
________________________________________
•	16 Delete todos os pods no namespace default
________________________________________
•	17 Crie um Deployment com as seguintes características:
•	nome: deploy-1
•	image: nginx
•	port: 80
•	replicas: 1
________________________________________
•	18 Consulte o status do Deployment criado anteriormente.
________________________________________
•	19 Altere a image do deployment para nginx:alpine.
________________________________________
•	20 Consulte todos os ReplicaSet criados por esse deployment.
________________________________________
•	21 Altere a image do deployment para nginx:latest e adicione um motivo de causa.
________________________________________
•	22 Agora volte esse deployment para "revison 1".
________________________________________
•	23 Verifique qual imagem o deployment está utilizando e grave em /tmp/deploy-image.
________________________________________
•	24 Escale esse deployment para 5 replicas utilizando o kubectl.
________________________________________
•	25 Escale esse deployment para 2 replicas utilizando o kubectl edit.
________________________________________
•	26 Pause o deployment.
________________________________________
•	27 Altere a image do deployment para nginx:alpine.
________________________________________
•	28 Agora tire o pause deste deployment.
________________________________________
•	29 Verifique qual imagem o deployment está utilizando e grave em /tmp/deploy-image-pause.
________________________________________
•	30 Crie um Deployment com as seguintes características utilizando um yaml:
•	nome: deploy-30
•	replicas: 5
•	container 1
•	name: web
•	image: nginx 
•	port: 80 
•	env: tier=web
•	env: environment=prod
•	container 2
•	nome: sleep
•	image: busybox
•	command: sleep 3600
________________________________________
•	31 Delete todos deployments no namespace default
________________________________________
•	32 Criar um ConfiMap com as seguintes características utilizando um yaml:
•	nome: env-configs
•	IP=10.0.0.1
•	SERVER=nginx
________________________________________
•	33 Verifique o ConfiMap criado.
________________________________________
•	34 Obtenha todos os dados do ConfiMap criado para /tmp/configmap.
________________________________________
•	35 Crie um ConfiMap com as seguintes características utilizando o kubectl:
•	nome: env-configs-kubectl
•	tier=web
•	server=homolog
________________________________________
•	36 Crie um POD com as seguintes características:
•	nome: ex-cm-pod1
•	image: nginx
•	port: 80 
Agora monte o configMap env-configs-kubectl como volume  em /data
________________________________________
•	37 Altere o pod ex-cm-pod1, agora montando somente o item tier agora com o nome ambiente.conf em /data.
________________________________________
•	38 Altere o pod ex-cm-pod1, remove todos os volumes e exporte o configMap completo como variáveis de ambiente. Após isso execute o comando ENV.
________________________________________
•	39 Altere o pod ex-cm-pod1, agora exporte somente o valor do item server para variável ENVIRONMENT. Após isso execute o comando ENV.
________________________________________
•	40 Altere o configMap env-configs-kubectl mude o valor de server para prod e faça essa alteração refletir no pod criado anteriormente.
________________________________________
•	41 Altere o configMap env-configs-kubectl para imutável.
________________________________________
•	42 Delete todos os pods e cofigmaps e pods criados anteriormente.
________________________________________
•	43 Crie uma Secret com as seguintes características utilizando um yaml:
•	nome: user-secret
•	user=superadmin
•	pass=minhasenhasupersegura
________________________________________
•	44 Verifique a Secret criada.
________________________________________
•	45 Obtenha os dados da Secret criada para /tmp/secret e descriptografe seus valores em /tmp/decrypt
________________________________________
•	46 Crie uma Secret com as seguintes características utilizando o kubectl:
•	nome: user-secret-kubectl
•	user=newuser
•	pass=agoraeseguraem
________________________________________
•	47 Crie um POD com as seguintes características:
•	nome: ex-secret-pod1
•	image: nginx
•	port: 80 
Agora monte a secret user-secret-kubectl como volume  em /secret
________________________________________
•	48 Altere o pod ex-secret-pod1, montando somente o item user agora com o nome user.conf em /secret
________________________________________
•	49 Altere o pod ex-secret-pod1, remove todos os volumes e exporte a secret completa como variáveis de ambiente, após isso execute o comando ENV
________________________________________
•	50 Altere o pod ex-secret-pod1, agora exporte somente o valor do item pass para variável SENHA, após isso execute o comando ENV
________________________________________
•	51 Altere a secret user-secret-kubectl e mude o valor de pass para minhanovasenhasegura e faça essa alteração refletir no pod criado anteriormente
________________________________________
•	52 Altere a secret user-secret-kubectl para imutável

