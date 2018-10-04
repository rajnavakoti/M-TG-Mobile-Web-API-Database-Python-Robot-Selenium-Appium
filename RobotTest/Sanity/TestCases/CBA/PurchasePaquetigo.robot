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
Resource  ../../Keywords/BSSQueries.robot


*** Variables ***
${STALE_ELEMENT_SLEEP}    2s
${path_excel}    C:/Test/CBA.xlsx
${Sheetname}    CBA
${SITuri}      http://localhost:8381
${Devuri}      http://10.150.34.184:8381
${DevApi}   http://10.150.34.184:3010
${SITApi}   http://localhost:3010
${apilink}    /ussd/purchasePaquetigo?msisdn=59178308288&salesCode=168&channelId=SMS_321
${Creds}      Create List     admin       password



*** Test Cases ***
Purchase Paquetigo
    [Tags]    DEBUG
    Read Purchase Paquetigo Data From Excel And Construct CBA Uri
    ${API_Response}  Post API Request   ${SITuri}   ${link}
    ${Reference_Number}  Get ID From Respose   ${API_Response}
    Create Session    Manageo  ${SITApi}
    ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}



#*** Keywords ***

