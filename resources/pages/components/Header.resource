*** Settings ***

Documentation        Ações e elementos do cabeçalho do Mark85

Library         String
Library         Browser

*** Keywords ***
User should be logged in
    [Arguments]      ${name}

    #Usado o splinted para pegar apenas o nome ao realizar a validação na tela de login com [0]  Olá, ${splited_name}[0]    
    @{splited_name}     Split String        ${name}
    ${element}          Set Variable        css=header .right small 

    Wait For Elements State          ${element}     visible    5
    Get Text                         ${element}     equal      Olá, ${splited_name}[0]

Go to task form
    Click         css=.button-add