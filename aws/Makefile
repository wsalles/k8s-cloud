-include ../makefiles/environment.mk

check_credentials:
	@if [ -z ${AWS_ACCESS_KEY_ID} ] || [ -z ${AWS_SECRET_ACCESS_KEY} ]; then \
		echo "Please, enter with 'Access Key' and 'Secret Key' \
			 \n\nExample:\n export AWS_ACCESS_KEY_ID=XXXXX \n export AWS_SECRET_ACCESS_KEY=YYYYYYY"; \
		exit 1; fi;

install-aws:
	@pip install awscli

create-workspace: check_env
	@terraform workspace new ${ENV}

init: check_credentials check_env
	@terraform init && terraform workspace select ${ENV}

validate:
	@terraform fmt -recursive
	@terraform validate

plan: init validate
	@terraform plan

apply: init validate
	@terraform apply

destroy:
	@terraform destroy

clean:
	@rm -rf .terraform
	@rm -rf terraform.tfstate.d
	@rm -f terraform.tfstate
	@rm -f terraform.tfstate.backup
