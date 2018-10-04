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
Resource    CSR.robot


*** Variables ***
### Env/General Variables ###
${CM_STALE_ELEMENT_SLEEP}    2s
${CM_path_excel}    C:/Test/CBA.xlsx
${CM_Sheetname}    CBA
${CM_URL}   http://csr-rfc.tigo.net.bo:8092/casemanager/sa/cases


### Object Rep ###
${CM_User_ID}    xpath://*[@id='username']
${CM_Password}  xpath://*[@id='password']
${CM_LogIn_Button}  xpath://*[@id='kc-login']
${CM_Create_Case_Button}   xpath://*[@id="w-app-facet-front"]//div[1]//ul[2]
${CM_Categeory_Drop_Down}  xpath://*[@id="w-app-body"]//section[1]//div[1]//form[1]//div[1]//div[1]//div[4]//div[1]//div[1]//span[1]//div[1]//div[1]//div[1]//span[2]
${CM_Selected_Categeory_Customer}   xpath://*[@id="react-select-3--list"]/div[1]/div[1]/div[1]/div[5]
${CM_Selected_Categeory}   xpath://*[@id="react-select-2--list"]//div[1]//div[1]//div[1]//div[5]
${CM_Heading}  xpath://*[@id="heading"]
${CM_Description}  xpath://*[@id="description"]
${CM_City_Dropdown}    xpath://*[@id="additionalFields.CITY"]
${CM_Selected_City}    xpath://*[@id="additionalFields.CITY"]//option[1]
${CM_Create_Button}    xpath://*[@id="create"]
${CM_Case_ID_Heading}     xpath://*[@id="idValue"]/h2[1]
${CM_Case_Search_Dropdown}     xpath://*[@id="searchBy_input"]//div[1]//span[1]//button[1]
${CM_Selected_Search}      xpath://*[@id="searchBy_listbox"]//li[3]
${CM_Search_Icon}      xpath://*[@id="w-app-header"]//div[2]//form[1]//span[1]//div[2]//span[1]//span[1]//button[1]
${CM_CSR_Cases_Tab}    xpath://*[@id="w-app-facet-front"]/nav[1]/ul[1]/li[6]/a[1]
${CM_CSR_Create_Case}    xpath://*[@id="w-app-facet-front"]/div[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[1]/div[2]/a[1]
${CM_CSR_Categeory_Drop_Down}  class:Select-arrow-zone
${CM_Link_Customer_Link}   xpath://*[@id="w-app-body"]/section[1]/div[1]/form[1]/div[1]/div[1]/div[3]/div[2]/table[1]/tbody[1]/div[1]/td[2]/a[1]
${CM_Link_TextBox}     xpath://*[@id="searchInput"]
${CM_Link_Search_Icon}      xpath://*[@id="w-app-body"]/section[1]/div[1]/form[1]/div[1]/div[1]/div[3]/div[2]/table[1]/tbody[1]/tr[1]/td[1]/div[1]/span[1]/i[1]
${CM_Link_Search_RButton}   xpath://*[@id="0"]
${CM_Link_button}      xpath://*[@id="link"]
${CM_CaseID_Link_CaseBrowser}      xpath://*[@id="w-app-body"]/div[1]/section[1]/div[1]/div[1]/div[2]/div[2]/table[1]/tbody[1]/tr[1]/td[6]/div[1]/a[1]
${CM_Escalate_Button}      xpath://*[@id="escalate"]
${CM_Piority}      xpath://*[@id="priorityValue"]/div[1]/span[1]
${PopUp_window}     xpath://body//div[2]/div[2]/div[1]



### Data Rep ###
${CM_Password_Value}  csr
${CM_User_ID_Value}   csr
${CM_Heading_Value}    Test Heading
${CM_Description_Value}    Test Description
${CM_Search_Value}     xpath://*[@id="searchText"]
${CM_MSISDN_Value}     59169412607
${CM_Case_ID}      7YB3-EE4Z

*** Test Cases ***

Test Execute
   Log In to Case Management    ${CM_URL}
   #Create Global Case
   Create Customer Case     ${CM_MSISDN_Value}
   #Escalate Case    ${CM_Case_ID}
   Close Browser
   #Create Case
   #Search Case
   #Create Case CSR


*** Keywords ***

Create Global Case
       ### Create Case ###
       Click on Element  CreateCaseButton   ${CM_Create_Case_Button}
       Click on Element  CategeoryDropdownButton    ${CM_Categeory_Drop_Down}
       Click on Element  SelectedCategeory      ${CM_Selected_Categeory}
       Sleep    1s
       Enter Value  HeadingText     ${CM_Heading}  ${CM_Heading_Value}
       Sleep    1s
       Enter Value  Description     ${CM_Description}  ${CM_Description_Value}
       Click on Element  CityDropdown   ${CM_City_Dropdown}
       Select From List    ${CM_City_Dropdown}  Santa Cruz
       #Click on Element  SelectedCity   ${CM_Selected_City}
       Capture Page Screenshot  CaseCreationScreen.png
       Click on Element  CreateCase     ${CM_Create_Button}
       ${CM_Global_Case_ID}  Get Element Value    GlobalCaseID      ${CM_Case_ID_Heading}
       #Set Suite Variable  ${Global_Case_ID}  ${Case_ID}
       Capture Page Screenshot  CreatedCase.png
       Search Case  ${CM_Global_Case_ID}


Create Customer Case
       [Arguments]   ${CM_MSISDN_Value}
       Click on Element  CreateCaseButton   ${CM_Create_Case_Button}
       Click on Element     LinkCustomer    ${CM_Link_Customer_Link}
       Enter Value    LinkTextBox     ${CM_Link_TextBox}   ${CM_MSISDN_Value}
       Click on Element     SearchIcon      ${CM_Link_Search_Icon}
       Click on Element     SearchRButton   ${CM_Link_Search_RButton}
       Click on Element     LinkButton      ${CM_Link_button}
       Click on Element     CategeoryDropdown   xpath://*[@id="categorypopup"]
       Sleep    5s
       #Select From List     xpath://div[2]/div[2]/div[1]/div[1]/div[2]/form[1]/fieldset[1]/div[1]/div[1]/select[1]      PREPAGO (7)
       #Click on Element     Testing    xpath://div[2]/div[2]/div[1]/div[1]/div[2]/form[1]/fieldset[1]/div[1]/div[1]/select[1]
       #Log to Console   ${Testing}
       #Select Window    xpath://div[2]//div[2]//div[1]
       #Wait Until Element Is Visible     xpath://div[2]//div[2]//div[1]
       Wait Until Element Is Visible     xpath://div[2]/div[2]/div[1]/div[1]/div[2]/form[1]/fieldset[1]/div[1]/div[1]/select[1]
       Select From List    xpath://div[2]/div[2]/div[1]/div[1]/div[2]/form[1]/fieldset[1]/div[1]/div[1]/select[1]  PREPAGO (7)
       Wait Until Element Is Visible     xpath://div[2]/div[2]/div[1]/div[1]/div[2]/form[1]/fieldset[1]/div[2]/div[1]/select[1]
       Select From List     xpath://div[2]/div[2]/div[1]/div[1]/div[2]/form[1]/fieldset[1]/div[2]/div[1]/select[1]    RED (3)
       Wait Until Element Is Visible     xpath://div[2]/div[2]/div[1]/div[1]/div[2]/form[1]/fieldset[1]/div[3]/div[1]/select[1]
       Select From List     xpath://div[2]/div[2]/div[1]/div[1]/div[2]/form[1]/fieldset[1]/div[3]/div[1]/select[1]    PROBLEMAS DE COBERTURA
       #Click on Element  CategeoryDropdownButton    ${CM_Categeory_Drop_Down}
       #Sleep    2s
       #Select From List  ${CM_Categeory_Drop_Down_Customer}  FF & SIMPLIFICADO
       #Click on Element  SelectedCategeory      ${CM_Selected_Categeory_Customer}
       Enter Value  HeadingText     ${CM_Heading}  ${CM_Heading_Value}
       Enter Value  Description     ${CM_Description}  ${CM_Description_Value}
       Click on Element  CityDropdown   ${CM_City_Dropdown}
       Select From List  ${CM_City_Dropdown}    Santa Cruz
       #Click on Element  SelectedCity   ${Selected_City}
       Capture Page Screenshot  CaseCreationScreen.png
       Click on Element  CreateCase     ${CM_Create_Button}
       ${CM_Customer_Case_ID}  Get Element Value    GlobalCaseID      ${CM_Case_ID_Heading}
       Set Suite Variable  ${CM_Global_Case_ID}  ${CM_Case_ID}
       Capture Page Screenshot  CreatedCase.png
       Search Case  ${CM_Customer_Case_ID}


Search Case
       [Arguments]   ${CM_Case_ID}
       Click on Element    SearchDropdown   ${CM_Case_Search_Dropdown}
       Click on Element    SelectedSearch   ${CM_Selected_Search}
       Enter Value      SearchValue     ${CM_Search_Value}   ${CM_Case_ID}
       Click on Element     SearchIcon      ${CM_Search_Icon}
       Sleep    3s
       Capture Page Screenshot  CaseScreen.png

Escalate Case
       [Arguments]   ${CM_Case_ID}
       Click on Element    SearchDropdown   ${CM_Case_Search_Dropdown}
       #Select From List   ${Case_Search_Dropdown}    Case ID
       Click on Element    SelectedSearch   ${CM_Selected_Search}
       Enter Value      SearchValue     ${CM_Search_Value}   ${CM_Global_Case_ID}
       Click on Element     SearchIcon      ${CM_Search_Icon}
       Sleep    2s
       Click on Element     CaseIDLinkCaseBrowser   ${CM_CaseID_Link_CaseBrowser}
       Click on Element     EsacalateButton     ${CM_Escalate_Button}
       Sleep    2s
       Reload Page
       Sleep    2s
       ${CM_Prority_Value}     Get Element Value    Prority     ${CM_Piority}
       Should Be Equal   ${CM_Prority_Value}   Critical
       Capture Page Screenshot  EscalatedCase.png


#Click on Element
       #[Arguments]  ${Element_Name}  ${Element_Path}
       #Wait Until Element Is Visible    ${Element_Path}   timeout=20   error=${Element_Name}NotVisible
       #Click Element    ${Element_Path}

#Enter Value
       #[Arguments]  ${Element_Name}  ${Element_Path}   ${Input}
       #Wait Until Element Is Visible    ${Element_Path}   timeout=20   error=${Element_Name}NotVisible
       #Clear Element Text   ${Element_Path}
       #Sleep    1s
       #Input Text    ${Element_Path}  ${Input}

#Get Element Value
       #[Arguments]  ${Element_Name}  ${Element_Path}
       #Wait Until Element Is Visible    ${Element_Path}   timeout=20   error=${Element_Name}NotVisible
       #${Element_Value}   Get Text    ${Element_Path}
       #Sleep    1s
       ##${Case_iD}   Set Suite Variable   ${Case_iD}
       #[Return]  ${Element_Value}
       #Log  ${Element_Name}:${Element_Value}

Log In to Case Management
       [Arguments]  ${URL}
       ### Open Browser and Maximize ###
       Open Browser    ${URL}   chrome
       Maximize Browser Window

       ### LogIn ###
       Enter Value  UserName    ${CM_User_ID}  ${CM_User_ID_Value}
       Enter Value  Password    ${CM_Password}  ${CM_Password_Value}
       Click on Element  Login  ${CM_LogIn_Button}