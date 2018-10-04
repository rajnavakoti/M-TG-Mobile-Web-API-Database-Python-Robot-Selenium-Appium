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
Resource  Testing.json
Library   SSHLibrary



*** Test Cases ***
First Test Case
    [Tags]    Api Test


    #call method    ForJson    test junk

    #${File_send}   Get Binary File    ${CURDIR}/Testing
    #Datachange.Test Junk
    #Log to Console  ${py_op}
    #${F_value}  call method   ForJosn.test_junk
    #Modify Json
    Create Session    Manageo    http://api-rfc.tigo.net.bo:3010
    ${File}    Get Binary File    ${CURDIR}/samplejs
    Log to Console  ${File}
    ${json_obj}  Update value To Json  ${File}   $..included.attributes.given-name  Test name
    ${new_obj}   Convert Json to String  ${json_obj}
    Log to Console  ${new_obj}
    #Create File  ${CURDIR}/samplejs  ${new_obj}  UTF-8
    ${resp}    Post Request    Manageo    /api/individuals-create    data=${File}
    Log  ${resp}
    Log To Console  ${resp}
    Log  ${resp.text}
    ${async_func}    Evaluate    ${resp.headers}.get('Content-Location')
    Log To Console  ${async_func}
    ${gresp}  Poll Until Status Complete  ${async_func}
    ${json_conv}     Make Get Request To Get UID  ${async_func}
     ${t_uuid}  Get Json Value  ${json_conv.content}   /data/relationships/resource/data/id
     Log to Console  ${t_uuid}
     ${json_convv}     Make Get Request To Get UID  ${async_func}/process
      ${order_id_quoted}    Get Json Value    ${json_convv.content}    /data/attributes/external-id
    ${order_id}    Evaluate    '${order_id_quoted}'.strip('"')
    Log to Console  ${order_id}
    #${UID}  Get Value From Json  ${json_conv.content}  $..data.attributes.lifecycle-status
    #Log To Console  ${t_uuid}
    #Log To Console  ${UID}

*** Keywords ***

Make Get Request To Get UID
   [Documentation]  This request is to make a json Get request to fetch the created UID of customer
   [Arguments]  ${async_func}
    ${headers}    Create Dictionary    Content-Type=application/vnd.api+json    Accept=application/vnd.api+json
     #${gresp}    Get Request    Manageo    ${async_func}   headers=${headers}
     ${gresp}    Get Request    Manageo    ${async_func}   headers=${headers}
      Log  ${gresp.status_code}
     #${json_conv}  To Json  ${gresp.text}
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

Modify Json
    ${py_op}   test junk


