*** Settings ***
Documentation    Suite description
Library  Selenium2Library
Library  JSONLibrary
Library  DependencyLibrary

*** Test Cases ***
Test Case One
    [Tags]    DEBUG
    Log     TestCase1
    Fail    Testing

Test Case Two
     Depends on test  Test Case One
     Log    TestCase2

#*** Keywords ***
#Provided precondition
    #Setup system under test