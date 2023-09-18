*** Settings ***
Documentation        Elementos de ação da página de cadastrdo

Library         FakerLibrary
Library         Browser
Resource        ../env.resource

*** Keywords ***
Go to signup page
    Go To       ${BASE_URL}/signup

    Wait For Elements State        css=h1    visible    5
    Get Text                       css=h1    equal      Faça seu cadastro 

signup page button
    Click           id=buttonSignup

Submit form email

    ${name}             FakerLibrary.Name
    ${password}         Set Variable     pwd123
    @{emails}           Create List      @teste.com    lima.gmail.com    lima@.com  rodrigo@gmail  

     FOR    ${email}    IN    @{emails}

    Fill Text       id=name         ${name}
    Fill Text       id=email        ${email}
    Fill Text       id=password     ${password}

    END
Submit signup form
    [Arguments]        ${user}

    Fill Text       css=input[name=name]             ${user}[name]
    Fill Text       css=input[name=email]            ${user}[email]
    Fill Text       css=input[name=password]         ${user}[password]
    #combina o css com uma função da biblioteca browser para buscar pelo nome do campo tb "Cadastrar"  
    Click           css=button[type=submit] >> text=Cadastrar 

Short password
    [Arguments]        ${short_pass}

    ${user}        Create Dictionary        
    ...            name=Dinno Lima       
    ...            email=dinno@gmail.com      
    ...            password=${short_pass}
   
    Go to signup page
    Submit signup form         ${user}
