package main

import (
	"fmt"
	"os"
)

func main() {
	outputDir := "./out"
	err := os.MkdirAll(outputDir, os.ModePerm)
	if err != nil {
		fmt.Printf("Failed to create directory: %v\n", err)
		return
	}

	for i := 1; i <= 100; i++ {
		fileName := fmt.Sprintf("%s/file_%s_%s,%d.txt", outputDir, os.Getenv("OS"), os.Getenv("ARCH"), i)

		file, err := os.Create(fileName)
		if err != nil {
			fmt.Printf("Failed to create file %s: %v\n", fileName, err)
			continue
		}

		content := fmt.Sprintf("This is the content of file %d\n", i)
		_, err = file.WriteString(content)
		if err != nil {
			fmt.Printf("Failed to write to file %s: %v\n", fileName, err)
		}

		file.Close()
	}

	fmt.Println("100 text files generated")
}
