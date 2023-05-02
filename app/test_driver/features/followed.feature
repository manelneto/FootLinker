Feature: Followed

  Scenario: I try to check my followed teams
    Given I am logged in
    And I see "home" page
    When I tap the "followed" button
    Then I see "followed" page
