package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"runtime"

	"github.com/klauspost/cpuid/v2"
)

func main() {

	// Setup cmd-line defaults
	var numLoop = flag.Int("loop", 100, "number of loops to execute")
	var method = flag.String("method", "gonative", "SHA method (gonative, avx512, simd)")
	var file = flag.String("file", "", "Path to filename to SHA sum")
	var check = flag.Bool("check", false, "Check CPU capabilities and exit")

	flag.Parse()

	// Confirm CPU capabilities for AVX-512
	if *method == "avx512" && !cpuid.CPU.Supports(cpuid.AVX512F, cpuid.AVX512DQ, cpuid.AVX512BW, cpuid.AVX512VL) {
		fmt.Println("Error: AVX512 extension not available on CPU (amd64)")
		os.Exit(1)
	}

	// Confirm SHA1 on ARM
	if *method == "simd" && !cpuid.CPU.Supports(cpuid.SHA, cpuid.SSSE3, cpuid.SSE4) {
		fmt.Println("Error: SHA extension not available on CPU (amd64)")
		os.Exit(1)
	}

	if *method == "simd" && !cpuid.CPU.Has(cpuid.SHA2) && runtime.GOARCH == "arm64" {
		fmt.Println("Error: SHA extension not available on CPU (arm64)")
		os.Exit(1)
	}

	if *check == true && (*method != "avx512" || *method != "simd") {
		fmt.Println("SIMD support available")
		os.Exit(0)
	}

	// Confirm file specified
	if *file == "" {
		fmt.Println("Error: Specify filename as an argument to calculate SHA256")
		os.Exit(1)
	}

	// Confirm SHA on x86

	// Slurp in the entire file to memory, want to reduce I/O constraints for our benchmark
	var data []byte
	data, err := os.ReadFile(*file)
	if err != nil {
		log.Fatal(err)
	}

	h := SelectCapability(method)

	// Loop through X benchmarks
	for i := 0; i < *numLoop; i++ {

		// Reset the hash calculation
		h.Reset()

		// Sum the file buffer in memory
		h.Write(data)

		// Write the seq ID and hash for verification
		fmt.Printf("%d)\t%x\n", i, h.Sum(nil))

	}

}
