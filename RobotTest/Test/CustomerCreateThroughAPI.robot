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

*** Variables ***
${STALE_ELEMENT_SLEEP}    2s

${Customer_JSON_FILE}              ${CURDIR}/CustomerCreateJson
${output}
${Ind_UID}   158799c7-4545-48aa-86a2-e7f81e4f54c1


*** Test Cases ***
Test title
    [Tags]    DEBUG

    #Open Connection  jump2.qvantel.net
    #Login   rnavakoti   Prabhas@5
    #Wait Until Keyword Succeeds    3x    60s     Executing command

    Create Customer Through Json





*** Keywords ***

Create Customer Through Json
      Create Session    Manageo    http://api-rfc.tigo.net.bo:3010
      ${File}    Get Binary File    ${CURDIR}/CustomerCreateJson

     #${family_name}   Set Variable   Dexter
     #${family_name}    Generate Family Name
     #Log  ${family_name}
     #${Ind_UID}
     ${existing_json}   OperatingSystem.Get File   ${Customer_JSON_FILE}
     ${new_customer_json}    Replace String    ${existing_json}    INDIVIDUALUID    ${Ind_UID}
     Log    ${new_customer_json}
#${raw}   Get Json Value   ${resp.content}    /data/attributes/raw-message
#${referencenumber}  Get Json Value  ${raw}  /


    ${resp}    Post Request    Manageo    /api/customer-accounts-create   data=${new_customer_json}
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