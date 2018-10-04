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
Library  ExcelLibrary
Resource  ../../Keywords/JSON.robot
Resource  ../../Keywords/CBA.robot

*** Variables ***
${STALE_ELEMENT_SLEEP}    2s
${path_excel}    C:/Test/CBA.xlsx
${Sheetname}    CBA
${SITuri}      http://localhost:8381
${Devuri}      http://10.150.34.184:8381
${apilink}     /ussd/nominateExistingCustomerTM?idType=Passport&id=45492416&msisdn=0123006349&channelId=ussd&sellerId=12345678
${Creds}      Create List     admin       password



*** Test Cases ***
Test title
    [Tags]    DEBUG
     Read Nominate Existing Customer Data From Excel And Construct CBA Uri
     Post API Request   ${Devuri}   ${link}


#*** Keywords ***

