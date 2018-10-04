*** Settings ***
Documentation    Suite description
Library     ExcelLibrary

*** Variables ***
${path_excel}    C:/Test/Testing.xls

*** Test Cases ***
Test title
  Open Excel    ${path_excel}
  ${CellValue}      Read Cell Data By Coordinates     Sheet1      0   0
  Log   ${CellValue}
  Add New Sheet     NewSheet
  Save Excel    Testing.xls   useTempDir=False

*** Keywords ***
Provided precondition
    Setup system under test