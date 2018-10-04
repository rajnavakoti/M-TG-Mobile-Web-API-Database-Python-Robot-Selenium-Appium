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

${UnregisterDevice_JSON_FILE}              ${CURDIR}/UnregisterDevice
${output}
${Ind_UID}   158799c7-4545-48aa-86a2-e7f81e4f54c1
${API_String}   /api/resources?filter=(AND%20(EQ%20primary-id%20"441613570660644")(EQ%20resource-type%20"device"))&include=realized-product.agreement-item.agreement.customer-account.external-references,realized-product.related-billing-accounts.billing-account.external-references

${Reference_Number}   UnregisterDevice_Automation_25

*** Test Cases ***
Test title
    [Tags]    DEBUG


    Create Session    Manageo    http://localhost:3010
    ${headers}    Create Dictionary    Content-Type=application/vnd.api+json    Accept=application/vnd.api+json
    ${gresp}    Get Request    Manageo    ${API_String}  headers=${headers}
    Log  ${gresp.status_code}
    Log   ${gresp.content}
    ${json_conv}  To Json  ${gresp.text}

    ${Agreement_JV}     Get Value From Json      ${json_conv}    $..included[?(@.type == agreements)].id
    ${Agreement_ID}     Convert Json value to string    ${Agreement_JV}
    Log    ${Agreement_ID}

    ${Customer_Acc_JV}     Get Value From Json      ${json_conv}    $..included[?(@.type == customer-accounts)].id
    ${Customer_Acc_ID}     Convert Json value to string    ${Customer_Acc_JV}
    Log    ${Customer_Acc_ID}

    ${Billing_JV}     Get Value From Json      ${json_conv}    $..included[?(@.type == billing-accounts)].id
    ${Billing_ID}     Convert Json value to string    ${Billing_JV}
    Log    ${Billing_ID}



    ${CH_Parent_ID}  Get Json Value  ${gresp.content}    /data/0/relationships/realized-product/data/id
    ${CH_Parent_ID}   Evaluate    '${CH_Parent_ID}'.strip('"')
    Log     ${CH_Parent_ID}

    ${CH_Inv_ID}    Get Json Value  ${gresp.content}    /data/0/id
    ${CH_Inv_ID}   Evaluate    '${CH_Inv_ID}'.strip('"')
    Log    ${CH_Inv_ID}



    ${existing_json}   OperatingSystem.Get File   ${UnregisterDevice_JSON_FILE}


    ${existing_json}   OperatingSystem.Get File   ${UnregisterDevice_JSON_FILE}
    ${existing_json}   Replace String    ${existing_json}    REFNUMBERTOBEREPLACED    ${Reference_Number}
    ${existing_json}   Replace String    ${existing_json}    CUSTACCOUNTTOBEREPLACED    ${Customer_Acc_ID}
    ${existing_json}   Replace String    ${existing_json}    TARGETAGGIDTOBEREPLACED    ${Agreement_ID}
    ${existing_json}   Replace String    ${existing_json}    BILLINGACCOUNTTOBEREPLACED    ${Billing_ID}
    ${existing_json}   Replace String    ${existing_json}    CHPARENTIDTOBEREPLACED    ${CH_Parent_ID}
    ${new_Unregister_json}   Replace String    ${existing_json}    CHINVENTORYIDTOBEREPLACED    ${CH_Inv_ID}

    #Log    ${new_Unregister_json}

    ${resp}    Post Request    Manageo    /api/orders-create   data=${new_Unregister_json}    params=None     headers=${Headers}
    ${self_id}   Get Json Value   ${resp.content}    /data/links/self
    ${cust_func}   Evaluate   '${self_id}'.strip('"')
    Log  ${cust_func}
    ${async_func}    Evaluate    ${resp.headers}.get('Content-Location')
    ${gresp}  Poll Until Status Complete  ${async_func}


*** Keywords ***

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

Make Get Request To Get UID
   [Documentation]  This request is to make a json Get request to fetch the created UID of customer
   [Arguments]  ${async_func}
    ${headers}    Create Dictionary    Content-Type=application/vnd.api+json    Accept=application/vnd.api+json
    ${gresp}    Get Request    Manageo    ${async_func}   headers=${headers}
    Log  ${gresp.status_code}
    [Return]    ${gresp}

Convert Json value to string
    [Documentation]  This request is to make a json Get request to fetch the created UID of customer
   [Arguments]  ${Json_Value}
    ${Json_string}  simplejson.dumps  ${Json_Value}
    ${Json_string}   Convert to string   ${Json_string}
    ${Json_string}     Evaluate    '${Json_string}'.strip('["')
    ${Json_string}     Evaluate    '${Json_string}'.strip('"]')
    [Return]    ${Json_string}


