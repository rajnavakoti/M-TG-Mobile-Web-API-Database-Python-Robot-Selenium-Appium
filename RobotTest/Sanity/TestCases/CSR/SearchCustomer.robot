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
Library  BuiltIn
Library  SSHLibrary
#Library  AppiumLibrary
Library  ExcelLibrary
Library  Screenshot

*** Variables ***
### Env/General Variables ###
${STALE_ELEMENT_SLEEP}    2s
${path_excel}    C:/Test/CBA.xlsx
${Sheetname}    CBA
${URL}   http://10.150.34.184:8092/casemanager/sa/cases

### Object Rep ###


*** Keywords ***

Search Customer Through MSISDN

       Open Excel Document     ${path_excel}  doc_3
      ${MSISDN}     Read Excel Cell  2  7  ActivateNewCustomer

      ### Converting Data variables to String ###
      ${MSISDN}     Convert To String   ${MSISDN}

       Open Browser   http://10.150.34.184:7500/loginForm    chrome
       Maximize Browser Window
       Wait Until Element Is Visible    xpath://*[@id='username']   timeout=5   error=ElementNotVisible
       Input Text    xpath://*[@id='username']    csr
       Wait Until Element Is Visible    xpath://*[@id='password']   timeout=5   error=ElementNotVisible
       Input Text    xpath://*[@id='password']    csr
       Wait Until Element Is Visible    xpath://*[@id='kc-login']   timeout=5   error=ElementNotVisible
       Click Element    xpath://*[@id='kc-login']
       Wait Until Element Is Visible    xpath://*[@class='btn btn-default dropdown-toggle ng-binding']   timeout=5   error=ElementNotVisible
       Click Element    xpath://*[@class='btn btn-default dropdown-toggle ng-binding']
       Wait Until Element Is Visible    xpath://*[@id='msisdn']   timeout=5   error=ElementNotVisible
       Click Element    xpath://*[@id='msisdn']
       Wait Until Element Is Visible    xpath://*[@name='query']   timeout=5   error=ElementNotVisible
       Input Text    xpath://*[@name='query']   ${MSISDN}
       Wait Until Element Is Visible    xpath://*[@name='submit-search']   timeout=5   error=ElementNotVisible
       Click Element    xpath://*[@name='submit-search']
       Wait Until Element Is Visible    xpath://div[1]//div/div[1]//main//section//section//ui-view//div//div//div[1]//span[2]  timeout=5   error=ElementNotVisible
       Capture Page Screenshot  TestOne.png
       Take Screenshot
       Wait Until Element Is Visible    xpath://div[1]//div//div[1]//nav//ul//li[1]//a//i
       Click Element    xpath://div[1]//div//div[1]//nav//ul//li[1]//a//i
       Capture Page Screenshot  TestTwo.png
       Take Screenshot

Create Customer case
       Wait Until Element Is Visible    xpath://div[1]//div//div[1]//div//async-load//div//csr-loaded-data//div//ng-transclude//ng-transclude//div//div[2]//a   timeout=5   error=ElementNotVisible
       Click Element    xpath://div[1]//div//div[1]//div//async-load//div//csr-loaded-data//div//ng-transclude//ng-transclude//div//div[2]//a



Click on Element
       [Arguments]  ${Element_Name}  ${Element_Path}
       Wait Until Element Is Visible    ${Element_Path}   timeout=20   error=${Element_Name}NotVisible
       Click Element    ${Element_Path}

Enter Value
       [Arguments]  ${Element_Name}  ${Element_Path}   ${Input}
       Wait Until Element Is Visible    ${Element_Path}   timeout=20   error=${Element_Name}NotVisible
       Clear Element Text   ${Element_Path}
       Sleep    1s
       Input Text    ${Element_Path}  ${Input}

Get Element Value
       [Arguments]  ${Element_Name}  ${Element_Path}
       Wait Until Element Is Visible    ${Element_Path}   timeout=20   error=${Element_Name}NotVisible
       ${Element_Value}   Get Text    ${Element_Path}
       Sleep    1s
       #${Case_iD}   Set Suite Variable   ${Case_iD}
       [Return]  ${Element_Value}
       Log  ${Element_Name}:${Element_Value}
