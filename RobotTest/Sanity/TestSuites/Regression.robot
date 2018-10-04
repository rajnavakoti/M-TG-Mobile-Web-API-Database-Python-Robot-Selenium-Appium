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
Resource  ../Keywords/CSR.robot
Resource  ../Keywords/CaseManagement.robot
Resource  ../../Keywords/BSSQueries.robot
Resource  ../Prerequisites/ResourceLoading.robot
Resource  ../Prerequisites/TestDataLoading.robot
#Resource  ../TestCases/CSR/SearchCustomer.robot

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

${CM_Password_Value}  csr
${CM_User_ID_Value}   csr
${MSISDN_Value}     59169413620
${SIM_Value}    8959103000436021039
${Customer_Name_Value}   TEST35 EE
${IMEI_Value}   520645455606981
${Device_Brand_Value}     Apple
${Device_Model_Value}     Automation
${Contact_MSISDN_Value}   59177010142
${Device_Type_Value}      Regression
${Report_ID_Value}    AutomationTest123
${Report_Name_Value}  AutomationTester
${URL}   http://10.150.34.184:7500



*** Test Cases ***
Preactivation
    [Tags]    Sanity    CBA
     Read Preactivation Data From Excel And Construct CBA Uri
     ${API_Response}  Post API Request   ${Dev}:${USSD_Port}   ${link}
     ${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     Create Session    Manageo  ${Dev}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

Issue New Subscription
    [Tags]    Sanity    CBA
     Depends on test  Preactivation
     Read Activate New Customer Data From Excel And Construct CBA Uri
     ${API_Response}  Post API Request   ${Dev}:${USSD_Port}   ${link}
     ${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     Create Session    Manageo  ${Dev}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

Device Registration
    [Tags]    Sanity    CBA
     Depends on test  Issue New Subscription
     Read Register Device Existing Customer Data From Excel And Construct CBA Uri
     ${API_Response}  Post API Request   ${Dev}:${USSD_Port}   ${link}
     ${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     Create Session    Manageo  ${Dev}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

Top up
    [Tags]    Sanity    CBA
     Depends on test  Issue New Subscription
     Read Topup Data From Excel And Construct CBA Uri
     ${API_Response}  Post API Request   ${Dev}:${USSD_Port}   ${link}
     ${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     Create Session    Manageo  ${Dev}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

Purchase Paquetigo
    [Tags]    Sanity    CBA
     Depends on test  Issue New Subscription
     Depends on test  Top up
     Read Purchase Paquetigo Data From Excel And Construct CBA Uri
     ${API_Response}  Post API Request   ${Dev}:${USSD_Port}   ${link}
     ${Reference_Number}  Get ID From Respose   ${API_Response}
     Create Session    Manageo  ${Dev}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

Search Customer Details in CSR
     [Tags]    Sanity    CBA
     Log In to CSR  ${URL}
     Search Customer Through MSISDN   ${MSISDN_Value}

Register Device Through CSR
     Sleep  2s
     Search Customer Through MSISDN   ${MSISDN_Value}
     Register Device    ${IMEI_Value}

Block Device Through CSR
     Sleep  2s
     Search Customer Through MSISDN   ${MSISDN_Value}
     Block Device   ${IMEI_Value}

Unblock Device Through CSR
     Sleep  2s
     Search Customer Through MSISDN   ${MSISDN_Value}
     UnBlock Device     ${IMEI_Value}

Unregister Device Through CSR
     Sleep  2s
     Search Customer Through MSISDN   ${MSISDN_Value}
     UnRegister Device  ${IMEI_Value}

Change SIM Through CSR
     Sleep  2s
     Search Customer Through MSISDN   ${MSISDN_Value}
     Change SIM   ${SIM_Value}

Block Subscription For Fraud Reason Through CSR
     Sleep  2s
     Search Customer Through MSISDN   ${MSISDN_Value}
     Block Subscription Due To Fraud    ${MSISDN_Value}

UnBlock Subscription For Fraud Reason Through CSR
     Sleep  2s
     Search Customer Through MSISDN   ${MSISDN_Value}
     UnBlock Subscription Due To Fraud   ${MSISDN_Value}


#Create Global Case From Case Mng
    #Create Global Case From Case Management

#Search Case Through Case Mng

    #Search Case Through Case Management

*** Keywords ***
Set Up - Suite
     Load MSISDN
     Load SIM
     Reserve MSISDN

Tear Down - Suite
     Delete All Sessions
     Close Browser