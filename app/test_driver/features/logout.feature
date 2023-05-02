Feature: Logout

  Scenario: I try to log out
    Given I am logged in
    When I tap the "profile" button
    And I tap the "logout" button
    Then I am not logged in
