Feature: See all lists of races and interact with this list

  Scenario: New user should see see empty list of its created races
    Given I sign up
    When I visit my races page
    Then I should see "Non hai ancora creato un gara!"

  Scenario: New user should see see empty list of its created races
    Given I sign up
    When I visit attendees page
    Then I should see "Non hai ancora partecipato a nessuna gara!"

  Scenario: New user should see see empty list of its created races
    Given I logged in as a "basic user"
    When I have create private race name "TestPrivateRace"
    When I visit "/races"
    Then I should see "TestPrivateRace"
