#!/bin/sh

echo "Creating benchmark files, please standby."
mkdir test-files
mkdir results

#dd if=/dev/zero of=test-files/2K.bin bs=2k count=1
#dd if=/dev/zero of=test-files/4K.bin bs=4k count=1
#dd if=/dev/zero of=test-files/8K.bin bs=8k count=1
dd if=/dev/zero of=test-files/16K.bin bs=16k count=1
#dd if=/dev/zero of=test-files/32K.bin bs=32k count=1
#dd if=/dev/zero of=test-files/64K.bin bs=64k count=1
#dd if=/dev/zero of=test-files/128K.bin bs=128k count=1
dd if=/dev/zero of=test-files/256K.bin bs=256k count=1
#dd if=/dev/zero of=test-files/512K.bin bs=512k count=1
dd if=/dev/zero of=test-files/1024K.bin bs=1024k count=1

#dd if=/dev/zero of=test-files/2M.bin bs=2M count=1
#dd if=/dev/zero of=test-files/4M.bin bs=4M count=1
#dd if=/dev/zero of=test-files/8M.bin bs=8M count=1
dd if=/dev/zero of=test-files/16M.bin bs=16M count=1
#dd if=/dev/zero of=test-files/32M.bin bs=32M count=1
dd if=/dev/zero of=test-files/64M.bin bs=64M count=1
#dd if=/dev/zero of=test-files/128M.bin bs=128M count=1
dd if=/dev/zero of=test-files/256M.bin bs=256M count=1
#dd if=/dev/zero of=test-files/512M.bin bs=512M count=1
#dd if=/dev/zero of=test-files/1024M.bin bs=1024M count=1

#dd if=/dev/zero of=test-files/2G.bin bs=1G count=2
#dd if=/dev/zero of=test-files/4G.bin bs=1G count=4
#dd if=/dev/zero of=test-files/8G.bin bs=1G count=8
#dd if=/dev/zero of=test-files/16G.bin bs=1G count=16