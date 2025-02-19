*** Settings ***
Library           RequestsLibrary
Library           OperatingSystem

*** Variables ***
${BASE_URL}       http://localhost:8080
${UPLOAD_ENDPOINT}    /api/upload-cv
${CORRECT_ENDPOINT}   /api/correct-cv
${TEST_CV_FILE}       ./tests/resources/cv_pl_1.png

*** Test Cases ***
Upload CV File
    [Documentation]    Test uploading a CV file
    File Should Exist    ${TEST_CV_FILE}
    ${image}=    Evaluate    {'file': open('${TEST_CV_FILE}', 'rb')}    sys
    Create Session    backend    ${BASE_URL}
    ${response}=    Post Request    backend    ${UPLOAD_ENDPOINT}    files=${image}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    ${response.json()}

Correct CV Data
    [Documentation]    Test correcting CV data
    Create Session    backend    ${BASE_URL}
    ${cv_data}=    Create Dictionary    fullname=John Doe    title=Developer
    ...    profile=Experienced developer    education=Bachelor's Degree    experience=5 years
    ...    skills=JavaScript, React    contact=john.doe@example.com
    ${response}=    Post Request    backend    ${CORRECT_ENDPOINT}    json=${cv_data}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Not Be Equal    ${cv_data}[profile]    ${response.json()['profile']}
    Log    ${response.json()}
