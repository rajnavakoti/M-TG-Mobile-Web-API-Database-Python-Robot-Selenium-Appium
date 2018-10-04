*** Settings ***
Documentation    Suite description


*** Variable ***

## Login Page (LP) ##
${POS_User_Name_text_box}    xpath://*[@id="username"]
${POS_Password_text_box}   xpath://*[@id="password"]
${POS_Login_in_button}    xpath://*[@id="kc-login"]

## Header ##
${POS_Header_Shop_tab}      //*[@id="servicedesk-shop-link"]


## Customer Creation Page (CCP) ##
${POS_CCP_Create_Customer_button}     xpath://*[@id="buttonStartNewCustomerCase"]
${POS_CCP_Create_Customer_casebar_button}      xpath://*[@id="CustomerCaseBar-buttons"]
${POS_CCP_Create_Individual_button}     xpath://*[@id="pos-create-individual-button"]
${POS_CCP_First_Name_Textbox}     xpath://*[@id="inputFirstNameIntoCustomerDataForm"]
${POS_CCP_Last_Name_Textbox}      xpath://*[@id="inputLastNameIntoCustomerDataForm"]
${POS_CCP_Last_Name2_textbox}     xpath://*[@id="inputLastName2IntoCustomerDataForm"]
${POS_CCP_Email_textbox}        xpath://*[@id="inputEmailIntoCustomerDataForm"]
${POS_CCP_MobileNumber_textbox}     xpath://*[@id="inputMobileNumberIntoCustomerDataForm"]
${POS_CCP_Fixedlinenumber_textbox}      xpath://*[@id="inputFixedLineNumberIntoCustomerDataForm"]
${POS_CCP_Gender_dropdown}      xpath://*[@id="inputGenderIntoCustomerDataForm-gender"]
${POS_CCP_Dateofbirth_textbox}      xpath://*[@id="inputBirthDayCustomerDataForm_inner_input"]
${POS_CCP_Documenttype_Dropdown}        xpath://*[@id="inputIdenificationTypeIntoCustomerDataForm-identificationType"]
${POS_CCP_DocumentID_textbox}       xpath://*[@id="inputIdenificationIdIntoCustomerDataForm"]
${POS_CCP_IssuingAuthority_textbox}     xpath://*[@id="inputIdenificationIdIntoCustomerDataForm"]
${POS_CCP_Issuingdate_textbox}      xpath://*[@id="inputIdenificationIdIntoCustomerDataForm"]
${POS_CCP_Exiprationdate_textbox}       xpath://*[@id="inputIdentificationExpiryDateIntoCustomerDataForm_inner_input"]
${POS_CCP_Streetaddress_textbox}        xpath://*[@id="inputStreetIntoCustomerDataForm"]
${POS_CCP_Postalcode_textbox}       xpath://*[@id="inputPostalCodeIntoCustomerDataForm"]
${POS_CCP_city_textbbox}        xpath://*[@id="inputCityIntoCustomerDataForm"]
${POS_CCP_Apartment_textbox}        xpath://*[@id="inputApartmentIntoCustomerDataForm"]
${POS_CCP_Buliding_textbox}     xpath://*[@id="inputBuildingIntoCustomerDataForm"]
${POS_CCP_Country_dropdown}     xpath://*[@id="inputCountryIntoCustomerDataForm-country"]
${POS_CCP_Continue_button}      xpath://*[@id="customer-search-form-continue-button"]
${POS_CCP_Create_Customer_final_button}     xpath://*[@id="buttonCreateCustomerInNewCustomerInfo"]


## Shop Prepaid Plans Page (SPPP) ##
${POS_SPPP_Prepaid_plans_link}      xapth://*[@id="CategoryList-category-cat-b2c-mobile-plan-prepaid"]











