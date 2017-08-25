@race
Feature: See all lists of races and interact with this list

  Scenario: New user should see see empty list of its created races
    Given I sign up
    When I visit my races page
    Then I should see "Non hai ancora creato una gara"

  Scenario: New user should see see empty list of its joined races races
    Given I sign up
    When I visit attendees page
    Then I should see "Non hai ancora partecipato a nessuna gara!"


  Scenario: Owner of the race should see list of attendee
    Given I logged in as a "creator"
    And I create public race
    When I visit "public" race page
    Then I should see "Partecipanti"


#  Scenario Race filter list
#    Given I logged in as a "Creator"
#    And a race exist with category: "auto"
#    And a race exist with category: "vita intera"
#    When I visit "/races"
#    And I sort by category "auto"
#    And I order by "" s ""
#    The I should see "auto"