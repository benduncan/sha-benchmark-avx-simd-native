# Benchmarking SHA-256

Using commonly used libraries in Node, OpenSSL and Go using optional CPU capabilities on AMD64 (AVX-512, SHA) and ARM64 where available.

The utility is aimed to help benchmark bottlenecks in your application that heavily rely on SHA functions for calculating image hashes, files and critical application logic that depends on calculating SHA hashes.

## Dependencies

Confirm the following are installed:

* gcc
* go (version >1.16)
* node (version >16.13)

## Usage

Firstly build the required Go code and pull down packages required by node.

```
make
```

## Benchmarking

For benchmarking the utility is available to run on both amd64 (x86) and ARM. The benchmarking is isolated to a single core for gathering performance metrics.

```
make benchmark
```

The utility will loop by default 100 times over each of the following files:

* test-files/16K.bin 
* test-files/256K.bin
* test-files/1024K.bin
* test-files/16M.bin
* test-files/64M.bin
* test-files/256M.bin

The tool will benchmark the following:

* openssl
* node
* go (native)
* go (AVX-512, CPU capability if available)
* go (SHA, CPU capability if available)
