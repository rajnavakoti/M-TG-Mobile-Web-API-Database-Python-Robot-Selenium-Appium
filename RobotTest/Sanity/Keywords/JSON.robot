*** Settings ***
Documentation    Suite description



*** Keywords ***
Post API Request
    [Arguments]  ${ENV}     ${Link}
    ${Headers}    Create Dictionary   Content-Type    application/vnd.api+json    authorisationFlag    N
    ${Creds}      Create List     admin       password

    Create Session    Manageo    ${ENV}    auth=${Creds}
    ${gresp}    Get Request    Manageo   ${Link}
    Log  Repsonse Code : ${gresp.status_code}
    Log   Response Content : ${gresp.content}
    Run Keyword Unless   ${gresp.status_code} == 200 or ${gresp.status_code} == 201 or ${gresp.status_code} == 202 or ${gresp.status_code} == 203 or ${gresp.status_code} == 204   Fail    ErrorCode ${gresp.content}
    [Return]   ${gresp.content}

Get ID From Respose
    [Arguments]  ${JSON_Response}
    ${Reference_ID}  Get Json Value  ${JSON_Response}   /id
    ${Reference_ID}  Evaluate    '${Reference_ID}'.strip('"')
    Log   ${Reference_ID}
    [Return]   ${Reference_ID}
    #Delete All Sessions

Get Reference ID From Respose
    [Arguments]  ${JSON_Response}
    ${Reference_Number}  Get Json Value  ${JSON_Response}   /referenceId
    ${Reference_Number}  Evaluate    '${Reference_Number}'.strip('"')
    Log   ${Reference_Number}
    [Return]   ${Reference_Number}




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
    [Arguments]    ${async_func}    ${duration}=60s    ${interval}=5s
    Wait Until Keyword Succeeds    ${duration}    ${interval}    Check Post Request Status Complete    ${async_func}


Check Post Request Status Complete
    [Arguments]    ${async_func}
    ${response}    Make Get Request To Get UID   ${async_func}
    ${lifecycle-status}    Get Json Value    ${response.content}    /data/attributes/lifecycle-status
    Should Be Equal As Strings    ${lifecycle-status}    "completed"
    Log To Console  ${lifecycle-status}



Executing command
   ${output}   Execute Command  echo Hello SSHLibrary!