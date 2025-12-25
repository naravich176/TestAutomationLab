*** Settings ***
Library    SeleniumLibrary
Test Teardown   Close Browser

*** Variables ***
${URL}           http://localhost:7272/Lab4/Registration.html
${BROWSER}       chrome

*** Test Cases ***
Valid Login-Register Success
    [Documentation]    ทดสอบกรอกข้อมูลครบถ้วน
    Open Registration Page
    Fill Registration Form    Somyod    Sodsai    CS KKU    somyod@kkumail.com    091-001-1234
    Submit Registration
    Verify Registration Success

Valid Login-Register Success No Organization Info
    [Documentation]    ทดสอบกรอกข้อมูลครบถ้วน โดยไม่กรอกข้อมูลหน่วยงาน
    Open Registration Page
    Fill Registration Form    Somyod    Sodsai    ${EMPTY}    somyod@kkumail.com    091-001-1234
    Submit Registration
    Verify Registration Success

InValid Login-Empty First Name
    [Documentation]    ทดสอบกรณีไม่กรอกชื่อ
    Open Registration Page
    Fill Registration Form    ${EMPTY}    Sodsai    CS KKU    somyod@kkumail.com    091-001-1234
    Submit Registration
    Verify Registration Fail    *Please enter your first name!!

InValid Login-Empty Last Name
    [Documentation]    ทดสอบกรณีไม่กรอกนามสกุล
    Open Registration Page
    Fill Registration Form    Somyod    ${EMPTY}    CS KKU    somyod@kkumail.com    091-001-1234
    Submit Registration
    Verify Registration Fail    *Please enter your last name!!

InValid Login-Empty First Name and Last Name
    [Documentation]    ทดสอบกรณีไม่กรอกชื่อและนามสกุล
    Open Registration Page
    Fill Registration Form    ${EMPTY}    ${EMPTY}    CS KKU    somyod@kkumail.com    091-001-1234
    Submit Registration
    Verify Registration Fail    *Please enter your name!!

InValid Login-Empty Email
    [Documentation]    ทดสอบกรณีไม่กรอกอีเมล
    Open Registration Page
    Fill Registration Form    Somyod    Sodsai    CS KKU    ${EMPTY}    091-001-1234
    Submit Registration
    Verify Registration Fail    *Please enter your email!!

InValid Login-Empty Phone Number
    [Documentation]    ทดสอบกรณีไม่กรอกเบอร์โทรศัพท์
    Open Registration Page
    Fill Registration Form    Somyod    Sodsai    CS KKU    somyod@kkumail.com    ${EMPTY}
    Submit Registration
    Verify Registration Fail    *Please enter your phone number!!

InValid Login-Invalid Phone Number
    [Documentation]    ทดสอบกรณีกรอกเบอร์โทรศัพท์ไม่ถูกต้อง
    Open Registration Page
    Fill Registration Form    Somyod    Sodsai    CS KKU    somyod@kkumail.com    1234
    Submit Registration
    Verify Registration Fail    Please enter a valid phone number, e.g., 081-234-5678, 081 234 5678, or 081.234.5678

*** Keywords ***
Open Registration Page
    Open Browser    ${URL}    ${BROWSER}
    # Set Selenium Speed    0.5 seconds
    Maximize Browser Window
    Wait Until Page Contains    Workshop Registration

Fill Registration Form
    [Arguments]    ${f_name}    ${l_name}    ${org}    ${email}    ${phone}
    Input Text    id=firstname       ${f_name}
    Input Text    id=lastname        ${l_name}
    Input Text    id=organization    ${org}
    Input Text    id=email           ${email}
    Input Text    id=phone           ${phone}

Submit Registration
    Click Button    id=registerButton

Verify Registration Success
    Wait Until Location Contains    Success.html
    Page Should Contain             Success
    Page Should Contain             Thank you for registering with us.
    Page Should Contain             We will send a confirmation to your email soon.

Verify Registration Fail
    [Arguments]    ${expected_error}
    Element Text Should Be    id=errors    ${expected_error}