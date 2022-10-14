#!/bin/bash

# All tests
#for value in 1024K.bin 128K.bin 16K.bin 16M.bin 256K.bin 2K.bin 2M.bin 32K.bin 32M.bin 4K.bin 4M.bin 512K.bin 64K.bin 64M.bin 8M.bin

# Check for AVX or SIMD (SHA) support
AVX512_SUPPORT=1
SIMD_SUPPORT=1

# Check AVX
./bin/sha256-go --method avx512 --check
retVal=$?

if [ $retVal -ne 0 ]; then
    AVX512_SUPPORT=0
fi

# Check SIMD/SHA
./bin/sha256-go --method simd --check
retVal=$?

if [ $retVal -ne 0 ]; then
    SIMD_SUPPORT=0
fi

# Selected tests
for value in 16K.bin 256K.bin 1024K.bin 16M.bin 64M.bin 256M.bin
do
    echo "\n${value} > openssl"
    time bash benchexec.sh "/usr/bin/openssl sha256 test-files/${value}" "100" &> results/${value}-openssl.log
    echo "-"
    
    echo "\n${value} > node"
    time node sha256-node.js --file test-files/${value} --loop 100 &> results/${value}-node.log
    echo "-"

    echo "\n${value} > go-native"
    time ./bin/sha256-go --file test-files/${value} --method gonative --loop 100 &> results/${value}-go-native.log
    echo "-"

if [ $AVX512_SUPPORT -eq 1 ]; then
    echo "\n${value} > go-avx512"
    time ./bin/sha256-go --file test-files/${value} --method avx512 --loop 100 &> results/${value}-go-avx512.log
    echo "-"
fi

if [ $SIMD_SUPPORT -eq 1 ]; then
    echo "\n${value} > go-simd"
    time ./bin/sha256-go --file test-files/${value} --method simd --loop 100 &> results/${value}-go-simd.log
    echo "-"
fi

done
