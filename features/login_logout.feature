@user @login_logout
Feature: Login and registration for users

  Scenario: New user should be see intent page after registration
    Given I sign up
    Then  I should see "Benvenuto"

  Scenario: User with basic account should see its Dashboard
    Given I logged in having basic account
    Then  I should see "Dashboard"

  Scenario: User with pro attendee account should see its Dashboard
    Given I logged in having attendee account
    Then  I should see "Dashboard"

  Scenario: User with pro creator account should see its Dashboard
    Given I logged in having creator account
    Then  I should see "Dashboard"