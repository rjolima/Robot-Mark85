*** Settings ***
Documentation        Cenários de tentativa de senha muita curta

Resource             ../resources/base.resource
Test Template        Short password

Test Setup        Start sessions        #Step inicial e final para todos os teste, antes de começar
Test Teardown     Take Screenshot        #Step inicial e final para todos os teste, depois de terminar

# Outra maneira de validar cenário informando o comportamento parecido
*** Test Cases ***
Não deve logar com senha de 1 digito         1

Não deve logar com senha de 2 digitos        1W

Não deve logar com senha de 3 digitos        1WS

Não deve logar com senha de 4 digitos        1WS@

Não deve logar com senha de 5 digitos        1WS@1

#Pode usar essa aqui direto ou do Base
*** Keywords ***
Short password
    [Arguments]        ${short_pass}

    ${user}        Create Dictionary        
    ...            name=Dinno Lima       
    ...            email=dinno@gmail.com      
    ...            password=${short_pass}
   
    Go to signup page
    Submit signup form         ${user}

    Alert shout be            Informe uma senha com pelo menos 6 digitos