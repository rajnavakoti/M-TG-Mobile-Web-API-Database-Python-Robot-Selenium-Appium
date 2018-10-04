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
Library  builtin
Library  Datachange.py
Library  UtilityKeywords.py
Library  SSHLibrary
#Library  AppiumLibrary
Library  ExcelLibrary
Resource  ../../Keywords/JSON.robot

*** Variables ***
${STALE_ELEMENT_SLEEP}    2s
#${path_excel}    C:/Test/CBA.xlsx
${SITuri}      http://localhost:8381
${Devuri}      http://10.150.34.184:8381
${apilink}     /ussd/preActivateSubscription?sellerId=12345678&iccid=123456789&channelId=ussd&dealerId=12345678&shortCode=ABC&channelId=ussd&reservedFor=abcd
${Creds}      Create List     admin       password




*** Keywords ***

Read Preactivation Data From Excel And Construct CBA Uri

      ### Reading data from Sanity Test Data Sheet ###
      Open Excel Document     ${path_excel}  doc_1
      ${Seller_Id}      Read Excel Cell  2  1  Preactivation
      ${Reserved_MSISDN}    Read Excel Cell  2  2  Preactivation
      ${Dealer_MSISDN}    Read Excel Cell  2  3  Preactivation
      ${ICC_ID}     Read Excel Cell  2  4  Preactivation
      ${Reserved_For}        Read Excel Cell  2  5  Preactivation
      ${Dealer_ID}     Read Excel Cell  2  6  Preactivation
      ${Channel_ID}     Read Excel Cell  2  7  Preactivation
      ${Short_Code}  Read Excel Cell  2  8  Preactivation


      ### Converting Data variables to String ###
      ${Seller_Id}    Convert To String   ${Seller_Id}
      ${Reserved_MSISDN}    Convert To String   ${Reserved_MSISDN}
      ${Dealer_MSISDN}    Convert To String   ${Dealer_MSISDN}
      ${ICC_ID}  Convert To String  ${ICC_ID}
      ${Reserved_For}  Convert To String  ${Reserved_For}
      ${Dealer_ID}  Convert To String  ${Dealer_ID}
      ${Channel_ID}  Convert To String  ${Channel_ID}
      ${Short_Code}  Convert To String  ${Short_Code}


      ### Constructing CBA Post Uri ###
      ${link}   Set Variable    /ussd/preActivateSubscription?sellerId=${Seller_Id}&reservedMsisdn=${Reserved_MSISDN}&dealerMsisdn=${Dealer_MSISDN}&iccid=${ICC_ID}&reservedFor=${Reserved_For}&dealerId=${Dealer_ID}&channelId=${Channel_ID}&shortCode=${Short_Code}
      ${link}    Convert To String   ${link}
      ${ulink}  Set Suite Variable    ${link}

      ### Print Request Uri ###
      Log  ${link}

Read Activate New Customer Data From Excel And Construct CBA Uri

      ### Reading data from Sanity Test Data Sheet ###
      Open Excel Document     ${path_excel}  doc_8
      ${FirstName}      Read Excel Cell  2  1  ActivateNewCustomer
      ${SurnameName_one}    Read Excel Cell  2  2   ActivateNewCustomer
      ${SurnameName_two}    Read Excel Cell  2  3   ActivateNewCustomer
      ${DOB}        Read Excel Cell  2  4  ActivateNewCustomer
      ${IDType}     Read Excel Cell  2  5  ActivateNewCustomer
      ${ID}     Read Excel Cell  2  6  ActivateNewCustomer
      ${MSISDN}     Read Excel Cell  2  7  ActivateNewCustomer
      ${ChannelID}  Read Excel Cell  2  8  ActivateNewCustomer
      ${SellerID}  Read Excel Cell  2  9  ActivateNewCustomer



      ### Converting Data variables to String ###
      ${FirstName}    Convert To String   ${FirstName}
      ${SurnameName_one}    Convert To String   ${SurnameName_one}
      ${SurnameName_two}    Convert To String    ${SurnameName_two}
      ${DOB}        Convert To String   ${DOB}
      ${IDType}     Convert To String   ${IDType}
      ${ID}     Convert To String   ${ID}
      ${MSISDN}     Convert To String   ${MSISDN}
      ${ChannelID}  Convert To String   ${ChannelID}
      ${SellerID}  Convert To String   ${SellerID}


      ### Constructing CBA Post Uri ###
      ${link}   Set Variable    /ussd/activateNewCustomer?firstName=${FirstName}&surname1=${SurnameName_one}&surname2=${SurnameName_two}&dateOfBirth=${DOB}&idType=${IDType}&id=${ID}&msisdn=${MSISDN}&channelId=${ChannelID}&sellerId=${SellerID}
      ${link}   Convert To String   ${link}
      ${ulink}  Set Suite Variable    ${link}

      ### Print Request Uri ###
      Log  ${link}


Read Nominate New Customer Data From Excel And Construct CBA Uri

      ### Reading data from Sanity Test Data Sheet ###
      Open Excel Document     ${path_excel}  doc_2
      ${FirstName}      Read Excel Cell  2  1  NominateNewCustomer
      ${SurnameName_one}    Read Excel Cell  2  2   NominateNewCustomer
      ${SurnameName_two}    Read Excel Cell  2  3   NominateNewCustomer
      ${SurnameName_three}     Read Excel Cell  2  4  NominateNewCustomer
      ${Nationality}     Read Excel Cell  2  5  NominateNewCustomer
      ${DOB}        Read Excel Cell  2  6  NominateNewCustomer
      ${IDType}     Read Excel Cell  2  7  NominateNewCustomer
      ${ID}     Read Excel Cell  2  8  NominateNewCustomer
      ${MSISDN}     Read Excel Cell  2  9  NominateNewCustomer
      ${ChannelID}  Read Excel Cell  2  10  NominateNewCustomer
      ${SellerID}  Read Excel Cell  2  11  NominateNewCustomer



      ### Converting Data variables to String ###
      ${FirstName}    Convert To String   ${FirstName}
      ${SurnameName_one}    Convert To String   ${SurnameName_one}
      ${SurnameName_two}    Convert To String    ${SurnameName_two}
      ${SurnameName_three}     Convert To String   ${SurnameName_three}
      ${Nationality}     Convert To String    ${Nationality}
      ${DOB}        Convert To String   ${DOB}
      ${IDType}     Convert To String   ${IDType}
      ${ID}     Convert To String   ${ID}
      ${MSISDN}     Convert To String   ${MSISDN}
      ${ChannelID}  Convert To String   ${ChannelID}
      ${SellerID}  Convert To String   ${SellerID}


      ### Constructing CBA Post Uri ###
      ${link}   Set Variable    /ussd/nominateNewCustomerTM?firstName=${FirstName}&surname1=${SurnameName_one}&surname2=${SurnameName_two}&dateOfBirth=${DOB}&nationality=${Nationality}&idType=${IDType}&id=${ID}&msisdn=${MSISDN} &channelId=${ChannelID}&sellerId=${SellerID}
      ${link}   Convert To String   ${link}
      ${ulink}  Set Suite Variable    ${link}

      ### Print Request Uri ###
      Log  ${link}

Read Nominate Existing Customer Data From Excel And Construct CBA Uri

      ### Reading data from Sanity Test Data Sheet ###
      Open Excel Document     ${path_excel}  doc_3
      ${IDType}     Read Excel Cell  2  1  NominateExistingCustomer
      ${ID}     Read Excel Cell  2  2  NominateExistingCustomer
      ${MSISDN}     Read Excel Cell  2  3  NominateExistingCustomer
      ${ChannelID}  Read Excel Cell  2  4  NominateExistingCustomer
      ${SellerID}  Read Excel Cell  2  5  NominateExistingCustomer


      ### Converting Data variables to String ###
      ${IDType}     Convert To String   ${IDType}
      ${ID}     Convert To String   ${ID}
      ${MSISDN}     Convert To String   ${MSISDN}
      ${ChannelID}  Convert To String   ${ChannelID}
      ${SellerID}  Convert To String   ${SellerID}


      ### Constructing CBA Post Uri ###
      ${link}   Set Variable    /ussd/nominateExistingCustomerTM?idType=${IDType}&id=${ID}&msisdn=${MSISDN}&channelId=${ChannelID}&sellerId=${SellerID}
      ${link}    Convert To String   ${link}
      ${ulink}  Set Suite Variable    ${link}

      ### Print Request Uri ###
      Log  ${link}



Read Register Device Existing Customer Data From Excel And Construct CBA Uri

      ### Reading data from Sanity Test Data Sheet ###
      Open Excel Document     ${path_excel}  doc_4
      ${IDType}     Read Excel Cell  2  1  RegisterDeviceExistingCustomer
      ${ID}     Read Excel Cell  2  2  RegisterDeviceExistingCustomer
      ${MSISDN}     Read Excel Cell  2  3  RegisterDeviceExistingCustomer
      ${IMEI}     Read Excel Cell  2  4  RegisterDeviceExistingCustomer
      ${ChannelID}  Read Excel Cell  2  5  RegisterDeviceExistingCustomer
      ${SellerID}  Read Excel Cell  2  6  RegisterDeviceExistingCustomer
      ${Device_Brand}   Read Excel Cell  2  7  RegisterDeviceExistingCustomer
      ${Device_Model}   Read Excel Cell  2  8  RegisterDeviceExistingCustomer


      ### Converting Data variables to String ###
      ${IDType}     Convert To String   ${IDType}
      ${ID}     Convert To String   ${ID}
      ${MSISDN}     Convert To String   ${MSISDN}
      ${IMEI}     Convert To String   ${IMEI}
      ${ChannelID}  Convert To String   ${ChannelID}
      ${Device_Brand}  Convert To String   ${Device_Brand}
      ${Device_Model}  Convert To String   ${Device_Model}


      ### Constructing CBA Post Uri ###
      ${link}   Set Variable    /ussd/registerDeviceExistingCustomer?idType=${IDType}&id=${ID}&msisdn=${MSISDN}&imei=${IMEI}&channelId=${ChannelID}&sellerId=${SellerID}&deviceBrand=${Device_Brand}&deviceModel=${Device_Model}
      ${link}    Convert To String   ${link}
      ${ulink}  Set Suite Variable    ${link}

      ### Print Request Uri ###
      Log  ${link}


Read Register Device New Customer Data From Excel And Construct CBA Uri

      ### Reading data from Sanity Test Data Sheet ###
      Open Excel Document     ${path_excel}  doc_5
      ${FirstName}      Read Excel Cell  2  1  RegisterDeviceNewCustomer
      ${SurnameName_one}    Read Excel Cell  2  2   RegisterDeviceNewCustomer
      ${SurnameName_two}    Read Excel Cell  2  3   RegisterDeviceNewCustomer
      ${Nationality}     Read Excel Cell  2  5  RegisterDeviceNewCustomer
      ${DOB}        Read Excel Cell  2  4  RegisterDeviceNewCustomer
      ${IDType}     Read Excel Cell  2  6  RegisterDeviceNewCustomer
      ${ID}     Read Excel Cell  2  7  RegisterDeviceNewCustomer
      ${MSISDN}     Read Excel Cell  2  8  RegisterDeviceNewCustomer
      ${IMEI}      Read Excel Cell  2  9  RegisterDeviceNewCustomer
      ${ChannelID}  Read Excel Cell  2  10  RegisterDeviceNewCustomer
      ${SellerID}  Read Excel Cell  2  11  RegisterDeviceNewCustomer
      ${Device_Brand}   Read Excel Cell  2  12  RegisterDeviceNewCustomer
      ${Device_Model}   Read Excel Cell  2  13  RegisterDeviceNewCustomer


      ### Converting Data variables to String ###
      ${FirstName}    Convert To String   ${FirstName}
      ${SurnameName_one}    Convert To String   ${SurnameName_one}
      ${SurnameName_two}    Convert To String    ${SurnameName_two}
      ${Nationality}     Convert To String    ${Nationality}
      ${DOB}        Convert To String   ${DOB}
      ${IDType}     Convert To String   ${IDType}
      ${ID}     Convert To String   ${ID}
      ${MSISDN}     Convert To String   ${MSISDN}
      ${IMEI}   Convert To String   ${IMEI}
      ${ChannelID}  Convert To String   ${ChannelID}
      ${SellerID}  Convert To String   ${SellerID}
      ${Device_Brand}  Convert To String   ${Device_Brand}
      ${Device_Model}  Convert To String   ${Device_Model}


      ### Constructing CBA Post Uri ###
      ${link}   Set Variable    /ussd/registerDevice?firstName=${FirstName}&surname1=${SurnameName_one}&surname2=${SurnameName_two}&dateOfBirth=${DOB}&nationality=${Nationality}&idType=${IDType}&id=${ID}&msisdn=${MSISDN}&imei=${IMEI}&channelId=${ChannelID}&sellerId=${SellerID}&deviceBrand=${Device_Brand}&deviceModel=${Device_Model}
      ${link}    Convert To String   ${link}
      ${ulink}  Set Suite Variable    ${link}

      ### Print Request Uri ###
      Log  ${link}

Read Topup Data From Excel And Construct CBA Uri

      ### Reading data from Sanity Test Data Sheet ###
      Open Excel Document     ${path_excel}  doc_6
      ${MSISDN}     Read Excel Cell  2  1  TopUp
      ${PIN}     Read Excel Cell  2  2  TopUp
      ${ChannelID}  Read Excel Cell  2  3  TopUp
      ${SellerID}  Read Excel Cell  2  4  TopUp


      ### Converting Data variables to String ###
      ${MSISDN}     Convert To String   ${MSISDN}
      ${PIN}     Convert To String   ${PIN}
      ${ChannelID}  Convert To String   ${ChannelID}
      ${SellerID}  Convert To String   ${SellerID}


      ### Constructing CBA Post Uri ###
      ${link}   Set Variable   /ussd/voucherTopup?msisdn=${MSISDN}&pin=${PIN}&channelId=${ChannelID}&sellerId=${SellerID}
      ${link}    Convert To String   ${link}
      ${ulink}  Set Suite Variable    ${link}

      ### Print Request Uri ###
      Log  ${link}

Read Purchase Paquetigo Data From Excel And Construct CBA Uri

      ### Reading data from Sanity Test Data Sheet ###
      Open Excel Document     ${path_excel}  doc_7
      ${MSISDN}     Read Excel Cell  2  1  PurchasePaquetigo
      ${Sales_Code}     Read Excel Cell  2  2  PurchasePaquetigo
      ${ChannelID}  Read Excel Cell  2  3  PurchasePaquetigo

      ### Converting Data variables to String ###
      ${MSISDN}     Convert To String   ${MSISDN}
      ${Sales_Code}     Convert To String   ${Sales_Code}
      ${ChannelID}  Convert To String   ${ChannelID}


      ### Constructing CBA Post Uri ###
      ${link}   Set Variable   /ussd/purchasePaquetigo?msisdn=${MSISDN}&salesCode=${Sales_Code}&channelId=${ChannelID}
      ${link}    Convert To String   ${link}
      ${ulink}  Set Suite Variable    ${link}

      ### Print Request Uri ###
      Log  ${link}


############# New Keywords #################

Construct Preactivation CBA Uri
       ${link}   Set Variable    /ussd/preActivateSubscription?sellerId=${SA_Seller_ID}&reservedMsisdn=${SA_MSISDN}&dealerMsisdn=${SA_Deal_MSISDN}&iccid=${SA_ICC_9_Digits}&reservedFor=${SA_Reserved_For}&dealerId=${SA_Deal_ID}&channelId=${SA_Pre_Channel_ID}&shortCode=${SA_ShortCode}
      ${link}    Convert To String   ${link}
      Log  ${link}
      [Return]  ${link}

Construct Activation CBA Uri
      ${link}   Set Variable    /ussd/activateNewCustomer?firstName=${SA_First_Name}&surname1=${SA_Middle_Name}&surname2=${SA_Last_Name}&dateOfBirth=${SA_DOB}&idType=${SA_ID_Type}&id=${SA_ID_Value}&msisdn=${SA_MSISDN}&channelId=${SA_Act_Channel_ID}&sellerId=${SA_Seller_ID}
      ${link}   Convert To String   ${link}
      ${ulink}  Set Suite Variable    ${link}
      Log  ${link}
      [Return]  ${link}

Construct Device Registration CBA Uri
       ${SA_MSISDN}     Get Substring   ${SA_MSISDN}    3
       ${link}   Set Variable    /ussd/registerDeviceExistingCustomer?idType=${SA_ID_Type}&id=${SA_ID_Value}&msisdn=${SA_MSISDN}&imei=${SA_IMEI}&channelId=${SA_Reg_Channel_ID}&sellerId=${SA_Seller_ID}&deviceBrand=${SA_Device_Brand}&deviceModel=${SA_Device_Model}
      ${link}    Convert To String   ${link}
      ${ulink}  Set Suite Variable    ${link}
      Log  ${link}
      [Return]  ${link}


Construct Top Up CBA Uri
      ${SA_MSISDN}     Get Substring   ${SA_MSISDN}    3
      ${link}   Set Variable   /ussd/voucherTopup?msisdn=${SA_MSISDN}&pin=${SA_Vocher}&channelId=${SA_TP_Channel_ID}&sellerId=${SA_Seller_ID}
      ${link}    Convert To String   ${link}
      ${ulink}  Set Suite Variable    ${link}
      Log  ${link}
      [Return]  ${link}

Construct Purchase Paquetigo CBA Uri
      ${link}   Set Variable   /ussd/purchasePaquetigo?msisdn=${SA_MSISDN}&salesCode=${SA_Sales_Code}&channelId=${SA_PP_Channel_ID}
      ${link}    Convert To String   ${link}
      ${ulink}  Set Suite Variable    ${link}
      Log  ${link}
      [Return]  ${link}
