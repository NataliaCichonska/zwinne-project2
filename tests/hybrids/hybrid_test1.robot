*** Settings ***
Resource     ${CURDIR}../../test_config/variables.resource
Resource    ../resources/deploy_apps.resource
Library    SeleniumLibrary
# Suite Setup    Run Keywords    Deploy Fronetnd    
# ...                            Deploy Backend

*** Variables ***
${NAME}    Jan Kowalski
${TITLE}    Fullstack Developer
${PROFILE}    Pasjonat technologii
${EXPERIENCE}    2 lata jako developer
${EDUCATION}    Politechnika Bydgoska
${SKILLS}    Python, JavaScript, Selenium
${CONTACT}    jan.kowalski@example.com


*** Test Cases ***
Verify CV Form Submission
    [Documentation]
    
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    # Zamknięcie informacji pop-up
    Sleep    2s
    Click Button    xpath=${BUTTON_POPUP}

    # Wypełnianie formularza
    Input Text    xpath=${XPATH_NAME}    ${NAME}
    Input Text    xpath=${INPUT_TITLE}    ${TITLE} 
    Input Text    xpath=${INPUT_PROFILE}    ${PROFILE}
    Input Text    xpath=${INPUT_EXPERIENCE}    ${EXPERIENCE}
    Input Text    xpath=${INPUT_EDUCATION}    ${EDUCATION}
    Input Text    xpath=${INPUT_SKILLS}    ${SKILLS}
    Input Text    xpath=${INPUT_CONTACT}    ${CONTACT}

    Wait Until Keyword Succeeds    3m    10s    Submit And Verify

    Close Browser

*** Keywords ***
Submit And Verify
    # Kliknięcie przycisku "POPRAW CV"
    Click Button    xpath=${BUTTON_CORRECT}

    # Sprawdzenie czy przetwarzanie CV zakończyło się sukcesem (dopasuj do aplikacji)
    Sleep    10s

    # Pobranie wartości po kliknięciu
    ${RESPOND}    Get Text    xpath=${RESPOND_FIELD}

    # Porównanie wartości input i exit
    Should Not Be Equal    ${RESPOND_DEFAULT}    ${RESPOND}