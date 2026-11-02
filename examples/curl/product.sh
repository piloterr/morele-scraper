#!/usr/bin/env bash
# Morele Product API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./product.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/morele/product" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=https://www.morele.net/laptop-lenovo-thinkbook-15-iil-20sm000fpb-6721152/
