*** Settings ***
Resource    ${CURDIR}../../resources/docker.resource
Resource    ${CURDIR}../../test_config/variables.resource
Library    RequestsLibrary

*** Test Cases ***
Verify Container Starts
    [Documentation]    Verify that the API key error message is displayed when no API key is provided
    ${output}    Run Docker Container    ${FRONTEND_IMAGE}    ${FRONTEND_CONTAINER_NAME}    port=3000:3000    env_vars=${FRONTEND_ENV_VARS}
    # Should Be Equal    ${output.rc}    ${0}
    Should Contain    ${output.stdout}    No issues found.
   [Teardown]    Run Keywords    Stop Docker Container     ${FRONTEND_CONTAINER_NAME}
   ...           AND             Delete Docker Container    ${FRONTEND_CONTAINER_NAME}