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
Library  BuiltIn
Library  SSHLibrary
#Library  AppiumLibrary
Library  ExcelLibrary
Library  Screenshot

*** Variables ***
### Env/General Variables ###
${STALE_ELEMENT_SLEEP}    2s
${path_excel}    C:/Test/CBA.xlsx
${Sheetname}    CBA
${URL}   http://10.150.34.184:8092/casemanager/sa/cases
${ENV}   http://10.150.34.184:3010
${Link}  /api/devices?filter=%28EQ+primary-id+"EIRDevices::543864851358799"%29
${IMEI}  543864851358799

### Object Rep ###

*** Test Cases ***
Test Test
   Verify Device Is Not Registered

*** Keywords ***

Register a device successfully from CSRtb
    [Arguments]   ${Test_Case}      ${Test_Description}     ${Device_Brand_Value}    ${Device_Model_Value}  ${IMEI1_Value}    ${IMEI2_Value}    ${Contact_MSIDN_Value}     ${Device_Type_Value}
    [Tags]    EndToEnd  TestCase    RegisterDevice  RUBT-90584
     #Verify Device Is Not Registered      ${IMEI_Value}
     Click on Element   ProductsTab   ${Prodcuts_Tab}
     Sleep    2s
     Click on Element   RegisterDeviceButton   ${Register_Device_Button}
     Enter Value    DeviceBrand   ${Device_Brand}     ${Device_Brand_value}
     Enter Value    DeviceModel   ${Device_Model}     ${Device_Model_Value}
     Enter Value    IMEI      ${IMEI}     ${IMEI1_Value}
     Enter Value    ContactMSISDN     ${Contact_MSISDN}     ${Contact_MSISDN_Value}
     Enter Value    DeviceType     ${Device_Type}     ${Device_Type_Value}
     Capture Page Screenshot  ${Test_Case}EnterDeviceDetails.png
     Click on Element     RegisterDeviceSubbmitButton    ${RegisterDevice_Submit_Button}
     Poll Untill Device Registered    ${IMEI1_Value}
     Search Customer Through IMEI    ${IMEI1_Value}
     Click on Element   ProductsTab   ${Prodcuts_Tab}
     Sleep    2s
     Click on Element   DeviceNavigate   ${Registered_Device}
     Sleep    2s
     Capture Page Screenshot  ${Test_Case}AfterDeviceRegistration.png
     ${RowCount}  Find IMEI on CSR     ${IMEI_Value}
     ${DeviceStatus}   Replace String  ${DeviceStatus}    RowCount    ${RowCount}
     ${Device_CSR_Status}     Get Element Value   DeviceSatusCSR   ${DeviceStatus}
     Log  DeviceStatus:${Device_CSR_Status}
     Should Be Equal  ${Device_CSR_Status}   REGISTRADO


     

Verify Device Is Not Registered
    ${Status}   ${gresp.content}    Search IMEI Through BSSAPI  ${ENV}  ${IMEI}
    ${LifeCycleStatus}  Run Keyword IF  ${Status} != True   Get Device LifeCycleStatus From Devices  ${gresp.content}
    #Log to Console  LifeCycleStatus:${LifeCycleStatus}
    #${Terminated_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  Terminated
    ${LifeCycleStatus}  Convert To String  ${LifeCycleStatus}
    ${NoData_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  None
    Run Keyword If  ${NoData_Status} != True    Fail    ErrorCode Primary Validation Failed, Order not submitted ${IMEI} is already registered as ${LifeCycleStatus}


Search IMEI Through BSSAPI
    [Arguments]   ${ENV}  ${IMEI}
    Create Session    Manageo    ${ENV}
    ${gresp}    Get Request    Manageo   ${Link}
    Log to console  Repsonse Code : ${gresp.status_code}
    Log   Response Content : ${gresp.content}
    Run Keyword Unless   ${gresp.status_code} == 200 or ${gresp.status_code} == 201 or ${gresp.status_code} == 202 or ${gresp.status_code} == 203 or ${gresp.status_code} == 204   Fail    ErrorCode ${gresp.content}
    ${Data}  Get Json Value  ${gresp.content}   /data
    ${Data}  Evaluate    '${Data}'.strip('[')
    ${Data}  Evaluate    '${Data}'.strip(']')
    ${Data}  Convert To String   ${Data}
    ${Data}  Set Variable   ${Data}
    ${Status}   Run Keyword And Return Status  Should Be Equal  ${Data}  ${Empty}
    Run Keyword IF  ${Status} == True   Log to console  IMEI is not available in the system
    Run Keyword IF  ${Status} != True   Log to console  IMEI is Registered
    [Return]   ${status}    ${gresp.content}


Get Device LifeCycleStatus
    [Arguments]   ${gresp.content}
    ${lifecycle_status}  Get Json Value  ${gresp.content}   /data/0/attributes/lifecycle-status
    ${lifecycle_status}  Evaluate    '${lifecycle_status}'.strip('"')
    [Return]   ${lifecycle_status}
    #[Return]   ${gresp.content}
