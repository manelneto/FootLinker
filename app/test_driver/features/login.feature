Feature: Login

  Background:
    Given I am not logged in

  Scenario: I try to log in with right email and right password
    When I fill the "email" field with "test@email.com"
    And I fill the "password" field with "password"
    And I tap the "login" button
    Then I am logged in

  Scenario: I try to log in with right email and wrong password
    When I fill the "email" field with "test@email.com"
    And I fill the "password" field with "wrong"
    And I tap the "login" button
    Then I am not logged in

  Scenario: I try to log in with wrong email and wrong password
    When I fill the "email" field with "wrong@email.com"
    And I fill the "password" field with "wrong"
    And I tap the "login" button
    Then I am not logged in

  Scenario: I try to log in without email and without password
    When I tap the "login" button
    Then I am not logged in
    