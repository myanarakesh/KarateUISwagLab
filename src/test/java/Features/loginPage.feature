Feature: Validate Login Page

  Background:
    * configure driver = { type: 'chrome', showDriverLog: false, addOptions: ["--remote-allow-origins=*"] }
    Given driver "https://www.saucedemo.com/"
    * driver.maximize()

  Scenario: Validate login page and logout for normal user
    * delay(1500)
    And input('#user-name','standard_user')
    And input('#password','secret_sauce')
    When click('#login-button')
#    * waitForEnabled('#someBtn').click()
    Then waitForUrl('https://www.saucedemo.com/inventory.html')
    And match driver.url == 'https://www.saucedemo.com/inventory.html'
    And click('#react-burger-menu-btn')
    And click('#logout_sidebar_link')