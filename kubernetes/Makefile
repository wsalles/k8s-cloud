PROJECT="file-transfer"

context-config:
	@aws eks update-kubeconfig --name k8s-cloud --region "us-east-1"

ebs-install:
	@kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=master"

ebs-config:
	@kubectl apply -f ebs/storageclass.yaml
	@kubectl apply -f ebs/claim.yaml

setup:
	@kubectl apply -k metric-server/
	@kubectl apply -k traefik/

deploy:
	@helm upgrade \
		--namespace webapp \
		--create-namespace \
		--install \
		--reset-values \
		${PROJECT} ./${PROJECT}

delete:
	@helm delete ${PROJECT}
