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
Library  SSHLibrary
#Library  AppiumLibrary
Library  ExcelLibrary


*** Variables ***
${STALE_ELEMENT_SLEEP}    2s
#${path_excel}    C:/Test/CBA.xlsx
#${path_excel}    C:/Test/Sanity.xlsx
${MSISDNLoading_JSON_FILE}              ../RobotTest/Sanity/TestData/BSSAPI/JSON/MSISDNInsertJson
${SIMLoading_JSON_FILE}              ../RobotTest/Sanity/TestData/BSSAPI/JSON/SIMInsert
${ReserveMSISDN_JSON_FILE}           ../RobotTest/Sanity/TestData/BSSAPI/JSON/ReserveMSISDN
${SIM_PATCH_FILE}                    ../RobotTest/Sanity/TestData/BSSAPI/JSON/SIMPatch
${Dev}  http://10.150.34.184
${SIT}  http://localhost
${RIM_Port}  23000
${BSS_Port}  3010
${Headers}    Create Dictionary   Content-Type    application/vnd.api+json    authorisationFlag    N
#${output}
#${Ind_UID}   158799c7-4545-48aa-86a2-e7f81e4f54c1




*** Keywords ***

Load MSISDN

      Create Session    Manageo    ${SIT}:${RIM_Port}
      ${File}    Get Binary File    ../RobotTest/Sanity/TestData/BSSAPI/JSON/MSISDNInsertJson

     ${existing_json}   OperatingSystem.Get File   ${MSISDNLoading_JSON_FILE}
     ${existing_json}    Replace String    ${existing_json}    MSISDNREPLACE    ${SA_MSISDN}
     ${existing_json}    Replace String    ${existing_json}    SKUREPLACE    ${SA_MSISDN_SKU}
     ${existing_json}    Replace String    ${existing_json}    RESOURCESTOCKREPLACE    ${SA_MSISDN_Stock}
     ${new_loader_json}    Replace String    ${existing_json}    RESOURCEBATCHREPLACE    ${SA_MSISDN_Batch}

     Log    ${new_loader_json}

     ${resp}    Post Request    Manageo    /api/msisdns   data=${new_loader_json}
     Log    ${resp.status_code}
     Log    ${resp.content}

     Run Keyword Unless   ${resp.status_code} == 200 or ${resp.status_code} == 201 or ${resp.status_code} == 202 or ${resp.status_code} == 203 or ${resp.status_code} == 204   Fail    ErrorCode ${resp.content}
    [Return]   ${resp.content}

Load SIM

      Create Session    Manageo    ${SIT}:${RIM_Port}
      ${File}    Get Binary File    ../RobotTest/Sanity/TestData/BSSAPI/JSON/SIMInsert

     ${existing_json}   OperatingSystem.Get File   ${SIMLoading_JSON_FILE}
     ${existing_json}    Replace String    ${existing_json}    SIMREPLACE    ${SA_ICC_ID}
     ${existing_json}    Replace String    ${existing_json}    IMSIREPLACE   ${SA_IMSI}
     ${existing_json}    Replace String    ${existing_json}    KIREPLACE   ${SA_KI}
     ${existing_json}    Replace String    ${existing_json}    SKUREPLACE    ${SA_ICC_SKU}
     ${existing_json}    Replace String    ${existing_json}    RESOURCESTOCKREPLACE    ${SA_ICC_Stock}
     ${existing_json}    Replace String    ${existing_json}    ZONEREPLACE    ${SA_Zone}
     ${new_loader_json}    Replace String    ${existing_json}    RESOURCEBATCHREPLACE    ${SA_ICC_Batch}


     Log    ${new_loader_json}

     ${resp}    Post Request    Manageo    /api/sim-cards   data=${new_loader_json}
     Log    ${resp.status_code}
     Log    ${resp.content}

     Run Keyword Unless   ${resp.status_code} == 200 or ${resp.status_code} == 201 or ${resp.status_code} == 202 or ${resp.status_code} == 203 or ${resp.status_code} == 204   Fail    ErrorCode ${resp.content}
    [Return]   ${resp.content}


Reserve MSISDN

      Create Session    Reserve    ${SIT}:${BSS_Port}
      ${Headers}    Create Dictionary   Content-Type    application/vnd.api+json    authorisationFlag    N
      ${File}    Get Binary File    ../RobotTest/Sanity/TestData/BSSAPI/JSON/ReserveMSISDN

     ${existing_json}   OperatingSystem.Get File   ${ReserveMSISDN_JSON_FILE}
     ${existing_json}    Replace String    ${existing_json}    RESERVEDFORREPLACE    ${SA_Reserved_For}
     ${new_loader_json}    Replace String    ${existing_json}    RESOURCESTOCKREPLACE   ${SA_MSISDN_Stock}


     Log    ${new_loader_json}

     ${resp}    Post Request    Reserve    /api/msisdn-reservations-create   data=${new_loader_json}    params=None     headers=${Headers}
     Log    ${resp.status_code}
     Log    ${resp.content}

     Run Keyword Unless   ${resp.status_code} == 200 or ${resp.status_code} == 201 or ${resp.status_code} == 202 or ${resp.status_code} == 203 or ${resp.status_code} == 204   Fail    ErrorCode ${resp.content}
    [Return]   ${resp.content}


Patch SIM
     [Arguments]   ${ICC_ID}

      Create Session    SIMPATCH    ${ENV}:${BSS_Port}
      ${Headers}    Create Dictionary   Content-Type    application/vnd.api+json    authorisationFlag    N
      ${File}    Get Binary File    ../RobotTest/Sanity/TestData/BSSAPI/JSON/SIMPatch
     ${uri}     set variable    /api/sim-cards/ICCID

     ${existing_json}   OperatingSystem.Get File   ${SIM_PATCH_FILE}
     ${new_loader_json}    Replace String    ${existing_json}    REPLACEICCID    ${ICC_ID}
     ${uri}    Replace String    ${uri}    ICCID    ${ICC_ID}
     Log    ${new_loader_json}
     Log    ${uri}

     ${resp}    Patch Request    SIMPATCH    ${uri}   data=${new_loader_json}    params=None     headers=${Headers}
     Log    ${resp.status_code}
     Log    ${resp.content}

     Run Keyword Unless   ${resp.status_code} == 200 or ${resp.status_code} == 201 or ${resp.status_code} == 202 or ${resp.status_code} == 203 or ${resp.status_code} == 204   Fail    ErrorCode ${resp.content}
    [Return]   ${resp.content}

Patch MSISDN
     [Arguments]   ${MSISDN_ID}

      Create Session    MSISDNPATCH    ${ENV}:${BSS_Port}
      ${Headers}    Create Dictionary   Content-Type    application/vnd.api+json    authorisationFlag    N
      ${File}    Get Binary File    ../RobotTest/Sanity/TestData/BSSAPI/JSON/MSISDNPatch
     ${uri}     set variable    /api/msisdns/MSISDNREPLACE

     ${existing_json}   OperatingSystem.Get File   ${SIM_PATCH_FILE}
     ${new_loader_json}    Replace String    ${existing_json}    REPLACEMSISDN    ${MSISDN_ID}
     ${uri}    Replace String    ${uri}    MSISDNREPLACE    ${MSISDN_ID}
     Log    ${new_loader_json}
     Log    ${uri}

     ${resp}    Patch Request    MSISDNPATCH    ${uri}   data=${new_loader_json}    params=None     headers=${Headers}
     Log    ${resp.status_code}
     Log    ${resp.content}

     Run Keyword Unless   ${resp.status_code} == 200 or ${resp.status_code} == 201 or ${resp.status_code} == 202 or ${resp.status_code} == 203 or ${resp.status_code} == 204   Fail    ErrorCode ${resp.content}
    [Return]   ${resp.content}


