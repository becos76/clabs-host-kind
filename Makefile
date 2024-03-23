

.PHONY: help

help: 
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

list: ## List clab-host images
	@@docker image ls clabs-host*

docker-build: build-ubuntu build-debian ## Build all images

build-ubuntu: ## Build ubuntu container
	@docker build -f images/Dockerfile.ubuntu-host -t clabs-host:ubuntu images/.

build-debian: ## Build debian container
	@@docker build -f images/Dockerfile.debian-host -t clabs-host:debian images/.

run-ubuntu: ## Run the ubuntu container
	@@docker run -it --rm --privileged clabs-host:ubuntu bash
	
run-debian: ## Run the ubuntu container
	@@docker run -it --rm --privileged clabs-host:debian bash
	
prune: ## Prune dangling images
	@@docker image prune

docker-clean: ## Remove host images
	@@docker image rm clabs-host:ubuntu
	@@docker image rm clabs-host:debian

clab-deploy: ## Bring up the lab
	@@sudo CLAB_VERSION_CHECK=disable CLAB_LABDIR_BASE=. containerlab deploy -t topo/hosts.clab.yml

clab-destroy: ## Stop the lab
	@@sudo CLAB_VERSION_CHECK=disable CLAB_LABDIR_BASE=. containerlab destroy -t topo/hosts.clab.yml

clab-reconfigure: ## Bring up the lab cleaning the directory first
	@@sudo CLAB_VERSION_CHECK=disable CLAB_LABDIR_BASE=. containerlab deploy -t topo/hosts.clab.yml --reconfigure

clab-purge: ## Stop the lab cleaning the lab directory
	@@sudo CLAB_VERSION_CHECK=disable CLAB_LABDIR_BASE=. containerlab destroy -t topo/hosts.clab.yml -c
