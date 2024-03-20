Feature: Validate Login Page

  Background:
#    * def testData = read('classpath:TestData.json')
    * def testData =  call read 'TestData.json'
    * print testData
    * print testData.credentials.standard_user
    * configure driver = { type: 'chrome', showDriverLog: false, addOptions: ["--remote-allow-origins=*"] }
    Given driver "https://www.saucedemo.com/"
    * driver.maximize()

  Scenario Outline: Validate login and logout for <user>
    * delay(1500)
    And input('#user-name',<userName>)
    And input('#password',<password>)
    When click('#login-button')
#    * waitForEnabled('#someBtn').click()
    Then waitForUrl('https://www.saucedemo.com/inventory.html')
    And match driver.url == 'https://www.saucedemo.com/inventory.html'
    And click('#react-burger-menu-btn')
    And click('#logout_sidebar_link')
    Examples:
      | user                    | userName                                     | password                          |
      | standard_user           | testData.credentials.standard_user           | testData.credentials.secret_sauce |
      | problem_user            | testData.credentials.problem_user            | testData.credentials.secret_sauce |
      | performance_glitch_user | testData.credentials.performance_glitch_user | testData.credentials.secret_sauce |

  Scenario: Validate login for locked user
    And input('#user-name','locked_out_user')
    And input('#password','secret_sauce')
    When click('#login-button')
    Then match text("//h3[@data-test='error']") contains 'Sorry, this user has been locked out'

  Scenario: Validate login without Password
    And input('#user-name','locked_out_user')
    When click('#login-button')
    Then match text("//h3[@data-test='error']") contains 'Password is required'

  Scenario: Validate login without Username
    When click('#login-button')
    Then match text("//h3[@data-test='error']") contains 'Username is required'