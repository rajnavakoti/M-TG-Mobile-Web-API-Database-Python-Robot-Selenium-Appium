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


*** Variables ***
${STALE_ELEMENT_SLEEP}    2s

${INDIVIDUAL_JSON_FILE}              ${CURDIR}/samplejs


*** Test Cases ***
Test title
    [Tags]    DEBUG
    Open Connection  rc11vm054
    Login   rnavakoti    Prabhas@5
    Create Session    Manageo    http://api-rfc.tigo.net.bo:3010
    ${File}    Get Binary File    ${CURDIR}/samplejs

    ${family_name}   Set Variable   Dexter
    ${existing_json}   OperatingSystem.Get File   ${INDIVIDUAL_JSON_FILE}
    ${new_individual_json}    Replace String    ${existing_json}    FAMILYNAMETOREPLACE    ${family_name}
    Log    ${new_individual_json}

     ${random_name}    Generate Family Name
     Log  ${random_name}

    ${resp}    Post Request    Manageo    /api/individuals-create    data=${new_individual_json}
    ${async_func}    Evaluate    ${resp.headers}.get('Content-Location')
    ${gresp}  Poll Until Status Complete  ${async_func}
    ${json_conv}     Make Get Request To Get UID  ${async_func}
     ${t_uuid}  Get Json Value  ${json_conv.content}   /data/relationships/resource/data/id
     Log to Console  ${t_uuid}
     #${json_convv}     Make Get Request To Get UID  ${async_func}/process
     #${order_id_quoted}    Get Json Value    ${json_convv.content}    /data/attributes/external-id
     #${order_id}    Evaluate    '${order_id_quoted}'.strip('"')
     #Log to Console  ${order_id}


*** Keywords ***

Make Get Request To Get UID
   [Documentation]  This request is to make a json Get request to fetch the created UID of customer
   [Arguments]  ${async_func}
    ${headers}    Create Dictionary    Content-Type=application/vnd.api+json    Accept=application/vnd.api+json
     ${gresp}    Get Request    Manageo    ${async_func}   headers=${headers}
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