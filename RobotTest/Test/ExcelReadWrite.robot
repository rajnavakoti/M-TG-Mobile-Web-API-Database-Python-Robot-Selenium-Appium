*** Settings ***
Library    ExcelLibrary


*** Keywords ***
Read Excel
  [Arguments]  ${path_excel}
  Open Excel Document  ${path_excel}  doc_1
  ${Customer_id}    Read Excel Cell  1  1  Sheet1
  Close All Excel Documents
  [Return]  ${Customer_id}

Write Excel
  [Arguments]  ${path_excel}  ${value}
  Open Excel Document  ${path_excel}  doc_1
  Write Excel Cell  4  4  ${value}  Sheet1
  Save Excel Document  ${path_excel}
  Close All Excel Documents

Get MSISDN
  [Arguments]  ${apirow}  ${Sheetname}
  ${MSISDN}    Read Excel Cell  1  1  Sheet1
  Open Excel Document  ${path_excel}  doc_1

*** Variables ***


*** Test Cases ***

STEP 1
  ${value}  Read Excel  C:/Project Files/ExcelRW.xlsx
  Log to console  ${value}
  Write Excel  C:/Project Files/ExcelRW.xlsx  Valor3