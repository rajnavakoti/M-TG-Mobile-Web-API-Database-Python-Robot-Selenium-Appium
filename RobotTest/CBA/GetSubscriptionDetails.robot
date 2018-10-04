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
${path_excel}    C\Test\CBA.xls
${Sheetname}    CBA
#${headers}       Create Dictionary    Content-Type    application/vnd.api+json    authorisationFlag    N
#${link}     /ussd/purchasePaquetigo?msisdn=59175548038&salesCode=168&channelId=USSD_555
${apirow}   1
${SITuri}      http://localhost:8381
${apilink}     /ussd/getIccidByMsisdn?msisdn=RMSISDN&channelId=RCHANNELID&sellerId=RSELLERID
${Creds}      Create List     admin       password



*** Test Cases ***
Test title
    [Tags]    DEBUG
     Read Excel  ${path_excel}
     Get Value From Excel   ${apirow}   ${Sheetname}



*** Keywords ***

Get ICCID By MSISDN

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
      ${id}     Get Json Value     ${gresp.content}    /id
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


Read Excel
  [Arguments]  ${path_excel}
  Open Excel Document  ${path_excel}  doc_1
  ${Customer_id}    Read Excel Cell  1  1  Sheet1
  Close All Excel Documents
  [Return]  ${Customer_id}

Write Excel
  [Arguments]  ${path_excel}  ${value}
  Open Excel Document  ${path_excel}  doc_1
  Write Excel Cell  4  4  ${value}  Sheet1
  Save Excel Document  ${path_excel}
  Close All Excel Documents