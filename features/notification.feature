@notifications @javascript
Feature: Notifications
  User should receive notifications in app and via email
  and active/deactive notifications email

  Background:
    Given a user named "creator" is online

  Scenario: User should see notification when someone join in its race
    Given I logged in having basic account
    When I join in race of 'creator' user
    Then creator should see notification "ha partecipato ad una tua gara"
    And creator should see "Dettagli della gara" page when click to "readed_join_in_race"

#  Scenario: User should see notification expired when someone join but leave form race before user seen notification
#    Given I logged in having basic account
#    When I join in race of 'creator' user
#    When I click to "Lascia gara"
#    Then creator should see notification "basic ha partecipato alla gara gara non trovata"
#    And creator should see "Notifica scaduta" page when click to "ha partecipato ad una tua gara"



