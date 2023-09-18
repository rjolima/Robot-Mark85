*** Settings ***

Documentation        Ações e elementos do componente de mensagem de alerta

Library         Browser

*** Keywords ***
Alert shout be
    [Arguments]        ${expert_text}

    Wait For Elements State        css=.alert-error >> text= ${expert_text}
    ...          visible           5    
