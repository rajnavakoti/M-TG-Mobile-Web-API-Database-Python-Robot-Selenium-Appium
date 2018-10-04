*** Settings ***
Documentation    Sanity test for Millicom Bolivia RFC
...              This suite covers
...              SALES - Preactivation, Activation, Device Registration, Purchase Paquetigo and Top up
...              CARE - Customer Search, Modification of Customer Data
...              Cases - Create Case

Library  Selenium2Library
Library  JSONLibrary
Library  RequestsLibrary
Library  OperatingSystem
Library  Collections
Library  simplejson
Library  String
Library  HttpLibrary.HTTP
Library  builtin
Library  SSHLibrary
#Library  AppiumLibrary
Library  ExcelLibrary
Library    DependencyLibrary

Resource  ../Keywords/JSON.robot
Resource  ../Keywords/CBA.robot
Resource  ../Keywords/CaseManagement.robot
Resource  ../Keywords/BSSQueries.robot
Resource  ../Prerequisites/ResourceLoading.robot
Resource  ../Prerequisites/TestDataLoading.robot
Resource  ../TestCases/CSR/SearchCustomer.robot

Suite Setup        Set Up - Suite

Suite Teardown     Tear Down - Suite


*** Variables ***
${STALE_ELEMENT_SLEEP}    2s
${path_excel}    C:/Test/CBA.xlsx
${Sheetname}    CBA
${SIT}      http://localhost
${Dev}   http://10.150.34.184
${USSD_Port}    8381
${BSS_Port}     3010
${Creds}      Create List     admin       password



*** Test Cases ***
Preactivation
     [Tags]    Sanity    CBA
     Read Preactivation Data From Excel And Construct CBA Uri
     ${API_Response}  Post API Request   ${SIT}:${USSD_Port}   ${link}
     ${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     Create Session    Manageo  ${SIT}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

Issue New Subscription
     [Tags]    Sanity    CBA
     Depends on test  Preactivation
     Read Activate New Customer Data From Excel And Construct CBA Uri
     ${API_Response}  Post API Request   ${SIT}:${USSD_Port}   ${link}
     ${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     Create Session    Manageo  ${SIT}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

#Device Registration
    #[Tags]    Sanity    CBA
     #Depends on test  Issue New Subscription
     #Read Register Device Existing Customer Data From Excel And Construct CBA Uri
     #${API_Response}  Post API Request   ${SIT}:${USSD_Port}   ${link}
     #${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     #Create Session    Manageo  ${SIT}:${BSS_Port}
     #${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

#Top up
    #[Tags]    Sanity    CBA
     #Depends on test  Issue New Subscription
     #Read Topup Data From Excel And Construct CBA Uri
     #${API_Response}  Post API Request   ${SIT}:${USSD_Port}   ${link}
     #${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     #Create Session    Manageo  ${SIT}:${BSS_Port}
     #${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

#Purchase Paquetigo
    #[Tags]    Sanity    CBA
     #Depends on test  Issue New Subscription
     #Depends on test  Top up
     #Read Purchase Paquetigo Data From Excel And Construct CBA Uri
     #${API_Response}  Post API Request   ${SIT}:${USSD_Port}   ${link}
     #${Reference_Number}  Get ID From Respose   ${API_Response}
     #Create Session    Manageo  ${SIT}:${BSS_Port}
     #${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

#Search Customer Details in CSR
     #[Tags]    Sanity    CBA
     #Depends on test  Issue New Subscription
     #Search Customer Through MSISDN



#Create Global Case From Case Mng
    #Create Global Case From Case Management

#Search Case Through Case Mng

    #Search Case Through Case Management

*** Keywords ***
Set Up - Suite
     ### Loading MSISDN ###
     ${MSISDN_Available_Status}     Verify MSISDN Status In RIM   5917701521
     Run Keyword IF    "${MSISDN_Available_Status}" == "200"    Log   MSISDN Is Aleardy Loaded
     Run Keyword IF    "${MSISDN_Available_Status}" == "None"     Load MSISDN
     Run Keyword Unless     "${MSISDN_Available_Status}" == "available"  or  "${MSISDN_Available_Status}" == "None"   Fail    ErrorCode MSISDN Is In ${MSISDN_Available_Status}

     ### Loading SIM ###
     ${SIM_Available_Status}     Verify SIM Status In RIM     8959103000436022094
     Run Keyword IF    "${SIM_Available_Status}" == "available"    Log   SIM Is Aleardy Loaded
     Run Keyword IF    "${SIM_Available_Status}" == "None"     Load SIM
     Run Keyword Unless     "${SIM_Available_Status}" == "available"  or  "${MSISDN_Available_Status}" == "None"   Fail    ErrorCode MSISDN Is In ${SIM_Available_Status}

     ### Reserve MSISDN ###
     ${MSISDN_Reserve_Status}     Verify MSISDN Status In RIM   5917701521
     Run Keyword IF    "${MSISDN_Reserve_Status}" == "reserved"    Log   MSISDN Is Aleardy Reserved
     Run Keyword IF    "${MSISDN_Reserve_Status}" == "available"     Reserve MSISDN
     Run Keyword Unless     "${MSISDN_Reserve_Status}" == "reserved"  or  "${MSISDN_Available_Status}" == "available"   Fail    ErrorCode MSISDN Is In ${MSISDN_Reserve_Status}

Tear Down - Suite
     Delete All Sessions