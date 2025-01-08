#!/bin/bash

PRODUCT=$(curl -L https://api.releases.hashicorp.com/v1/releases/vault/latest | jq -r '.name')
VERSION=$(curl -L https://api.releases.hashicorp.com/v1/releases/vault/latest | jq -r '.version')

OUTPUT_DIR="artifacts"
mkdir -p "$OUTPUT_DIR"

curl -L https://api.releases.hashicorp.com/v1/releases/vault/latest | jq --arg product "$PRODUCT" --arg version "$VERSION" -r '.builds[] | "\(.url) \($product)_\($version)_\(.os)_\(.arch).zip"' | while read -r url filename; do
    echo "Downloading $url..."
    curl -o "$OUTPUT_DIR/$filename" "$url"
    echo "Saved as $filename"
done

echo "Download complete!"
