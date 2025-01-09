#!/bin/bash

PRODUCT=$(curl -L https://api.releases.hashicorp.com/v1/releases/vault/latest | jq -r '.name')
VERSION=$(curl -L https://api.releases.hashicorp.com/v1/releases/vault/latest | jq -r '.version')

OUTPUT_DIR="artifacts"
mkdir -p "$OUTPUT_DIR"

#download OSS
curl -L https://api.releases.hashicorp.com/v1/releases/vault/latest | jq --arg product "$PRODUCT" --arg version "$VERSION" -r '.builds[] | "\(.url) \($product)_\($version)_\(.os)_\(.arch).zip"' | while read -r url filename; do
    trimmed="${filename// /}"
    echo "Downloading $url..."
    curl -o "$OUTPUT_DIR/${trimmed}" "$url"
    echo "Saved as $trimmed"
done

#download Ent artifacts
ENT_VERSION=$(curl -L https://api.releases.hashicorp.com/v1/releases/vault/1.18.3+ent | jq -r '.version')
curl -L https://api.releases.hashicorp.com/v1/releases/vault/1.18.3+ent | jq --arg product "$PRODUCT" --arg version "$ENT_VERSION" -r '.builds[] | "\(.url) \($product)_\($version)_\(.os)_\(.arch).zip"' | while read -r url filename; do
    trimmed="${filename// /}"
    echo "Downloading $url..."
    curl -o "$OUTPUT_DIR/${trimmed}" "$url"
    echo "Saved as $trimmed"
done

echo "Download complete!"
