// +build amd64
package main

import (
	sha "crypto/sha256"
	"hash"

	shasimd "github.com/minio/sha256-simd"
)

func SelectCapability(method *string) (h hash.Hash) {

	if *method == "avx512" {
		// If AVX-512 is enabled
		server := shasimd.NewAvx512Server()
		h = shasimd.NewAvx512(server)

	} else if *method == "simd" {
		// If AVX512 is unavailable, fallback to other SIMD features available (e.g SHA1/2 extension on amd64 or ARM)
		h = shasimd.New()

	} else {
		h = sha.New()

	}

	return h

}
