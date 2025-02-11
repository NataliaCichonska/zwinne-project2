*** Settings ***
Library    Process
Library    Collections

*** Keywords ***
Run Docker Container
    [Arguments]    ${image}    ${name}    ${port}=${EMPTY}    ${detached}=${False}    ${env_vars}=${EMPTY}    ${timeout}=5
    ${command}    Create List    docker    run    --name    ${name}
    IF    $env_vars
        FOR    ${env_var}    IN    @{env_vars}
            Append To List    ${command}    -e    ${env_var}
        END
    END
    IF    $detached    Append To List    ${command}    -d
    # Image always should be last
    Append To List    ${command}    ${image}
    ${output}    Run Process    @{command}    timeout=${timeout}    shell=${True}
    RETURN    ${output}

Stop Docker Container
    [Arguments]    ${name}
    Run Process    docker    stop    ${name}

Delete Docker Container
    [Arguments]    ${name}
    Run Process    docker    rm    ${name}