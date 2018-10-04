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
${path_excel}    C:/Test/Sanity.xlsx
${SITuri}      http://localhost:8381
${Devuri}      http://10.150.34.184:8381
${apilink}     /ussd/preActivateSubscription?sellerId=12345678&iccid=123456789&channelId=ussd&dealerId=12345678&shortCode=ABC&channelId=ussd&reservedFor=abcd
${Creds}      Create List     admin       password

*** Keywords ***
Load Sanity Test Data

      ### Reading data from Sanity Test Data Sheet ###
      Open Excel Document     ${path_excel}  Sanity_1


      ${SA_MSISDN}      Read Excel Cell  2  3  Sanity
      ${SA_MSISDN}  Convert To String   ${SA_MSISDN}
      Set Suite Variable    ${SA_MSISDN}
      Log   ${SA_MSISDN}

      ${SA_MSISDN_SKU}      Read Excel Cell  3  3  Sanity
      ${SA_MSISDN_SKU}  Convert To String   ${SA_MSISDN_SKU}
      Set Suite Variable    ${SA_MSISDN_SKU}
      Log   ${SA_MSISDN_SKU}

      ${SA_MSISDN_Stock}      Read Excel Cell  4  3  Sanity
      ${SA_MSISDN_Stock}  Convert To String   ${SA_MSISDN_Stock}
      Set Suite Variable    ${SA_MSISDN_Stock}
      Log   ${SA_MSISDN_Stock}

      ${SA_MSISDN_Batch}      Read Excel Cell  5  3  Sanity
      ${SA_MSISDN_Batch}  Convert To String   ${SA_MSISDN_Batch}
      Set Suite Variable    ${SA_MSISDN_Batch}
      Log   ${SA_MSISDN_Batch}

      ${SA_ICC_ID}      Read Excel Cell  6  3  Sanity
      ${SA_ICC_ID}  Convert To String   ${SA_ICC_ID}
      Set Suite Variable    ${SA_ICC_ID}
      Log   ${SA_ICC_ID}

      ${SA_IMSI}      Read Excel Cell  7  3  Sanity
      ${SA_IMSI}  Convert To String   ${SA_IMSI}
      Set Suite Variable    ${SA_IMSI}
      Log   ${SA_IMSI}

      ${SA_KI}      Read Excel Cell  8  3  Sanity
      ${SA_KI}  Convert To String   ${SA_KI}
      Set Suite Variable    ${SA_KI}
      Log   ${SA_KI}

      ${SA_ICC_SKU}      Read Excel Cell  9  3  Sanity
      ${SA_ICC_SKU}   Convert To String   ${SA_ICC_SKU}
      Set Suite Variable    ${SA_ICC_SKU}
      Log   ${SA_ICC_SKU}

      ${SA_ICC_Stock}      Read Excel Cell  10  3  Sanity
      ${SA_ICC_Stock}   Convert To String   ${SA_ICC_Stock}
      Set Suite Variable    ${SA_ICC_Stock}
      Log   ${SA_ICC_Stock}

      ${SA_ICC_Batch}      Read Excel Cell  11  3  Sanity
      ${SA_ICC_Batch}   Convert To String   ${SA_ICC_Batch}
      Set Suite Variable    ${SA_ICC_Batch}
      Log   ${SA_ICC_Batch}

      ${SA_Zone}      Read Excel Cell  12  3  Sanity
      ${SA_Zone}   Convert To String   ${SA_Zone}
      Set Suite Variable    ${SA_Zone}
      Log   ${SA_Zone}

      ${SA_Reserved_For}      Read Excel Cell  13  3  Sanity
      ${SA_Reserved_For}   Convert To String   ${SA_Reserved_For}
      Set Suite Variable    ${SA_Reserved_For}
      Log   ${SA_Reserved_For}

      ${SA_Seller_ID}      Read Excel Cell  14  3  Sanity
      ${SA_Seller_ID}   Convert To String   ${SA_Seller_ID}
      Set Suite Variable    ${SA_Seller_ID}
      Log   ${SA_Seller_ID}

      ${SA_Deal_MSISDN}      Read Excel Cell  15  3  Sanity
      ${SA_Deal_MSISDN}   Convert To String   ${SA_Deal_MSISDN}
      Set Suite Variable    ${SA_Deal_MSISDN}
      Log   ${SA_Deal_MSISDN}

      ${SA_ICC_9_Digits}      Read Excel Cell  16  3  Sanity
      ${SA_ICC_9_Digits}   Convert To String   ${SA_ICC_9_Digits}
      Set Suite Variable    ${SA_ICC_9_Digits}
      Log   ${SA_ICC_9_Digits}

      ${SA_Deal_ID}      Read Excel Cell  17  3  Sanity
      ${SA_Deal_ID}   Convert To String   ${SA_Deal_ID}
      Set Suite Variable    ${SA_Deal_ID}
      Log   ${SA_Deal_ID}

      ${SA_Pre_Channel_ID}      Read Excel Cell  18  3  Sanity
      ${SA_Pre_Channel_ID}   Convert To String   ${SA_Pre_Channel_ID}
      Set Suite Variable    ${SA_Pre_Channel_ID}
      Log   ${SA_Pre_Channel_ID}

      ${SA_ShortCode}      Read Excel Cell  19  3  Sanity
      ${SA_ShortCode}   Convert To String   ${SA_ShortCode}
      Set Suite Variable    ${SA_ShortCode}
      Log   ${SA_ShortCode}

      ${SA_First_Name}      Read Excel Cell   20  3  Sanity
      ${SA_First_Name}   Convert To String   ${SA_First_Name}
      Set Suite Variable    ${SA_First_Name}
      Log   ${SA_First_Name}

      ${SA_Middle_Name}      Read Excel Cell  21  3  Sanity
      ${SA_Middle_Name}   Convert To String   ${SA_Middle_Name}
      Set Suite Variable    ${SA_Middle_Name}
      Log   ${SA_Middle_Name}

      ${SA_Last_Name}      Read Excel Cell  22  3  Sanity
      ${SA_Last_Name}    Convert To String   ${SA_Last_Name}
      Set Suite Variable    ${SA_Last_Name}
      Log   ${SA_Last_Name}

      ${SA_DOB}      Read Excel Cell  23  3  Sanity
      ${SA_DOB}    Convert To String   ${SA_DOB}
      Set Suite Variable    ${SA_DOB}
      Log   ${SA_DOB}

      ${SA_ID_Type}      Read Excel Cell  24  3  Sanity
      ${SA_ID_Type}    Convert To String   ${SA_ID_Type}
      Set Suite Variable    ${SA_ID_Type}
      Log   ${SA_ID_Type}

      ${SA_ID_Value}      Read Excel Cell  25  3  Sanity
      ${SA_ID_Value}    Convert To String   ${SA_ID_Value}
      Set Suite Variable    ${SA_ID_Value}
      Log   ${SA_ID_Value}

      ${SA_Act_Channel_ID}      Read Excel Cell  26  3  Sanity
      ${SA_Act_Channel_ID}    Convert To String   ${SA_Act_Channel_ID}
      Set Suite Variable    ${SA_Act_Channel_ID}
      Log   ${SA_Act_Channel_ID}

      ${SA_IMEI}      Read Excel Cell  27  3  Sanity
      ${SA_IMEI}    Convert To String   ${SA_IMEI}
      Set Suite Variable    ${SA_IMEI}
      Log   ${SA_IMEI}

      ${SA_Reg_Channel_ID}      Read Excel Cell  28  3  Sanity
      ${SA_Reg_Channel_ID}    Convert To String   ${SA_Reg_Channel_ID}
      Set Suite Variable    ${SA_Reg_Channel_ID}
      Log   ${SA_Reg_Channel_ID}

      ${SA_Device_Model}      Read Excel Cell  29  3  Sanity
      ${SA_Device_Model}    Convert To String   ${SA_Device_Model}
      Set Suite Variable    ${SA_Device_Model}
      Log   ${SA_Device_Model}

      ${SA_Device_Brand}      Read Excel Cell  30  3  Sanity
      ${SA_Device_Brand}    Convert To String   ${SA_Device_Brand}
      Set Suite Variable    ${SA_Device_Brand}
      Log   ${SA_Device_Brand}

      ${SA_Device_Type}      Read Excel Cell  31  3  Sanity
      ${SA_Device_Type}    Convert To String   ${SA_Device_Type}
      Set Suite Variable    ${SA_Device_Type}
      Log   ${SA_Device_Type}

      ${SA_Vocher}      Read Excel Cell  32  3  Sanity
      ${SA_Vocher}    Convert To String   ${SA_Vocher}
      Set Suite Variable    ${SA_Vocher}
      Log   ${SA_Vocher}

      ${SA_TP_Channel_ID}      Read Excel Cell  33  3  Sanity
      ${SA_TP_Channel_ID}    Convert To String   ${SA_TP_Channel_ID}
      Set Suite Variable    ${SA_TP_Channel_ID}
      Log   ${SA_TP_Channel_ID}

      ${SA_Sales_Code}      Read Excel Cell  34  3  Sanity
      ${SA_Sales_Code}    Convert To String   ${SA_Sales_Code}
      Set Suite Variable    ${SA_Sales_Code}
      Log   ${SA_Sales_Code}

      ${SA_PP_Channel_ID}      Read Excel Cell  35  3  Sanity
      ${SA_PP_Channel_ID}    Convert To String   ${SA_PP_Channel_ID}
      Set Suite Variable    ${SA_PP_Channel_ID}
      Log   ${SA_PP_Channel_ID}