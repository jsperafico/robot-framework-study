*** Settings ***
Library           SeleniumLibrary
Test Setup    Open Browser
...  url=${SUT_URL}
...  browser=${BROWSER}
...  remote_url=${SELENIUM_GRID_URL}
Test Teardown     Close Browser
Default Tags    Regression

Documentation     Visualization of producs.
...
...               The goal of this test suite is to validate product navigation,
...               from main page to product details, back to home page with all
...               respected caveats.


*** Variables ***
${SUT_URL}                https://www.demoblaze.com/
${BROWSER}                chrome
${SELENIUM_GRID_URL}      http://localhost:4444


*** Test Cases ***
A person should be able to visualize more than one project on home page
    [Tags]    Smoke
    [Documentation]    Given a person accessing Demo Blaze
    ...                When home page is displayed
    ...                Then should display one or more items
    Maximize Browser Window
    Wait Until Page Contains Element    css:div#contcont div.card

A person should be able to view item details
    [Documentation]    Given a person accessing Demo Blaze
    ...                When home page is displayed
    ...                And click over an item
    ...                Then item details should appear
    Maximize Browser Window
    Wait Until Element Is Visible    css:div#contcont div.card
    ${product_title}    Get Text
    ...  xpath:(//div[@id="tbodyid"]/div/div[contains(@class, "card")])[1]/a
    ${product_url}    Get Element Attribute
    ...  xpath:(//div[@id="tbodyid"]/div/div[contains(@class, "card")])[1]/a
    ...  href
    Click Element    xpath:(//div[@id="tbodyid"]/div/div[contains(@class, "card")])[1]/a
    Wait Until Location Contains    ${product_url}
    Wait Until Element Is Visible    css:div#tbodyid h2    10
    Element Should Contain    css:div#tbodyid h2    ${product_title}
