@notifications @javascript
Feature: Notifications
  User should receive notifications in app and via email
  and active/deactive notifications email

  Background:
    Given a user named "creator" is online
    And I create public race name "public_race"

  Scenario: User should see notification when someone join in its race
    Given I logged in as a "basic"
    When I join in "public_race" with "1000" euro
    Then creator should see notification "ha partecipato alla gara"
