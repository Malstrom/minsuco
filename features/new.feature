@user @settings
Feature: User settings
  User should be able to update its data
  User should be able to change ita plan
  User should be reset its password
  User should be able to toggle notification

  @current
  Scenario:Test pickle
    Given a user exists
    And another user exists with email: "igor@gm.com"
    Then a user should exist with email: "igor@gm.com"

  Scenario: User should be able to turn off all notifications
  Scenario: User should be able to turn off email notifications
  Scenario: User should be able to turn on all notifications
  Scenario: User should be able to turn on email notifications
#
