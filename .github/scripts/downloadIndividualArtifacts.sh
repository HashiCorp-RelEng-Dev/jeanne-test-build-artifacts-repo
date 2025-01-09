#!/bin/bash

filename=$1
PRODUCT=$(curl -L https://api.releases.hashicorp.com/v1/releases/vault/latest | jq -r '.name')
VERSION=$(curl -L https://api.releases.hashicorp.com/v1/releases/vault/latest | jq -r '.version')
OUTPUT_DIR="artifacts"
mkdir -p "$OUTPUT_DIR"

url=https://releases.hashicorp.com/$PRODUCT/$VERSION/$filename
curl -o "$OUTPUT_DIR/$filename" "$url"