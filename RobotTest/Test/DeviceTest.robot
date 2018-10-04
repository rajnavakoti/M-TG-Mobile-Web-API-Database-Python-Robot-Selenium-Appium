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


*** Variables ***
#${USSD}    Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=6.0.1    deviceName=c138d207    appPackage=com.android.contacts    appActivity=com.android.dialer.DialtactsActivity


*** Test Cases ***
Test title
    [Tags]    DEBUG

    #Start Process   appium -p 4732  shell=true     alias=test
    #Process Should Be Running   handle=test     error_message=Process is not running
    #${prcid}    Get Process ID      handle=test
    #Log     ${prcid}
    #Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=5.0.2    deviceName=BH9093Y20G    appPackage=com.sonyericsson.android.socialphonebook    appActivity=com.sonyericsson.android.socialphonebook.DialerEntryActivity
    #Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=4.1.2    deviceName=4df70a696602cf53    appPackage=com.android.contacts    appActivity=com.android.contacts.activities.DialtactsActivity
    #Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=6.0.1    deviceName=f8cefb    appPackage=com.android.contacts    appActivity=com.android.contacts.DialtactsActivityAlias
     #Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=6.0.1    deviceName=c138d207    appPackage=com.android.mms    appActivity=com.android.mms.ui.ComposeMessageMms
     #Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=6.0.1    deviceName=c138d207    appPackage=com.android.contacts    appActivity=com.android.dialer.DialtactsActivity
     #${SMS}    Open Application    http://localhost:4723/wd/hub     alias=SMSApp    platformName=Android    platformVersion=6.0.1    deviceName=c138d207    appPackage=com.android.mms    appActivity=com.android.mms.ui.ComposeMessageMms
     ${USSD}    Open Application    http://localhost:4723/wd/hub    alias=USSDApp    platformName=Android    platformVersion=6.0.1    deviceName=c138d207    appPackage=com.android.contacts    appActivity=com.android.dialer.DialtactsActivity


     Click Element   xpath=//*[contains(@content-desc,'Asterisk')]
     Click Element   id=two
     Click Element   id=two
     Click Element   id=two

     ${SMS}    Open Application    http://localhost:4723/wd/hub     alias=SMSApp    platformName=Android    platformVersion=6.0.1    deviceName=c138d207    appPackage=com.android.mms    appActivity=com.android.mms.ui.ComposeMessageMms

     #Start Activity     com.android.mms     com.android.mms.ui.ComposeMessageMms
     #AppiumLibrary.Switch Application     ${USSD}
     #Background App     5
     #SMS Actions
     Wait Until Element Is Visible    id=floating_action_button
     Click Element  id=floating_action_button
     Wait Until Element Is Visible   id=recipients_editor_to  timeout=30   error=None
     Input Text     id=recipients_editor_to     5321
     Input Text     id=editor_body      Menu
     Click Element      id=send_button
     Wait Until Element Is Visible      xpath=//*[contains(@text,"Compra el PAQUETIGO")]     timeout=10
     Capture Page Screenshot    Menuss.jpg
     ${response}    Get Text    id=list_item_text_view
     Log    ${response}
     ${element}     Get Element Attribute   id=list_item_text_view     text
     Capture Page Screenshot    textss.jpg
     Log    ${element}
     Input Text     id=editor_body      A
     Click Element      id=send_button
     Wait Until Element Is Visible      id=list_item_text_view
     @{elements}    Get Webelements     id=list_item_text_view
     ${responsetwo}    Get Text    id=list_item_text_view[2]
     Log    ${responsetwo}

     #USSD Actions
     Click Element   xpath=//*[contains(@content-desc,'star')]
     Click Element   id=two_indonesian
     Click Element   id=two_indonesian
     Click Element   id=two_indonesian
     #Click Element   xpath=//*[contains(@content-desc,'two')]
     #Click Element   xpath=//*[contains(@content-desc,'two')]
     #Click Element   xpath=//*[contains(@content-desc,'two')]
     Click Element   xpath=//*[contains(@content-desc,'pound')]
     Click Element   xpath=//*[contains(@content-desc,'dial two button')]
     #Click Element   xpath=//*[contains(@content-desc,'Call')]
     #Wait Until Element Is Visible   xpath=//*[contains(@text,'OK')]   timeout=30   error=None
      Wait Until Element Is Visible   class=android.widget.EditText   timeout=30   error=None
      Input Text     class=android.widget.EditText   1
      #Wait Until Element Is Visible   id=input_field   timeout=30   error=None
      #Input Text     id=input_field   1
      Click Element   id=button1
     #Input Text     class=android.widget.EditText
      #Click Element   xpath=//*[contains(@text,'OK')]
     Click Element   id=fab
     click Element   id=starNum
     click Element   id=fiveNum
     click Element   id=nineNum
     click Element   id=nineNum
     click Element   id=nineNum
     click Element   id=poundNum
     click Element   id=fab
     #close Application
     Set Appium Timeout    15 seconds
     #${MMI_ACTIVITY}     Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=5.1.1    deviceName=BH908WKW08    appPackage=com.android.phone    appActivity=com.android.phone.ErrorDilogActivity
     #Switch Application   ${MMI_ACTIVITY}
     Wait Until Element Is Visible   class=android.widget.EditText   timeout=30   error=None
     Input Text     class=android.widget.EditText     1
     #Input Text   id=input_field   1
     click Element   id=button2
     click Element   id=fab

