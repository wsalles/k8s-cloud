help:
	@echo
	@echo "Usage: 'make <env> <target>'"
	@echo

check_env:
	@if [ -z "${ENV}" ]; then echo "ENVIRONMENT not set"; exit 1; fi ||:

dev:
	@:$(eval ENV=dev)

qa01:
	@:$(eval ENV=qa01)

prod:
	@:$(eval ENV=prod)