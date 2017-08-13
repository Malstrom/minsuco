@user @login_logout
Feature: Login and registration for users

  Scenario: New user should be see intent page after registration
    Given I sign up
    Then  I should see "Cosa desideri fare?"

  Scenario: User with basic account should see its Dashboard
    Given I logged in as a "basic user"
    Then  I should see "La mia Dashboard"

  Scenario: User with pro attendee account should see its Dashboard
    Given I logged in as a "pro attendee user"
    Then  I should see "La mia Dashboard"

  Scenario: User with pro creator account should see its Dashboard
    Given I logged in as a "pro creator user"
    Then  I should see "La mia Dashboard"

  # log in with Google
  # log in with Facebook
