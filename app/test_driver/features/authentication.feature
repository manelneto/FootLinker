Feature: Authentication


  Scenario: I try to log in with right email and right password
    Given I am not logged in
    When I fill the "email" field with "manuel@gmail.com"
    And I fill the "password" field with "password"
    And I tap the "login" button
    Then I am logged in

  Scenario: I try to log in with right email and wrong password
    Given I am not logged in
    When I fill the "email" field with "manuel@gmail.com"
    And I fill the "password" field with "wrong"
    And I tap the "login" button
    Then I am not logged in

  Scenario: I try to log in with wrong email and wrong password
    Given I am not logged in
    When I fill the "email" field with "wrong@gmail.com"
    And I fill the "password" field with "wrong"
    And I tap the "login" button
    Then I am not logged in

  Scenario: I try to log in without email and without password
    Given I am not logged in
    When I tap the "login" button
    Then I am not logged in