*** Settings ***
Resource     ${CURDIR}../../test_config/variables.resource
Resource    ../resources/deploy_apps.resource
Library    SeleniumLibrary
# Suite Setup    Run Keywords    Deploy Fronetnd    
# ...                            Deploy Backend

*** Test Cases ***
Verify CV Form Submission
    [Documentation]
    
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    Sleep    2s

    # Kliknięcie przycisku "Wgraj swoje CV"
    Click Element    xpath=${BUTTON_CHANGE}

    # Wgranie CV
    Click Element    xpath=${FILE_UPLOAD}
    Sleep    2s
    Evaluate    __import__('pyautogui').write(r"${CV_PATH}")    
    Evaluate    __import__('pyautogui').press("enter")

    Sleep    5s

    # Pobranie koemntarza CV
    ${COMMENT}    Get Text    xpath=${CV_COOMENT}

    # Porównanie wartości input i exit
    Should Not Be Equal    ${COMMENT}    ${null}
 
    Close Browser
