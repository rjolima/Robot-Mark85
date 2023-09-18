*** Settings ***
Documentation        Açoes  e elementos da página de cadastro de tarefa

Library        Browser

*** Keywords ***
Submit task form
    [Arguments]         ${task}

    Fill Text          css=input[placeholder$=tarefa]          ${task}[name]
    
    ${tags_element}        Set Variable         css=input[name=tags]
    
    #é usado o @ pra entender que é uma lista pra pecorrer todos os campos
    FOR    ${tag}    IN    @{task}[tags]
        Fill Text          ${tags_element}        ${tag}   
        #esse sleep pode por causa do comportamento, simulando o que seria feito ao inserir as tags 
        Sleep              1 
        Press Keys         ${tags_element}        Enter                              
    END

    Click         css=button >> text=Cadastrar
        