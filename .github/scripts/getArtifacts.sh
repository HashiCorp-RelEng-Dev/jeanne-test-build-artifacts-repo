#!/bin/bash

WORKFLOW_RUN_ID=$1
API_URL="https://api.github.com/repos/hashicorp-releng-dev/jeanne-test-build-artifacts-repo/actions/runs/$WORKFLOW_RUN_ID/artifacts"
PER_PAGE=100
PAGE=1       # First page

fetch_page() {
    curl -i -H "Authorization: Bearer $GITHUB_TOKEN" \
         -H "Accept: application/vnd.github+json" \
         "$API_URL?per_page=$PER_PAGE&page=$PAGE"
}

while true; do
    echo "Fetching page $PAGE..."
    RESPONSE=$(fetch_page)

    if echo "$RESPONSE" | grep -q '"message":'; then
        echo "Error: $(echo "$RESPONSE" | jq -r '.message')"
        exit 1
    fi

    # Parse and display artifact details
    echo "$RESPONSE" | jq -r '.artifacts[] | "\(.id): \(.name)"'

    # Check if there are more results
    HAS_MORE=$(echo "$RESPONSE" | jq '.artifacts | length')
    if [[ "$HAS_MORE" -lt "$PER_PAGE" ]]; then
        echo "No more pages."
        break
    fi

    # Increment the page number for the next iteration
    PAGE=$((PAGE + 1))
done

echo "Artifacts fetched successfully."
