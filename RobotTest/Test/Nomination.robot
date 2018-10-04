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
${path_excel}    C:/Test/Testing.xls
${Customer_JSON_FILE}              ${CURDIR}/NominationJson
${output}
${Ind_UID}   158799c7-4545-48aa-86a2-e7f81e4f54c1
#${headers}       Create Dictionary    Content-Type    application/vnd.api+json    authorisationFlag    N


*** Test Cases ***
Test title
    [Tags]    DEBUG

    #Open Connection  jump2.qvantel.net
    #Login   rnavakoti   Prabhas@5
    #Wait Until Keyword Succeeds    3x    60s     Executing command

    Nomination Through Json



*** Keywords ***

Nomination Through Json
      ${Headers}    Create Dictionary   Content-Type    application/vnd.api+json    authorisationFlag    N
      Log   ${Headers}
      Create Session    Manageo    http://52.16.101.192:3010
      ${File}    Get Binary File    ${CURDIR}/NominationJson

     #${family_name}   Set Variable   Dexter
     #${family_name}    Generate Family Name
     #Log  ${family_name}
     #${Ind_UID}

      Open Excel    ${path_excel}
      ${NOM_Reference_number}      Read Cell Data By Coordinates     Sheet1      7   1
      ${Customer_id}    Read Cell Data By Coordinates   Sheet1      1   1
      ${MSISDN}    Read Cell Data By Coordinates   Sheet1      2   1
      ${ICC_ID}    Read Cell Data By Coordinates   Sheet1      3   1
      ${Offer_ID}   Read Cell Data By Coordinates   Sheet1      4   1
      ${Reserved_for}   Read Cell Data By Coordinates   Sheet1      5   1
      ${Product_offering}   Read Cell Data By Coordinates   Sheet1      6   1
      ${Billing_ID}     Read Cell Data By Coordinates   Sheet1      8   1
      ${Individual_ID}     Read Cell Data By Coordinates   Sheet1      9   1

     ${existing_json}   OperatingSystem.Get File   ${Customer_JSON_FILE}

     ${NOM_Reference_number}    Convert To String   ${NOM_Reference_number}
     ${Customer_id}    Convert To String   ${Customer_id}
     ${MSISDN}    Convert To String   ${MSISDN}
     ${ICC_ID}    Convert To String   ${ICC_ID}
     ${Offer_ID}    Convert To String   ${Offer_ID}
     ${Reserved_for}     Convert To String   ${Reserved_for}
     ${Product_offering}    Convert To String   ${Product_offering}
     ${Billing_ID}      Convert To String   ${Billing_ID}
     ${Individual_ID}   Convert To String   ${Individual_ID}

     ${existing_json}    Replace String    ${existing_json}    NOMREFNUMBERTOCHANAGE       ${NOM_Reference_number}
     ${existing_json}    Replace String    ${existing_json}    CUSTUIDTOREPLACE      ${Customer_id}
     ${existing_json}    Replace String    ${existing_json}    MSISDNTOREPLACE      ${MSISDN}
     ${existing_json}    Replace String    ${existing_json}    ICCTOREPLACE     ${ICC_ID}
     ${existing_json}    Replace String    ${existing_json}    OFFERIDTOREPLACE     ${Offer_ID}
     ${existing_json}    Replace String    ${existing_json}    RESERVEFORTOREPLACE      ${Reserved_for}
     ${existing_json}    Replace String    ${existing_json}    BILLINGACCOUNTIDTOREPLACE      ${Billing_ID}
     ${existing_json}    Replace String    ${existing_json}    INDUIDTOREPLACE      ${Individual_ID}
     ${new_customer_json}    Replace String    ${existing_json}    PRODUCTOFFERTOREPLACE    ${Product_offering}
     Log    ${new_customer_json}


    Log     ${headers}
    ${resp}    Post Request    Manageo    /api/orders-create   data=${new_customer_json}    params=None     headers=${Headers}
    ${self_id}   Get Json Value   ${resp.content}    /data/links/self
    ${cust_func}   Evaluate   '${self_id}'.strip('"')
    Log  ${cust_func}
    ${async_func}    Evaluate    ${resp.headers}.get('Content-Location')
    ${gresp}  Poll Until Status Complete  ${async_func}
    ${json_conv}     Make Get Request To Get UID  ${async_func}
     ${t_uuid}  Get Json Value  ${json_conv.content}   /data/relationships/resource/data/id
     ${customer_id}    Evaluate    '${t_uuid}'.strip('"')
     Set Suite Variable  ${customer_id}
     Log  ${customer_id}

     ${json_convv}     Make Get Request To Get Billing ID   ${cust_func}
     #${json_convv}   Evaluate   '${json_convv.content}'.replace("[","")
     #${json_convv}   Evaluate   '${json_convv}'.replace("]","")
     Log  ${json_convv}
     ${billing_data}  Get Json Value  ${json_convv.content}   /data/relationships/billing-accounts/data
     ${billing_id}   Evaluate   '${billing_data}'.strip('[{"type": "billing-accounts", "id": "').strip('"}]')
     #${billing_uuid}   Evaluate   '${billing_data}'.strip(']')
     Log  ${billing_id}

     #Set Suite Variable   ${t_uuid}
     #Log  ${t_uuid}

     #${json_convv}     Make Get Request To Get UID  ${async_func}/process
     #${order_id_quoted}    Get Json Value    ${json_convv.content}    /data/attributes/external-id
     #${order_id}    Evaluate    '${order_id_quoted}'.strip('"')
     #Log to Console  ${order_id}
     Delete All Sessions


Make Get Request To Get UID
   [Documentation]  This request is to make a json Get request to fetch the created UID of customer
   [Arguments]  ${async_func}
    ${headers}    Create Dictionary    Content-Type=application/vnd.api+json    Accept=application/vnd.api+json
     ${gresp}    Get Request    Manageo    ${async_func}   headers=${headers}
      Log  ${gresp.status_code}
     [Return]    ${gresp}


Make Get Request To Get Billing ID
   [Documentation]  This request is to make a json Get request to fetch the created UID of customer
   [Arguments]  ${cust_func}
    ${headers}    Create Dictionary    Content-Type=application/vnd.api+json    Accept=application/vnd.api+json
     ${gresp}    Get Request    Manageo    ${cust_func}   headers=${headers}
      Log  ${gresp.status_code}
     [Return]    ${gresp}


Poll Until Status Complete
    [Documentation]    Polls URL retrieved from asysnc function until lifecycle-status = completed.
    ...                Uses WUKS to call Check Post Request Status Complete
    [Arguments]    ${async_func}    ${duration}=2m    ${interval}=5s
    Wait Until Keyword Succeeds    ${duration}    ${interval}    Check Post Request Status Complete    ${async_func}


Check Post Request Status Complete
    [Arguments]    ${async_func}
    ${response}    Make Get Request To Get UID   ${async_func}
    ${lifecycle-status}    Get Json Value    ${response.content}    /data/attributes/lifecycle-status
    Should Be Equal As Strings    ${lifecycle-status}    "completed"
    Log To Console  ${lifecycle-status}


Executing command
   ${output}   Execute Command  echo Hello SSHLibrary!