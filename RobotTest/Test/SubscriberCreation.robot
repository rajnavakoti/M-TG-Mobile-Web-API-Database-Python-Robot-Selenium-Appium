*** Settings ***
Documentation    Suite description
Library  Selenium2Library
Library  JSONLibrary
Library  RequestsLibrary
Library  OperatingSystem
Library  Collections
Library  simplejson
Library  String
Library  HttpLibrary.HTTP
Library  builtin
Library  Datachange.py
Library  UtilityKeywords.py
Library  SSHLibrary
Library  AppiumLibrary
Resource  JsonKeywords.robot

*** Variables ***
${STALE_ELEMENT_SLEEP}    2s

${INDIVIDUAL_JSON_FILE}              ${CURDIR}/samplejs
${Customer_JSON_FILE}              ${CURDIR}/CustomerCreateJson
${output}


*** Test Cases ***
Complete Customer creation
    [Tags]    DEBUG

    Open Connection  rc11vm054
    Login   rnavakoti   XXXXXX
    Wait Until Keyword Succeeds    3x    60s     Executing command
    Create Individual Through Json
    Create Customer Through Json
    Preactivation Through Json
    Nomination Through Json
