#!/bin/bash

filename=$1

if [[ "$filename" == *ent* ]]; then
    PRODUCT=$(curl -L https://api.releases.hashicorp.com/v1/releases/vault/1.18.3+ent | jq -r '.name')
    VERSION=$(curl -L https://api.releases.hashicorp.com/v1/releases/vault/1.18.3+ent | jq -r '.version')
else
    PRODUCT=$(curl -L https://api.releases.hashicorp.com/v1/releases/vault/latest | jq -r '.name')
    VERSION=$(curl -L https://api.releases.hashicorp.com/v1/releases/vault/latest | jq -r '.version')
fi

OUTPUT_DIR="artifacts"
mkdir -p "$OUTPUT_DIR"

url=https://releases.hashicorp.com/$PRODUCT/$VERSION/$filename
curl -o "$OUTPUT_DIR/$filename" "$url"