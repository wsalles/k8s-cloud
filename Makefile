.PHONY: help build push

DOCKER_IMAGEM = "wsalles/iac-cli"
DOCKER_TAG = "latest"

help:	# The following lines will print the available commands when entering just 'make'
ifeq ($(UNAME), Linux)
	@grep -P '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
else
	@awk -F ':.*###' '$$0 ~ FS {printf "%15s%s\n", $$1 ":", $$2}' \
		$(MAKEFILE_LIST) | grep -v '@awk' | sort
endif

build:
	@docker build -t ${DOCKER_IMAGEM}:${DOCKER_TAG} .

push:
	@docker push ${DOCKER_IMAGEM}:${DOCKER_TAG}
