*** Settings ***
Documentation        Online

Resource            ../resources/base.resource

*** Test Cases ***
Webapp deve estar online
    
    Start sessions
    Get Title        equal       Mark85 by QAx
