*** Variables ***
${BACKEND_IMAGE}    cichonskanatalia/zw_back
${BACKEND_CONTAINER_NAME}    backend
@{BACKEND_ENV_VARS}    OPENAI_API_KEY=${OPENAI_API_KEY}
${OPENAI_API_KEY}    ${EMPTY}
${FRONTEND_IMAGE}    cichonskanatalia/zw_front
${FRONTEND_CONTAINER_NAME}    fronetnd
${FRONTEND_SERVER_IP}    192.168.0.31:3000
@{FRONTEND_ENV_VARS}    BACKEND_URL=http://${FRONTEND_SERVER_IP}
${BROWSER}      Firefox
${URL}          http://${FRONTEND_SERVER_IP}
${XPATH_NAME}    /html/body/div/div/div/div/div/div/div/div/form/div/div/div[2]/div[1]/input
${INPUT_TITLE}    /html/body/div/div/div/div/div/div/div/div/form/div/div/div[2]/div[2]/input
${INPUT_PROFILE}    /html/body/div/div/div/div/div/div/div/div/form/div/div/div[2]/div[3]/textarea
${INPUT_EXPERIENCE}    /html/body/div/div/div/div/div/div/div/div/form/div/div/div[2]/div[4]/textarea
${INPUT_EDUCATION}    /html/body/div/div/div/div/div/div/div/div/form/div/div/div[2]/div[5]/textarea
${INPUT_SKILLS}    /html/body/div/div/div/div/div/div/div/div/form/div/div/div[1]/div[1]/textarea
${INPUT_CONTACT}    /html/body/div/div/div/div/div/div/div/div/form/div/div/div[1]/div[2]/textarea
${BUTTON_CORRECT}    /html/body/div/div/div/div/div/div/div/div/form/div/div/button
${BUTTON_CHANGE}    /html/body/div/div/div/div/h6/span[2]
${FILE_UPLOAD}    /html/body/div/div/div/div/div/div/div/div/div/div/div/div/div
${CV_PATH}    D:\\Code\\zwinne-project2\\tests\\CV_Sample.jpg
${CV_COOMENT}    /html/body/div/div/div/div/div/div/div/div/div/div/div/div/div/div[2]
${BUTTON_POPUP}    /html/body/div/div/div/div/div/div/div/div/form/div/div[1]/button
${RESPOND_FIELD}    /html/body/div/div/div/div/div/div/div/div/form/div/div[2]/span
${RESPOND_DEFAULT}    Odpowiedź pojawi się tutaj