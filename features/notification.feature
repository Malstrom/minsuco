@notifications @javascript @current
Feature: Notifications
  User should receive notifications in app and via email
  and active/deactive notifications email


  Scenario: Chat
    Given a user named "creator" is online
    When I create public race name "public_race"
    Given I logged in as a "basic user"
    When I join in "public_race" with "1000" euro
    Then creator should see notification "join in race"