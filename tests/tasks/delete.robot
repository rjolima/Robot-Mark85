*** Settings ***
Documentation        Cenários de teste de remoção de tarefas

Resource        ../../resources/base.resource

Test Setup        Start sessions        
Test Teardown     Take Screenshot     

*** Test Cases ***
deve poder deletar um tarefa
                                           #cenário usando a massa do Json task.json
    ${data}        Get fixture    tasks    delete

    Reset user from database     ${data}[user] 
    Create a new task API        ${data}

    Do login        ${data}[user]

    Request removal          ${data}[task][name]   
    Task should not exist    ${data}[task][name] 

deve poder deletar um tarefa já concluída
                                          #cenário usando a massa do Json task.json
    ${data}        Get fixture    tasks    delete

    Reset user from database     ${data}[user] 
    Create a new task API        ${data}

    Do login        ${data}[user]

    Mark task as completed      ${data}[task][name]
    Task should be complete     ${data}[task][name]   

    Request removal          ${data}[task][name]  
    Task should not exist    ${data}[task][name]  