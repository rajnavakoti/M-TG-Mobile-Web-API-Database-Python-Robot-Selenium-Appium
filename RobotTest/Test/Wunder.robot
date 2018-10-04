*** Settings ***
Documentation    Suite description
Library  AppiumLibrary
Library  Process
Library  PythonFunctions.py

Suite Setup        Set Up - Suite
Suite Teardown     Tear Down - Suite



*** Variables ***
${Input_Field_Left}     inputFieldLeft
${Input_Field_Right}    inputFieldRight
${Addition_Button}  additionButton
${subtract_Button}  subtractButton
${multiplication_Button}  multiplicationButton
${division_Button}   divisionButton
${reset_Button}  resetButton
${result_Text_View}   resultTextView

${TC_01_Left_Value}     51
${TC_01_Right_Value}     49
${Addition}     Add



*** Test Cases ***
Test Case 01 : Addition of Integer values
    [Documentation]  This request is to make a json Get request to fetch the created UID of customer
    [Tags]    Functional    PositiveScenario
    ${Test_Case_Number}     Set Variable    TC_01

    # Step 1 : Capture intial app screenshot
    Capture Page Screenshot     ${Test_Case_Number}_filename=Initial_Screen.png

    # Step 2 : Evalute expected result
    ${TC_01_Left_Value}     Round Of Number  ${TC_01_Left_Value}
    ${TC_01_Right_Value}     Round Of Number  ${TC_01_Right_Value}
    ${Expected_Output_Value}    Evaluate    ${TC_01_Left_Value}+${TC_01_Right_Value}
    ${Expected_Output_Value}     Round Of Number  ${Expected_Output_Value}
    ${Expected_Result}   catenate   ${TC_01_Left_Value}    +   ${TC_01_Right_Value}    =   ${Expected_Output_Value}
    Log to console    ${Expected_Result}

    # Step 3 : Evalute acutal result (Using SimpleApp)
    ${Actual_Result}   Through SimpleApp Perform    Add     ${TC_01_Left_Value}  ${TC_01_Right_Value}   ${Test_Case_Number}
    Log to console     ${Actual_result}

    # Step 4 : Compare Expected and Actual result (Pass/Fail Test Case)
    Should Be Equal    ${Expected_Result}   ${Actual_result}


*** Keywords ***

Set Up - Suite
    start appium server
    Open Application    http://localhost:4723/wd/hub    alias=AndroidSampleApp    platformName=Android    platformVersion=5.1.1    deviceName=ZH8006HQCF    appPackage=com.vbanthia.androidsampleapp    appActivity=com.vbanthia.androidsampleapp.MainActivity

Tear Down - Suite
     Close All Applications
     stop appium server

Through SimpleApp Perform
    [Documentation]  This request is to make a json Get request to fetch the created UID of customer
    [Arguments]  ${Operation}   ${Left_Value}  ${Right_Value}   ${Test_Case_Number}
    Enter Value To  Left Text Box  id=${Input_Field_Left}      ${Left_Value}
    Enter Value To  Right Text Box  id=${Input_Field_Right}     ${Right_Value}
    Capture Page Screenshot     ${Test_Case_Number}_After_Values_Entered_Screen.png
    Run Keyword If  '${Operation}' == 'Add'     Click On  Add Button   ${Addition_Button}
    ...     ELSE IF     '${Operation}' == 'Sub'     Click On  Sub Button   ${subtract_Button}
    ...     Else IF     '${Operation}' == 'Mul'     Click on  Mul Button   ${multiplication_Button}
    ...     Else IF     '${Operation}' == 'Div'     Click On  Div Button   ${division_Button}
    ...     ELSE    Fail    Error: Operation must be Add or Sub or Mul or Div
    ${Output}   Get Value From  Result Text     ${result_Text_View}
    Capture Page Screenshot     ${Test_Case_Number}_After_${Operation}_Screen.png
    [Return]   ${Output}

Click On
       [Arguments]  ${Element_Name}  ${Element_Path}
       Wait Until Element Is Visible    ${Element_Path}   timeout=20   error=${Element_Name}NotVisible
       Element Should Be Enabled    ${Element_Path}     loglevel=${Element_Name} Is Not Enabled
       Click Element    ${Element_Path}

Enter Value To
       [Arguments]  ${Element_Name}  ${Element_Path}   ${Input}
       Wait Until Element Is Visible    ${Element_Path}   timeout=20   error=${Element_Name}NotVisible
       Element Should Be Enabled    ${Element_Path}     loglevel=${Element_Name} Is Not Enabled
       Clear Text   ${Element_Path}
       Sleep    1s
       Input Text    ${Element_Path}  ${Input}

Get Value From
       [Arguments]  ${Element_Name}  ${Element_Path}
       Wait Until Element Is Visible    ${Element_Path}   timeout=20   error=${Element_Name}NotVisible
       ${Element_Value}   Get Text    ${Element_Path}
       Sleep    1s
       [Return]  ${Element_Value}
       Log  ${Element_Name}:${Element_Value}

