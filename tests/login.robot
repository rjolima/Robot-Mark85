*** Settings ***
Documentation        Cenários de autenticação do usuário

Library              Collections  
Resource             ../resources/base.resource

Test Setup        Start sessions        
Test Teardown     Take Screenshot        

*** Test Cases ***
Deve poder logar com usuário pré cadastrado
    [Tags]    logar

    ${user}        Create Dictionary        
    ...            name=Rodrigo Lima   
    ...            email=lima@gmail.com        
    ...            password=pwd123  
    
    Remove users from database     ${user}[email]
    Insert users from database     ${user}
        
    Submit login form              ${user}

    User should be logged in       ${user}[name]  

Não Deve deve logar com a senha incorreta
    ${user}        Create Dictionary        
    ...            name=Steve Woz   
    ...            email=woz@gmail.com        
    ...            password=123456  
    
    Remove users from database     ${user}[email]
    Insert users from database     ${user}

    Set To Dictionary              ${user}        password=abc123
        
    Submit login form              ${user}

    Notice should be               Ocorreu um erro ao fazer login, verifique suas credenciais.

Campos obrigatórios
    ${user}        Create Dictionary        
    ...            name=Steve Woz   
    ...            email=${EMPTY}       
    ...            password=${EMPTY}   
           
    Submit login form              ${user}

    Alert shout be               Informe seu e-mail
    Alert shout be               Informe sua senha

Campo obrigatório sem email
    ${user}        Create Dictionary        
    ...            name=Steve Woz   
    ...            email=${EMPTY}       
    ...            password=123456  
           
    Submit login form              ${user}

    Alert shout be               Informe seu e-mail

Campo obrigatório sem senha
    ${user}        Create Dictionary        
    ...            name=Steve Woz   
    ...            email=woz@gmail.com       
    ...            password=${EMPTY} 
           
    Submit login form              ${user}

    Alert shout be               Informe sua senha