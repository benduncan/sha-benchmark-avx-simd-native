.PHONY: clean init

all: clean init buildgo buildnode

run: benchmark

buildgo:
	go build -o ./bin/sha256-go

buildnode:
	npm ci	

init:
	sh init.sh

clean:
	rm -f ./bin/sha256-go
	rm -f ./results/*
	rm -f ./test-files/*

benchmark:
	sh benchmark.sh

