*** Settings ***
Documentation    Provide standard behavior to open and maximaze a browser window.
Library    SeleniumLibrary


*** Variables ***
${SUT_URL}                https://www.demoblaze.com/
${BROWSER}                chrome
${SELENIUM_GRID_URL}      http://localhost:4444


*** Keywords ***
Open Remote And Maximize
    [Documentation]    Will open the respective browser in Grid and will Maximaze browser window.
    Open Browser
    ...  url=${SUT_URL}
    ...  browser=${BROWSER}
    ...  remote_url=${SELENIUM_GRID_URL}
    Maximize Browser Window
