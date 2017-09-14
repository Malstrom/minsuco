@navigation
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
    Given I logged in having creator account
    And I create public race
    When I visit "public" race page
    Then I should see "Partecipanti"

  Scenario: User should be turn back with history back icon
    Given I logged in having basic account
    And I visit "/races"
    And I visit user setting page
    And I visit my races page
    And I visit attendees page
    When I click to "back-history"
    And I click to "back-history"
    Then I should see "IL MIO PROFILO"

  Scenario: User should be turn back with history back icon
    Given I logged in having basic account
    And I visit "/races"
    When I click to "back-history"
    When I click to "back-history"
    When I click to "back-history"
    Then I should see "Dashboard"