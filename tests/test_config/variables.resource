*** Variables ***
${BACKEND_IMAGE}    cichonskanatalia/zw_back
${BACKEND_CONTAINER_NAME}    backend
@{BACKEND_ENV_VARS}    OPENAI_API_KEY=${OPENAI_API_KEY}
${OPENAI_API_KEY}    ${EMPTY}