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

    # Kliknięcie przycisku "POPRAW CV"
    Click Button    xpath=${BUTTON_CORRECT}

    # Sprawdzenie czy przetwarzanie CV zakończyło się sukcesem (dopasuj do aplikacji)
    Sleep    20s

    # Pobranie wartości po kliknięciu
    ${EXIT_NAME}         Get Text    xpath=${XPATH_NAME}
    ${EXIT_TITLE}        Get Text    xpath=${INPUT_TITLE}
    ${EXIT_PROFILE}    Get Text    xpath=${INPUT_PROFILE} 
    ${EXIT_EXPERIENCE}       Get Text    xpath=${INPUT_EXPERIENCE}
    ${EXIT_EDUCATION}      Get Text    xpath=${INPUT_EXPERIENCE}
    ${EXIT_SKILLS}    Get Text   xpath=${INPUT_SKILLS}
    ${EXIT_CONTACT}     Get Text    xpath=${INPUT_CONTACT}

    # Porównanie wartości input i exit
    Should Not Be Equal    ${NAME}    ${EXIT_NAME}
    Should Not Be Equal    ${TITLE}    ${EXIT_TITLE}   
    Should Not Be Equal    ${PROFILE}    ${EXIT_PROFILE}
    Should Not Be Equal    ${EXPERIENCE}    ${EXIT_EXPERIENCE}    
    Should Not Be Equal    ${EDUCATION}    ${EXIT_EDUCATION}
    Should Not Be Equal    ${SKILLS}    ${EXIT_SKILLS}    
    Should Be Equal    ${CONTACT}    ${EXIT_CONTACT}    

    Close Browser
