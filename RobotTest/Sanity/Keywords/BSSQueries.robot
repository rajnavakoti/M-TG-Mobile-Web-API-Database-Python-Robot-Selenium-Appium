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
#Library  AppiumLibrary
Library  ExcelLibrary
Resource  JSON.robot

*** Variables ***
${STALE_ELEMENT_SLEEP}    2s
#${path_excel}    C:/Test/CBA.xlsx
${SITuri}      http://localhost:8381
${Devuri}      http://10.150.34.184:8381
${DevApi}   http://10.150.34.184:3010
${SITApi}   http://localhost:3010
${OrderID_By_Refnumber}     /api/orders?filter=(EQ reference-number REFNUMBER)
${Search_By_IMEI_Devices}   /api/devices?filter=(EQ primary-id "EIRDevices::IMEI")
${Search_By_IMEI_Resources}   /api/resources?filter=(AND (EQ primary-id "IMEI")(EQ resource-type "Device"))
${Search_By_SIM_Simcards}    /api/sim-cards/REPLACESIM
${Search_By_SIM_Resources}   /api/resources?filter=(AND (EQ primary-id "REPLACEICCID")(EQ resource-type "sim"))
${Search_Product_By_MSISDN}   /api/resources?filter=(AND (EQ primary-id "MSISDN")(EQ resource-type "msisdn"))
${Search_By_MSISDN_Resources}   /api/resources?filter=(AND (EQ primary-id "REPLACEMSISDN")(EQ resource-type "msisdn"))
${Search_Subscription_Status}   /api/products/ProductID
${apilink}    /ussd/purchasePaquetigo?msisdn=77010034&salesCode=168&channelId=SMS_321
${Search_By_MSISDN_MSISDNS}    /api/msisdns/REPLACEMSISDN
${Search_By_MSISDN_Resource_Relations}  /api/msisdns?filter=(EQ id "REPLACEMSISDN")&include=related-resources
${Creds}      Create List     admin       password

${Testing}  "FirstTest_ChangeMSISDN_Test1216"
${Data}





*** Keywords ***

Fetch Oreder ID By Reference Number
      [Documentation]  This request is to make a json Get request to fetch the created UID of customer
      [Arguments]  ${ENV}  ${Reference_ID}
      Create Session    BSS    ${ENV}
      ${headers}    Create Dictionary    Content-Type=application/vnd.api+json    Accept=application/vnd.api+json
      ${OrderID_By_Refnumber}   Replace String  ${OrderID_By_Refnumber}  REFNUMBER  ${Reference_ID}
      ${gresp}    Get Request    BSS   ${OrderID_By_Refnumber}   headers=${headers}
      Log   ${gresp.content}
      ${Order_ID}   Get Json Value  ${gresp.content}    /data/0/id
      ${Order_ID}  Evaluate    '${Order_ID}'.strip('"')
      Log   ${Order_ID}
      [Return]  ${Order_ID}

Search IMEI from Devices Through BSSAPI
    [Arguments]   ${ENV}  ${IMEI}
    ${Link}   Replace String  ${Search_By_IMEI_Devices}  IMEI  ${IMEI}
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

Search SIM Through BSSAPI
    [Arguments]   ${ENV}  ${SIM_Value}
    ${Link}   Replace String  ${Search_By_SIM_SIMCards}  SIM  ${SIM_Value}
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
    Run Keyword IF  ${Status} == True   Log to console  SIM is not available in the system
    Run Keyword IF  ${Status} != True   Log to console  SIM is Registered
    [Return]   ${status}    ${gresp.content}

Search IMEI from Resources Through BSSAPI
    [Arguments]   ${ENV}  ${IMEI_Value}
    ${Link}   Replace String  ${Search_By_IMEI_Resources}  IMEI  ${IMEI_Value}
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

Search SIM from Resources Through BSSAPI
    [Arguments]   ${ENV}  ${SIM_Value}
    ${Link}   Replace String  ${Search_By_SIM_Resources}  ICCID  ${SIM_Value}
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
    Run Keyword IF  ${Status} == True   Log to console  SIM is not available in the system
    Run Keyword IF  ${Status} != True   Log to console  SIM is Registered
    [Return]   ${status}    ${gresp.content}

Search IMEI Through BSSAPI
    [Arguments]   ${ENV}  ${IMEI_Value}
    Create Session    Manageo    ${ENV}
    ${Link}     Replace String    ${Search_By_IMEI_Devices}    IMEI   ${IMEI_Value}
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


Get Device LifeCycleStatus From Devices
    [Arguments]   ${gresp.content}
    ${lifecycle_status}  Get Json Value  ${gresp.content}   /data/0/attributes/lifecycle-status
    #${lifecycle_status}   Convert To String    ${lifecycle_status}
    #${EIR_Status}   Get Json Value  ${gresp.content}  /data/0/attributes/characteristics/eir_list_code
    ${lifecycle_status}  Evaluate   '${lifecycle_status}'.strip('"')
    #${EIR_Status}  Evaluate  '${EIR_Status}'.strip('"')
    [Return]   ${lifecycle_status}
    #[Return]   ${gresp.content}

Get SIM LifeCycleStatus From SIMCards
    [Arguments]   ${gresp.content}
    ${lifecycle_status}  Get Json Value  ${gresp.content}   /data/attributes/lifecycle-status
    #${lifecycle_status}   Convert To String    ${lifecycle_status}
    #${EIR_Status}   Get Json Value  ${gresp.content}  /data/0/attributes/characteristics/eir_list_code
    ${lifecycle_status}  Evaluate   '${lifecycle_status}'.strip('"')
    #${EIR_Status}  Evaluate  '${EIR_Status}'.strip('"')
    [Return]   ${lifecycle_status}
    #[Return]   ${gresp.content}

Get Device LifeCycleStatus From Resources
    [Arguments]   ${gresp.content}
    ${lifecycle_status}  Get Json Value  ${gresp.content}   /data/0/attributes/lifecycle-status
    #${lifecycle_status}   Convert To String    ${lifecycle_status}
    #${EIR_Status}   Get Json Value  ${gresp.content}  /data/0/attributes/characteristics/eir_list_code
    ${lifecycle_status}  Evaluate   '${lifecycle_status}'.strip('"')
    #${EIR_Status}  Evaluate  '${EIR_Status}'.strip('"')
    [Return]   ${lifecycle_status}
    #[Return]   ${gresp.content}

Get SIM LifeCycleStatus From Resources
    [Arguments]   ${gresp.content}
    ${lifecycle_status}  Get Json Value  ${gresp.content}   /data/0/attributes/lifecycle-status
    #${lifecycle_status}   Convert To String    ${lifecycle_status}
    #${EIR_Status}   Get Json Value  ${gresp.content}  /data/0/attributes/characteristics/eir_list_code
    ${lifecycle_status}  Evaluate   '${lifecycle_status}'.strip('"')
    #${EIR_Status}  Evaluate  '${EIR_Status}'.strip('"')
    [Return]   ${lifecycle_status}
    #[Return]   ${gresp.content}


Get Subscription Product ID By MSISDN
    [Arguments]   ${ENV}  ${MSISDN_Value}
    ${Link}   Replace String  ${Search_Product_By_MSISDN}  MSISDN  ${MSISDN_Value}
    Create Session    Manageo    ${ENV}
    ${gresp}    Get Request    Manageo   ${Link}
    Log to console  Repsonse Code : ${gresp.status_code}
    Log   Response Content : ${gresp.content}
    Run Keyword Unless   ${gresp.status_code} == 200 or ${gresp.status_code} == 201 or ${gresp.status_code} == 202 or ${gresp.status_code} == 203 or ${gresp.status_code} == 204   Fail    ErrorCode ${gresp.content}
    ${Data}  Get Json Value  ${gresp.content}   /data/0/relationships/realized-product/data/id
    ${Data}  Evaluate    '${Data}'.strip('"')
    ${Data}  Convert To String   ${Data}
    ${Data}  Set Variable   ${Data}
    [Return]   ${Data}

Get Product LifeCycleStatus
    [Arguments]   ${Product_ID}
    ${Link}   Replace String  ${Search_Subscription_Status}  ProductID   ${Product_ID}
    Create Session    Manageo    ${ENV}
    ${gresp}    Get Request    Manageo   ${Link}
    Log to console  Repsonse Code : ${gresp.status_code}
    Log   Response Content : ${gresp.content}
    Run Keyword Unless   ${gresp.status_code} == 200 or ${gresp.status_code} == 201 or ${gresp.status_code} == 202 or ${gresp.status_code} == 203 or ${gresp.status_code} == 204   Fail    ErrorCode ${gresp.content}
    ${Data}  Get Json Value  ${gresp.content}   /data/attributes/lifecycle-status
    ${Data}  Evaluate    '${Data}'.strip('"')
    ${Data}  Convert To String   ${Data}
    ${Data}  Set Variable   ${Data}
    [Return]   ${Data}

Verify MSISDN Status In RIM
    [Arguments]   ${MSISDN_ID}
    ${LifeCycleStatus}    Fetch MSISDN Details From RIM     ${MSISDN_ID}    ${Search_By_MSISDN_MSISDNS}
    ${LifeCycleStatus}  Convert To String  ${LifeCycleStatus}
    #${Resource_Available_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  available
    [Return]   ${LifeCycleStatus}


Verify SIM Status In RIM
    [Arguments]   ${ICC_ID}
    ${LifeCycleStatus}    Fetch SIM Details From RIM      ${ICC_ID}      ${Search_By_SIM_Simcards}
    ${LifeCycleStatus}  Convert To String  ${LifeCycleStatus}
    #${Resource_Available_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  available
    [Return]   ${LifeCycleStatus}

Verify Device EIR Status In RIM
    [Arguments]   ${IMEI}
    ${LifeCycleStatus}    Fetch Device EIR Details From RIM      ${IMEI}      ${Search_By_IMEI_Devices}
    ${LifeCycleStatus}  Convert To String  ${LifeCycleStatus}
    #${Resource_Available_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  available
    [Return]   ${LifeCycleStatus}

Fetch MSISDN Details From RIM
    [Arguments]   ${MSISDN_ID}  ${Query_String}
    ${Link}   Replace String  ${Query_String}  REPLACEMSISDN   ${MSISDN_ID}
    Create Session    Manageo    ${SITApi}
    ${gresp}    Get Request    Manageo   ${Link}
    Log to console  Repsonse Code : ${gresp.status_code}
    Log   Response Content : ${gresp.content}
    Run Keyword IF  ${gresp.status_code} == 404   Set Variable    ${Data}   None
    ${Data}     Run Keyword IF   ${gresp.status_code} == 200 or ${gresp.status_code} == 201 or ${gresp.status_code} == 202 or ${gresp.status_code} == 203 or ${gresp.status_code} == 204   Get Resource LifecycleStatus From RIM    ${gresp.content}
    [Return]   ${Data}

Fetch SIM Details From RIM
    [Arguments]   ${ICC_ID}  ${Query_String}
    ${Link}   Replace String  ${Query_String}  REPLACESIM   ${ICC_ID}
    Create Session    Manageo    ${SITApi}
    ${gresp}    Get Request    Manageo   ${Link}
    Log to console  Repsonse Code : ${gresp.status_code}
    Log   Response Content : ${gresp.content}
    Run Keyword IF  ${gresp.status_code} == 404   Set Variable    ${Data}   None
    ${Data}     Run Keyword IF   ${gresp.status_code} == 200 or ${gresp.status_code} == 201 or ${gresp.status_code} == 202 or ${gresp.status_code} == 203 or ${gresp.status_code} == 204   Get Resource LifecycleStatus From RIM    ${gresp.content}
    [Return]   ${Data}

Fetch Device EIR Details From RIM
    [Arguments]   ${IMEI}  ${Query_String}
    ${Link}   Replace String  ${Query_String}  IMEI   ${IMEI}
    Create Session    Manageo    ${SITApi}
    ${gresp}    Get Request    Manageo   ${Link}
    Log to console  Repsonse Code : ${gresp.status_code}
    Log   Response Content : ${gresp.content}
    ${EIR_List_Code}    Run Keyword And Return Status   Should Contain  ${gresp.content}   eir_list_code
    Log To Console    ${EIR_List_Code}
    Run Keyword If  ${EIR_List_Code} == False   Set Variable    ${Data}   None
    ${Data}     Run Keyword IF  ${EIR_List_Code} == True   Get Device EIR Status    ${gresp.content}
    [Return]   ${Data}

Verify MSISDN Status In ResourceRelations
    [Arguments]   ${MSISDN_ID}
    ${LifeCycleStatus}    Fetch MSISDN Details From ResourceRelations     ${MSISDN_ID}    ${Search_By_MSISDN_Resource_Relations}
    ${LifeCycleStatus}  Convert To String  ${LifeCycleStatus}
    #${Resource_Available_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  available
    Log To Console  ${LifeCycleStatus}
    [Return]   ${LifeCycleStatus}

Fetch MSISDN Details From ResourceRelations
    [Arguments]   ${MSISDN_ID}  ${Query_String}
    ${Link}   Replace String  ${Query_String}  REPLACEMSISDN   ${MSISDN_ID}
    Create Session    Manageo    ${SITApi}
    ${gresp}    Get Request    Manageo   ${Link}
    Log to console  Repsonse Code : ${gresp.status_code}
    Log   Response Content : ${gresp.content}
    #${Json_Content}  Get Json Value  ${gresp.content}   /data
    #${Json_Content}    Convert To String   ${Json_Content}
    #${Json_Content}  Evaluate    '${Json_Content}'.strip('[')
    #${Json_Content}  Evaluate    '${Json_Content}'.strip(']')
    ${Resource_realtion_Available}    Run Keyword And Return Status   Should Contain  ${gresp.content}   target
    Log To Console    ${Resource_realtion_Available}
    Run Keyword If  ${Resource_realtion_Available} == False   Set Variable    ${Data}   None
    ${Data}     Run Keyword IF  ${Resource_realtion_Available} == True   Get Resource LifecycleStatus From ResourceRelations    ${gresp.content}
    [Return]   ${Data}


Get Resource LifecycleStatus From RIM
    [Arguments]    ${gresp.content}
     ${Data}  Get Json Value  ${gresp.content}   /data/attributes/lifecycle-status
    ${Data}  Evaluate    '${Data}'.strip('"')
    ${Data}  Convert To String   ${Data}
    ${Data}  Set Variable   ${Data}
    Log To Console     ${Data}
    [Return]   ${Data}


Get Resource LifecycleStatus From ResourceRelations
    [Arguments]    ${gresp.content}
     ${Data}  Get Json Value  ${gresp.content}   /included/0/attributes/role
    ${Data}  Evaluate    '${Data}'.strip('"')
    ${Data}  Convert To String   ${Data}
    ${Data}  Set Variable   ${Data}
    Log To Console     ${Data}
    [Return]   ${Data}

Get Device EIR Status
    [Arguments]    ${gresp.content}
     ${Data}  Get Json Value  ${gresp.content}   data/0/attributes/characteristics/eir_list_code
     ${Data}  Evaluate    '${Data}'.strip('"')
     ${Data}  Convert To String   ${Data}
     ${Data}  Set Variable   ${Data}
     Log To Console     ${Data}
     [Return]   ${Data}


############### CIM Customer Inventory BSS API Queries #############################

Verify MSISDN Status In CIM
    [Arguments]   ${MSISDN_ID}
    ${LifeCycleStatus}    Fetch MSISDN Details From CIM      ${MSISDN_ID}      ${Search_By_MSISDN_Resources}
    ${LifeCycleStatus}  Convert To String  ${LifeCycleStatus}
    #${Resource_Available_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  available
    Log To Console  ${LifeCycleStatus}
    [Return]   ${LifeCycleStatus}

Fetch MSISDN Details From CIM
    [Arguments]   ${MSISDN_ID}  ${Query_String}
    ${Link}   Replace String  ${Query_String}  REPLACEMSISDN   ${MSISDN_ID}
    Create Session    Manageo    ${SITApi}
    ${gresp}    Get Request    Manageo   ${Link}
    Log to console  Repsonse Code : ${gresp.status_code}
    Log   Response Content : ${gresp.content}
    ${Json_Content}  Get Json Value  ${gresp.content}   /data
    ${Json_Content}    Convert To String   ${Json_Content}
    ${Json_Content}  Evaluate    '${Json_Content}'.strip('[')
    ${Json_Content}  Evaluate    '${Json_Content}'.strip(']')
    ${Lifecyclestatus_Available}    Run Keyword And Return Status   Should Contain  ${Json_Content}   lifecycle-status
    Log To Console    ${Lifecyclestatus_Available}
    Run Keyword If  ${Lifecyclestatus_Available} == False   Set Variable    ${Data}   None
    ${Data}     Run Keyword IF  ${Lifecyclestatus_Available} == True   Get Resource LifecycleStatus From CIM    ${gresp.content}
    [Return]   ${Data}

Verify SIM Status In CIM
    [Arguments]   ${ICC_ID}
    ${LifeCycleStatus}    Fetch SIM Details From CIM      ${ICC_ID}      ${Search_By_SIM_Resources}
    ${LifeCycleStatus}  Convert To String  ${LifeCycleStatus}
    #${Resource_Available_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  available
    Log To Console  ${LifeCycleStatus}
    [Return]   ${LifeCycleStatus}


Verify Device Status In CIM
    [Arguments]   ${IMEI}
    ${LifeCycleStatus}    Fetch Device Details From CIM      ${IMEI}      ${Search_By_IMEI_Resources}
    ${LifeCycleStatus}  Convert To String  ${LifeCycleStatus}
    #${Resource_Available_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  available
    Log To Console  ${LifeCycleStatus}
    [Return]   ${LifeCycleStatus}

Fetch Device Details From CIM
    [Arguments]   ${IMEI}  ${Query_String}
    ${Link}   Replace String  ${Query_String}  IMEI   ${IMEI}
    Create Session    Manageo    ${SITApi}
    ${gresp}    Get Request    Manageo   ${Link}
    Log to console  Repsonse Code : ${gresp.status_code}
    Log   Response Content : ${gresp.content}
    ${Json_Content}  Get Json Value  ${gresp.content}   /data
    ${Json_Content}    Convert To String   ${Json_Content}
    ${Json_Content}  Evaluate    '${Json_Content}'.strip('[')
    ${Json_Content}  Evaluate    '${Json_Content}'.strip(']')
    ${Lifecyclestatus_Available}    Run Keyword And Return Status   Should Contain  ${Json_Content}   lifecycle-status
    Log To Console    ${Lifecyclestatus_Available}
    Run Keyword If  ${Lifecyclestatus_Available} == False   Set Variable    ${Data}   None
    ${Data}     Run Keyword IF  ${Lifecyclestatus_Available} == True   Get Resource LifecycleStatus From CIM    ${gresp.content}
    [Return]   ${Data}


Fetch SIM Details From CIM
    [Arguments]   ${ICC_ID}  ${Query_String}
    ${Link}   Replace String  ${Query_String}  REPLACEICCID   ${ICC_ID}
    Create Session    Manageo    ${SITApi}
    ${gresp}    Get Request    Manageo   ${Link}
    Log to console  Repsonse Code : ${gresp.status_code}
    Log   Response Content : ${gresp.content}
    ${Json_Content}  Get Json Value  ${gresp.content}   /data
    ${Json_Content}    Convert To String   ${Json_Content}
    ${Json_Content}  Evaluate    '${Json_Content}'.strip('[')
    ${Json_Content}  Evaluate    '${Json_Content}'.strip(']')
    ${Lifecyclestatus_Available}    Run Keyword And Return Status   Should Contain  ${Json_Content}   lifecycle-status
    Log To Console    ${Lifecyclestatus_Available}
    Run Keyword If  ${Lifecyclestatus_Available} == False   Set Variable    ${Data}   None
    ${Data}     Run Keyword IF  ${Lifecyclestatus_Available} == True   Get Resource LifecycleStatus From CIM    ${gresp.content}
    [Return]   ${Data}

Get Resource LifecycleStatus From CIM
    [Arguments]    ${gresp.content}
     ${Data}  Get Json Value  ${gresp.content}   /data/0/attributes/lifecycle-status
    ${Data}  Evaluate    '${Data}'.strip('"')
    ${Data}  Convert To String   ${Data}
    ${Data}  Set Variable   ${Data}
    Log To Console     ${Data}
    [Return]   ${Data}


