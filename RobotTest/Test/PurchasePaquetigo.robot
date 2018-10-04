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

*** Variables ***
${STALE_ELEMENT_SLEEP}    2s
#${path_excel}    C:/Test/Testing.xls
${Customer_JSON_FILE}              ${CURDIR}/PreactivationJson
${path_excel}    C:/Test/CBA.xls
${Ind_UID}   158799c7-4545-48aa-86a2-e7f81e4f54c1
#${headers}       Create Dictionary    Content-Type    application/vnd.api+json    authorisationFlag    N
#${link}     /ussd/purchasePaquetigo?msisdn=59175548038&salesCode=168&channelId=USSD_555
${linkone}     /ussd/purchasePaquetigo?msisdn=
${linktwo}      &salesCode=
${linkthree}    &channelId=
${auth}     admin



*** Test Cases ***
Test title
    [Tags]    DEBUG

    #Open Connection  jump2.qvantel.net
    #Login   rnavakoti   Prabhas@5
    #Wait Until Keyword Succeeds    3x    60s     Executing command

    Purchase Paquetigo Through CBA



*** Keywords ***

Purchase Paquetigo Through CBA

      Open Excel    ${path_excel}
      ${MSISDN}      Read Cell Data By Coordinates     Sheet1      0   1
      ${Sales_Code}    Read Cell Data By Coordinates   Sheet1      1   1
      ${Channel_Id}    Read Cell Data By Coordinates   Sheet1      2   1

      ${MSISDN}    Convert To String   ${MSISDN}
      ${Sales_Code}    Convert To String   ${Sales_Code}
      ${Channel_Id}    Convert To String   ${Channel_Id}

      Log   ${MSISDN}
      Log   ${Sales_Code}
      Log   ${Channel_Id}

      ${link}   Set Variable    ${linkone}${MSISDN}${linktwo}${Sales_Code}${linkthree}${Channel_Id}

      ${Headers}    Create Dictionary   Content-Type    application/vnd.api+json    authorisationFlag    N
      ${Creds}      Create List     admin       password
      Log   ${Headers}
      Log   ${Creds}
      Create Session    Manageo    http://localhost:8381    auth=${Creds}
      ${gresp}    Get Request    Manageo   ${link}
      Log  ${gresp.status_code}
      Log   ${gresp.content}
      ${ExpiryDate}  Get Json Value  ${gresp.content}   /expiryDate
      ${supplementaryProductOrderInitiation}    Get Json Value    ${gresp.content}    /supplementaryProductOrderInitiation
      ${id}     Get Value From Json     ${gresp.content}    $..data[0].id
      ${id}   Evaluate   '${id}'.strip('"')
      Log   ${ExpiryDate}
      Log   ${supplementaryProductOrderInitiation}
      Log   ${id}
      #Close session

      Put String To Cell    Sheet1  3   1   ${id}
      Save Excel    ${path_excel}

      Create Session    Apiquery    http://localhost:3010    auth=${Creds}
      ${grepp}   Get Request    ApiQuery     /api/async-functions/${id}
      Log   ${grepp.content}