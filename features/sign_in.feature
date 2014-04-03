Feature: Signin in

  Scenario: Unsuccessfull signin
    Given a user visits the signin page
    When the user submit invalid signin information
    Then the user should see an error message

  Scenario: Successful signin
    Given a user visits the signin page
      And the user has an account
    When the user submit valid signin information
    Then the user should see their profile page
      And the user should see a sign out link
