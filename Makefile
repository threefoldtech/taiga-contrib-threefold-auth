ifndef THREEFOLD_TAG
override THREEFOLD_TAG = latest
endif

ifndef TAIGA_VERSION
override TAIGA_VERSION = latest
endif

all: clean test build

build: build-front build-back

build-front:
	cd front && npm run preinstall && npm install && npm run build
	docker build --build-arg TAIGA_VERSION=$(TAIGA_VERSION) --no-cache docker/front -t threefolddev/taiga-front-threefold:$(THREEFOLD_TAG) 
	
build-back:
	docker build --build-arg TAIGA_VERSION=$(TAIGA_VERSION) --no-cache docker/back -t threefolddev/taiga-back-threefold:$(THREEFOLD_TAG)

publish:
	docker push threefolddev/taiga-back-threefold:$(THREEFOLD_TAG)
	docker push threefolddev/taiga-front-threefold:$(THREEFOLD_TAG)
	
