NAME = cluster-zero/ubuntu-ajenti
VERSION = 1.0.0

.PHONY: all build 

all: build

build:
	docker build -t $(NAME):$(VERSION) .
