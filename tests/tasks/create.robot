*** Settings ***
Documentation        Cenários de cadastro de tarefas

Resource        ../../resources/base.resource

Test Setup        Start sessions        
Test Teardown     Take Screenshot     

*** Test Cases ***
Deve pode cadastar uma nova tarefa
    ${data}    Get fixture        tasks        create

    Reset user from database     ${data}[user] 

    Do login        ${data}[user]

    Go to task form
    Submit task form          ${data}[task]

    Task should be registred        ${data}[task][name]

Não deve cadastrar uma tarefa duplicada
    [Tags]    dup
    ${data}    Get fixture        tasks        duplicate
    
    Reset user from database     ${data}[user] 
    Create a new task API        ${data}

    Do login        ${data}[user]

    Go to task form
    Submit task form          ${data}[task]
    
    Notice should be          Oops! Tarefa duplicada.

Não deve cadastrar uma nova tarefa quando atinge o limite de tags
    [Tags]    tags_limit
    ${data}    Get fixture        tasks        tags_limit
    
    Reset user from database    ${data}[user] 
    
    Do login        ${data}[user]

    Go to task form
    Submit task form          ${data}[task]
    
    Notice should be          Oops! Limite de tags atingido.

    