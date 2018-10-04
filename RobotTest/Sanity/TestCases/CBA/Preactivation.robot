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
${SITuri}      http://localhost:8381
${Devuri}      http://10.150.34.184:8381
${DevApi}   http://10.150.34.184:3010
${SITApi}   http://localhost:3010
${apilink}     /ussd/preActivateSubscription?sellerId=10786&reservedMsisdn=59177119634&dealerMsisdn=59178008270&iccid=436023415&reservedFor=AMRA810&dealerId=41316&channelId=USSD&shortCode=USSD_282
${Creds}      Create List     admin       password



*** Test Cases ***
Preactivation Through CBA API
    [Tags]    DEBUG
     Read Preactivation Data From Excel And Construct CBA Uri
     ${API_Response}  Post API Request   ${SITuri}   ${link}
     ${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     Create Session    Manageo  ${SITApi}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

#*** Keywords ***


