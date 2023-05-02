Feature: Schedule

  Scenario: I try to check my schedule
    Given I am logged in
    And I see "home" page
    When I tap the "schedule" button
    Then I see "schedule" page
