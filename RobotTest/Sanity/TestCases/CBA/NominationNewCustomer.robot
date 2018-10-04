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

*** Variables ***
${STALE_ELEMENT_SLEEP}    2s
${path_excel}    C:/Test/CBA.xlsx
${Sheetname}    CBA
${SITuri}      http://localhost:8381
${Devuri}      http://10.150.34.184:8381
${apilink}     /ussd/nominateNewCustomerTM?firstName=Raj&surname1=Nava&surname2=Casas&dateOfBirth=19910101&nationality=BO&idType=PP&id=78676319&msisdn=78004746&channelId=TigoMatic&sellerId=abc
${Creds}      Create List     admin       password



*** Test Cases ***
Test title
    [Tags]    DEBUG
     Read Nominate New Customer Data From Excel And Construct CBA Uri
     Post API Request   ${Devuri}   ${link}


#*** Keywords ***






