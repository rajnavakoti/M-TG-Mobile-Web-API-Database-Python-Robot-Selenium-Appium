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
    #Complete flow of Register device through USSD for new customer   3   2  123456789012345  1   1  2   PP123456    Raj   shahil   Sai   08 09 1988

Change SIM with valid data
    [Documentation]  This test case is to verify the Happy path of change SIM thorugh USSD
    [Tags]    HappyPath     Regression
    Complete flow of Change SIM through USSD   2   62864689  08 05 1988  69802182   22  10731   12345   8959103000436024819    1


*** Keywords ***

Complete flow of Change SIM through USSD
     [Documentation]  This request is to make a json Get request to fetch the created UID of customer
     [Arguments]  ${Identitytype_Selection}   ${Identification_ID}  ${DOB}  ${MSISDN}   ${Last_recharge}  ${Seller_EH_code}   ${Seller_Pwd}    ${New_SIM_Last_Digits}   ${Final_Confimation}

      ${USSD}    Open Application    http://localhost:4723/wd/hub    alias=USSDApp    platformName=Android    platformVersion=5.1.1    deviceName=42000ba1c82f1300    appPackage=com.android.contacts    appActivity=com.android.dialer.DialtactsActivity

     Capture Page Screenshot    ${TEST NAME}_DialPad.jpg

     Dial short code for Change SIM

     Wait until the element is visible and enter the data   ${Identitytype_Selection}   ${TEST NAME}_2ForPassportNacional.jpg
     Click send

     wait until the element is visible and enter the data   ${Identification_ID}   ${TEST NAME}_EnteringPassportNumber.jpg
     Click send

     Wait until the element is visible and enter the data   ${DOB}    ${TEST NAME}_EnteringCustomerDOB.jpg
     Click send

     Wait until the element is visible and enter the data   ${MSISDN}    ${TEST NAME}_EnteringCustomerMSISDN.jpg
     Click send

     Wait until the element is visible and enter the data   ${Last_recharge}    ${TEST NAME}_EnteringLastRecharge.jpg
     Click send

     Wait until the element is visible and enter the data   ${Seller_EH_code}    ${TEST NAME}_EnteringSellerEHCode.jpg
     Click send

     Wait until the element is visible and enter the data   ${Seller_Pwd}    ${TEST NAME}_EnteringSellerPwd.jpg
     Click send

     Wait until the element is visible and enter the data   ${New_SIM_Last_Digits}    ${TEST NAME}_EnteringNewSIMLastDigits.jpg
     Click send

     Wait until the element is visible and enter the data   ${Final_Confimation}    ${TEST NAME}_1ForFinalConfirmation.jpg
     Click send

     Capture Page Screenshot    ${TEST NAME}_FinalScreen.jpg

     Get Text from popup message
     Click ok

     #Navigate to Messages
     #Open 452345 Message
     #Verify Device Registration Message is received

     Close All Applications

