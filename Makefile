DOCKERFILE_PATH = .

IMAGE_NAME = redmine-create-ticket-webhook

VERSION = 1.0.0

REGISTRY = abeyuki

PLATFORMS = linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/arm/v7,linux/arm/v8

build:
	docker build --no-cache -t $(IMAGE_NAME):latest $(DOCKERFILE_PATH)
	docker build --no-cache -t $(IMAGE_NAME):$(VERSION) $(DOCKERFILE_PATH)

local-run:
	docker run -itd --name redmine-create-ticket-webhook  --rm -p 5000:5000 \
	-e REDMINE_URL=${REDMINE_URL} \
	-e REDMINE_API_KEY=${REDMINE_API_KEY} \
	-e REDMINE_PROJECT_ID=${REDMINE_PROJECT_ID} \
	-e RDMINE_TRACKER_ID=${RDMINE_TRACKER_ID} \
	$(IMAGE_NAME):$(VERSION)

stop:
	docker stop $(IMAGE_NAME)

test:
	./test.sh

push:
	docker buildx build --no-cache --platform $(PLATFORMS) -t $(REGISTRY)/$(IMAGE_NAME):latest --push $(DOCKERFILE_PATH)
	docker buildx build --no-cache --platform $(PLATFORMS) -t $(REGISTRY)/$(IMAGE_NAME):$(VERSION) --push $(DOCKERFILE_PATH)

remote-run:
	docker run -itd --name redmine-create-ticket-webhook  --rm -p 5000:5000 \
	-e REDMINE_URL=${REDMINE_URL} \
	-e REDMINE_API_KEY=${REDMINE_API_KEY} \
	-e REDMINE_PROJECT_ID=${REDMINE_PROJECT_ID} \
	-e RDMINE_TRACKER_ID=${RDMINE_TRACKER_ID} \
	$(REGISTRY)/$(IMAGE_NAME):$(VERSION)