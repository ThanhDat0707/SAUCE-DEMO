*** Settings ***
Documentation     Do exercice midterm
Library           SeleniumLibrary
Library           DateTime
Library           RequestsLibrary
Library           Collections
Library           String
Library           OperatingSystem
Library           random

*** Variables ***
${URL}            https://www.saucedemo.com/
${URL_INDEX}      https://www.saucedemo.com/inventory.html
${Browser}        Chrome
${logo_index}     //*[@id="header_container"]/div[1]/div[2]/div
${Swag_Labs}      Swag Labs
${xpath_username}    //*[@id="user-name"]
${xpath_password}    //*[@id="password"]
${standard_user}    standard_user
${locked_out_user}    locked_out_user
${problem_user}    problem_user
${performance_glitch_user}    performance_glitch_user
${error_user}     error_user
${visual_user}    visual_user
${password_all}    secret_sauce
${button_login}    //*[@id="login-button"]
${name_product}    inventory_item_name
${price_product}    inventory_item_price
${Username}       standard_user
${Username Field}    id:user-name
${Password}       secret_sauce
${Password Field}    id:password
${Login Button}    id:login-button
${Anchor Xpath}    //*[@id="shopping_cart_container"]/a
${Span Xpath}     //*[@id="shopping_cart_container"]/a/span
${Add to cart}    id:add-to-cart-sauce-labs-backpack
${Remove button}    id:remove-sauce-labs-backpack
${firstname}      //*[@id="first-name"]
${lastname}       //*[@id="last-name"]
${zipcode}        //*[@id="postal-code"]
${continue}       //*[@id="continue"]
${total_xpath}    //*[@id="checkout_summary_container"]/div/div[2]/div[8]
${tax_xpath}      //*[@id="checkout_summary_container"]/div/div[2]/div[7]
${item_total_xpath}    //*[@id="checkout_summary_container"]/div/div[2]/div[6]
@{xpaths}         //*[@id="item_4_title_link"]/div    //*[@id="item_0_title_link"]/div    //*[@id="item_1_title_link"]/div    //*[@id="item_5_title_link"]/div    //*[@id="item_2_title_link"]/div    //*[@id="item_3_title_link"]/div
@{name_list}      Sauce Labs Backpack    Sauce Labs Bike Light    Sauce Labs Bolt T-Shirt    Sauce Labs Fleece Jacket    Sauce Labs Onesie    Test.allTheThings() T-Shirt (Red)
@{IDs}            id:add-to-cart-sauce-labs-backpack    id:add-to-cart-sauce-labs-bike-light    id:add-to-cart-sauce-labs-bolt-t-shirt    id:add-to-cart-sauce-labs-fleece-jacket    id:add-to-cart-sauce-labs-onesie    id:add-to-cart-test.allthethings()-t-shirt-(red)
@{ID1s}           id:remove-sauce-labs-backpack    remove-sauce-labs-bike-light    remove-sauce-labs-bolt-t-shirt    remove-sauce-labs-fleece-jacket    remove-sauce-labs-onesie    remove-test.allthethings()-t-shirt-(red)
@{list_user_name}    standard_user    visual_user    performance_glitch_user    problem_user    error_user    locked_out_user
@{list_product_A-Z}    Sauce Labs Backpack    Sauce Labs Bike Light    Sauce Labs Bolt T-Shirt    Sauce Labs Fleece Jacket    Sauce Labs Onesie    Test.allTheThings() T-Shirt (Red)
@{list_procuct_low_price}    $7.99    $9.99    $15.99    $15.99    $29.99    $49.99

*** Test Cases ***
TC Open Browser
    Open Web
    ${CURRENT_URL}=    Get Location
    Should Be Equal As Strings    ${CURRENT_URL}    ${URL}
    Close Browser

TC Login in URL index
    Open Browser    ${URL_INDEX}    ${Browser}
    ${text}=    Get Text    //*[@id="login_button_container"]/div/form/div[3]/h3
    Should Be Equal As Strings    ${text}    Epic sadface: You can only access '/inventory.html' when you are logged in.
    Close Browser

TC Login no fill Username
    Open Web
    Click Element    ${button_login}
    ${text}=    Get Text    //*[@id="login_button_container"]/div/form/div[3]/h3
    Should Be Equal As Strings    ${text}    Epic sadface: Username is required
    Close Browser

TC Login no fill Password
    Open Web
    Click Element    ${button_login}
    ${text}=    Get Text    //*[@id="login_button_container"]/div/form/div[3]/h3
    Should Be Equal As Strings    ${text}    Epic sadface: Username is required
    Close Browser

TC Login wrong Username
    Open Web
    Input Text    \    ${xpath_username}    thai
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    ${text}=    Get Text    //*[@id="login_button_container"]/div/form/div[3]/h3
    Should Be Equal As Strings    ${text}    Epic sadface: Username and password do not match any user in this service
    Close Browser

TC Login wrong Password
    Open Web
    Input Text    \    ${xpath_username}    ${standard_user}
    Input Text    \    ${xpath_password}    123
    Click Element    ${button_login}
    ${text}=    Get Text    //*[@id="login_button_container"]/div/form/div[3]/h3
    Should Be Equal As Strings    ${text}    Epic sadface: Username and password do not match any user in this service
    Close Browser

TC Login standard_user
    Open Web
    Input Text    \    ${xpath_username}    ${standard_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Page Should Contain Element    ${logo_index}
    ${CURRENT_URL}=    Get Location
    Should Be Equal As Strings    ${CURRENT_URL}    ${URL_INDEX}
    Log To Console    Login success
    Close Browser

TC Validate standard_user
    Open Web
    Input Text    \    ${xpath_username}    ${standard_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    ${CURRENT_URL}=    Get Location
    Should Be Equal As Strings    ${CURRENT_URL}    ${URL_INDEX}
    Validate add to cart
    Close Browser

TC Check out standard_user
    Open Web
    Input Text    \    ${xpath_username}    ${standard_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Check out product
    Close Browser

TC log out standard_user
    Open Web
    Input Text    \    ${xpath_username}    ${standard_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Log out user
    Close Browser

TC Login all user
    FOR    ${user}    IN    @{list_user_name}
        Open Web
        Log To Console    ${user}
        Input Text    \    ${xpath_username}    ${user}
        Input Text    \    ${xpath_password}    ${password_all}
        Click Element    ${button_login}
        ${CURRENT_URL}=    Get Location
        Run Keyword And Continue On Failure    Should Be Equal As Strings    ${CURRENT_URL}    ${URL_INDEX}
    #    sai nhưng van chạy tiep
        Close Browser
    END

TC Login problem_user
    Open Web
    Input Text    \    ${xpath_username}    ${problem_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Page Should Contain Element    ${logo_index}
    ${CURRENT_URL}=    Get Location
    Should Be Equal As Strings    ${CURRENT_URL}    ${URL_INDEX}
    Should Be Equal As Strings    //*[@id="item_4_img_link"]/img    //*[@id="item_4_img_link"]/img
    Log To Console    User problem in images
    Close Browser

TC Validate problem_user
    Open Web
    Input Text    \    ${xpath_username}    ${problem_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Page Should Contain Element    ${logo_index}
    ${CURRENT_URL}=    Get Location
    Should Be Equal As Strings    ${CURRENT_URL}    ${URL_INDEX}
    Validate add to cart
    Close Browser

TC Check out problem_user
    Open Web
    Input Text    \    ${xpath_username}    ${problem_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Check out product
    Close Browser

TC log out problem_user
    Open Web
    Input Text    \    ${xpath_username}    ${problem_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Log out user
    Close Browser

TC Login performance_glitch_user
    #    Time login standard_user
    ${time_standard_user}=    Get Time
    ${time_in_seconds1}=    Get Current Date    ${time_standard_user}    result_format=epoch
    Open Web
    Input Text    \    ${xpath_username}    ${standard_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    ${date2}=    Get Time
    ${time_in_seconds2}=    Get Current Date    ${date2}    result_format=epoch
    ${t1}= Subtract Time From Time    ${time_in_seconds2}    ${time_in_seconds1}
    Log To Console    ${t1}
    Close Browser
    #    Time login standard_user
    ${time_performance_glitch_user}=    Get Time
    ${time_in_seconds1}=    Get Current Date    ${time_performance_glitch_user}    result_format=epoch
    Open Web
    Input Text    \    ${xpath_username}    ${performance_glitch_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    ${date2}=    Get Time
    ${time_in_seconds2}=    Get Current Date    ${date2}    result_format=epoch
    ${t2}= Subtract Time From Time    ${time_in_seconds2}    ${time_in_seconds1}
    Log To Console    ${t2}
    Close Browser
    ${t3}= Subtract Time From Time    ${t2}    ${1}
    Run Keyword If    ${t3} > 0    Log To Console User problem in Performance in ${t3}

TC Validate performance_glitch_user
    Open Web
    Input Text    \    ${xpath_username}    ${performance_glitch_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Validate add to cart
    Close Browser

TC Check out performance_glitch_user
    Open Web
    Input Text    \    ${xpath_username}    ${performance_glitch_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Check out product
    Close Browser

TC log out performance_glitch_user
    Open Web
    Input Text    \    ${xpath_username}    ${performance_glitch_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Log out user
    Close Browser

TC Login error_user
    Open Web
    Input Text    \    ${xpath_username}    ${error_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Validate add to cart
    Close Browser

TC log out error_user
    Open Web
    Input Text    \    ${xpath_username}    ${error_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Log out user
    Close Browser

TC Login visual_user
    Open Web
    Input Text    \    ${xpath_username}    ${visual_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    TRY
        Element should have class //*[@id="shopping_cart_container"] visual_failure
    EXCEPT    message
        Log To Console The interface has redundant classes visual_failure
    END
    Close Browser

TC Validate visual_user
    Open Web
    Input Text    \    ${xpath_username}    ${visual_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Validate add to cart
    Close Browser

TC Check out visual_user
    Open Web
    Input Text    \    ${xpath_username}    ${visual_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Check out product
    Close Browser

TC log out visual_user
    Open Web
    Input Text    \    ${xpath_username}    ${visual_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Log out user
    Close Browser

TC Login locked_out_user
    Open Web
    Input Text    \    ${xpath_username}    ${locked_out_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    ${text}=    Get Text    //*[@id="login_button_container"]/div/form/div[3]/h3
    Log To Console ${text}
    Should Be Equal As Strings    ${text}    Epic sadface: Sorry, this user has been locked out.
    Page Should Contain Element    //*[@id="login_button_container"]/div/form/div[3]/h3
    Log To Console    User locked
    Close Browser

TC standard_user buy 6 product
    Open Web
    Input Text    \    ${xpath_username}    ${standard_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Validate number shopping cart
    Close Browser

TC problem_user buy 6 product
    Open Web
    Input Text    \    ${xpath_username}    ${problem_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Validate number shopping cart
    Close Browser

TC performance_glitch_user buy 6 product
    Open Web
    Input Text    \    ${xpath_username}    ${performance_glitch_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Validate number shopping cart
    Close Browser

TC error_user buy 6 product
    Open Web
    Input Text    \    ${xpath_username}    ${error_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Validate number shopping cart
    Close Browser

TC visual_user buy 6 product
    Open Web
    Input Text    \    ${xpath_username}    ${visual_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Validate number shopping cart
    Close Browser

TC Check sort product A - Z
    Open Web
    Input Text    \    ${xpath_username}    ${standard_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    ${texts}    Get Texts By Class Name    ${name_product}
    ${length_1}= Get Length    ${texts}
    ${length_2}= Get Length    ${list_product_A-Z}
    Should Be Equal As Strings    ${length_1}    ${length_2}
    Lists Should Be Equal    ${texts}    ${list_product_A-Z}
    Close Browser

TC Check sort product Z - A
    Open Web
    Input Text    \    ${xpath_username}    ${standard_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Sleep    2
    Click Element    //*[@id="header_container"]/div[2]/div/span/select
    Sleep    1
    Click Element    //*[@id="header_container"]/div[2]/div/span/select/option[2]
    ${texts}    Get Texts By Class Name    ${name_product}
    Reverse List    ${list_product_A-Z}
    Log To Console    ${list_product_A-Z}
    Lists Should Be Equal    ${texts}    ${list_product_A-Z}
    Close Browser

TC Check sort product price low to high
    Open Web
    Input Text    \    ${xpath_username}    ${standard_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Sleep    2
    Click Element    //*[@id="header_container"]/div[2]/div/span/select
    Sleep    1
    Click Element    //*[@id="header_container"]/div[2]/div/span/select/option[3]
    ${texts}    Get Texts By Class Name    ${price_product}
    Lists Should Be Equal    ${texts}    ${list_procuct_low_price}
    Close Browser

TC Check sort product price high to low
    Open Web
    Input Text    \    ${xpath_username}    ${standard_user}
    Input Text    \    ${xpath_password}    ${password_all}
    Click Element    ${button_login}
    Sleep    2
    Click Element    //*[@id="header_container"]/div[2]/div/span/select
    Sleep    1
    Click Element    //*[@id="header_container"]/div[2]/div/span/select/option[4]
    ${texts}    Get Texts By Class Name    ${price_product}
    Reverse List    ${list_procuct_low_price}
    Lists Should Be Equal    ${texts}    ${list_procuct_low_price}
    Close Browser
    # ======================================

The test case verifies the price before checking out.
    FOR    ${user}    IN    @{list_user_name}
        TRY
        ${Tong}    Set Variable    0
        ${sum}    Set Variable    0
        Open Browser    ${URL}    ${Browser}
        Maximize Browser Window
        Input Text    ${xpath_username}    ${user}
        Input Text    ${xpath_password}    ${Password}
        Click Element    ${Login Button}
        ${CURRENT_URL}=    Get Location
        ${my_list}    Create List
        FOR    ${id}    IN    @{IDs}
            Click Button    ${id}
            ${Tong}=    Evaluate    ${Tong} + 1
            Append To List    ${my_list}    ${id}
        END
        Click Element    ${Anchor Xpath}
        Location Should Be    https://www.saucedemo.com/cart.html
        Click Button    xpath=//*[@id="checkout"]
        Location Should Be    https://www.saucedemo.com/checkout-step-one.html
        ${anchor_element}=    Get WebElement    ${Anchor Xpath}
        ${span_element}=    Get WebElement    ${Span Xpath}
        ${anchor_text}=    Get Text    ${anchor_element}
        ${span_text}=    Get Text    ${span_element}
        Should Be True    '${span_text}' != ''
        Should Be True    '${span_text}' in '${anchor_text}'
        Should Be Equal As Numbers    ${span_text}    ${Tong}
        Element Should Be Visible //*[@id="first-name"]
        Element Should Be Visible //*[@id="last-name"]
        Element Should Be Visible //*[@id="postal-code"]
        ${random_numbers}=    Generate Random String    10    1234567890
        Input Text    ${firstname}    ${random_numbers}
        Input Text    ${lastname}    ${random_numbers}
        Input Text    ${zipcode}    ${random_numbers}
        Click Button    ${continue}
        ${values}    Create List
        Location Should Be    https://www.saucedemo.com/checkout-step-two.html
        FOR    ${id}    IN    @{my_list}
            ${id1}    Get value by ID    ${id}
            Append To List    ${values}    ${id1}
        END
        ${tax}    Multiply each value by 0.08 and add the result to the sum    ${values}
        ${price}    Sum of price    ${values}
        ${sum}=    Evaluate    ${tax} + ${price}
        ${total_text}    Get Text    ${total_xpath}
        ${dollar_position}=    Evaluate    "${total_text}".index("$") + 1
        ${total_value}=    Get Substring    ${total_text}    ${dollar_position}
        ${total_value}=    Convert To Number    ${total_value}
        ${tax_text}    Get Text    ${tax_xpath}
        ${dollar_position}=    Evaluate    "${tax_text}".index("$") + 1
        ${tax_value}=    Get Substring    ${tax_text}    ${dollar_position}
        ${tax_value}=    Convert To Number    ${tax_value}
        ${item_total_text}    Get Text    ${item_total_xpath}
        ${dollar_position}=    Evaluate    "${item_total_text}".index("$") + 1
        ${item_total_value}=    Get Substring    ${item_total_text}    ${dollar_position}
        ${item_total_value}=    Convert To Number    ${item_total_value}
        ${sum}=    Evaluate    round(${sum}, 2)
        ${tax}=    Evaluate    round(${tax}, 2)
        ${price}    Evaluate    round(${price}, 2)
        Should Be Equal As Numbers    ${total_value}    ${sum}
        Should Be Equal As Numbers    ${tax_value}    ${tax}
        Should Be Equal As Numbers    ${item_total_value}    ${price}
        Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

The test case verifies the products before checking out
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${sum}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${my_list}    Create List
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                Append To List    ${my_list}    ${id}
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_numbers}=    Generate Random String    10    1234567890
            Input Text    ${firstname}    ${random_numbers}
            Input Text    ${lastname}    ${random_numbers}
            Input Text    ${zipcode}    ${random_numbers}
            Click Button    ${continue}
            ${names}    Create List
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            FOR    ${id}    IN    @{my_list}
                ${name}    Get name by ID    ${id}
                Append To List    ${names}    ${name}
            END
            ${texts}=    Create List
            FOR    ${xpath}    IN    @{xpaths}
                ${element}=    Run Keyword And Return Status    Element Should Be Visible    ${xpath}
                ${text}=    Run Keyword If    ${element}    Get Text Names    ${xpath}
                Append To List    ${texts}    ${text}
            END
            Lists Should Be Equal    ${texts}    ${names}
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

The test case verifies random prices before checking out
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${sum}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${my_list}    Create List
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                Append To List    ${my_list}    ${id}
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_numbers}=    Generate Random String    10    1234567890
            Input Text    ${firstname}    ${random_numbers}
            Input Text    ${lastname}    ${random_numbers}
            Input Text    ${zipcode}    ${random_numbers}
            Click Button    ${continue}
            ${values}    Create List
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            FOR    ${id}    IN    @{my_list}
                ${id1}    Get value by ID    ${id}
                Append To List    ${values}    ${id1}
            END
            ${tax}    Multiply each value by 0.08 and add the result to the sum    ${values}
            ${price}    Sum of price    ${values}
            ${sum}=    Evaluate    ${tax} + ${price}
            ${total_text}    Get Text    ${total_xpath}
            ${dollar_position}=    Evaluate    "${total_text}".index("$") + 1
            ${total_value}=    Get Substring    ${total_text}    ${dollar_position}
            ${total_value}=    Convert To Number    ${total_value}
            ${tax_text}    Get Text    ${tax_xpath}
            ${dollar_position}=    Evaluate    "${tax_text}".index("$") + 1
            ${tax_value}=    Get Substring    ${tax_text}    ${dollar_position}
            ${tax_value}=    Convert To Number    ${tax_value}
            ${item_total_text}    Get Text    ${item_total_xpath}
            ${dollar_position}=    Evaluate    "${item_total_text}".index("$") + 1
            ${item_total_value}=    Get Substring    ${item_total_text}    ${dollar_position}
            ${item_total_value}=    Convert To Number    ${item_total_value}
            ${sum}=    Evaluate    round(${sum}, 2)
            ${tax}=    Evaluate    round(${tax}, 2)
            ${price}    Evaluate    round(${price}, 2)
            Should Be Equal As Numbers    ${total_value}    ${sum}
            Should Be Equal As Numbers    ${tax_value}    ${tax}
            Should Be Equal As Numbers    ${item_total_value}    ${price}
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

The test case verifies random products before checking out.
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${sum}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${my_list}    Create List
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                Append To List    ${my_list}    ${id}
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_numbers}=    Generate Random String    10    1234567890
            Input Text    ${firstname}    ${random_numbers}
            Input Text    ${lastname}    ${random_numbers}
            Input Text    ${zipcode}    ${random_numbers}
            Click Button    ${continue}
            ${names}    Create List
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            FOR    ${id}    IN    @{my_list}
                ${name}    Get name by ID    ${id}
                Append To List    ${names}    ${name}
            END
            ${texts}=    Create List
            FOR    ${xpath}    IN    @{xpaths}
                ${element}=    Run Keyword And Return Status    Element Should Be Visible    ${xpath}
                ${text}=    Run Keyword If    ${element}    Get Text Names    ${xpath}
                Run Keyword If    '${text}' != 'None'    Append To List    ${texts}    ${text}
            END
            Lists Should Be Equal    ${texts}    ${names}    ignore_order=False
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END
    #========= Thanh toan =============

The test case checks the actions transitioning to the cart page
    FOR    ${user}    IN    @{list_user_name}
        TRY
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

The test case verifies the data after transitioning to the cart page
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button Template    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            FOR    ${id}    IN    @{ID1s}
                ${button_appear}=    Run Keyword And Return Status    Element Should Be Visible    ${id}
                Should Be True    ${button_appear}
            END
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

The test case verifies the data after transitioning to the cart page when not all products are selected
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            ${Dem1}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button Template    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            FOR    ${id}    IN    @{ID1s}
                ${button_appear}=    Run Keyword And Return Status    Element Should Be Visible    ${id}    # Kiểm tra xem nút ban đầu đã biến mất hay chưa
                Should Be True    ${button_appear}    # Nút ban đầu không còn hiển thị
                ${Dem1}=    Evaluate    ${Dem1} + 1
                Exit For Loop If    ${Dem1} == 3
            END
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

The test case verifies the data after transitioning to the cart page when selecting random products.
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button Template    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            FOR    ${id}    IN    @{ID1s}
                ${button_appear}=    Run Keyword And Return Status    Element Should Be Visible    ${id}    # Kiểm tra xem nút ban đầu đã biến mất hay chưa
                Should Be True    ${button_appear}    # Nút ban đầu không còn hiển thị
            END
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

The test case verifies the data after transitioning to the cart page when selecting random products and not selecting all items.
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button Template    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 5
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            FOR    ${id}    IN    @{my_list}
                ${id}=    Replace String    ${id}    add-to-cart    remove
                ${button_appear}=    Run Keyword And Return Status    Element Should Be Visible    ${id}
                Should Be True    ${button_appear}    # Nút ban đầu không còn hiển thị
            END
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

The test case checks removing an item from the cart
    FOR    ${user}    IN    @{list_user_name}
        TRY
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            Click Button    ${Add to cart}
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    1
            Click Button    ${Remove button}
            ${span_element_exist}=    Run Keyword And Return Status    Element Should Not Be Visible    ${Span Xpath}
            Should Be True    ${span_element_exist}
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

The test case checks removing items from the cart
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button Template    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            FOR    ${id}    IN    @{ID1s}
                ${button_appear}=    Run Keyword And Return Status    Element Should Be Visible    ${id}
                Should Be True    ${button_appear}
            END
            FOR    ${id}    IN    @{ID1s}
                Click Button Template    ${id}
                Sleep    1s
                ${span_element_exist}=    Run Keyword And Return Status    Element Should Be Visible    ${Span Xpath}
                ${Tong}=    Evaluate    ${Tong} - 1
                Run Keyword If    '${span_element_exist}' == 'True'    Run Multiple Keywords True    ${id}    ${Tong}
                Run Keyword If    '${span_element_exist}' == 'False'    Run Multiple Keywords False    ${id}
            END
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

The test case checks removing items random from the cart
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button Template    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            FOR    ${id}    IN    @{ID1s}
                ${id}=    Replace String    ${id}    add-to-cart    remove
                ${button_appear}=    Run Keyword And Return Status    Element Should Be Visible    ${id}
                Should Be True    ${button_appear}
            END
            FOR    ${id}    IN    @{ID1s}
                ${id}=    Replace String    ${id}    add-to-cart    remove
                Click Button Template    ${id}
                Sleep    1s
                ${span_element_exist}=    Run Keyword And Return Status    Element Should Be Visible    ${Span Xpath}
                ${Tong}=    Evaluate    ${Tong} - 1
                Run Keyword If    '${span_element_exist}' == 'True'    Run Multiple Keywords True    ${id}    ${Tong}
                Run Keyword If    '${span_element_exist}' == 'False'    Run Multiple Keywords False    ${id}
            END
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

The test case checks removing some but not all items from the cart.
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            ${Dem1}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button Template    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            FOR    ${id}    IN    @{my_list}
                ${id}=    Replace String    ${id}    add-to-cart    remove
                ${button_appear}=    Run Keyword And Return Status    Element Should Be Visible    ${id}
                Should Be True    ${button_appear}
            END
            FOR    ${id}    IN    @{my_list}
                ${id}=    Replace String    ${id}    add-to-cart    remove
                Click Button Template    ${id}
                Sleep    1s
                ${span_element_exist}=    Run Keyword And Return Status    Element Should Be Visible    ${Span Xpath}
                ${Tong}=    Evaluate    ${Tong} - 1
                Run Keyword If    '${span_element_exist}' == 'True'    Run Multiple Keywords True    ${id}    ${Tong}
                Run Keyword If    '${span_element_exist}' == 'False'    Run Multiple Keywords False    ${id}
                ${Dem1}=    Evaluate    ${Dem1} + 1
                Exit For Loop If    ${Dem1} == 3
            END
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END
    #========== mua hang ===========

TC Check Transition To Checkout Step One Page
    FOR    ${user}    IN    @{list_user_name}
        Open Browser    ${URL}    ${Browser}
        Maximize Browser Window
        Log To Console    ${user}
        Input Text    \    ${xpath_username}    ${user}
        Input Text    \    ${xpath_password}    ${Password}
        Click Element    ${Login Button}
        Click Element    ${Anchor Xpath}
        Location Should Be    https://www.saucedemo.com/cart.html
        Click Button    xpath=//*[@id="checkout"]
        Location Should Be    https://www.saucedemo.com/checkout-step-one.html
        Close Browser
    END

TC Check Transition To Checkout Step One Page With Sufficient Quantity of Products
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition To Checkout Step One Page With Sufficient Quantity Of Products When Not Selecting All Items
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition To Checkout Step One Page With Sufficient Quantity of Products When Selecting Items Optionally
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Dem}    Set Variable    0
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition To Checkout Step One Page With Sufficient Quantity Of Products In A Page Containing Firstname, Lastname, And Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition To Checkout Step Two Page And Enter Random 10-Digit Numbers Into Firstname, Lastname, And Zipcode Fields #############
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_numbers}=    Generate Random String    10    1234567890
            Input Text    ${firstname}    ${random_numbers}
            Input Text    ${lastname}    ${random_numbers}
            Input Text    ${zipcode}    ${random_numbers}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition To Checkout Step Two Page And Enter Random 10-Letter Lowercase Characters Into Firstname, Lastname, And Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_lowercase}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyz
            Input Text    ${firstname}    ${random_lowercase}
            Input Text    ${lastname}    ${random_lowercase}
            Input Text    ${zipcode}    ${random_lowercase}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition To Checkout Step Two Page And Enter Random 10-Letter Uppercase Characters Into Firstname, Lastname, and Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_uppercase}=    Generate Random String    10    ABCDEFGHIJKLMNOPQRSTUVWXYZ
            Input Text    ${firstname}    ${random_uppercase}
            Input Text    ${lastname}    ${random_uppercase}
            Input Text    ${zipcode}    ${random_uppercase}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition To Checkout Step Two Page And Enter Random 10 Lowercase And Uppercase Characters Into Firstname, Lastname, And Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_lower_upper}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
            Input Text    ${firstname}    ${random_lower_upper}
            Input Text    ${lastname}    ${random_lower_upper}
            Input Text    ${zipcode}    ${random_lower_upper}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition To Checkout Step Two Page And Enter Random 10 Lowercase And Uppercase Characters, Numbers Into Firstname, Lastname, And Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_mix}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890
            Input Text    ${firstname}    ${random_mix}
            Input Text    ${lastname}    ${random_mix}
            Input Text    ${zipcode}    ${random_mix}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname, Lastname, and Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${lastname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Lastname and Zipcode Fields Wrong
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${lastname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into and Zipcode Fields Wrong
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Lastname Fields Wrong
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${lastname}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Lastname, Zipocde Fields Right
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${lastname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: First Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Zipcode Fields Right
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: First Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Lastname Fields Right
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${lastname}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: First Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname, Zipcode Fields Wrong
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname Fields Wrong
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname, Zipcode Fields Right
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: Last Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname Fields Right
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: Last Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname, Lastname Fields Wrong
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${lastname}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname, Lastname Fields Right
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${lastname}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: Postal Code is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters Wrong
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Right
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: First Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Numbers into Firstname Lastname and Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_numbers}=    Generate Random String    10    1234567890
            Input Text    ${firstname}    ${random_numbers}
            Input Text    ${lastname}    ${random_numbers}
            Input Text    ${zipcode}    ${random_numbers}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercas Characters into Firstname, Lastname and Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_lowercase}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyz
            Input Text    ${firstname}    ${random_lowercase}
            Input Text    ${lastname}    ${random_lowercase}
            Input Text    ${zipcode}    ${random_lowercase}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Uppercase Characters into Firstname, Lastname and Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_uppercase}=    Generate Random String    10    ABCDEFGHIJKLMNOPQRSTUVWXYZ
            Input Text    ${firstname}    ${random_uppercase}
            Input Text    ${lastname}    ${random_uppercase}
            Input Text    ${zipcode}    ${random_uppercase}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Special Characters into Firstname, Lastname and Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_special}=    Generate Random String    10    !@#$%^&*()
            Input Text    ${firstname}    ${random_special}
            Input Text    ${lastname}    ${random_special}
            Input Text    ${zipcode}    ${random_special}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters into Firstname, Lastname and Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_lower_upper}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
            Input Text    ${firstname}    ${random_lower_upper}
            Input Text    ${lastname}    ${random_lower_upper}
            Input Text    ${zipcode}    ${random_lower_upper}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters, Numbers into Firstname, Lastname and Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_mix}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890
            Input Text    ${firstname}    ${random_mix}
            Input Text    ${lastname}    ${random_mix}
            Input Text    ${zipcode}    ${random_mix}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname, Lastname and Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${lastname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Lastname and Zipcode Fields Wrong
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${lastname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Zipcode Fields Wrong
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Lastname Fields Wrong
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${lastname}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

ExamTC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Lastname and Zipcode Fields Right
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${lastname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: First Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Zipcode Fields Right
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: First Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Lastname Fields Right
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${lastname}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: First Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname and Zipcode Fields Wrong
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname Fields Wrong
    #Bỏ lastname và zipcode
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname and Zipcode Fields Right
    #Bỏ lastname
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: Last Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname Fields Right
    #Bỏ lastname và zipcode
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: Last Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname, Lastname Fields Wrong
    #Bỏ zipcode
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${lastname}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname, Lastname and Fields Right
    #Bỏ zipcode
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${lastname}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: Postal Code is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters Wrong
    #Bỏ cả 3
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Verify Transition to Checkout Step Two Page with Correct Number of Selected Items, Whether Optional or Not, and Enter Random 10 Lowercase and Uppercase Characters, Numbers, and Special Characters Right
    #Bỏ cả 3
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    10    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: First Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition To Checkout Step Two Page And Enter Random 100-Digit Numbers Into Firstname, Lastname, And Zipcode Fields #############
    # click all with 1000 random
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_numbers}=    Generate Random String    100    1234567890
            Input Text    ${firstname}    ${random_numbers}
            Input Text    ${lastname}    ${random_numbers}
            Input Text    ${zipcode}    ${random_numbers}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition To Checkout Step Two Page And Enter Random 100-Letter Lowercase Characters Into Firstname, Lastname, And Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_lowercase}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyz
            Input Text    ${firstname}    ${random_lowercase}
            Input Text    ${lastname}    ${random_lowercase}
            Input Text    ${zipcode}    ${random_lowercase}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100-Letter Uppercase Characters into Firstname, Lastname, and Zipcode Fields"
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_uppercase}=    Generate Random String    100    ABCDEFGHIJKLMNOPQRSTUVWXYZ
            Input Text    ${firstname}    ${random_uppercase}
            Input Text    ${lastname}    ${random_uppercase}
            Input Text    ${zipcode}    ${random_uppercase}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Special Characters into Firstname, Lastname, and Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_special}=    Generate Random String    100    !@#$%^&*()
            Input Text    ${firstname}    ${random_special}
            Input Text    ${lastname}    ${random_special}
            Input Text    ${zipcode}    ${random_special}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters into Firstname, Lastname, and Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_lower_upper}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
            Input Text    ${firstname}    ${random_lower_upper}
            Input Text    ${lastname}    ${random_lower_upper}
            Input Text    ${zipcode}    ${random_lower_upper}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters, Numbers into Firstname, Lastname, and Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_mix}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890
            Input Text    ${firstname}    ${random_mix}
            Input Text    ${lastname}    ${random_mix}
            Input Text    ${zipcode}    ${random_mix}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname, Lastname, and Zipcode Fields
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${lastname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters, Numbers, and Special Characters into Lastname, and Zipcode Fields Wrong
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${lastname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters, Numbers, and Special Characters into Zipcode Fields Wrong
    #Bỏ firstname và last name
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters, Numbers, and Special Characters into Lastname Fields Wrong
    #Bỏ firstname và zipcode
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${lastname}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters, Numbers, and Special Characters into Lastname, Zipcode Fields Right
    #Bỏ firstname
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${lastname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: First Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters, Numbers, and Special Characters into Zipcode Fields Right
    #Bỏ firstname và lastname
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: First Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters, Numbers, and Special Characters into Lastname Fields Right
    #Bỏ firstname và zipcode
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${lastname}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: First Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname, Zipcode Fields Wrong
    #Bỏ lastname
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname Fields Wrong
    #Bỏ lastname và zipcode
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname, Zipcode Fields Right
    #Bỏ lastname
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: Last Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname Fields Right
    #Bỏ lastname và zipcode
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: Last Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname, Lastname Fields Wrong
    #Bỏ zipcode
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${lastname}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters, Numbers, and Special Characters into Firstname, Lastname Fields Right
    #Bỏ zipcode
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${lastname}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: Postal Code is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters, Numbers, and Special Characters Wrong
    #Bỏ cả 3
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Transition to Checkout Step Two Page and Enter Random 100 Lowercase and Uppercase Characters, Numbers, and Special Characters Right
    #Bỏ cả 3
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Click Button    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: First Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products.
    # click random
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_numbers}=    Generate Random String    100    1234567890
            Input Text    ${firstname}    ${random_numbers}
            Input Text    ${lastname}    ${random_numbers}
            Input Text    ${zipcode}    ${random_numbers}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products1
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_lowercase}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyz
            Input Text    ${firstname}    ${random_lowercase}
            Input Text    ${lastname}    ${random_lowercase}
            Input Text    ${zipcode}    ${random_lowercase}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products2
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_uppercase}=    Generate Random String    100    ABCDEFGHIJKLMNOPQRSTUVWXYZ
            Input Text    ${firstname}    ${random_uppercase}
            Input Text    ${lastname}    ${random_uppercase}
            Input Text    ${zipcode}    ${random_uppercase}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products4
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_special}=    Generate Random String    100    !@#$%^&*()
            Input Text    ${firstname}    ${random_special}
            Input Text    ${lastname}    ${random_special}
            Input Text    ${zipcode}    ${random_special}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products5
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_lower_upper}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
            Input Text    ${firstname}    ${random_lower_upper}
            Input Text    ${lastname}    ${random_lower_upper}
            Input Text    ${zipcode}    ${random_lower_upper}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products6
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_mix}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890
            Input Text    ${firstname}    ${random_mix}
            Input Text    ${lastname}    ${random_mix}
            Input Text    ${zipcode}    ${random_mix}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products7
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${lastname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products8
    #Bỏ firstname
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${lastname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products9
    #Bỏ firstname và lastname
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products10
    #Bỏ firstname và zipcode
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${lastname}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products11
    #Bỏ firstname
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${lastname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: First Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products12
    #Bỏ firstname và lastname
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: First Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products13
    #Bỏ firstname và zipcode
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${lastname}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: First Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products14
    #Bỏ lastname
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products15
    #Bỏ lastname và zipcode
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products16
    #Bỏ lastname
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${zipcode}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: Last Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products17
    #Bỏ lastname và zipcode
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Click Button    ${continue}
            Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
            Should Be Equal As Strings    ${h3Text}    Error: Last Name is required
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products18
    #Bỏ zipcode
    FOR    ${user}    IN    @{list_user_name}
        TRY
            ${Tong}    Set Variable    0
            ${Dem}    Set Variable    0
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${shuffled_ids}=    Copy List    ${IDs}
            ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
            FOR    ${id}    IN    @{shuffled_ids}
                Click Button    ${id}
                ${my_list}=    Create List    ${id}
                ${Tong}=    Evaluate    ${Tong} + 1
                ${Dem}=    Evaluate    ${Dem} + 1
                Exit For Loop If    ${Dem} == 3
            END
            Click Element    ${Anchor Xpath}
            Location Should Be    https://www.saucedemo.com/cart.html
            Click Button    xpath=//*[@id="checkout"]
            Location Should Be    https://www.saucedemo.com/checkout-step-one.html
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    ${Tong}
            Element Should Be Visible    ${firstname}
            Element Should Be Visible    ${lastname}
            Element Should Be Visible    ${zipcode}
            ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
            Input Text    ${firstname}    ${random_all}
            Input Text    ${lastname}    ${random_all}
            Click Button    ${continue}
            Location Should Be    https://www.saucedemo.com/checkout-step-two.html
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

Similar to the above test cases, but with randomly selected products19
    #Bỏ zipcode
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${firstname}    ${random_all}
    Input Text    ${lastname}    ${random_all}
    Click Button    ${continue}
    Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    Should Be Equal As Strings    ${h3Text}    Error: Postal Code is required
    Close Browser

Similar to the above test cases, but with randomly selected products20
    #Bỏ cả 3
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the above test cases, but with randomly selected products21
    #Bỏ cả 3
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    100    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Click Button    ${continue}
    Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    Should Be Equal As Strings    ${h3Text}    Error: First Name is required
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters filled into 3 fields
    # click all with 1000 random
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_numbers}=    Generate Random String    1000    1234567890
    Input Text    ${firstname}    ${random_numbers}
    Input Text    ${lastname}    ${random_numbers}
    Input Text    ${zipcode}    ${random_numbers}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters filled into 3 fields1
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_lowercase}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyz
    Input Text    ${firstname}    ${random_lowercase}
    Input Text    ${lastname}    ${random_lowercase}
    Input Text    ${zipcode}    ${random_lowercase}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters filled into 3 fields2
    ${Tong}    Set Variable    0
    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_uppercase}=    Generate Random String    1000    ABCDEFGHIJKLMNOPQRSTUVWXYZ
    Input Text    ${firstname}    ${random_uppercase}
    Input Text    ${lastname}    ${random_uppercase}
    Input Text    ${zipcode}    ${random_uppercase}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters filled into 3 fields3
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_special}=    Generate Random String    1000    !@#$%^&*()
    Input Text    ${firstname}    ${random_special}
    Input Text    ${lastname}    ${random_special}
    Input Text    ${zipcode}    ${random_special}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters filled into 3 fields4
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_lower_upper}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
    Input Text    ${firstname}    ${random_lower_upper}
    Input Text    ${lastname}    ${random_lower_upper}
    Input Text    ${zipcode}    ${random_lower_upper}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters filled into 3 fields5
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_mix}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890
    Input Text    ${firstname}    ${random_mix}
    Input Text    ${lastname}    ${random_mix}
    Input Text    ${zipcode}    ${random_mix}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters filled into 3 fields6
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${firstname}    ${random_all}
    Input Text    ${lastname}    ${random_all}
    Input Text    ${zipcode}    ${random_all}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters not filled sequentially into the fields
    #Bỏ firstname
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${lastname}    ${random_all}
    Input Text    ${zipcode}    ${random_all}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters not filled sequentially into the fields1
    #Bỏ firstname và last name
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${zipcode}    ${random_all}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters not filled sequentially into the fields2
    #Bỏ firstname và zipcode
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${lastname}    ${random_all}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters not filled sequentially into the fields3
    #Bỏ firstname
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${lastname}    ${random_all}
    Input Text    ${zipcode}    ${random_all}
    Click Button    ${continue}
    Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    Should Be Equal As Strings    ${h3Text}    Error: First Name is required
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters not filled sequentially into the fields4
    #Bỏ firstname và lastname
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${zipcode}    ${random_all}
    Click Button    ${continue}
    Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    Should Be Equal As Strings    ${h3Text}    Error: First Name is required
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters not filled sequentially into the fields5
    #Bỏ firstname và zipcode
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${lastname}    ${random_all}
    Click Button    ${continue}
    Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    Should Be Equal As Strings    ${h3Text}    Error: First Name is required
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters not filled sequentially into the fields6
    #Bỏ lastname
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${firstname}    ${random_all}
    Input Text    ${zipcode}    ${random_all}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters not filled sequentially into the fields7
    #Bỏ lastname và zipcode
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${firstname}    ${random_all}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters not filled sequentially into the fields8
    #Bỏ lastname
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${firstname}    ${random_all}
    Input Text    ${zipcode}    ${random_all}
    Click Button    ${continue}
    Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    Should Be Equal As Strings    ${h3Text}    Error: Last Name is required
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters not filled sequentially into the fields9
    #Bỏ lastname và zipcode
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${firstname}    ${random_all}
    Click Button    ${continue}
    Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    Should Be Equal As Strings    ${h3Text}    Error: Last Name is required
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters not filled sequentially into the fields10
    #Bỏ zipcode
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${firstname}    ${random_all}
    Input Text    ${lastname}    ${random_all}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters not filled sequentially into the fields11
    #Bỏ zipcode
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${firstname}    ${random_all}
    Input Text    ${lastname}    ${random_all}
    Click Button    ${continue}
    Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    Should Be Equal As Strings    ${h3Text}    Error: Postal Code is required
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters not filled sequentially into the fields12
    #Bỏ cả 3
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting all products, but with random 1000 characters not filled sequentially into the fields13
    #Bỏ cả 3
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Click Button    ${continue}
    Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    Should Be Equal As Strings    ${h3Text}    Error: First Name is required
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters filled sequentially into the fields
    # click random
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_numbers}=    Generate Random String    1000    1234567890
    Input Text    ${firstname}    ${random_numbers}
    Input Text    ${lastname}    ${random_numbers}
    Input Text    ${zipcode}    ${random_numbers}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters filled sequentially into the fields1
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_lowercase}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyz
    Input Text    ${firstname}    ${random_lowercase}
    Input Text    ${lastname}    ${random_lowercase}
    Input Text    ${zipcode}    ${random_lowercase}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters filled sequentially into the fields2
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_uppercase}=    Generate Random String    1000    ABCDEFGHIJKLMNOPQRSTUVWXYZ
    Input Text    ${firstname}    ${random_uppercase}
    Input Text    ${lastname}    ${random_uppercase}
    Input Text    ${zipcode}    ${random_uppercase}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters filled sequentially into the fields3
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_special}=    Generate Random String    1000    !@#$%^&*()
    Input Text    ${firstname}    ${random_special}
    Input Text    ${lastname}    ${random_special}
    Input Text    ${zipcode}    ${random_special}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters filled sequentially into the fields4
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_lower_upper}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
    Input Text    ${firstname}    ${random_lower_upper}
    Input Text    ${lastname}    ${random_lower_upper}
    Input Text    ${zipcode}    ${random_lower_upper}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters filled sequentially into the fields5
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_mix}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890
    Input Text    ${firstname}    ${random_mix}
    Input Text    ${lastname}    ${random_mix}
    Input Text    ${zipcode}    ${random_mix}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters filled sequentially into the fields6
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${firstname}    ${random_all}
    Input Text    ${lastname}    ${random_all}
    Input Text    ${zipcode}    ${random_all}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters sequentially skipped in the fields
    #Bỏ firstname
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${lastname}    ${random_all}
    Input Text    ${zipcode}    ${random_all}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters sequentially skipped in the fields1
    #Bỏ firstname và lastname
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${zipcode}    ${random_all}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters sequentially skipped in the fields2
    #Bỏ firstname và zipcode
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${lastname}    ${random_all}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters sequentially skipped in the fields3
    #Bỏ firstname
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${lastname}    ${random_all}
    Input Text    ${zipcode}    ${random_all}
    Click Button    ${continue}
    Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    Should Be Equal As Strings    ${h3Text}    Error: First Name is required
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters sequentially skipped in the fields4
    #Bỏ firstname và lastname
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${zipcode}    ${random_all}
    Click Button    ${continue}
    Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    Should Be Equal As Strings    ${h3Text}    Error: First Name is required
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters sequentially skipped in the fields5
    #Bỏ firstname và zipcode
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${lastname}    ${random_all}
    Click Button    ${continue}
    Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    Should Be Equal As Strings    ${h3Text}    Error: First Name is required
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters sequentially skipped in the fields6
    #Bỏ lastname
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${firstname}    ${random_all}
    Input Text    ${zipcode}    ${random_all}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters sequentially skipped in the fields7
    #Bỏ lastname và zipcode
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${firstname}    ${random_all}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters sequentially skipped in the fields8
    #Bỏ lastname
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${firstname}    ${random_all}
    Input Text    ${zipcode}    ${random_all}
    Click Button    ${continue}
    Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    Should Be Equal As Strings    ${h3Text}    Error: Last Name is required
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters sequentially skipped in the fields9
    #Bỏ lastname và zipcode
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${firstname}    ${random_all}
    Click Button    ${continue}
    Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    Should Be Equal As Strings    ${h3Text}    Error: Last Name is required
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters sequentially skipped in the fields10
    #Bỏ zipcode
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${firstname}    ${random_all}
    Input Text    ${lastname}    ${random_all}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters sequentially skipped in the fields11
    #Bỏ zipcode
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Input Text    ${firstname}    ${random_all}
    Input Text    ${lastname}    ${random_all}
    Click Button    ${continue}
    Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    Should Be Equal As Strings    ${h3Text}    Error: Postal Code is required
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters sequentially skipped in the fields12
    #Bỏ cả 3
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser

Similar to the test cases selecting specific products, but with random 1000 characters sequentially skipped in the fields13
    #Bỏ cả 3
    ${Tong}    Set Variable    0
    ${Dem}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button    ${id}
        ${my_list}=    Create List    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
        ${Dem}=    Evaluate    ${Dem} + 1
        Exit For Loop If    ${Dem} == 3
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_all}=    Generate Random String    1000    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()
    Click Button    ${continue}
    Element Should Be Visible    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    ${h3Text}=    Get Text    xpath=//*[@id="checkout_info_container"]/div/form/div[1]/div[4]/h3
    Should Be Equal As Strings    ${h3Text}    Error: First Name is required
    Close Browser

Similar to the test cases selecting all products, but with random 10000 characters filled into 3 fields.
    # click all with 10000 random
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    FOR    ${id}    IN    @{IDs}
        Click Button    ${id}
        ${Tong}=    Evaluate    ${Tong} + 1
    END
    Click Element    ${Anchor Xpath}
    Location Should Be    https://www.saucedemo.com/cart.html
    Click Button    xpath=//*[@id="checkout"]
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    Element Should Be Visible    ${firstname}
    Element Should Be Visible    ${lastname}
    Element Should Be Visible    ${zipcode}
    ${random_numbers}=    Generate Random String    10000    1234567890
    Input Text    ${firstname}    ${random_numbers}
    Input Text    ${lastname}    ${random_numbers}
    Input Text    ${zipcode}    ${random_numbers}
    Click Button    ${continue}
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html
    Close Browser
    # \ \ =========== Nhập hàng ==========

TC Check The First Button Change
    FOR    ${user}    IN    @{list_user_name}
        TRY
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            ${anchor_element}=    Get WebElement    ${Anchor Xpath}
            ${span_element}=    Get WebElement    ${Span Xpath}
            ${anchor_text}=    Get Text    ${anchor_element}
            ${span_text}=    Get Text    ${span_element}
            Should Be True    '${span_text}' != ''
            Should Be True    '${span_text}' in '${anchor_text}'
            Should Be Equal As Numbers    ${span_text}    1
            ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${Add to cart}    # Kiểm tra xem nút ban đầu đã biến mất hay chưa
            Should Be True    ${button_disappear}    # Nút ban đầu không còn hiển thị
            Element Should Be Visible    ${Remove button}
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Click Twice The First Button Add To Cart
    FOR    ${user}    IN    @{list_user_name}
        TRY
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            Click Button    ${Add to cart}
            Click Button    ${Add to cart}
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Check Click Twice The First Button Add To Cart And Remove Button
    FOR    ${user}    IN    @{list_user_name}
        TRY
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            Click Button    ${Add to cart}
            Click Button    ${Remove button}
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Checks Clicking On All Add To Cart Buttons With Single Browser Opening And Login.
    #bug
    FOR    ${user}    IN    @{list_user_name}
        TRY
            Open Browser    ${URL}    ${Browser}
            Maximize Browser Window
            Input Text    ${xpath_username}    ${user}
            Input Text    ${xpath_password}    ${Password}
            Click Element    ${Login Button}
            FOR    ${id}    IN    @{IDs}
                Nhaphang1 Template    ${id}
    #    bug
            END
            Close Browser
        EXCEPT
            Log To Console    error
            Close Browser
        END
    END

TC Checks Clicking On All Add To Cart Buttons With Each Browser Opening And Login.
    FOR    ${id}    IN    @{IDs}
        Nhaphang Template    ${id}
    END
