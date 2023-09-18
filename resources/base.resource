*** Settings ***

Library       libs/database.py 
Library       Browser
Library       JSONLibrary

Resource      env.resource

Resource      pages/components/Header.resource
Resource      pages/components/Notice.resource
Resource      pages/components/alert.resource

Resource      pages/SignupPage.resource
Resource      pages/LoginPage.resource
Resource      pages/TaskCreatePage.resource
Resource      pages/TasksPage.resource

Resource      services.resource

*** Keywords ***
Start sessions

    New Browser     browser=${BROWSER}   headless=False
    New Page        ${BASE_URL}

#Helpers
Get fixture
    [Arguments]        ${file_name}        ${scenario}

    #${EXECDIR} variável de ambiente do robot para lista o diretório de execução 
    ${data}     Load Json From File         ${EXECDIR}/resources/fixtures/tasks.json
    ...         encoding=utf-8
    
    [Return]    ${data}[${scenario}]

Reset user from database
     [Arguments]        ${user} 
                                       #uma variável e campo 
    Clean user from database           ${user}[email] 
    Insert users from database         ${user}

Create a new task API
    [Arguments]        ${data}

    Post user session      ${data}[user]
    Post a new task        ${data}[task]

Do login
    [Arguments]        ${user}

    Submit login form                  ${user}
    User should be logged in           ${user}[name]
