*** Settings ***
Documentation    Suite description
Library  Selenium2Library
Library  JSONLibrary
Library  RequestsLibrary
Library  OperatingSystem
Library  Collections
Library  simplejson
Library  String



*** Test Cases ***
Test title
First Test Case
    [Tags]    DEBUG

    #Open Browser    http://csr-rfc.tigo.net.bo:7500/loginForm    Chrome
    #Input Text    xpath://*[@id='username']    rnavakoti
    #Input Text    xpath://*[@id='password']    Prabhas@5
    #Click Element    xpath://*[@id='w-app-body']/div/div/section/div/div/div/form/fieldset/div[3]/div/button
    #Wait Until Element Is Visible    xpath://*[@id='w-app-actions']/button[1]
    #Click Element    xpath://*[@id='w-app-actions']/button[1]
    #Wait Until Element Is Visible    xpath://*[@id='language-select-link-en']
    #Click Element    xpath://*[@id='language-select-link-en']
    #Wait Until Page Contains Element    xpath://*[@id='w-app-search']/div/div[1]/button
    #Click Element    xpath://*[@id='w-app-search']/div/div[1]/button
    #Wait Until Element Is Visible    xpath://*[@id='passport']
    #Click Element    xpath://*[@id='passport']
    #Input Text    xpath://*[@id='w-app-search']/div/input    TestRR1-1029744999
    #Click Element    xpath://*[@id='w-app-search']/div/div[2]/button



    Create Session    Manageo    http://api-rfc.tigo.net.bo:3010
    ${File}    Get Binary File    ${CURDIR}/samplejs
    ${resp}    Post Request    Manageo    /api/individuals-create    data=${File}
    Log  ${resp}
    Log To Console  ${resp}
    #Log  ${resp.json()}
    Log  ${resp.text}

    #Log To Console  ${resp.json()}
    #${json_conv}  To Json  ${resp.text}
    #Log  ${json_conv}
    #${json_j_conv}    simplejson.Loads    ${resp.text}
    #Log  ${json_j_conv}
    #${Jvalue_q}  Get Value From Json  ${json_conv}  $..data.links.related
    #${Jvalue}  Evaluate  '${Jvalue_q}'.strip('"')
    #Log  ${Jvalue}
    ${async_func}    Evaluate    ${resp.headers}.get('Content-Location')
    Log To Console  ${async_func}
    ${UID}  Make Get Request To Get UID  ${async_func}
    Log To Console  ${UID}
    #${headers}    Create Dictionary    Content-Type=application/vnd.api+json    Accept=application/vnd.api+json
     #${gresp}    Get Request    Manageo    ${async_func}   headers=${headers}
     #${gresp}    Get Request    Manageo    /api/async-functions/63714   headers=${headers}

     #Log  ${gresp.status_code}
     #${json_conv}  To Json  ${gresp.text}
     #Log to Console  ${json_conv}
     #Log to console  ${gresp.json()}
     #Log To Console  ${gresp.text}
     #Log To Console  ${gresp.content}
     #Log to Console  ${json_conv}
     #Log To Console  ${gresp.json()}

     #${t_uuid}  Get Value From Json  ${json_conv}   $..data.relationships.resource.data.id
     #${Lifecycle}  Get Value From Json  ${json_conv}  $..data.attributes.lifecycle-status
     #${t_uuid_o}  Get Value From Json  ${gresp.json}    $..data.relationships.resource.data.id
     #${t_uuid_t}  Get Value From Json  ${gresp.text}    $..data.relationships.resource.data.id
     #${t_uuid_te}  Get Value From Json  ${gresp.content}   $..data.relationships.resource.data.id
      #Log To Console  ${t_uuid}
      #Log To Console  ${Lifecycle}
      #Log To Console  ${t_uuid_o}
      #Log To Console  ${t_uuid_t}
      #Log To Console  ${t_uuid_te}
    #${stripped}  Evaluate  ${t_uuid}
    #Log To Console  ${stripped}

    #Open Browser    http://csr-rfc.tigo.net.bo:7500/loginForm    Chrome
    #Input Text    xpath://*[@id='username']    ${t_uuid}
    #Input Text    xpath://*[@id='password']    Prabhas@5




      #${test}  Get Json Value  ${gresp.content}   /data/id
      #Log to Console    ${test}


     #${uuid_quoted}    Get Json Value    ${gresp.content}    /data/id
    #${uuid}    Evaluate    '${uuid_quoted}'.strip('"')




    #${Json_j_conv_again}  To Json  ${Jvalue}

    #${disc_val}  Get From Dictionary  ${disc}  reference-number
    #Log  ${disc_val}
    #Log  ${disc}
    #Log  ${JValue}
    #Log To Console  ${Jvalue}
    #Log To Console  ${Json_j_conv_again}
    #${Jvalue_str}  Convert To String  ${Jvalue}
    #${Json_j_conv_again}  simplejson.Loads  ${Jvalue}
    #Log  ${json_j_conv_again}


    #${dtype}  Evaluate    type(${Jvalue})
    #${str}  Catenate  ${Jvalue}
    #${str_cts}  Convert To String  ${Jvalue}
    #${dstype}  Evaluate  type(${str})
    #${str_cts_type} Evaluate  ${str_cts}
    #Log  ${dtype}
    #Log  ${dstype}
    #Log  ${str_cts_type}


    #${json_again}  To Json  ${str_cts}
    #Log To Console  ${json_again}

    #Log  ${Jvalue}
    #Log To Console  ${Jvalue}

    #Log  ${json_j_conv['lifecycle-status']}
    #${Jvalue}  Get Value From Json  ${json_conv}  $..raw-message
    #Dictionary Should Contain Value  ${json_j_conv}  accepted
    #Dictionary Should Contain Value  ${json_conv}  Pavan Kumar
    #${Jsvalue}  Get Value From Json  ${resp.json()}  $..CH_ISR_identification_id
    #${Jvalue}  Get Value From Json  ${json_conv}  $..raw-message
    #Log  ${Jvalue}
    #Log  ${Jsvalue}
    #Log To Console  ${Jvalue}
    #Dictionary Should Contain Value	  ${resp.text}  Pavan Kumar
    #Log To Console  ${vars.lifecycle-status}



    #Log To Console  ${json_obj}



*** Keywords ***

Make Get Request To Get UID
   [Documentation]  This request is to make a json Get request to fetch the created UID of customer
   [Arguments]  ${async_func}
    ${headers}    Create Dictionary    Content-Type=application/vnd.api+json    Accept=application/vnd.api+json
     #${gresp}    Get Request    Manageo    ${async_func}   headers=${headers}
     ${gresp}    Get Request    Manageo    ${async_func}   headers=${headers}
      Log  ${gresp.status_code}
     ${json_conv}  To Json  ${gresp.text}
     ${Lifecycle}  Get Value From Json  ${json_conv}  $..data.attributes.lifecycle-status
     Run Keyword If     'in-progress' in @{Lifecycle}    Make Get Request To Get UID   ${async_func}
      #Run Keyword If     ${Lifecycle} == u'in-progress'    Make Get Request To Get UID   ${async_func}
     Log to Console  ${Lifecycle}
     Log To Console  ${json_conv}
      ${t_uuid}  Get Value From Json  ${json_conv}   $..data.relationships.resource.data.id
      Log To Console  ${t_uuid}
     [Return]  ${t_uuid}

      #Log     ${Agreement_ID}   ${Customer_Acc_ID}   ${Billing_ID}  ${CH_Parent_ID}   ${CH_Inv_ID}
     #Log to Console    ${CH_Parent_ID}
    #Log to Console     ${CH_Inv_ID}
    #Log to Console     ${Billing_ID}
    #Log to Console     ${Agreement_ID}
    #Log to Console     ${Customer_Acc_ID}

    ##${Type}     Evaluate    type(${Test})
    ##Log to console    ${Test}
    ##Log to console      ${Type}
    #${Test_conv}    Convert to string   ${Test}
    ##${Test_conv}  simplejson.dumps  ${Test}
    ##${Type_conv}     Evaluate    type(${Test_conv})
    ##Log to console    ${Test_conv}
    ##Log to console      ${Type_conv}
    ##${Test_convv}   Convert to string   ${Test_conv}
    ##${Type_convv}     Evaluate    '${Test_convv}'.strip('["')
    ##${Type_convv}     Evaluate    '${Type_convv}'.strip('"]')
    ##Log to console    ${Test_convv}
    ##Log to console      ${Type_convv}
    #${CH_Parent_ID}  Get Json Value  ${gresp.content}    /data/0/relationships/realized-product/data/id
    #${CH_Parent_ID}   Evaluate    '${CH_Parent_ID}'.strip('"')
    #${CH_Inv_ID}    Get Json Value  ${gresp.content}    /data/0/id
    #${CH_Inv_ID}   Evaluate    '${CH_Inv_ID}'.strip('"')
    #${Billing_ID}    Get Json Value  ${gresp.content}   /included/0/relationships/billing-accounts/data/id
    #${Billing_ID}   Evaluate    '${Billing_ID}'.strip('"')
    #${Agreement_ID}  Get Json Value  ${gresp.content}    /included/9/attributes/reference-id
    #${Agreement_ID}   Evaluate    '${Agreement_ID}'.strip('"')
    #${Customer_Acc_ID}   Get Json Value  ${gresp.content}   /included/11/relationships/target/data/id
    #${Customer_Acc_ID}   Evaluate    '${Customer_Acc_ID}'.strip('"')
    #Log to Console    ${CH_Parent_ID}
    #Log to Console     ${CH_Inv_ID}
    #Log to Console     ${Billing_ID}
    #Log to Console     ${Agreement_ID}
    #Log to Console     ${Customer_Acc_ID}

      #${CH_Inv_JV}     Get Value From Json      ${json_conv}    $..data.
    #${CH_Inv_ID}     Convert Json value to string    ${CH_Inv_JV}
    #Log    ${CH_Inv_ID}

    #${CH_Parent_JV}     Get Value From Json      ${json_conv}    $..data.relationships.realized-product.data.id
    #${CH_Parent_ID}     Convert Json value to string    ${CH_Parent_JV}
    #Log    ${CH_Parent_ID}
