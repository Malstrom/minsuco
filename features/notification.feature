@notifications @javascript
Feature: Notifications
  User should receive notifications in app and via email
  and active/deactive notifications email

  Background:
    Given a user named "creator" is online

  Scenario: User should see notification when someone join in its race
    Given I logged in as a "basic"
    When I join in race of 'creator' user
    Then creator should see notification "ha partecipato alla gara"


