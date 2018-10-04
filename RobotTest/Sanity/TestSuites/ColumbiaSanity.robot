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
#Resource  ../Keywords/CaseManagement.robot
Resource  ../Keywords/BSSQueries.robot
Resource  ../Prerequisites/ResourceLoading.robot
Resource  ../Prerequisites/TestDataLoading.robot
#Resource  ../TestCases/CSR/SearchCustomer.robot

Suite Setup        Set Up - Suite

Suite Teardown     Tear Down - Suite


*** Variables ***
${STALE_ELEMENT_SLEEP}    2s
${SIT}      http://localhost
${Dev}   http://10.150.34.184
${USSD_Port}    8381
${BSS_Port}     3010
${Creds}      Create List     admin       password



*** Test Cases ***
Preactivation
     [Tags]    Sanity    CBA
     ${Preactivation_Status}     Verify MSISDN Status In ResourceRelations   ${SA_MSISDN}
     Run Keyword IF    "${Preactivation_Status}" == "preactivation"    Log   MSISDN Is Aleardy Preactivated
     Run Keyword IF    "${Preactivation_Status}" == "None"     Perform Preactivation

Issue New Subscription
     [Tags]    Sanity    CBA
     Depends on test  Preactivation
     ${MSISDN_Status_Resources}     Verify MSISDN Status In CIM   ${SA_MSISDN}
     Run Keyword IF    "${MSISDN_Status_Resources}" == "active"    Log   MSISDN Is Aleardy active
     Run Keyword IF    "${MSISDN_Status_Resources}" == "None"     Perform Activation

Device Registration
     [Tags]    Sanity    CBA
     Depends on test  Issue New Subscription
     ${Device_Status_Resources}     Verify Device Status In CIM   ${SA_IMEI}
     Run Keyword IF    "${Device_Status_Resources}" == "active"    Log   Device Is Aleardy active
     Run Keyword IF    "${Device_Status_Resources}" == "None"     Perform Device registration

Top up
     [Tags]    Sanity    CBA
     Depends on test  Issue New Subscription
     Perform Top up

Purchase Paquetigo
     [Tags]    Sanity    CBA
     Depends on test  Issue New Subscription
     Depends on test  Top up
     Perform Purchase Paquetigo

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

     Load Sanity Test Data
     Load Dummy MSISDN To HPD
     Patch Dummy MSISDN Details
     Load SIM To HPD
     Patch SIM Details
     Load MSISDN To HPD

Tear Down - Suite
     Delete All Sessions


Load MSISDN To HPD
     ${MSISDN_Available_Status}     Verify MSISDN Status In RIM   ${SA_MSISDN}
     Run Keyword IF    "${MSISDN_Available_Status}" == "available"    Log   MSISDN Is Aleardy Loaded
     Run Keyword IF    "${MSISDN_Available_Status}" == "None"     Load MSISDN

Load SIM To HPD
     ${SIM_Available_Status}     Verify SIM Status In RIM     ${SA_ICC_ID}
     Run Keyword IF    "${SIM_Available_Status}" == "available"    Log   SIM Is Aleardy Loaded
     Run Keyword IF    "${SIM_Available_Status}" == "None"     Load SIM

Patch SIM Details
    ${MSISDN_Available_Status}     Verify SIM Status In RIM   ${SA_MSISDN}
     Run Keyword IF    "${MSISDN_Available_Status}" == "in-use"    Log   SIM Is Aleardy in-use
     Run Keyword IF    "${MSISDN_Available_Status}" == "None"     Patch SIM     ${SA_ICC_ID}

Load Dummy MSISDN To HPD
     ${MSISDN_Available_Status}     Verify MSISDN Status In RIM   ${SA_MSISDN}
     Run Keyword IF    "${MSISD
     N_Available_Status}" == "available"    Log   MSISDN Is Aleardy Loaded
     Run Keyword IF    "${MSISDN_Available_Status}" == "None"     Load MSISDN

Patch Dummy MSISDN Details
    ${MSISDN_Available_Status}     Verify MSISDN Status In RIM   ${SA_MSISDN}
     Run Keyword IF    "${MSISDN_Available_Status}" == "in-use"    Log   MSISDN Is Aleardy in-use
     Run Keyword IF    "${MSISDN_Available_Status}" == "None"     Patch MSISDN      ${SA_MSISDN}

Reserve Selected MSISDN
     ${MSISDN_Reserve_Status}     Verify MSISDN Status In RIM   ${SA_MSISDN}
     Run Keyword IF    "${MSISDN_Reserve_Status}" == "reserved"    Log   MSISDN Is Aleardy Reserved
     Run Keyword IF    "${MSISDN_Reserve_Status}" == "available"     Reserve MSISDN

Perform Preactivation
     ${link}    Construct Preactivation CBA Uri
     ${API_Response}  Post API Request   ${SIT}:${USSD_Port}   ${link}
     ${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     Create Session    Manageo  ${SIT}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

Perform Activation
     ${link}    Construct Activation CBA Uri
     ${API_Response}  Post API Request   ${SIT}:${USSD_Port}   ${link}
     ${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     Create Session    Manageo  ${SIT}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

Perform Device registration
     ${link}    Construct Device Registration CBA Uri
     ${API_Response}  Post API Request   ${SIT}:${USSD_Port}   ${link}
     ${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     Create Session    Manageo  ${SIT}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

Perform Top up
     ${link}    Construct Top Up CBA Uri
     ${API_Response}  Post API Request   ${SIT}:${USSD_Port}   ${link}
     ${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     Create Session    Manageo  ${SIT}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

Perform Purchase Paquetigo
     ${link}    Construct Purchase Paquetigo CBA Uri
     ${API_Response}  Post API Request   ${SIT}:${USSD_Port}   ${link}
     ${Reference_Number}  Get ID From Respose   ${API_Response}
     Create Session    Manageo  ${SIT}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}