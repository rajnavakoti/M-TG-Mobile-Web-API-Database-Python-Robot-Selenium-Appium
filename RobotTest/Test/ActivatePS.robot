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
${API_String}   /api/specifications/PS_Block_Tigo_te_Presta/blockable-items
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

    ${Agreement_JV}     Get Value From Json      ${json_conv}    $..data[?(@.type == product-offerings)].id

    #${Agreement_ID}     Convert Json value to string    ${Agreement_JV}
    #Log    ${Agreement_ID}
    Log to Console      ${Agreement_JV}

    ${List}     Get Json Value      ${gresp.content}    /data
    ${Json_obj}     simplejson.dumps  ${List}
    ${Length}       Evaluate    len(${Json_obj})
    Log to console     ${Length}
    #Log to console  ${Json_obj}
    #${dtype}  Evaluate    type(${List})
    #Log to console  ${dtype}
    ${CH_Parent_ID}  Get Json Value  ${gresp.content}    /data/0/id
    ${CH_Parent_ID}   Evaluate    '${CH_Parent_ID}'.strip('"')
    Log     ${CH_Parent_ID}
    Log to console      ${CH_Parent_ID}

    #${Customer_Acc_JV}     Get Value From Json      ${json_conv}    $..included[?(@.type == customer-accounts)].id
    #${Customer_Acc_ID}     Convert Json value to string    ${Customer_Acc_JV}
    #Log    ${Customer_Acc_ID}

    #${Billing_JV}     Get Value From Json      ${json_conv}    $..included[?(@.type == billing-accounts)].id
    #${Billing_ID}     Convert Json value to string    ${Billing_JV}
    #Log    ${Billing_ID}

*** Keywords ***

Convert Json value to string
    [Documentation]  This request is to make a json Get request to fetch the created UID of customer
   [Arguments]  ${Json_Value}
    ${Json_string}  simplejson.dumps  ${Json_Value}
    ${Json_string}   Convert to string   ${Json_string}
    ${Json_string}     Evaluate    '${Json_string}'.strip('["')
    ${Json_string}     Evaluate    '${Json_string}'.strip('"]')
    ${Json}
    [Return]    ${Json_string}



    #${CH_Parent_ID}  Get Json Value  ${gresp.content}    /data/0/relationships/realized-product/data/id
    #${CH_Parent_ID}   Evaluate    '${CH_Parent_ID}'.strip('"')
    #Log     ${CH_Parent_ID}

    #${CH_Inv_ID}    Get Json Value  ${gresp.content}    /data/0/id
    #${CH_Inv_ID}   Evaluate    '${CH_Inv_ID}'.strip('"')
    #Log    ${CH_Inv_ID}





