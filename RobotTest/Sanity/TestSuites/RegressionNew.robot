*** Settings ***
Documentation    Regression test for Millicom Bolivia RFC
...              This suite covers
...              SALES - Preactivation, Activation, Device Registration, Purchase Paquetigo and Top up
...              CARE - Customer Search, Modification of Customer Data, Register Device, Block Device, Unblock Device, Unregister Device,Change MSISDN, Change SIM, Block Subscription (Customer Request), Unblock Subscription (Customer Request), Block Subscription (Fraud), Unblock Subscription (Fraud), Terminate subscription
...              CASES - Create global Case, Create Customer case, Manage Case, Escalate Case, Show case

Library  Selenium2Library
Library  JSONLibrary
Library  RequestsLibrary
Library  OperatingSystem
Library  Collections
Library  simplejson
Library  String
Library  HttpLibrary.HTTP
Library  builtin
Library  SSHLibrary
#Library  AppiumLibrary
Library  ExcelLibrary
Library    DependencyLibrary

Resource  ../Keywords/JSON.robot
Resource  ../Keywords/CBA.robot
Resource  ../Keywords/CSR.robot
Resource  ../Keywords/CaseManagement.robot
Resource  ../../Keywords/BSSQueries.robot
Resource  ../Prerequisites/ResourceLoading.robot
Resource  ../Prerequisites/TestDataLoading.robot
#Resource  ../TestCases/CSR/SearchCustomer.robot

#Suite Setup        Set Up - Suite

#Suite Teardown     Tear Down - Suite


*** Variables ***
${STALE_ELEMENT_SLEEP}    2s
${SIT}      http://localhost
${Dev}   http://10.150.34.184
${USSD_Port}    8381
${BSS_Port}     3010
${CSR_Port}     7500
${Creds}      Create List     admin       password

${CM_Password_Value}  csr
${CM_User_ID_Value}   csr
${MSISDN_Value}     59169413620
${SIM_Value}    8959103000436021039
${Customer_Name_Value}   TEST35 EE
${IMEI_Value}   520645455606981
${Device_Brand_Value}     Apple
${Device_Model_Value}     Automation
${Contact_MSISDN_Value}   59177010142
${Device_Type_Value}      Regression
${Report_ID_Value}    AutomationTest123
${Report_Name_Value}  AutomationTester
${URL}   http://10.150.34.184:7500



*** Test Cases ***
#Preactivation
     #[Tags]    Sanity    CBA
     #${Preactivation_Status}     Verify MSISDN Status In ResourceRelations   ${SA_MSISDN}
     #Run Keyword IF    "${Preactivation_Status}" == "preactivation"    Log   MSISDN Is Aleardy Preactivated
     #Run Keyword IF    "${Preactivation_Status}" == "None"     Perform Preactivation

#Issue New Subscription
     #[Tags]    Sanity    CBA
     #Depends on test  Preactivation
     #${MSISDN_Status_Resources}     Verify MSISDN Status In CIM   ${SA_MSISDN}
     #Run Keyword IF    "${MSISDN_Status_Resources}" == "active"    Log   MSISDN Is Aleardy active
     #Run Keyword IF    "${MSISDN_Status_Resources}" == "pending" or "${MSISDN_Status_Resources}" == "terminated"    Fail   ErrorCode:MSISDN Is IN ${MSISDN_Status_Resources} Status
     #Run Keyword IF    "${MSISDN_Status_Resources}" == "None"     Perform Activation

#Device Registration
     #[Tags]    Sanity    CBA
     #Depends on test  Issue New Subscription
     #${Device_Status_Resources}     Verify Device Status In CIM   ${SA_IMEI}
     #Run Keyword IF    "${Device_Status_Resources}" == "active"    Log   Device Is Aleardy active
     #Run Keyword IF    "${Device_Status_Resources}" == "pending" or "${MSISDN_Status_Resources}" == "terminated"    Fail   ErrorCode:Device Is IN ${Device_Status_Resources} Status
     #Run Keyword IF    "${Device_Status_Resources}" == "None"     Perform Device registration

#Top up
     #[Tags]    Sanity    CBA
     #Depends on test  Issue New Subscription
     #Perform Top up

#Purchase Paquetigo
     #[Tags]    Sanity    CBA
     #Depends on test  Issue New Subscription
     #Depends on test  Top up
     #Perform Purchase Paquetigo

#Show Subscription Information In CSR
     #[Tags]    Sanity    CBA
     #Depends on test  Issue New Subscription
     #Log In to CSR  ${URL}
     #Search Customer Through MSISDN   ${MSISDN_Value}

#Register Device Through CSR
     #Depends on test  Show Subscription Information In CSR
     #Sleep  2s
     #${Device_Status_Resources}     Verify Device Status In CIM   ${RG_RD_IMEI}
     #Run Keyword IF    "${Device_Status_Resources}" == "active"    Log   Device Is Aleardy Registered
     #Run Keyword IF    "${Device_Status_Resources}" == "pending" or "${MSISDN_Status_Resources}" == "terminated"    Fail   ErrorCode:Device Is IN ${Device_Status_Resources} Status
     #Run Keyword IF    "${Device_Status_Resources}" == "None"     Perform Device registration Through CSR


#Block Device Through CSR
     #Depends on test  Register Device Through CSR
     #Sleep  2s
     #${Device_Status_Resources}     Verify Device Status In CIM   ${RG_RD_IMEI}
     #${Device_White_List_Status}    Verify Device EIR Status In RIM   ${RG_RD_IMEI}
     #Run Keyword IF    "${Device_Status_Resources}" == "active" and "${Device_White_List_Status}" == "B"   Log   Device Is Aleardy Blocked
     #Run Keyword IF    "${Device_Status_Resources}" == "active" and "${Device_White_List_Status}" == "W"   Perform Block Device Through CSR
     #Run Keyword IF    "${Device_Status_Resources}" == "pending" or "${MSISDN_Status_Resources}" == "terminated"    Fail   ErrorCode:Device Is IN ${Device_Status_Resources} Status
     #Run Keyword IF    "${Device_Status_Resources}" == "None" or "${Device_White_List_Status}" == "None"    Fail   ErrorCode:Device Details not available either in RIM or CIM


#Unblock Device Through CSR
     #Depends on test  Block Device Through CSR
     #Sleep  2s
     #${Device_Status_Resources}     Verify Device Status In CIM   ${RG_RD_IMEI}
     #${Device_White_List_Status}    Verify Device EIR Status In RIM   ${RG_RD_IMEI}
     #Run Keyword IF    "${Device_Status_Resources}" == "active" and "${Device_White_List_Status}" == "W"   Log   Device Is In whiteList
     #Run Keyword IF    "${Device_Status_Resources}" == "active" and "${Device_White_List_Status}" == "B"   Perform Unblock Device Through CSR
     #Run Keyword IF    "${Device_Status_Resources}" == "pending" or "${MSISDN_Status_Resources}" == "terminated"    Fail   ErrorCode:Device Is IN ${Device_Status_Resources} Status
     #Run Keyword IF    "${Device_Status_Resources}" == "None" or "${Device_White_List_Status}" == "None"    Fail   ErrorCode:Device Details not available either in RIM or CIM


#Unregister Device Through CSR
     #Depends on test  Register Device Through CSR
     #Sleep  2s
     #${Device_Status_Resources}     Verify Device Status In CIM   ${RG_RD_IMEI}
     #Run Keyword IF    "${Device_Status_Resources}" == "None"    Fail   ErrorCode:Device Not Existing In CIM
     #Run Keyword IF    "${Device_Status_Resources}" == "pending"  Fail   ErrorCode:Device Is IN ${Device_Status_Resources} Status
     #Run Keyword IF    "${MSISDN_Status_Resources}" == "terminated"    Log     Device Is Aleardy termianted
     #Run Keyword IF    "${Device_Status_Resources}" == "active"     Perform Unblock Device Through CSR

#Change SIM Through CSR
     #Depends on test  Show Subscription Information In CSR
     #Sleep  2s
     #${SIM_Status_Resources}    Verify SIM Status In CIM    ${RG_CS_NEW_ICC_ID}
     #Run Keyword IF    "${SIM_Status_Resources}" == "active"    Log   SIM Is Already Active
     #Run Keyword IF    "${SIM_Status_Resources}" == "None"  Fail   Perfom SIM Change Thorugh CSR
     #Run Keyword IF    "${SIM_Status_Resources}" != "active" or "${SIM_Status_Resources}" != "None"   Fail  SIM Is In ${SIM_Status_Resourcs} Status In CIM


#Block Subscription For Fraud Reason Through CSR
     #Depends on test  Show Subscription Information In CSR
     #Sleep  2s
     #${Subscription_Product_ID}     Get Subscription Product ID By MSISDN   ${RG_BSC_MSISDN}
     #${Subscription_Status}     Get Product LifeCycleStatus     ${Subscription_Product_ID}
     #Run Keyword IF    "${Subscription_Status}" == "suspended"    Log   Subscription Is Already Suspended
     #Run Keyword IF    "${Subscription_Status}" == "active"  Perform Block Subscription For Fruad Reason Through CSR
     #Run Keyword IF    "${Subscription_Status}" != "active" or "${SIM_Status_Resources}" != "suspended"    Fail    Susbcription is in  ${Subscription_Status} Status and not eligible for suspension

#UnBlock Subscription For Fraud Reason Through CSR
     #Depends on test  Show Subscription Information In CSR
     #Depends on test  Block Subscription For Fraud Reason Through CSR
     #Sleep  2s
     #${Subscription_Product_ID}     Get Subscription Product ID By MSISDN   ${RG_BSC_MSISDN}
     #${Subscription_Status}     Get Product LifeCycleStatus     ${Subscription_Product_ID}
     #Run Keyword IF    "${Subscription_Status}" == "active"    Log   Subscription Is Already active
     #Run Keyword IF    "${Subscription_Status}" == "suspended"  Perform Unblock Subscription For Fruad Reason Through CSR
     #Run Keyword IF    "${Subscription_Status}" != "active" or "${SIM_Status_Resources}" != "suspended"    Fail    Susbcription is in  ${Subscription_Status} Status and not eligible for suspension


########################################################
################  Manage Barring's  ####################
########################################################

Suspendido Cambio de SIM
     #Depends on test  Show Subscription Information In CSR
     #Sleep  2s
     Log In to CSR  http://csr-rfc.tigo.net.bo:7500
     Search Customer Through MSISDN     59177020075
     #Navigate to Agreements
     Click on Element   BarringsLink    ${Barrings_Link}
     ${ChangeSIM_Service_Status}    Get Subscription Service Status   Cambio de SIM
     Run Keyword IF     "${ChangeSIM_Service_Status}" == "INACTIVO"     Perform Service block   Cambio de SIM
     #Run Keyword IF     "${ChangeSIM_Service_Status}" == "ACTIVA"     Log   Change SIM Service Is Already Blocked
     Run Keyword IF     "${ChangeSIM_Service_Status}" == "ACTIVA"     Run Keywords
     ...    Log     Change SIM Service Is Already Blocked
     ...    AND     Capture Page Screenshot


#Reanudar Cambio de SIM
     #Depends on test  Show Subscription Information In CSR
     #Depends on test  Suspendido Cambio de SIM
     #Sleep  2s
     #${ChangeSIM_Service_Status}    Get Subscription Service Status   Cambio de SIM
     #Run Keyword IF     "${ChangeSIM_Service_Status}" == "ACTIVA"     Perform Service unblock   Cambio de SIM
     #Run Keyword IF     "${ChangeSIM_Service_Status}" == "INACTIVO"     Log   Change SIM Service Is Already Active

#Suspendido Alerta de Llamadas Perdidas
     #Depends on test  Show Subscription Information In CSR
     #Sleep  2s
     #${MissedCallAlert_Service_Status}    Get Subscription Service Status   Alerta de Llamadas Perdidas
     #Run Keyword IF     "${MissedCallAlert_Service_Status}" == "INACTIVO"     Perform Service block   Alerta de Llamadas Perdidas
     #Run Keyword IF     "${MissedCallAlert_Service_Status}" == "ACTIVA"     Log   Missed Call Alert Is Already Blocked

#Reanudar Alerta de Llamadas Perdidas
     #Depends on test  Show Subscription Information In CSR
     #Depends on test  Suspendido Alerta de Llamadas Perdidas
     #Sleep  2s
     #${MissedCallAlert_Service_Status}    Get Subscription Service Status   Alerta de Llamadas Perdidas
     #Run Keyword IF     "${MissedCallAlert_Service_Status}" == "ACTIVA"     Perform Service unblock   Alerta de Llamadas Perdidas
     #Run Keyword IF     "${MissedCallAlert_Service_Status}" == "INACTIVO"     Log   Missed Call Alert Is Already Active


#Suspendido Buzón de Voz
     #Depends on test  Show Subscription Information In CSR
     #Sleep  2s
     #${VoiceMail_Service_Status}    Get Subscription Service Status   Buzón de Voz
     #Run Keyword IF     "${VoiceMail_Service_Status}" == "INACTIVO"     Perform Service block   Buzón de Voz
     #Run Keyword IF     "${VoiceMail_Service_Status}" == "ACTIVA"     Log   Voice Mail Service Is Already Blocked

#Reanudar Buzón de Voz
     #Depends on test  Show Subscription Information In CSR
     #Depends on test  Suspendido Buzón de Voz
     #Sleep  2s
     #${VoiceMail_Service_Status}    Get Subscription Service Status   Buzón de Voz
     #Run Keyword IF     "${VoiceMail_Service_Status}" == "INACTIVO"     Perform Service block   Buzón de Voz
     #Run Keyword IF     "${VoiceMail_Service_Status}" == "ACTIVA"     Log   Voice Mail Service Is Already Blocked





*** Keywords ***
Set Up - Suite

     Load Sanity Test Data
     Load MSISDN To HPD
     Load SIM To HPD
     Reserve Selected MSISDN

Tear Down - Suite
     Delete All Sessions


Load MSISDN To HPD
     ${MSISDN_Available_Status}     Verify MSISDN Status In RIM   ${SA_MSISDN}
     Run Keyword IF    "${MSISDN_Available_Status}" == "available"    Log   MSISDN Is Aleardy Loaded
     Run Keyword IF    "${MSISDN_Available_Status}" == "None"     Load MSISDN

Load SIM To HPD
     ${SIM_Available_Status}     Verify SIM Status In RIM     ${SA_ICC_ID}
     Run Keyword IF    "${SIM_Available_Status}" == "available"    Log   SIM Is Aleardy Loaded
     Run Keyword IF    "${SIM_Available_Status}" == "None"     Load SIM

Reserve Selected MSISDN
     ${MSISDN_Reserve_Status}     Verify MSISDN Status In RIM   ${SA_MSISDN}
     Run Keyword IF    "${MSISDN_Reserve_Status}" == "reserved"    Log   MSISDN Is Aleardy Reserved
     Run Keyword IF    "${MSISDN_Reserve_Status}" == "available"     Reserve MSISDN

Perform Preactivation
     ${link}    Construct Preactivation CBA Uri
     ${API_Response}  Post API Request   ${SIT}:${USSD_Port}   ${link}
     ${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     Create Session    Manageo  ${SIT}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

Perform Activation
     ${link}    Construct Activation CBA Uri
     ${API_Response}  Post API Request   ${SIT}:${USSD_Port}   ${link}
     ${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     Create Session    Manageo  ${SIT}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

#Search Customer Through MSISDN
     #Log In to CSR  ${URL}
     #Search Customer Through MSISDN   ${MSISDN_Value}

Perform Device registration
     ${link}    Construct Device Registration CBA Uri
     ${API_Response}  Post API Request   ${SIT}:${USSD_Port}   ${link}
     ${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     Create Session    Manageo  ${SIT}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

Perform Top up
     ${link}    Construct Top Up CBA Uri
     ${API_Response}  Post API Request   ${SIT}:${USSD_Port}   ${link}
     ${Reference_Number}  Get Reference ID From Respose   ${API_Response}
     Create Session    Manageo  ${SIT}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

Perform Purchase Paquetigo
     ${link}    Construct Purchase Paquetigo CBA Uri
     ${API_Response}  Post API Request   ${SIT}:${USSD_Port}   ${link}
     ${Reference_Number}  Get ID From Respose   ${API_Response}
     Create Session    Manageo  ${SIT}:${BSS_Port}
     ${OrderStatus_Response}   poll until status complete    /api/async-functions/${Reference_Number}

Perform Device registration Through CSR
     Search Customer Through MSISDN   ${RG_RD_MSISDN}
     Register Device    ${RG_RD_IMEI}

Perform Block Device Through CSR
     Search Customer Through MSISDN   ${RG_BD_MSISDN}
     Block Device   ${RG_BD_IMEI}

Perform Unblock Device Through CSR
     Search Customer Through MSISDN   ${MSISDN_Value}
     UnBlock Device     ${IMEI_Value}

Perfom SIM Change Thorugh CSR
     Search Customer Through MSISDN   ${MSISDN_Value}
     Change SIM   ${SIM_Value}

Perform Block Subscription For Fruad Reason Through CSR
     Search Customer Through MSISDN   ${MSISDN_Value}
     Block Subscription Due To Fraud    ${MSISDN_Value}

Perform Unblock Subscription For Fruad Reason Through CSR
     Search Customer Through MSISDN   ${MSISDN_Value}
     UnBlock Subscription Due To Fraud    ${MSISDN_Value}

