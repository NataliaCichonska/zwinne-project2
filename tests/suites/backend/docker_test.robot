*** Settings ***
Resource    ../../resources/docker.resource
Resource    ../../test_config/variables.resource
Library    RequestsLibrary

*** Test Cases ***
Verify No API Key Error
    [Documentation]    Verify that the API key error message is displayed when no API key is provided
    ${output}    Run Docker Container    ${BACKEND_IMAGE}    ${BACKEND_CONTAINER_NAME}    port=8080:8080
    Should Contain    ${output.stdout}    Error: OPENAI_API_KEY environment variable is required
   [Teardown]    Run Keywords    Stop Docker Container     ${BACKEND_CONTAINER_NAME}
   ...           AND             Delete Docker Container    ${BACKEND_CONTAINER_NAME}


Verify Container Starts
    [Documentation]    Verify that the API key error message is displayed when no API key is provided
    ${output}    Run Docker Container    ${BACKEND_IMAGE}    ${BACKEND_CONTAINER_NAME}    port=8080:8080    env_vars=${BACKEND_ENV_VARS}
    Should Contain    ${output.stdout}    Started BackendApplication
   [Teardown]    Run Keywords    Stop Docker Container     ${BACKEND_CONTAINER_NAME}
   ...           AND             Delete Docker Container    ${BACKEND_CONTAINER_NAME}