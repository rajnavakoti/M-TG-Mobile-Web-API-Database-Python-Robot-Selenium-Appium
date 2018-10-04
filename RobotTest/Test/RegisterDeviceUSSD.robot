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
Resource  USSDKeywords.robot


*** Variables ***
#${USSD}    Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=6.0.1    deviceName=c138d207    appPackage=com.android.contacts    appActivity=com.android.dialer.DialtactsActivity

${Main_Menu_Text}   3. Registrar Equipo
${Device_Selection_Text}    SEPARATOR=\n    Desea registrar el IMEI capturado357764074510322?
...             1.Si     2.No
${Enter_IMEI_Text}   Ingrese IMEI de dispositivo a registrar:



*** Test Cases ***

#Happy Path
    #[Documentation]  This request is to make a json Get request to fetch the created UID of customer
    #[Tags]    DEBUG
    #Complete flow of Register device through USSD for new customer   3   2  914861252607338  1   1  2   PPRM8590    Raj   Device   Test   09 09 1977

MSISDN Subscription status Active subscription type prepaid and valid IMEI
    [Documentation]  This request is to make a json Get request to fetch the created UID of customer
    [Tags]    DEBUG
    Complete flow of Register device through USSD for existing customer   3   2  307191985391470  1   1  2   M6197136   Rajone   shahil   Sai   02 02 1985


*** Keywords ***

Complete flow of Register device through USSD for new customer
     [Documentation]  This request is to make a json Get request to fetch the created UID of customer
     [Arguments]  ${MainMenu_Selection}   ${Device_selection}  ${IMEI}  ${First_confirmation}   ${Second_Confirmation}  ${Identitytype_Selection}   ${Identification_ID}    ${First_Name}   ${Middle_Name}  ${Last_Name}    ${DOB}

      ${USSD}    Open Application    http://localhost:4723/wd/hub    alias=USSDApp    platformName=Android    platformVersion=5.1.1    deviceName=42000ba1c82f1300    appPackage=com.android.contacts    appActivity=com.android.dialer.DialtactsActivity

     Capture Page Screenshot    ${TEST NAME}_DialPad.jpg

     Dial short code for Register Device

     Wait until the element is visible and enter the data   ${MainMenu_Selection}   ${TEST NAME}_3ForRegistration.jpg
     Click send

     wait until the element is visible and enter the data   ${Device_selection}   ${TEST NAME}_2ForOtherDevice.jpg
     Click send

     Wait until the element is visible and enter the data   ${IMEI}    ${TEST NAME}_EnteringIMEINumber.jpg
     Click send

     Wait until the element is visible and enter the data   ${First_confirmation}    ${TEST NAME}_1ForCustomerApproval.jpg
     Click send

     Wait until the element is visible and enter the data   ${Second_Confirmation}    ${TEST NAME}_1ForCustomerApprovalSecondTime.jpg
     Click send

     Wait until the element is visible and enter the data   ${Identitytype_Selection}    ${TEST NAME}_2ForPassportNacional.jpg
     Click send

     Wait until the element is visible and enter the data   ${Identification_ID}    ${TEST NAME}_EnteringPassportNumber.jpg
     Click send

     Wait until the element is visible and enter the data   ${First_Name}    ${TEST NAME}_EnteringCustomerFirstName.jpg
     Click send

     Wait until the element is visible and enter the data   ${Middle_Name}    ${TEST NAME}_EnteringCustomerMiddleName.jpg
     Click send

     Wait until the element is visible and enter the data   ${Last_Name}    ${TEST NAME}_EnteringCustomerLastName.jpg
     Click send

     Wait until the element is visible and enter the data   ${DOB}    ${TEST NAME}_EnteringCustomerDOB.jpg
     Click send

     Capture Page Screenshot    ${TEST NAME}_FinalScreen.jpg

     Get Text from popup message
     Click ok

     Navigate to Messages
     Open 452345 Message
     Verify Device Registration Message is received

     Close All Applications

Complete flow of Register device through USSD for existing customer
     [Documentation]  This request is to make a json Get request to fetch the created UID of customer
     [Arguments]  ${MainMenu_Selection}   ${Device_selection}  ${IMEI}  ${First_confirmation}   ${Second_Confirmation}  ${Identitytype_Selection}   ${Identification_ID}    ${First_Name}   ${Middle_Name}  ${Last_Name}    ${DOB}

      ${USSD}    Open Application    http://localhost:4723/wd/hub    alias=USSDApp    platformName=Android    platformVersion=5.1.1    deviceName=42000ba1c82f1300    appPackage=com.android.contacts    appActivity=com.android.dialer.DialtactsActivity

     Capture Page Screenshot    ${TEST NAME}_DialPad.jpg

     Dial short code for Register Device

     Wait until the element is visible and enter the data   ${MainMenu_Selection}   ${TEST NAME}_3ForRegistration.jpg
     Click send

     wait until the element is visible and enter the data   ${Device_selection}   ${TEST NAME}_2ForOtherDevice.jpg
     Click send

     Wait until the element is visible and enter the data   ${IMEI}    ${TEST NAME}_EnteringIMEINumber.jpg
     Click send

     Wait until the element is visible and enter the data   ${First_confirmation}    ${TEST NAME}_1ForCustomerApproval.jpg
     Click send

     Wait until the element is visible and enter the data   ${Second_Confirmation}    ${TEST NAME}_1ForCustomerApprovalSecondTime.jpg
     Click send

     Wait until the element is visible and enter the data   ${Identitytype_Selection}    ${TEST NAME}_2ForPassportNacional.jpg
     Click send

     Wait until the element is visible and enter the data   ${Identification_ID}    ${TEST NAME}_EnteringPassportNumber.jpg
     Click send

     #Wait until the element is visible and enter the data   ${First_Name}    ${TEST NAME}_EnteringCustomerFirstName.jpg
     #Click send

     #Wait until the element is visible and enter the data   ${Middle_Name}    ${TEST NAME}_EnteringCustomerMiddleName.jpg
     #Click send

     #Wait until the element is visible and enter the data   ${Last_Name}    ${TEST NAME}_EnteringCustomerLastName.jpg
     #Click send

     Wait until the element is visible and enter the data   ${DOB}    ${TEST NAME}_EnteringCustomerDOB.jpg
     Click send

     Capture Page Screenshot    ${TEST NAME}_FinalScreen.jpg

     Get Text from popup message    ${TEST NAME}_SuccessMessage.jpg
     Click ok

     Navigate to Messages
     Open 452345 Message    ${TEST NAME}_SMSMessage.jpg
     Verify Device Registration Message is received     ${TEST NAME}_SMSSuccessMessage.jpg

     Close All Applications