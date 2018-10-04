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
Resource  BSSQueries.robot

*** Variables ***
### Env/General Variables ###
${STALE_ELEMENT_SLEEP}    2s
${path_excel}    C:/Test/CBA.xlsx
${Sheetname}    CBA
${URL}   http://10.150.34.184:7500
${ENV}   http://10.150.34.184:3010

### Object Rep ###
${CM_User_ID}    xpath://*[@id='username']
${CM_Password}  xpath://*[@id='password']
${LogIn_Button}  xpath://*[@id='kc-login']
${Search_DropDown}  xpath://*[@class='btn btn-default dropdown-toggle ng-binding']
${Select_MSISDN}    xpath://*[@id='msisdn']
${Search_TextBox}   xpath://*[@name='query']
${Customer_Name}    xpath://*[@id="customer"]
${Select_Device}    xpath://*[@id="mobile-device"]
${Select_SIM}       xpath://*[@id="sim"]
${Search_Icon}   xpath://*[@name='submit-search']
${Customer_Title}     xpath://*[@id="w-app-facet-front"]/div[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[1]/div[1]/div[1]/span[1]
${Prodcuts_Tab}     xpath://*[@id="w-app-facet-front"]/nav[1]/ul[1]/li[3]/a[1]
${Register_Device_Button}   xpath://*[@id="w-app-body"]/section[1]/div[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[1]/nav[1]/ul[1]/li[2]/button[1]
${Device_Brand}     xpath://*[@id="CH_Device_Brand"]
${Device_Model}     xpath://*[@id="CH_Device_Model"]
${IMEI}     xpath://*[@id="CH_IMEI"]
${Contact_MSISDN}   xpath://*[@id="CH_Contact_MSISDN"]
${Device_Type}      xpath://*[@id="CH_Device_Type"]
${RegisterDevice_Submit_Button}     xpath://div[1]//div[1]//div[1]//form[1]//div[3]//button[2]
${Registered_Device}    xpath://*[@id="w-app-body"]/section[1]/div[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[2]/div[1]/div[1]/section[1]/async-load[2]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[2]/div[1]
${Device_Table}    //*[@id="w-app-body"]//section[1]//div[1]//async-load[1]//div[1]//csr-loaded-data[1]//div[1]//ng-transclude[1]//ng-transclude[1]//div[2]/div[1]//csr-devices-details[1]//div[1]//section[1]//async-load[1]//div[1]//csr-loaded-data[1]/div[1]//ng-transclude[1]//ng-transclude[1]//table[1]
${ID}   //*[@id="w-app-body"]/section[1]/div[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[2]/div[1]/csr-devices-details[1]/div[1]/section[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/table[1]/tbody[RowCount]/tr[1]/td[4]
${DeviceStatus}   xpath://*[@id="w-app-body"]/section[1]/div[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[2]/div[1]/csr-devices-details[1]/div[1]/section[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/table[1]/tbody[RowCount]/tr[1]/td[3]
${BlockButton}  xpath://*[@id="w-app-body"]/section[1]/div[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[2]/div[1]/csr-devices-details[1]/div[1]/section[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/table[1]/tbody[RowCount]/tr[1]/td[7]/button[2]/span[1]
${UnBlockButton}   xpath://*[@id="w-app-body"]/section[1]/div[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[2]/div[1]/csr-devices-details[1]/div[1]/section[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/table[1]/tbody[RowCount]/tr[1]/td[7]/button[1]/span[1]
${UnregisterButon}  xpath://*[@id="w-app-body"]/section[1]/div[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[2]/div[1]/csr-devices-details[1]/div[1]/section[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/table[1]/tbody[RowCount]/tr[1]/td[7]/button[1]/span[1]
${Suspend_Reason}   xpath://*[@id="CH_Suspend_Device_Reason"]
${Report_ID}    xpath://*[@id="CH_Police_Report_ID"]
${Report_Name}  xpath://*[@id="CH_Police_Report_Reporter_Name"]
${Block_DoneButton}  xpath://div[1]//div[1]//div[1]//form[1]//div[3]//button[2]
${UnRegister_DoneButton}   xpath://div[1]/div[1]/div[1]/form[1]/div[3]/button[2]
${Resources_Tab}    xpath://*[@id="resourcesTab"]/a[1]
${Change_SIM_Change}    xpath://*[@id="w-app-body"]/section[1]/section[1]/ui-view[1]/div[1]/div[1]/div[5]/div[1]/div[1]/div[2]/csr-resources-table[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[1]/table[1]/tbody[2]/tr[1]/td[5]/div[2]/button[1]/span[1]
${ActivateSIM_RButton}   xpath://div[1]/div[1]/div[1]/form[1]/div[2]/div[1]/section[6]/div[1]/div[1]/div[1]/label[1]/translate[1]/span[1]
${Confirm_ChangeSIM}    xpath://div[1]/div[1]/div[1]/form[1]/div[3]/button[2]
${ICC}  xpath://*[@id="new-icc"]
${Immediate_RButton}    xpath://*[@id="activationType1"]
${ChangeSIM_Reason}     xpath://*[@id="razón"]
${ChangeSIM_DoneButton}     xpath://div[1]/div[1]/div[1]/form[1]/div[3]/button[2]
${ICC_ID_CSR}   xpath://*[@id="w-app-body"]/section[1]/section[1]/ui-view[1]/div[1]/div[1]/div[5]/div[1]/div[1]/div[2]/csr-resources-table[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[1]/table[1]/tbody[2]/tr[1]/td[3]/csr-non-empty[1]/span[1]/span[1]
${Suspend_Button}   xpath://*[@id="w-app-body"]/section[1]/section[1]/ui-view[1]/div[1]/nav[1]/ul[1]/li[4]/a[1]
${Suspend_Subscription_Reason}   xpath://*[@id="barring"]
${Suspend_DoneButton}   xpath://div[1]/div[1]/div[1]/form[1]/div[3]/button[2]
${Subscription_Status}      xpath://*[@id="w-app-body"]/section[1]/section[1]/ui-view[1]/div[1]/div[1]/div[1]/lifecycle-status[1]/span[1]
${Subscription_Suspended_Expand}    xpath://*[@id="w-app-body"]/section[1]/section[1]/ui-view[1]/div[1]/div[1]/div[1]/csr-resume-suspension[1]/div[1]/div[1]/i[1]
${Suspend_Reason_CSR}       xpath://*[@id="w-app-body"]/section[1]/section[1]/ui-view[1]/div[1]/div[1]/div[1]/csr-resume-suspension[1]/div[1]/div[2]/div[1]/div[1]/div[2]/csr-non-empty[1]/span[1]/span[1]
${Resume_Button}    xpath://*[@id="w-app-body"]/section[1]/section[1]/ui-view[1]/div[1]/nav[1]/ul[1]/li[5]/a[1]
${Resume_Subscription_Reason}   xpath://*[@id="barring"]
${Confirm_Unblock_Button}   xpath://*[@id="confirmResume"]
${Terminate_Button}     xpath://*[@id="terminateButton"]
${Confirm_Terminate_Button}     xpath://*[@id="confirm-modal-ok"]
${Terminate_Reason}      xpath://*[@id="terminateSubscriptionReason"]
${Terminate_Sub_Reason}     xpath://*[@id="terminateSubscriptionSubReason"]
${Terminate_comments}       xpath://*[@id="terminateAgreementStepTwo"]/section[1]/csr-form-label[1]/div[1]/ng-transclude[1]/div[1]/textarea[1]

#### Agreements Page ###
${Agreeements_Tab}  xpath://*[@id="w-app-facet-front"]/nav[1]/ul[1]/li[4]/a[1]
${Barrings_Link}    xpath://*[@id="barringsTab"]/a[1]
${Barrings_Table}   xpath://*[@id="w-app-body"]/section[1]/section[1]/ui-view[1]/div[1]/div[1]/div[5]/div[1]/div[1]/div[6]/csr-barrings-table[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[1]/table[1]
${Barring_Service_Name_Path}     xpath://*[@id="w-app-body"]/section[1]/section[1]/ui-view[1]/div[1]/div[1]/div[5]/div[1]/div[1]/div[6]/csr-barrings-table[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[1]/table[1]/tbody[RowCount]/tr/td[1]
${Barring_Service_Status_Path}     xpath://*[@id="w-app-body"]/section[1]/section[1]/ui-view[1]/div[1]/div[1]/div[5]/div[1]/div[1]/div[6]/csr-barrings-table[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[1]/table[1]/tbody[RowCount]/tr/td[5]
#${Barring_Service_Activation_Link_Path}     xpath://*[@id="w-app-body"]/section[1]/section[1]/ui-view[1]/div[1]/div[1]/div[5]/div[1]/div[1]/div[6]/csr-barrings-table[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[1]/table[1]/tbody[RowCount]/tr/td[6]
${Barring_Service_Activation_Path}      xpath://*[@id="w-app-body"]/section[1]/section[1]/ui-view[1]/div[1]/div[1]/div[5]/div[1]/div[1]/div[6]/csr-barrings-table[1]/async-load[1]/div[1]/csr-loaded-data[1]/div[1]/ng-transclude[1]/ng-transclude[1]/div[1]/table[1]/tbody[RowCount]/tr[1]/td[6]/div[1]/button[1]/span[1]
${Barring_service_Activation_Button_Path}   xpath://div[1]/div[1]/div[1]/form[1]/div[3]/button[2]

${Count_Variable}


### Data Rep ###
${CM_Password_Value}  csr
${CM_User_ID_Value}   csr
${MSISDN_Value}     59177010116
${SIM_Value}    8959103000436021740
${Customer_Name_Value}   TEST35 EE
${IMEI_Value}   356927588435614
${Device_Brand_Value}     Apple
${Device_Model_Value}     Automation
${Contact_MSISDN_Value}   59177010142
${Device_Type_Value}      Regression
${Report_ID_Value}    AutomationTest123
${Report_Name_Value}  AutomationTester

#*** Test Cases ***
#Test Execution
     #Log In to CSR  ${URL}
     #Search Customer Through MSISDN   ${MSISDN_Value}
     #Register Device    ${IMEI_Value}
     #Sleep  2s
     #Search Customer Through MSISDN   ${MSISDN_Value}
     #Block Device   ${IMEI_Value}
     #Sleep  2s
     #Search Customer Through MSISDN   ${MSISDN_Value}
     #UnBlock Device     ${IMEI_Value}
     #Sleep  2s
     #Search Customer Through MSISDN   ${MSISDN_Value}
     #UnRegister Device  ${IMEI_Value}
     #Sleep  2s
     #Search Customer Through MSISDN   ${MSISDN_Value}
     #Change SIM   ${SIM_Value}
     #Sleep  2s
     #Search Customer Through MSISDN   ${MSISDN_Value}
     #Block Subscription Due To Fraud    ${MSISDN_Value}
     #Sleep  2s
     #Search Customer Through MSISDN   ${MSISDN_Value}
     #UnBlock Subscription Due To Fraud   ${MSISDN_Value}
     #Block Device   ${IMEI_Value}
     #UnBlock Device   ${IMEI_Value}
     #UnRegister Device  ${IMEI_Value}
     #Change SIM     ${SIM_Value}
     #Block Subscription Due To Customer Request     ${MSISDN_Value}
     #UnBlock Subscription Due To Customer   ${MSISDN_Value}


*** Keywords ***

### CSR Functional Keywords ###
Search Customer Through MSISDN
       [Arguments]    ${MSISDN_Value}
       Click on Element   SearchDropdown    ${Search_DropDown}
       Click on Element   SelectMSISDNValue     ${Select_MSISDN}
       Enter Value   MSISDN     ${Search_TextBox}   ${MSISDN_Value}
       Click on Element     SearchIcon    ${Search_Icon}
       ${Customer_details}    Get Element Value    CustomerID_Name    ${Customer_Title}
       Sleep    5s
       Capture Page Screenshot

Search Customer Through Name
      [Arguments]   ${Customer_Name_Value}
       Click on Element   SearchDropdown    ${Search_DropDown}
       Click on Element   SelectCustomerValue     ${Customer_Name}
       Enter Value   CustomerName     ${Search_TextBox}   ${Customer_Name_Value}
       Click on Element   SearchIcon   ${Search_Icon}
       ${Customer_details}    Get Element Value    CustomerID_Name    ${Customer_Title}
       Sleep    5s
       Capture Page Screenshot

Search Customer Through IMEI
       [Arguments]   ${IMEI_Value}
       Click on Element   SearchDropdown    ${Search_DropDown}
       Click on Element   DeviceIMEI     ${Select_Device}
       Enter Value   IMEI     ${Search_TextBox}   ${IMEI_Value}
       Click on Element   SearchIcon   ${Search_Icon}
       #${Customer_details}    Get Element Value    CustomerID_Name    ${Customer_Title}
       Sleep    5s
       Capture Page Screenshot

Search Customer Through SIM
       [Arguments]   ${SIM_Value}
       Click on Element   SearchDropdown    ${Search_DropDown}
       Click on Element   SelectSIM     ${Select_SIM}
       Enter Value   ICCID     ${Search_TextBox}   ${SIM_Value}
       Click on Element   SearchIcon   ${Search_Icon}
       #${Customer_details}    Get Element Value    CustomerID_Name    ${Customer_Title}
       Sleep    5s
       Capture Page Screenshot

Register Device
       [Arguments]   ${IMEI_Value}
       Verify Device Is Not Registered      ${IMEI_Value}
       Click on Element   ProductsTab   ${Prodcuts_Tab}
       Sleep    2s
       Click on Element   RegisterDeviceButton   ${Register_Device_Button}
       Enter Value    DeviceBrand   ${Device_Brand}     ${Device_Brand_Value}
       Enter Value    DeviceModel   ${Device_Model}     ${Device_Model_Value}
       Enter Value    IMEI      ${IMEI}     ${IMEI_Value}
       Enter Value    ContactMSISDN     ${Contact_MSISDN}     ${Contact_MSISDN_Value}
       Enter Value    DeviceType     ${Device_Type}     ${Device_Type_Value}
       Capture Page Screenshot  EnterDeviceDetails.png
       Click on Element     RegisterDeviceSubbmitButton    ${RegisterDevice_Submit_Button}
       Poll Untill Device Registered    ${IMEI_Value}
       Search Customer Through IMEI    ${IMEI_Value}
       Click on Element   ProductsTab   ${Prodcuts_Tab}
       Sleep    2s
       Click on Element   DeviceNavigate   ${Registered_Device}
       Sleep    2s
       Capture Page Screenshot  AfterDeviceRegistration.png
       ${RowCount}  Find IMEI on CSR     ${IMEI_Value}
       ${DeviceStatus}   Replace String  ${DeviceStatus}    RowCount    ${RowCount}
       ${Device_CSR_Status}     Get Element Value   DeviceSatusCSR   ${DeviceStatus}
       Log  DeviceStatus:${Device_CSR_Status}
       Should Be Equal  ${Device_CSR_Status}   REGISTRADO

Block Device
       [Arguments]    ${IMEI_Value}
       Click on Element   ProductsTab   ${Prodcuts_Tab}
       Sleep    2s
       Click on Element   DeviceNavigate   ${Registered_Device}
       Sleep    2s
       Capture Page Screenshot  BeforeBlockDevice.png
       ${RowCount}  Find IMEI on CSR     ${IMEI_Value}
       ${BlockButton}   Replace String  ${BlockButton}    RowCount    ${RowCount}
       Click on Element   BlockButton   ${BlockButton}
       Click on Element   SuspendReason     ${Suspend_Reason}
       Select From List  ${Suspend_Reason}    Lost
       Enter Value      ReportID    ${Report_ID}   ${Report_ID_Value}
       Enter Value      ReportID    ${Report_Name}  ${Report_Name_Value}
       Click on Element   SuspendReason     ${Block_DoneButton}
       Sleep    10s
       Reload Page
       Sleep    2s
       Click on Element   DeviceNavigate   ${Registered_Device}
       ${RowCount}  Find IMEI on CSR     ${IMEI_Value}
       ${DeviceStatus}   Replace String  ${DeviceStatus}    RowCount    ${RowCount}
       ${Device_CSR_Status}     Get Element Value   DeviceSatusCSR   ${DeviceStatus}
       Log  DeviceStatus:${Device_CSR_Status}
       Should Be Equal  ${Device_CSR_Status}   BLOQUEADO
       Capture Page Screenshot  AfterBlockDevice.png
UnBlock Device
       [Arguments]    ${IMEI_Value}
       Click on Element   ProductsTab   ${Prodcuts_Tab}
       Sleep    2s
       Click on Element   DeviceNavigate   ${Registered_Device}
       Sleep    2s
       Capture Page Screenshot  BeforeUnblockDevice.png
       ${RowCount}  Find IMEI on CSR     ${IMEI_Value}
       ${UnBlockButton}   Replace String  ${UnBlockButton}    RowCount    ${RowCount}
       Click on Element   BlockButton   ${UnBlockButton}
       Sleep    10s
       Reload Page
       Sleep    2s
       Click on Element   DeviceNavigate   ${Registered_Device}
       ${RowCount}  Find IMEI on CSR     ${IMEI_Value}
       ${DeviceStatus}   Replace String  ${DeviceStatus}    RowCount    ${RowCount}
       ${Device_CSR_Status}     Get Element Value   DeviceSatusCSR   ${DeviceStatus}
       Log  DeviceStatus:${Device_CSR_Status}
       Should Be Equal  ${Device_CSR_Status}   REGISTRADO
       Capture Page Screenshot  AfterUnblockDevice.png
UnRegister Device
       [Arguments]    ${IMEI_Value}
       Click on Element   ProductsTab   ${Prodcuts_Tab}
       Sleep    2s
       Click on Element   DeviceNavigate   ${Registered_Device}
       Sleep    2s
       Capture Page Screenshot  BeforeUnregisterDevice.png
       ${RowCount}  Find IMEI on CSR     ${IMEI_Value}
       ${UnregisterButon}   Replace String  ${UnregisterButon}    RowCount    ${RowCount}
       Click on Element   UnregisterButton   ${UnregisterButon}
       Click on Element   UnregisterDoneButton   ${UnRegister_DoneButton}
       Poll Untill Device UnRegistered    ${IMEI_Value}
       Search Customer Through IMEI    ${IMEI_Value}
       Click on Element   ProductsTab   ${Prodcuts_Tab}
       Sleep    2s
       Click on Element   DeviceNavigate   ${Registered_Device}
       Sleep    2s
       Capture Page Screenshot  AfterUnregisterProduct.png
       ${RowCount}  Find IMEI on CSR     ${IMEI_Value}
       ${DeviceStatus}   Replace String  ${DeviceStatus}    RowCount    ${RowCount}
       ${Device_CSR_Status}     Get Element Value   DeviceSatusCSR   ${DeviceStatus}
       Log  DeviceStatus:${Device_CSR_Status}
       Should Be Equal  ${Device_CSR_Status}    NO REGISTRADO
       Capture Page Screenshot  AfterUnregisterDevice.png

Change SIM
       [Arguments]    ${SIM_Value}
       Verify The New MSISDN Already Exists    ${SIM_Value}
       Click on Element    ResourcesLink    ${Resources_Tab}
       Click on Element     ChangeMSISDNButton   ${Change_SIM_Change}
       Capture Page Screenshot  BeforeChangeSIM.png
       Sleep    2s
       Wait Until Element Is Visible    ${ActivateSIM_RButton}
       Click on Element     ActivateRadioButton     ${ActivateSIM_RButton}
       #Input Text   ${ActivateSIM_RButton}    Y
       #Select Radio Button     typeOfActionRadio     activateSim
       Wait Until Element Is Enabled    ${Confirm_ChangeSIM}    timeout=4s   error=ConfirmChangeSIMButtonDisabled
       Capture Page Screenshot  ChangeSIMDetailsOne.png
       Click on Element     ConfirmChangeSIMButton      ${Confirm_ChangeSIM}
       Sleep    2s
       Enter Value      ICC     ${ICC}   ${SIM_Value}
       Click on Element     ImmediateRadioButton    ${Immediate_RButton}
       Click on Element     ChangeSIMReason     ${ChangeSIM_Reason}
       Sleep    1s
       Select From List  ${ChangeSIM_Reason}    Malfunctioning
       Sleep    2s
       Wait Until Element Is Enabled    ${ChangeSIM_DoneButton}     timeout=4s   error=ListoButtonDisabled
       Capture Page Screenshot  ChangeSIMDetailsTwo.png
       Click on Element     ChangeSIMDoneButton     ${ChangeSIM_DoneButton}
       Poll Untill SIM Registered    ${SIM_Value}
       Search Customer Through SIM    ${SIM_Value}
       Sleep    2s
       Click on Element    ResourcesLink    ${Resources_Tab}
       ${NEW_ICC_ID}     Get Element Value   ICCID   ${ICC_ID_CSR}
       Capture Page Screenshot  AfterChangeSIMAgreements.png
       Log  SIM:${NEW_ICC_ID}
       Should Be Equal  ${NEW_ICC_ID}   ${SIM_Value}

Change MSIDN
       [Arguments]    ${New_MSIDN_Value}
       Verify The New SIM Already Exists    ${New_MSISDN_Value}
       Click on Element    ResourcesLink    ${Resources_Tab}
       Click on Element     ChangeSIMButton   ${Change_SIM_Change}
       Capture Page Screenshot  BeforeChangeSIM.png
       Sleep    2s
       Wait Until Element Is Visible    ${ActivateSIM_RButton}
       Click on Element     ActivateRadioButton     ${ActivateSIM_RButton}

Block Subscription Due To Customer Request
       [Arguments]    ${MSISDN_Value}
       Capture Page Screenshot  BeforeBlockSubscriptionCR.png
       Click on Element     SuspendButton   ${Suspend_Button}
       Click on Element     SuspendReasonSelection      ${Suspend_Subscription_Reason}
       Select From List  ${Suspend_Subscription_Reason}    Suspend Customer
       Sleep    2s
       Wait Until Element Is Enabled    ${Suspend_DoneButton}     timeout=4s   error=ListoButtonDisabled
       Capture Page Screenshot  SuspendCRDetails.png
       Click on Element     SuspendDoneButton       ${Suspend_DoneButton}
       Poll Untill Subscription Blocked    ${MSISDN_Value}
       Search Customer Through MSISDN   ${MSISDN_Value}
       Sleep    2s
       Click on Element     SuspendExpand   ${Subscription_Suspended_Expand}
       ${Subscription_Status_CSR}   Get Element Value   SubscriptionStatus     ${Subscription_Status}
       ${Subscription_Reason_CSR}   Get Element Value   SubscriptionStatus     ${Suspend_Reason_CSR}
       Capture Page Screenshot  BlockCustRequestAggrementsPage.png
       Should Be Equal  ${Subscription_Status}  SUSPENDIDO
       Should Be Equal  ${Subscription_Reason_CSR}  El cliente inició el bloqueo (perdido)
       Log  SuspendedSubcriptionWithReason:${Subscription_Reason_CSR}
       Capture Page Screenshot  AfterBlockSubscriptionCR.png

Block Subscription Due To Fraud
       [Arguments]    ${MSISDN_Value}
       Sleep    1s
       Capture Page Screenshot  BeforeBlockSubscriptionFR.png
       Click on Element     SuspendButton   ${Suspend_Button}
       Click on Element     SuspendReasonSelection      ${Suspend_Subscription_Reason}
       Select From List  ${Suspend_Subscription_Reason}    Suspend Fraud
       Sleep    2s
       Wait Until Element Is Enabled    ${Suspend_DoneButton}     timeout=4s   error=ListoButtonDisabled
       Capture Page Screenshot  BeforeFRDetails.png
       Click on Element     SuspendDoneButton       ${Suspend_DoneButton}
       Poll Untill Subscription Blocked    ${MSISDN_Value}
       Search Customer Through MSISDN   ${MSISDN_Value}
       Sleep    2s
       Click on Element     SuspendExpand   ${Subscription_Suspended_Expand}
       ${Subscription_Status_CSR}   Get Element Value   SubscriptionStatus     ${Subscription_Status}
       ${Subscription_Reason_CSR}   Get Element Value   SubscriptionStatus     ${Suspend_Reason_CSR}
       Capture Page Screenshot  BlockFraudAggrementsPage.png
       Should Be Equal  ${Subscription_Status_CSR}  SUSPENDIDO
       Should Be Equal  ${Subscription_Reason_CSR}  Suspend Fraud
       Log  SuspendedSubcriptionWithReason:${Subscription_Reason_CSR}
       Capture Page Screenshot  AfterBlockSubscriptionFR.png

UnBlock Subscription Due To Customer
       [Arguments]    ${MSISDN_Value}
       Capture Page Screenshot  BeforeUnBlockSubscriptionCR.png
       Click on Element     ResumeButton   ${Resume_Button}
       Click on Element     ResumeReasonSelection      ${Resume_Subscription_Reason}
       Select From List  ${Resume_Subscription_Reason}    Suspend Customer
       Wait Until Element Is Enabled    ${Confirm_Unblock_Button}     timeout=4s   error=ListoButtonDisabled
       Capture Page Screenshot  UnBlockCRDetails.png
       Click on Element     ConfirmUnblockButton    ${Confirm_Unblock_Button}
       Poll Untill Subscription Active    ${MSISDN_Value}
       Search Customer Through MSISDN   ${MSISDN_Value}
       Sleep    2s
       #Click on Element     SuspendExpand   ${Subscription_Suspended_Expand}
       ${Subscription_Status_CSR}   Get Element Value   SubscriptionStatus     ${Subscription_Status}
       #${Subscription_Reason_CSR}   Get Element Value   SubscriptionStatus     ${Suspend_Reason_CSR}
       Should Be Equal  ${Subscription_Status_CSR}  ACTIVA
       #Should Be Equal  ${Subscription_Reason_CSR}  El cliente inició el bloqueo (perdido)
       Log  SuspendedSubcription:${Subscription_Status_CSR}
       Capture Page Screenshot  AfterBlockSubscriptionCR.png

UnBlock Subscription Due To Fraud
       [Arguments]    ${MSISDN_Value}
       Sleep    1s
       Capture Page Screenshot  BeforeUnBlockSubscriptionFR.png
       Click on Element     ResumeButton   ${Resume_Button}
       Click on Element     ResumeReasonSelection      ${Resume_Subscription_Reason}
       Select From List  ${Resume_Subscription_Reason}    Suspend Fraud
       Sleep    2s
       Wait Until Element Is Enabled    ${Confirm_Unblock_Button}     timeout=4s   error=ListoButtonDisabled
       Capture Page Screenshot  UnBlockFRDetails.png
       Click on Element     ConfirmUnblockButton    ${Confirm_Unblock_Button}
       Poll Untill Subscription Active    ${MSISDN_Value}
       Search Customer Through MSISDN   ${MSISDN_Value}
       Sleep    2s
       #Click on Element     SuspendExpand   ${Subscription_Suspended_Expand}
       ${Subscription_Status_CSR}   Get Element Value   SubscriptionStatus     ${Subscription_Status}
       #${Subscription_Reason_CSR}   Get Element Value   SubscriptionStatus     ${Suspend_Reason_CSR}
       Should Be Equal  ${Subscription_Status_CSR}  ACTIVA
       #Should Be Equal  ${Subscription_Reason_CSR}  El cliente inició el bloqueo (perdido)
       Log  SuspendedSubcription:${Subscription_Status_CSR}
       Capture Page Screenshot  AfterUnBlockSubscriptionFR.png

Terminate Subscription
       [Arguments]    ${MSISDN_Value}
       Capture Page Screenshot  BeforeTerminateSubscription.png
       Click on Element     TerminateButton     ${Terminate_Button}
       Click on Element     ConfirmTerminateButton      ${Confirm_Terminate_Button}
       Click on Element     TerminateReason     ${Terminate_Reason}
       Select From List   ${Terminate_Reason}    Competencia
       Click on Element     TerminateSubReason      ${Terminate_Sub_Reason}
       Select From List   ${Terminate_Sub_Reason}    La Competencia tiene mejores tarifas
       Enter Value     TerminateComments       ${Terminate_comments}    Termination Using Automation
       Capture Page Screenshot  TerminateSuscriptionDetails.png
       ## Click Done Button
       Poll Untill Subscription Terminated     ${MSISDN_Value}
       Search Customer Through MSISDN   ${MSISDN_Value}
       Sleep    2s
       #Click on Element     SuspendExpand   ${Subscription_Suspended_Expand}
       ${Subscription_Status_CSR}   Get Element Value   SubscriptionStatus     ${Subscription_Status}
       #${Subscription_Reason_CSR}   Get Element Value   SubscriptionStatus     ${Suspend_Reason_CSR}
       Should Be Equal  ${Subscription_Status}  FINALIZADO
       #Should Be Equal  ${Subscription_Reason_CSR}  El cliente inició el bloqueo (perdido)
       Log  SuspendedSubcription:${Subscription_Status}
       Capture Page Screenshot  AfterTerminateSubscription.png

####################### Helping Keywords ####################################################################################
####################### Helping Keywords ####################################################################################
####################### Helping Keywords ####################################################################################
####################### Helping Keywords ####################################################################################
####################### Helping Keywords ####################################################################################
####################### Helping Keywords ####################################################################################
####################### Helping Keywords ####################################################################################
####################### Helping Keywords ####################################################################################




Poll Untill Device Registered
    [Documentation]    Polls URL retrieved from asysnc function until lifecycle-status = completed.
    ...                Uses WUKS to call Check Post Request Status Complete
    [Arguments]    ${IMEI_Value}    ${duration}=30s    ${interval}=5s
    Wait Until Keyword Succeeds    ${duration}    ${interval}    Verify Device Is Registered    ${IMEI_Value}


Verify Device Is Not Registered
    [Arguments]   ${IMEI_Value}
    ${Status}   ${gresp.content}    Search IMEI Through BSSAPI  ${ENV}  ${IMEI_Value}
    ${LifeCycleStatus}  Run Keyword IF  ${Status} != True   Get Device LifeCycleStatus From Devices  ${gresp.content}
    #Log to Console  LifeCycleStatus:${LifeCycleStatus}
    #${Terminated_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  Terminated
    ${LifeCycleStatus}  Convert To String  ${LifeCycleStatus}
    ${NoData_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  None
    ${Retired_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  retired
    Run Keyword Unless  ${NoData_Status} == True or ${Retired_Status} == True   Fail    ErrorCode Primary Validation Failed, Order not submitted ${IMEI_Value} is already registered as ${LifeCycleStatus}

Verify Device Is Registered
    [Arguments]   ${IMEI_Value}
    ${Status}   ${gresp.content}    Search IMEI from Resources Through BSSAPI   ${ENV}  ${IMEI_Value}
    ${LifeCycleStatus}  Run Keyword IF  ${Status} != True   Get Device LifeCycleStatus From Resources  ${gresp.content}
    #Log to Console  LifeCycleStatus:${LifeCycleStatus}
    #${Terminated_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  Terminated
    ${LifeCycleStatus}  Convert To String  ${LifeCycleStatus}
    Should Be Equal As Strings    ${LifeCycleStatus}    active
    [Rerutn]   ${lifecycle-status}
    #Log To Console  ${lifecycle-status}
    #${NoData_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  None
    #Run Keyword If  ${NoData_Status} != True    Pass    ${IMEI_Value} is registered with status ${LifeCycleStatus}

Poll Untill Device UnRegistered
    [Documentation]    Polls URL retrieved from asysnc function until lifecycle-status = completed.
    ...                Uses WUKS to call Check Post Request Status Complete
    [Arguments]    ${IMEI_Value}    ${duration}=30s    ${interval}=5s
    Wait Until Keyword Succeeds    ${duration}    ${interval}    Verify Device Is Unregistered    ${IMEI_Value}

Verify Device Is Unregistered
    [Arguments]   ${IMEI_Value}
    ${Status}   ${gresp.content}    Search IMEI from Resources Through BSSAPI   ${ENV}  ${IMEI_Value}
    ${LifeCycleStatus}  Run Keyword IF  ${Status} != True   Get Device LifeCycleStatus From Resources  ${gresp.content}
    #Log to Console  LifeCycleStatus:${LifeCycleStatus}
    #${Terminated_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  Terminated
    ${LifeCycleStatus}  Convert To String  ${LifeCycleStatus}
    Should Be Equal As Strings    ${LifeCycleStatus}    terminated
    [Rerutn]   ${lifecycle-status}
    #Log To Console  ${lifecycle-status}
    #${NoData_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  None
    #Run Keyword If  ${NoData_Status} != True    Pass    ${IMEI_Value} is registered with status ${LifeCycleStatus}

Poll Untill SIM Registered
    [Documentation]    Polls URL retrieved from asysnc function until lifecycle-status = completed.
    ...                Uses WUKS to call Check Post Request Status Complete
    [Arguments]    ${SIM_Value}    ${duration}=30s    ${interval}=5s
    Wait Until Keyword Succeeds    ${duration}    ${interval}    Verify SIM Is Registered    ${SIM_Value}

Verify SIM Is Registered
    [Arguments]   ${SIM_Value}
    ${Status}   ${gresp.content}    Search SIM from Resources Through BSSAPI   ${ENV}  ${SIM_Value}
    ${LifeCycleStatus}  Run Keyword IF  ${Status} != True   Get SIM LifeCycleStatus From Resources  ${gresp.content}
    #Log to Console  LifeCycleStatus:${LifeCycleStatus}
    #${Terminated_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  Terminated
    ${LifeCycleStatus}  Convert To String  ${LifeCycleStatus}
    Should Be Equal As Strings    ${LifeCycleStatus}    active
    [Return]   ${lifecyclestatus}
    #Log To Console  ${lifecycle-status}
    #${NoData_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  None
    #Run Keyword If  ${NoData_Status} != True    Pass    ${IMEI_Value} is registered with status ${LifeCycleStatus}

Poll Untill Subscription Blocked
    [Documentation]    Polls URL retrieved from asysnc function until lifecycle-status = completed.
    ...                Uses WUKS to call Check Post Request Status Complete
    [Arguments]    ${MSISDN_Value}    ${duration}=30s    ${interval}=5s
    ${Subscription_Product_ID}    Get Subscription Product ID By MSISDN    ${ENV}   ${MSISDN_Value}
    ${Subscription_Product_ID}      Convert To String      ${Subscription_Product_ID}
    Wait Until Keyword Succeeds    ${duration}    ${interval}    Verify Subscription Is Blocked    ${Subscription_Product_ID}

Verify Subscription Is Blocked
    [Arguments]   ${Subscription_Product_ID}
    ${LifeCycleStatus}  Get Product LifeCycleStatus    ${Subscription_Product_ID}
    #${Terminated_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  Terminated
    ${LifeCycleStatus}  Convert To String  ${LifeCycleStatus}
    Should Be Equal As Strings    ${LifeCycleStatus}    suspended
    [Return]   ${LifeCycleStatus}

Poll Untill Subscription Active
    [Documentation]    Polls URL retrieved from asysnc function until lifecycle-status = completed.
    ...                Uses WUKS to call Check Post Request Status Complete
    [Arguments]    ${MSISDN_Value}    ${duration}=30s    ${interval}=5s
    ${Subscription_Product_ID}    Get Subscription Product ID By MSISDN    ${ENV}   ${MSISDN_Value}
    ${Subscription_Product_ID}      Convert To String      ${Subscription_Product_ID}
    Wait Until Keyword Succeeds    ${duration}    ${interval}    Verify Subscription Is Active    ${Subscription_Product_ID}

Verify Subscription Is Active
    [Arguments]   ${Subscription_Product_ID}
    ${LifeCycleStatus}  Get Product LifeCycleStatus    ${Subscription_Product_ID}
    #${Terminated_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  Terminated
    ${LifeCycleStatus}  Convert To String  ${LifeCycleStatus}
    Should Be Equal As Strings    ${LifeCycleStatus}    active
    [Return]   ${lifecyclestatus}

Poll Untill Subscription Terminated
    [Documentation]    Polls URL retrieved from asysnc function until lifecycle-status = completed.
    ...                Uses WUKS to call Check Post Request Status Complete
    [Arguments]    ${MSISDN_Value}    ${duration}=30s    ${interval}=5s
    ${Subscription_Product_ID}    Get Subscription Product ID By MSISDN    ${ENV}   ${MSISDN_Value}
    ${Subscription_Product_ID}      Convert To String      ${Subscription_Product_ID}
    Wait Until Keyword Succeeds    ${duration}    ${interval}    Verify Subscription Is Terminated    ${Subscription_Product_ID}

Verify Subscription Is Terminated
    [Arguments]   ${Subscription_Product_ID}
    ${LifeCycleStatus}  Get Product LifeCycleStatus    ${Subscription_Product_ID}
    #${Terminated_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  Terminated
    ${LifeCycleStatus}  Convert To String  ${LifeCycleStatus}
    Should Be Equal As Strings    ${LifeCycleStatus}    Terminated
    [Return]   ${LifeCycleStatus}



Find IMEI on CSR
    [Arguments]  ${IMEI_Value}
    Sleep   4s
    ${Row_Count}    Get Element Count    ${Device_Table}/tbody
    ${Row_Count}    Evaluate    ${Row_Count}+1
    :FOR     ${Count_Variable}    In Range    1   ${Row_Count}
    \    ${Count_Variable}  Convert To String   ${Count_Variable}
    \    ${New_xpath}   Replace String  ${ID}   RowCount   ${Count_Variable}
    \    Log   ${New_xpath}
    \    ${IMEI_CSR}     Get Element Value   IMEICSR   ${New_xpath}
    \
    \    ${IMEI_CSR}    Convert To String   ${IMEI_CSR}
    \    ${IMEI_Value}  Convert To String   ${IMEI_Value}
    \    ${Compare_Status}  Run Keyword And Return Status   Should Be Equal  ${IMEI_CSR}   ${IMEI_Value}
    \    Exit For Loop If   ${Compare_Status} == True
    \    Log To Console  ${Count_Variable}


    Log To Console  ${Count_Variable}
    [Return]    ${Count_Variable}

Find Service on Barrings
    [Arguments]  ${Barring_Service_Name}
    Sleep   4s
    ${Barring_Service_First_Path}   Replace String  ${Barring_Service_Name_Path}    RowCount   1
    Wait Until Element Is Visible    ${Barring_Service_First_Path}   timeout=20   error=Barrings Services Not Available
    ${Row_Count}    Get Element Count    ${Barrings_Table}/tbody
    #${Row_Count}    Evaluate    ${Row_Count}+1
    :FOR     ${Count_Variable}    In Range    1   ${Row_Count}
    \    ${Count_Variable}  Convert To String   ${Count_Variable}
    \    ${New_xpath}   Replace String  ${Barring_Service_Name_Path}    RowCount   ${Count_Variable}
    \    Log   ${New_xpath}
    \    ${Barring_Service_Name_Value}     Get Element Value   ServiceName   ${New_xpath}
    \
    \    ${Barring_Service_Name_Value}    Convert To String   ${Barring_Service_Name_Value}
    \    ${Barring_Service_Name}  Convert To String   ${Barring_Service_Name}
    \    ${Compare_Status}  Run Keyword And Return Status   Should Be Equal  ${Barring_Service_Name}   ${Barring_Service_Name_Value}
    \    Exit For Loop If   ${Compare_Status} == True
    \    Log To Console  ${Count_Variable}


    Log To Console  ${Count_Variable}
    [Return]    ${Count_Variable}

Verify The New SIM Already Exists
    [Arguments]   ${SIM_Value}
    ${Status}   ${gresp.content}    Search SIM Through BSSAPI  ${ENV}  ${SIM_Value}
    ${LifeCycleStatus}  Run Keyword IF  ${Status} != True   Get SIM LifeCycleStatus From SIMCards  ${gresp.content}
    #Log to Console  LifeCycleStatus:${LifeCycleStatus}
    #${Terminated_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  Terminated
    ${LifeCycleStatus}  Convert To String  ${LifeCycleStatus}
    ${NoData_Status}   Run Keyword And Return Status  Should Be Equal  ${LifeCycleStatus}  available
    Run Keyword If  ${NoData_Status} != True    Fail    ErrorCode Primary Validation Failed, Order not submitted ${SIM_Value} is already registered as ${LifeCycleStatus}

Get Subscription Service Status
     [Arguments]    ${Service_Name}
     ${Row_Value}   Find Service on Barrings    ${Service_Name}
     ${Barring_Service_Status_Path}     Replace String      ${Barring_Service_Status_Path}  RowCount   ${Row_Value}
     ${Barring_Service_Activation_Status}   Get Element Value   BarringACTStatus   ${Barring_Service_Status_Path}
     [Return]    ${Barring_Service_Activation_Status}


Perform Service block
     [Arguments]    ${Service_Name}
     ${Row_Value}   Find Service on Barrings    ${Service_Name}
     ${Barring_Service_Activation_Path}     Replace String      ${Barring_Service_Activation_Path}  RowCount   ${Row_Value}
     Click on Element   ${Service_Name}   {Barring_Service_Activation_Path}





################################ General UI Action Keywords ###########################################################
################################ General UI Action Keywords ###########################################################
################################ General UI Action Keywords ###########################################################
################################ General UI Action Keywords ###########################################################
################################ General UI Action Keywords ###########################################################
################################ General UI Action Keywords ###########################################################


Click on Element
       [Arguments]  ${Element_Name}  ${Element_Path}
       Wait Until Element Is Visible    ${Element_Path}   timeout=20   error=${Element_Name}NotVisible
       Wait Until Element Is Enabled    ${Element_Path}   timeout=20   error=${Element_Name}NotVisible
       Click Element    ${Element_Path}

Enter Value
       [Arguments]  ${Element_Name}  ${Element_Path}   ${Input}
       Wait Until Element Is Visible    ${Element_Path}   timeout=20   error=${Element_Name}NotVisible
       Wait Until Element Is Enabled    ${Element_Path}   timeout=20   error=${Element_Name}NotVisible
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


Log In to CSR
       [Arguments]  ${URL}
       ### Open Browser and Maximize ###
       Open Browser    ${URL}   chrome
       Maximize Browser Window

       ### LogIn ###
       Enter Value  UserName    ${CM_User_ID}  ${CM_User_ID_Value}
       Enter Value  Password    ${CM_Password}  ${CM_Password_Value}
       Click on Element  Login  ${LogIn_Button}

#### Navigations ####
Navigate to Agreements
      Click on Element  Agreements  ${Agreeements_Tab}
      Capture Page Screenshot
      Click on Element  BarringActivationSubmitButton  ${Barring_service_Activation_Button_Path}
