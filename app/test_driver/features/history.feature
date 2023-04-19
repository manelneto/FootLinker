Feature: History

  Scenario: I try to check my history
    Given I am logged in
    When I tap the "history" button
    Then I see "history"
