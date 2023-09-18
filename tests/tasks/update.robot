*** Settings ***
Documentation        Cenários de teste de autorização de tarefas

Resource        ../../resources/base.resource

Test Setup        Start sessions        
Test Teardown     Take Screenshot     

*** Test Cases ***
deve poder marcar um tarefa como concluída
    ${data}        Get fixture    tasks    done

    Reset user from database     ${data}[user] 
    Create a new task API        ${data}

    Do login        ${data}[user]

    Mark task as completed      ${data}[task][name]
    Task should be complete     ${data}[task][name]    

