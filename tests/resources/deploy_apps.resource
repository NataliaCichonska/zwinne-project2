*** Settings ***
Resource    ./docker.resource
Resource   ../test_config/variables.resource

*** Keywords ***
Deploy Fronetnd
    ${output}    Run Docker Container    ${FRONTEND_IMAGE}    ${FRONTEND_CONTAINER_NAME}    port=3000:3000    env_vars=${FRONTEND_ENV_VARS}    detached=${True}
    Should Not Be Equal    ${output.rc}    ${1}
    Log    ${output.stdout}
    Sleep    1m

Deploy Backend
    ${output}    Run Docker Container    ${BACKEND_IMAGE}    ${BACKEND_CONTAINER_NAME}    port=8080:8080    env_vars=${BACKEND_ENV_VARS}    detached=${True}
    Should Not Be Equal    ${output.rc}    ${1}
    Log    ${output.stdout}
    Sleep    1m

Teardown Fronetnd
    Stop Docker Container     ${FRONTEND_CONTAINER_NAME}
    Delete Docker Container    ${FRONTEND_CONTAINER_NAME}

Teradown Backend
    Stop Docker Container     ${BACKEND_CONTAINER_NAME}
    Delete Docker Container    ${BACKEND_CONTAINER_NAME}