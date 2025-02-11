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
    Choose File    xpath=${FILE_UPLOAD}    xpath=${CV_PATH}
    # Drag And Drop  xpath=${CV_PATH}    xpath=${FILE_UPLOAD}
    
    # Click Element    xpath=${FILE_UPLOAD}
    # Sleep    1s
    # Evaluate    from pywinauto import Application; app = Application().connect(title="Wysyłanie pliku");
    # ...    dlg = app.window(title="Wysyłanie pliku"); dlg.Edit.set_text("D:\Code\zwinne-project2\tests\CV_Sample.jpg"); dlg.Button.click()    
    
    # Sleep    1s
    # Execute Script    from pynput.keyboard import Controller; keyboard = Controller(); 
    # ...    keyboard.type("C:\\Users\\User\\Desktop\\moje_cv.png"); keyboard.press(Key.enter); keyboard.release(Key.enter)
    
    Sleep    5s

    # Pobranie koemntarza CV
    ${COMMENT}    Get Text    xpath=${CV_COOMENT}

    # Porównanie wartości input i exit
    Should Not Be Equal    ${COMMENT}    ${null}
 
    Close Browser
