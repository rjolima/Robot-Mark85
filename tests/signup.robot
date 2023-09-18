*** Settings ***
Documentation        Cenários de testes do cadastro  de usuários

Resource        ../resources/base.resource

# Suite Setup         Log    Aqui ocorre antes da suite(antes de todos os testes)
# Suite Teardown      Log    Aqui ocorre depois da suite(depois de todos os testes)

Test Setup        Start sessions        #Step inicial e final para todos os teste, antes de começar
Test Teardown     Take Screenshot        #Step inicial e final para todos os teste, depois de terminar

*** Test Cases ***
Deve poder cadastrar um novo usuário
   
    ${user}        Create Dictionary        
    ...            name=Rodrigo Lima        
    ...            email=lima@gmail.com        
    ...            password=pwd123

    Remove users from database           ${user}[email]

    Go to signup page
    Submit signup form         ${user}

    Notice should be           Boas vindas ao Mark85, o seu gerenciador de tarefas.
 
Não deve cadastrar com email duplicado
    [Tags]    dup

    #super variável pode usar dessa maneira ou da outra pode alterar para inserção no BD
    ${user}        Create Dictionary        
    ...            name=Rodrigo Lima        
    ...            email=lima@gmail.com        
    ...            password=pwd123
   
    Remove users from database     ${user}[email]
    Insert users from database     ${user}

    Go to signup page
    Submit signup form         ${user}
 
    Notice should be           Oops! Já existe uma conta com o e-mail informado.

Campos obrigatórios    
    [Tags]    required

    ${user}        Create Dictionary        
    ...            name=${EMPTY}       
    ...            email=${EMPTY}       
    ...            password=${EMPTY}  

    Go to signup page
    Submit signup form         ${user}

    Alert shout be            Informe seu nome completo
    Alert shout be            Informe seu e-email
    Alert shout be            Informe uma senha com pelo menos 6 digitos

Campos obrigatórios sem o nome   

    ${user}        Create Dictionary        
    ...            name=${EMPTY}       
    ...            email=dinno@gmail.com       
    ...            password=pwd123  

    Go to signup page
    Submit signup form         ${user}

    Alert shout be            Informe seu nome completo

Campos obrigatórios sem o email   
  
    ${user}        Create Dictionary        
    ...            name=dinno       
    ...            email=${EMPTY}    
    ...            password=pwd123  
   
    Go to signup page
    Submit signup form         ${user}

    Alert shout be            Informe seu e-email

Campos obrigatórios sem password   

    ${user}        Create Dictionary        
    ...            name=dinno       
    ...            email=dinno@gmail.com      
    ...            password=${EMPTY}
   
    Go to signup page
    Submit signup form         ${user}

    Alert shout be            Informe uma senha com pelo menos 6 digitos

Não deve logar com senha de 1 digito  
    [Tags]            short_pass
    [Template]       
    Short password    1
        
Não deve logar com senha de 2 digitos        
    [Tags]            short_pass
    [Template]       
    Short password    1Q

Não deve logar com senha de 3 digitos
    [Tags]            short_pass
    [Template]       
    Short password    1Q@


Não deve logar com senha de 4 digitos   
    [Tags]            short_pass
    [Template]       
    Short password    1Q@z


Não deve logar com senha de 5 digitos        
    [Tags]            short_pass
    [Template]       
    Short password    1Q@z^

#Passou para Base pode usar qq uma das duas
# *** Keywords ***
# Short password
#     [Arguments]        ${short_pass}

#     ${user}        Create Dictionary        
#     ...            name=Dinno Lima       
#     ...            email=dinno@gmail.com      
#     ...            password=${short_pass}
   
#     Go to signup page
#     Submit signup form         ${user}

#     Alert shout be         Informe uma senha com pelo menos 6 digitos

#Outra maneira de validar inserção da senha incorreta sem PageObject
Informe senha com no mínimo 5 caracteres

    ${name}               FakerLibrary.Name
    ${email}              Set Variable     dinno@gmail.com 
    @{password_list}      Create List      0    QA    QAS  QAS!    QA!@3  

    FOR    ${password}    IN    @{password_list}
    
    Go to signup page

    Fill Text       id=name         ${name}
    Fill Text       id=email        ${email}
    Fill Text       id=password     ${password}

    signup page button

    Alert shout be            Informe uma senha com pelo menos 6 digitos     
    
    END  
Não deve cadastrar com email incorreto
    [Tags]        form
    
    Go to signup page

    Submit form email

    signup page button

    Alert shout be            Digite um e-mail válido
    
   