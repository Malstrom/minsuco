@race
Feature: See all lists of races and interact with this list

#  Scenario: New user should see see empty list of its created races
#    Given I sign up
#    When I visit my races page
#    Then I should see "Non hai ancora creato un gara!"
#
#  Scenario: New user should see see empty list of its created races
#    Given I sign up
#    When I visit attendees page
#    Then I should see "Non hai ancora partecipato a nessuna gara!"
#

  Scenario: Owner of the race should see list of attendee
    Given I logged in as a "creator"
    And I create public race
    When I visit "public" race page
    Then I should see "Partecipanti"

#  Scenario: User should ban user from the race
#    Given I logged in as a "creator"
#    And I create public race name "test_race"
#    And User "join_test_user" join in "test_race" race
#    When I visit "test_race" race page
#    And I ban "join_test_user"
#    Then I should see "Partecipazione aggiornata"
