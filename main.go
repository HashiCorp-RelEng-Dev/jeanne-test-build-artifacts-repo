package main

import (
	"fmt"
	"os"
)

func createFile(fileName string, sizeInGB int) error {
	file, err := os.Create(fileName)
	if err != nil {
		return err
	}
	defer func(file *os.File) {
		err := file.Close()
		if err != nil {
			fmt.Printf("Error closing file: %v\n", err)
		}
	}(file)

	fileSize := int64(sizeInGB) * 1024 * 1024 * 1024

	if err := file.Truncate(fileSize); err != nil {
		return err
	}

	return nil
}

func main() {
	outputDir := "./out"
	err := os.MkdirAll(outputDir, os.ModePerm)
	if err != nil {
		fmt.Printf("Failed to create directory: %v\n", err)
		return
	}

	fileName := fmt.Sprintf("%s/file_%s_%s.txt", outputDir, os.Getenv("OS"), os.Getenv("ARCH"))
	fmt.Println(fileName)
	sizeInGB := 100

	if err := createFile(fileName, sizeInGB); err != nil {
		fmt.Printf("Error creating file: %v\n", err)
	}

	fmt.Printf("File '%s' of size %dMB created successfully!\n", fileName, sizeInGB)

}
