.PHONY: bootstrap run verify harden

bootstrap:
	./scripts/bootstrap.sh

run:
	./scripts/run.sh

verify:
	./scripts/verify.sh

harden:
	./scripts/harden.sh
