// +build arm
package main

import (
	sha "crypto/sha256"
	"hash"

	shasimd "github.com/minio/sha256-simd"
)

func SelectCapability(method *string) (h hash.Hash) {

	if *method == "simd" {
		// Since AVX512 is unavailable on ARM, fallback to other SIMD features available (e.g SHA1/2 extension on amd64 or ARM)
		h = shasimd.New()

	} else {
		h = sha.New()

	}

	return h

}
