TAG := 2.19.0-python3.10.4-alpine3.15
REGISTRY := ghcr.io

.PHONY: all clean test run build upgrade help publish

all: 			# default action
	@pre-commit install --install-hooks
	@git config commit.template .git-commit-template

clean:			# clean-up environment
	@find . -name '*.sw[po]' -delete

test:			# run test

run:			# run in the local environment
	docker run -it $(REGISTRY)/cmj0121/pre-commit:$(TAG) $(ARGS)

build:			# build the binary/library
	docker build -t $(REGISTRY)/cmj0121/pre-commit:$(TAG) .

upgrade:		# upgrade all the necessary packages
	pre-commit autoupdate

publish:		# publish the docker image to ghcr.io
	docker push $(REGISTRY)/cmj0121/pre-commit:$(TAG)

help:			# show this message
	@printf "Usage: make [OPTION]\n"
	@printf "\n"
	@perl -nle 'print $$& if m{^[\w-]+:.*?#.*$$}' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?#"} {printf "    %-18s %s\n", $$1, $$2}'
