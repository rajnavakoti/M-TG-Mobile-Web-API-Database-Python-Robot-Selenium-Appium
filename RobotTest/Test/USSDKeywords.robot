*** Settings ***
Documentation    Suite description
#Library  Selenium2Library
#Library  JSONLibrary
#Library  RequestsLibrary
#Library  OperatingSystem
#Library  Collections
#Library  simplejson
#Library  String
#Library  HttpLibrary.HTTP
#Library  builtin
#Library  Datachange.py
#Library  UtilityKeywords.py
#Library  SSHLibrary
Library  AppiumLibrary
Library  Process



*** Keywords ***

Dial short code for Register Device
    [Documentation]  This request is to make a json Get request to fetch the created UID of customer

     Wait Until Element Is Visible    id=digits     timeout=5
     Input Text  id=digits      *5108#
     Capture Page Screenshot    Dailing5108.jpg
     Click Element   id=dialButton

Dial short code for Change SIM
    [Documentation]  This request is to make a json Get request to fetch the created UID of customer

     Wait Until Element Is Visible    id=digits     timeout=5
     Input Text  id=digits      *525#
     Capture Page Screenshot    Dailing525.jpg
     Click Element   id=dialButton

Wait until the element is visible and enter the data
    [Documentation]  This request is to make a json Get request to fetch the created UID of customer
    [Arguments]  ${Input_Data}  ${Screenshot_Name}

     Wait Until Element Is Visible    class=android.widget.EditText    timeout=10
     Input Text  class=android.widget.EditText      ${Input_Data}
     Capture Page Screenshot    ${Screenshot_Name}

Select option
     [Documentation]  This request is to make a json Get request to fetch the created UID of customer
     [Arguments]  ${Input_Data}  ${Screenshot_Name}

     Wait Until Element Is Visible    class=android.widget.EditText    timeout=10
     Input Text  class=android.widget.EditText      ${Input_Data}
     Capture Page Screenshot   ${Screenshot_Name}

Click send

    Click Element   id=button1

Click cancel

    Click Element   id=button2

Click ok

    Click Element   id=button1

Get Text from popup message
   [Arguments]  ${Screenshot_Name}

    Wait Until Element Is Visible    class=android.widget.TextView    timeout=30
    ${Popup_text}   Get Text   class=android.widget.TextView
    Log    ${Popup_text}
    Capture Page Screenshot   ${Screenshot_Name}

Verify the text message
    [Documentation]  This request is to make a json Get request to fetch the created UID of customer
    [Arguments]  ${Expected_Text}

     ${Main Menu Text}      Get Text   class=android.widget.TextView
     Log    ${Main Menu Text}
     Element Text Should Be     class=android.widget.TextView   ${Expected_Text}    message=Incorrect Text message

Navigate to Messages
   ${SMS}    Open Application    http://localhost:4723/wd/hub     alias=SMSApp    platformName=Android    platformVersion=5.1.1    deviceName=42000ba1c82f1300    appPackage=com.android.mms    appActivity=com.android.mms.ui.ComposeMessageMms

Open 452345 Message
   [Arguments]  ${Screenshot_Name}

   Wait Until Element Is Visible      xpath=//*[contains(@text,"452345")]     timeout=10
   Click Element    xpath=//*[contains(@text,"452345")]
   Capture Page Screenshot   ${Screenshot_Name}

Verify Device Registration Message is received
   [Arguments]  ${Screenshot_Name}

   Capture Page Screenshot   ${Screenshot_Name}


