#!/bin/sh

if [ -z "$OPENAI_API_KEY" ]; then
    echo "Error: OPENAI_API_KEYenvironment variable is required"
    exit 1
fi

exec "$@"
