*** Settings ***
Resource    ../../test_config/variables.resource


*** Keywords ***
Verify OpenAI API Key
    IF    not $OPENAI_API_KEY
        Fail    OPENAI_API_KEY environment variable or robot command variable is required
    END
