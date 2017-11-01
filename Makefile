ORG=khanlab
NAME=neuroglia-vasst-dev
VERSION = 0.0.1d

DOCKER_NAME=$(ORG)/$(NAME):$(VERSION)
DOCKER_LATEST=$(ORG)/$(NAME):latest
SINGULARITY_NAME=$(ORG)_$(NAME)_$(VERSION)
BUILD_DIR=~/singularity


build:
	rm -f $(BUILD_DIR)/$(SINGULARITY_NAME).img
	sudo singularity build $(BUILD_DIR)/$(SINGULARITY_NAME).img Singularity | tee build_$(SINGULARITY_NAME).log


sandbox:
	sudo singularity build --sandbox sandbox_$(SINGULARITY_NAME) Singularity | tee -a sandbox_$(SINGULARITY_NAME).log
	
docker_build: 
	docker build -t $(DOCKER_NAME) --rm .


docker_tag_latest:
	docker tag $(DOCKER_NAME) $(DOCKER_LATEST)

docker_push:
	docker push $(DOCKER_NAME)

docker_push_latest:
	docker push $(DOCKER_LATEST)

docker_run:
	docker run --rm -it $(DOCKER_NAME) /bin/bash	

docker_last_built_date:
	docker inspect -f '{{ .Created }}' $(DOCKER_NAME)

