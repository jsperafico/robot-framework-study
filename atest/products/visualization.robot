*** Settings ***
Library           SeleniumLibrary

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
    [Documentation]    Given a person accessing Demo Blaze \n
    ...                When home page is displayed \n
    ...                Then should display one or more items
    [Setup]    Open Browser
    ...  url=${SUT_URL}
    ...  browser=${BROWSER}
    ...  remote_url=${SELENIUM_GRID_URL}
    Maximize Browser Window
    [Teardown]    Close Browser
