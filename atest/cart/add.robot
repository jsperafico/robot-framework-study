*** Settings ***
Library    SeleniumLibrary
Resource    ../setup.robot
Documentation     Interaction with Shopping cart.
...
...               The goal of this test suite is to validate the shopping cart functionality by
...               adding one and more products to the cart, change the quanity, removing an item
...               from the cart and adding the same item twice.
Default Tags    Regression
Test Setup    Open Remote And Maximize
Test Teardown    Close Browser


*** Test Cases ***
A person should be able to add an item to the cart if empty
    [Documentation]    Given a person
    ...                When adding an item to cart
    ...                And its empty
    ...                Then item should be in cart
    [Tags]    Smoke    Regression
    Verify Shopping Cart Items
    Open Item Details     2
    ${item_2}    Add Item To Cart
    Verify Shopping Cart Items    ${item_2}

A person should be able to add an item twice to the cart
    [Documentation]    Given a person
    ...                When adding an item to cart
    ...                And its already there
    ...                Then both item should be in cart
    Verify Shopping Cart Items
    Open Item Details     2
    ${1_item_2}    Add Item To Cart
    Open Item Details     2
    ${2_item_2}    Add Item To Cart
    Verify Shopping Cart Items    ${1_item_2}    ${2_item_2}

A person should be able to different an items to the cart
    [Documentation]    Given a person
    ...                When adding an item to cart
    ...                And adding another item to cart
    ...                Then items should be in cart
    Verify Shopping Cart Items
    Open Item Details     2
    ${1_item_2}    Add Item To Cart
    Open Item Details     3
    ${2_item_3}    Add Item To Cart
    Verify Shopping Cart Items    ${1_item_2}    ${2_item_3}


*** Keywords ***
Open Item Details
    [Arguments]    ${id}
    [Documentation]    Provide default functionality to click on item in Home Page.
    ...                ${id} is the element index from LEFT-RIGHT and UP-DOWN.
    Wait Until Element Is Visible    css:a.nav-link[href="index.html"]
    Click Link    css:a.nav-link[href="index.html"]
    Wait Until Location Is    ${SUT_URL}index.html
    Wait Until Element Is Visible    xpath:(//div[@id="tbodyid"]/div/div[contains(@class, "card")])[${id}]/a
    ${product_title}    Get Text
    ...  xpath:(//div[@id="tbodyid"]//h4[contains(@class, "card-title")])[${id}]/a
    ${product_url}    Get Element Attribute
    ...  xpath:(//div[@id="tbodyid"]/div/div[contains(@class, "card")])[${id}]/a
    ...  href
    Click Element    xpath:(//div[@id="tbodyid"]/div/div[contains(@class, "card")])[${id}]/a
    Wait Until Location Contains    ${product_url}
    Wait Until Element Is Visible    css:div#tbodyid h2    10
    Element Should Contain    css:div#tbodyid h2    ${product_title}

Add Item To Cart
    [Documentation]    Once in item details, will click on `Add to Cart` button and the
    ...                item will be added to shopping cart.
    ${product_title}    Get Text    css:div#tbodyid h2
    Wait Until Element Is Visible    css:a.btn-success
    Click Link    css:a.btn-success
    Alert Should Be Present    Product added    ACCEPT    5
    [Return]    ${product_title}

Verify Shopping Cart Items
    [Arguments]    @{descriptions}
    [Documentation]    Will open shopping cart and verify
    ...                @{descriptions} list of descriptions to be found
    ${amount}    Get Length    ${descriptions}
    Wait Until Element Is Visible    css:a#cartur
    Click Link    css:a#cartur
    Wait Until Location Is    ${SUT_URL}cart.html
    IF    ${amount} == 0
        Wait Until Element Is Visible    css:tbody#tbodyid
    ELSE
        Wait Until Element Is Visible    css:tbody#tbodyid tr.success
    END
    ${web_elements}    Get WebElements    css:tbody#tbodyid tr.success
    ${items}    Get Length    ${web_elements}
    Should Be Equal As Integers    ${amount}    ${items}
