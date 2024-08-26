*** Settings ***
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

*** Test Case ***
TC Checks Clicking On All Add To Cart Buttons Once With A Single Browser Opening And Login
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    Sleep    3s
    FOR    ${id}    IN    @{IDs}
        Click Button Template    ${id}
        Sleep    1s
    END
    Close Browser

TC Check Pressing All Add To Cart Buttons With Each Browser Opening And Login But Window Minimized
    FOR    ${id}    IN    @{IDs}
        Nhaphang1 Template    ${id}
    END

TC Check Pressing All Add To Cart Buttons Once With Browser Opening And Login But Window Minimized
    Open Browser    ${URL}    ${Browser}
    Set Window Size    800    600
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    Sleep    3s
    FOR    ${id}    IN    @{IDs}
        Click Button Template    ${id}
        Sleep    1s
    END
    Close Browser

TC Check Pressing All Add To Cart Buttons From Bottom Up With Each Browser Opening And Login
    FOR    ${id}    IN    @{IDs}[::-1]
        Nhaphang Template    ${id}
    END

TC Check Pressing All Add To Cart Buttons From Bottom Up Once With Browser Opening And Login
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    Sleep    3s
    FOR    ${id}    IN    @{IDs}[::-1]
        Click Button Template    ${id}
        Sleep    1s
    END
    Close Browser

TC Check Pressing All Add To Cart Buttons From Bottom Up With Each Browser Opening And Login But Window Minimized
    FOR    ${id}    IN    @{IDs}[::-1]
        Nhaphang1 Template    ${id}
    END

TC Check Pressing All Add To Cart Buttons From Bottom Up Once With Browser Opening And Login But Window Minimized
    Open Browser    ${URL}    ${Browser}
    Set Window Size    800    600
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    Sleep    3s
    FOR    ${id}    IN    @{IDs}[::-1]
        Click Button Template    ${id}
        Sleep    1s
    END
    Close Browser

TC Checks If Add To Cart Buttons Have Changed To Remove Button Or Not With Each Browser Opening And Login
    ${Tong}    Set Variable    0
    FOR    ${id}    IN    @{IDs}
        Nhaphang2 Template    ${id}
        ${anchor_element}=    Get WebElement    ${Anchor Xpath}
        ${span_element}=    Get WebElement    ${Span Xpath}
        ${anchor_text}=    Get Text    ${anchor_element}
        ${span_text}=    Get Text    ${span_element}
        Should Be True    '${span_text}' != ''
        Should Be True    '${span_text}' in '${anchor_text}'
        ${expected_value}=    Evaluate    ${Tong} + 1
        Should Be Equal As Numbers    ${span_text}    ${expected_value}
        ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${id}
        Should Be True    ${button_disappear}
        ${id}=    Replace String    ${id}    add-to-cart    remove
        Element Should Be Visible    ${id}
        Close Browser
    END

TC Checks If The First Remove Button Has Changed Back To Add To Cart Button Or Not
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    Sleep    3s
    Click Button    ${Add to cart}
    Sleep    3s
    Click Button    ${Remove button}
    Sleep    3s
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${Remove button}
    Should Be True    ${button_disappear}
    Element Should Be Visible    ${Add to cart}
    Close Browser

TC Checks If Add To Cart Buttons Have Changed To Remove Button Or Not Once With Browser Opening And Login
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    Sleep    3s
    FOR    ${id}    IN    @{IDs}
        Click Button Template    ${id}
        Sleep    1s
        ${anchor_element}=    Get WebElement    ${Anchor Xpath}
        ${span_element}=    Get WebElement    ${Span Xpath}
        ${anchor_text}=    Get Text    ${anchor_element}
        ${span_text}=    Get Text    ${span_element}
        Should Be True    '${span_text}' != ''
        Should Be True    '${span_text}' in '${anchor_text}'
        ${Tong}=    Evaluate    ${Tong} + 1
        Should Be Equal As Numbers    ${span_text}    ${Tong}
        ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${id}
        Should Be True    ${button_disappear}
        ${id}=    Replace String    ${id}    add-to-cart    remove
        Element Should Be Visible    ${id}
    END
    Close Browser

TC Checks If Add To Cart Buttons Have Changed To Remove Button Or Not With Each Browser Opening And Login But Window Minimized
    ${Tong}    Set Variable    0
    FOR    ${id}    IN    @{IDs}
        Nhaphang3 Template    ${id}
        ${anchor_element}=    Get WebElement    ${Anchor Xpath}
        ${span_element}=    Get WebElement    ${Span Xpath}
        ${anchor_text}=    Get Text    ${anchor_element}
        ${span_text}=    Get Text    ${span_element}
        Should Be True    '${span_text}' != ''
        Should Be True    '${span_text}' in '${anchor_text}'
        ${expected_value}=    Evaluate    ${Tong} + 1
        Should Be Equal As Numbers    ${span_text}    ${expected_value}
        ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${id}
        Should Be True    ${button_disappear}
        ${id}=    Replace String    ${id}    add-to-cart    remove
        Element Should Be Visible    ${id}
        Close Browser
    END

TC Checks If Add To Cart Buttons Have Changed To Remove Button Or Not Once With Browser Opening And Login But Window Minimized
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Set Window Size    800    600
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    Sleep    3s
    FOR    ${id}    IN    @{IDs}
        Click Button Template    ${id}
        Sleep    1s
        ${anchor_element}=    Get WebElement    ${Anchor Xpath}
        ${span_element}=    Get WebElement    ${Span Xpath}
        ${anchor_text}=    Get Text    ${anchor_element}
        ${span_text}=    Get Text    ${span_element}
        Should Be True    '${span_text}' != ''
        Should Be True    '${span_text}' in '${anchor_text}'
        ${Tong}=    Evaluate    ${Tong} + 1
        Should Be Equal As Numbers    ${span_text}    ${Tong}
        ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${id}
        Should Be True    ${button_disappear}
        ${id}=    Replace String    ${id}    add-to-cart    remove
        Element Should Be Visible    ${id}
    END
    Close Browser

TC Checks If Add To Cart Buttons Have Changed To Remove Button Or Not From Bottom Up With Each Browser Opening And Login
    ${Tong}    Set Variable    0
    FOR    ${id}    IN    @{IDs}[::-1]
        Nhaphang2 Template    ${id}
        ${anchor_element}=    Get WebElement    ${Anchor Xpath}
        ${span_element}=    Get WebElement    ${Span Xpath}
        ${anchor_text}=    Get Text    ${anchor_element}
        ${span_text}=    Get Text    ${span_element}
        Should Be True    '${span_text}' != ''
        Should Be True    '${span_text}' in '${anchor_text}'
        ${expected_value}=    Evaluate    ${Tong} + 1
        Should Be Equal As Numbers    ${span_text}    ${expected_value}
        ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${id}
        Should Be True    ${button_disappear}
        ${id}=    Replace String    ${id}    add-to-cart    remove
        Element Should Be Visible    ${id}
        Close Browser
    END

TC Checks If Add To Cart Buttons Have Changed To Remove Button Or Not From Bottom Up Once With Browser Opening And Login
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    Sleep    3s
    FOR    ${id}    IN    @{IDs}[::-1]
        Click Button Template    ${id}
        Sleep    1s
        ${anchor_element}=    Get WebElement    ${Anchor Xpath}
        ${span_element}=    Get WebElement    ${Span Xpath}
        ${anchor_text}=    Get Text    ${anchor_element}
        ${span_text}=    Get Text    ${span_element}
        Should Be True    '${span_text}' != ''
        Should Be True    '${span_text}' in '${anchor_text}'
        ${Tong}=    Evaluate    ${Tong} + 1
        Should Be Equal As Numbers    ${span_text}    ${Tong}
        ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${id}
        Should Be True    ${button_disappear}
        ${id}=    Replace String    ${id}    add-to-cart    remove
        Element Should Be Visible    ${id}
    END
    Close Browser

TC Check If The Remove Buttons Have Changed Back To Add To Cart Buttons With Each Browser Opening And Login
    ${Tong}    Set Variable    0
    FOR    ${id}    IN    @{IDs}
        Nhaphang2 Template    ${id}
        ${anchor_element}=    Get WebElement    ${Anchor Xpath}
        ${span_element}=    Get WebElement    ${Span Xpath}
        ${anchor_text}=    Get Text    ${anchor_element}
        ${span_text}=    Get Text    ${span_element}
        Should Be True    '${span_text}' != ''
        Should Be True    '${span_text}' in '${anchor_text}'
        ${expected_value}=    Evaluate    ${Tong} + 1
        Should Be Equal As Numbers    ${span_text}    ${expected_value}
        ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${id}
        Should Be True    ${button_disappear}
        ${id}=    Replace String    ${id}    add-to-cart    remove
        Element Should Be Visible    ${id}
        Click Button Template    ${id}
        ${anchor_element}=    Get WebElement    ${Anchor Xpath}
        ${anchor_text}=    Get Text    ${anchor_element}
        ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${id}
        ${id}=    Replace String    ${id}    remove    add-to-cart
        Should Be True    ${button_disappear}
        Element Should Be Visible    ${id}
        Close Browser
    END

TC Check If The Remove Buttons Have Changed Back To Add To Cart Buttons Once With Browser Opening And Login
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    Sleep    3s
    FOR    ${id}    IN    @{IDs}
        Click Button Template    ${id}
        Sleep    1s
        ${anchor_element}=    Get WebElement    ${Anchor Xpath}
        ${span_element}=    Get WebElement    ${Span Xpath}
        ${anchor_text}=    Get Text    ${anchor_element}
        ${span_text}=    Get Text    ${span_element}
        Should Be True    '${span_text}' != ''
        Should Be True    '${span_text}' in '${anchor_text}'
        ${Tong}=    Evaluate    ${Tong} + 1
        Should Be Equal As Numbers    ${span_text}    ${Tong}
        ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${id}    # Kiểm tra xem nút ban đầu đã biến mất hay chưa
        Should Be True    ${button_disappear}    # Nút ban đầu không còn hiển thị
        ${id}=    Replace String    ${id}    add-to-cart    remove    # Thay thế chuỗi 'add-to-cart' thành 'remove-sauce-labs'
        Element Should Be Visible    ${id}
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

TC Check If The Add To Cart Buttons Have Changed To Remove Buttons Optionally With One Browser Opening And login
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    Sleep    3s
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button Template    ${id}
        Sleep    1s
        ${anchor_element}=    Get WebElement    ${Anchor Xpath}
        ${span_element}=    Get WebElement    ${Span Xpath}
        ${anchor_text}=    Get Text    ${anchor_element}
        ${span_text}=    Get Text    ${span_element}
        Should Be True    '${span_text}' != ''
        Should Be True    '${span_text}' in '${anchor_text}'
        ${Tong}=    Evaluate    ${Tong} + 1
        Should Be Equal As Numbers    ${span_text}    ${Tong}
        ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${id}
        Should Be True    ${button_disappear}
        ${id}=    Replace String    ${id}    add-to-cart    remove
        Element Should Be Visible    ${id}
    END
    Close Browser

TC Check If The Remove Buttons Have Changed To Add To Cart Buttons Buttons Optionally With One Browser Opening And login
    ${Tong}    Set Variable    0
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    Sleep    3s
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Sleep    3s
    Click Button    ${Login Button}
    Sleep    3s
    ${shuffled_ids}=    Copy List    ${IDs}
    ${shuffled_ids}=    Evaluate    random.sample($shuffled_ids, len($shuffled_ids))
    FOR    ${id}    IN    @{shuffled_ids}
        Click Button Template    ${id}
        Sleep    1s
        ${anchor_element}=    Get WebElement    ${Anchor Xpath}
        ${span_element}=    Get WebElement    ${Span Xpath}
        ${anchor_text}=    Get Text    ${anchor_element}
        ${span_text}=    Get Text    ${span_element}
        Should Be True    '${span_text}' != ''
        Should Be True    '${span_text}' in '${anchor_text}'
        ${Tong}=    Evaluate    ${Tong} + 1
        Should Be Equal As Numbers    ${span_text}    ${Tong}
        ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${id}    # Kiểm tra xem nút ban đầu đã biến mất hay chưa
        Should Be True    ${button_disappear}    # Nút ban đầu không còn hiển thị
        ${id}=    Replace String    ${id}    add-to-cart    remove    # Thay thế chuỗi 'add-to-cart' thành 'remove-sauce-labs'
        Element Should Be Visible    ${id}
    END
    ${shuffled_ids1}=    Copy List    ${ID1s}
    ${shuffled_ids1}=    Evaluate    random.sample($shuffled_ids1, len($shuffled_ids1))
    FOR    ${id}    IN    @{shuffled_ids1}
        Click Button Template    ${id}
        Sleep    1s
        ${span_element_exist}=    Run Keyword And Return Status    Element Should Be Visible    ${Span Xpath}
        ${Tong}=    Evaluate    ${Tong} - 1
        Run Keyword If    '${span_element_exist}' == 'True'    Run Multiple Keywords True    ${id}    ${Tong}
        Run Keyword If    '${span_element_exist}' == 'False'    Run Multiple Keywords False    ${id}
    END
    Close Browser

*** Keywords ***


Open Web
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window

Validate add to cart
    TRY
        Click Element    //*[@id="add-to-cart-sauce-labs-backpack"]
        Click Element    //*[@id="remove-sauce-labs-backpack"]
        Click Element    //*[@id="add-to-cart-sauce-labs-bike-light"]
        Click Element    //*[@id="remove-sauce-labs-bike-light"]
        Click Element    //*[@id="add-to-cart-sauce-labs-bolt-t-shirt"]
        Click Element    //*[@id="remove-sauce-labs-bolt-t-shirt"]
        Click Element    //*[@id="add-to-cart-sauce-labs-fleece-jacket"]
        Click Element    //*[@id="remove-sauce-labs-fleece-jacket"]
        Click Element    //*[@id="add-to-cart-sauce-labs-onesie"]
        Click Element    //*[@id="remove-sauce-labs-onesie"]
        Click Element    //*[@id="add-to-cart-test.allthethings()-t-shirt-(red)"]
        Click Element    //*[@id="remove-test.allthethings()-t-shirt-(red)"]
    EXCEPT
        Log To Console    User error in add to cart
    END

Element Should Have Class
    [Arguments]    ${locator}    ${class}
    ${escaped}=    \    \    \    Regexp Escape    \    \    ${class}
    ${classes}=    \    \    \    Get Element Attribute    ${locator}    \    class
    Should Match Regexp    \    ${classes}    \    \    \\b${escaped}\\b

Check out product
    TRY
        Click Element    //*[@id="add-to-cart-sauce-labs-backpack"]
        Click Element    //*[@id="add-to-cart-sauce-labs-bike-light"]
        Click Element    //*[@id="add-to-cart-sauce-labs-bolt-t-shirt"]
        Click Element    //*[@id="add-to-cart-sauce-labs-fleece-jacket"]
        Click Element    //*[@id="add-to-cart-sauce-labs-onesie"]
        Click Element    //*[@id="add-to-cart-test.allthethings()-t-shirt-(red)"]
        Click Element    //*[@id="shopping_cart_container"]/a
        Click Button    //*[@id="checkout"]
        Input Text    //*[@id="first-name"]    admin
        Input Text    //*[@id="last-name"]    admin
        Input Text    //*[@id="postal-code"]    10000
        Click Button    //*[@id="continue"]
        Click Button    //*[@id="finish"]
        Page Should Contain Element    //*[@id="checkout_complete_container"]/h2
    EXCEPT
        Log To Console    Error in check out product
    END

Log out user
    Click Element    //*[@id="react-burger-menu-btn"]
    Sleep    1
    Click Element    //*[@id="logout_sidebar_link"]
    Page Should Contain Element    //*[@id="login-button"]
    Log To Console    Log out success

Validate number shopping cart
    TRY
        Click Element    //*[@id="add-to-cart-sauce-labs-backpack"]
        Click Element    //*[@id="add-to-cart-sauce-labs-bike-light"]
        Click Element    //*[@id="add-to-cart-sauce-labs-bolt-t-shirt"]
        Click Element    //*[@id="add-to-cart-sauce-labs-fleece-jacket"]
        Click Element    //*[@id="add-to-cart-sauce-labs-onesie"]
        Click Element    //*[@id="add-to-cart-test.allthethings()-t-shirt-(red)"]
        Click Element    //*[@id="shopping_cart_container"]/a
        ${number}=    Get Text    //*[@id="shopping_cart_container"]/a/span
        Log    Num Value is ${number} in shopping cart
        Should Be Equal    ${number}    6
        Should Be Equal As Numbers    ${number}    6
    EXCEPT
        Log To Console    Error in number product
    END
    #Calculation performance

Get Texts By Class Name
    [Arguments]    ${class_name}
    ${elements}    Get WebElements    class:${class_name}
    ${texts}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${texts}    ${text}
    END
    #    =========== Tính tiền =================
    [Return]    ${texts}

Convert Name to Dictionary
    ${values}    Create List    29.99    9.99    15.99    49.99    7.99    15.99
    ${id_value_dict}    Create Dictionary
    FOR    ${index}    IN RANGE    ${name_list.__len__()}
        Set To Dictionary    ${id_value_dict}    ${name_list[${index}]}    ${values[${index}]}
    END
    [Return]    ${id_value_dict}

Convert IDs to Dictionary
    ${id_value_dict}    Create Dictionary
    FOR    ${index}    IN RANGE    ${IDs.__len__()}
        Set To Dictionary    ${id_value_dict}    ${IDs[${index}]}    ${name_list[${index}]}
    END
    [Return]    ${id_value_dict}

Get value by ID
    [Arguments]    ${id}
    ${dict_id_name}    Convert IDs to Dictionary
    ${dict_name_value}    Convert Name to Dictionary
    ${name}    Get From Dictionary    ${dict_id_name}    ${id}    ${id}
    ${value}    Get From Dictionary    ${dict_name_value}    ${name}    ${name}
    #    Get From Dictionary    dictionary    key    default
    [Return]    ${value}

Get name by ID
    [Arguments]    ${id}
    ${dict_id_name}    Convert IDs to Dictionary
    ${name}    Get From Dictionary    ${dict_id_name}    ${id}    ${id}
    #    Get From Dictionary    dictionary    key    default
    [Return]    ${name}

Multiply each value by 0.08 and add the result to the sum
    [Arguments]    ${values}
    ${sum_of_values}    Set Variable    0
    FOR    ${value}    IN    @{values}
        ${result}    Evaluate    ${value} * 0.08
        ${sum_of_values}    Evaluate    ${sum_of_values} + ${result}
    END
    [Return]    ${sum_of_values}

Sum of price
    [Arguments]    ${values}
    ${sum_of_values}    Set Variable    0
    FOR    ${value}    IN    @{values}
        ${sum_of_values}    Evaluate    ${sum_of_values} + ${value}
    END
    [Return]    ${sum_of_values}

Get Text Names
    [Arguments]    ${xpath}
    ${text}    Get Text    ${xpath}
    #============== thanh toan ==========
    [Return]    ${text}

Click Button Template
    [Arguments]    ${id}
    Click Button    ${id}

Run Multiple Keywords False
    [Arguments]    ${id}
    ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${id}    # Kiểm tra xem nút ban đầu đã biến mất hay chưa
    Should Be True    ${button_disappear}    # Nút ban đầu không còn hiển thị
    Element Should Not Be Visible    ${id}

Run Multiple Keywords True
    [Arguments]    ${id}    ${Tong}
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${id}    # Kiểm tra xem nút ban đầu đã biến mất hay chưa
    Should Be True    ${button_disappear}    # Nút ban đầu không còn hiển thị
    Element Should Not Be Visible    ${id}
    #    =============== Nhập hàng ===========

Nhaphang Template
    [Arguments]    ${id}
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Click Button    ${Login Button}
    Click Button    ${id}
    Close Browser

Nhaphang1 Template
    [Arguments]    ${id}
    Open Browser    ${URL}    ${Browser}
    Set Window Size    800    600
    Input Text    ${Username Field}    ${Username}
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Click Button    ${Login Button}
    Click Button    ${id}
    Close Browser

Nhaphang2 Template
    [Arguments]    ${id}
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Input Text    ${Username Field}    ${Username}
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Click Button    ${Login Button}
    Click Button    ${id}

Nhaphang3 Template
    [Arguments]    ${id}
    Open Browser    ${URL}    ${Browser}
    Set Window Size    800    600
    Input Text    ${Username Field}    ${Username}
    SeleniumLibrary.Input Password    ${Password Field}    ${Password}
    Click Button    ${Login Button}
    Click Button    ${id}

Click Button Template
    [Arguments]    ${id}
    Click Button    ${id}

Run Multiple Keywords False
    [Arguments]    ${id}
    ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${id}    # Kiểm tra xem nút ban đầu đã biến mất hay chưa
    Should Be True    ${button_disappear}    # Nút ban đầu không còn hiển thị
    ${id}=    Replace String    ${id}    remove    add-to-cart    # Thay thế chuỗi 'add-to-cart' thành 'remove-sauce-labs'
    Element Should Be Visible    ${id}

Run Multiple Keywords True
    [Arguments]    ${id}    ${Tong}
    ${anchor_element}=    Get WebElement    ${Anchor Xpath}
    ${span_element}=    Get WebElement    ${Span Xpath}
    ${anchor_text}=    Get Text    ${anchor_element}
    ${span_text}=    Get Text    ${span_element}
    Should Be True    '${span_text}' != ''
    Should Be True    '${span_text}' in '${anchor_text}'
    Should Be Equal As Numbers    ${span_text}    ${Tong}
    ${button_disappear}=    Run Keyword And Return Status    Element Should Not Be Visible    ${id}    # Kiểm tra xem nút ban đầu đã biến mất hay chưa
    Should Be True    ${button_disappear}    # Nút ban đầu không còn hiển thị
    ${id}=    Replace String    ${id}    remove    add-to-cart    # Thay thế chuỗi 'add-to-cart' thành 'remove-sauce-labs'
    Element Should Be Visible    ${id}
