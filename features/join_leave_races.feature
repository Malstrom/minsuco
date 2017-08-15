@race @join_leave @javascript
Feature: Join in race
  New user should be able to join for max 3 times using rewards
  User with pro attendee plan should partecipate to unlimited races
  Pro creator user should not join to race without rewards


  Scenario: User should see modal after click to join in race
    Given I logged in as a "basic user"
    And I visit "/races"
    And I join in a race
    Then I should see "Inserisci per quanto vuoi partecipare"

  Scenario: User should see no not be able to partecipate a race if ita parteipation amount it's over available partecipation
    Given I logged in as a "basic user"
    Then I join in a race with amount over limit
    Then I should see "supera il limite"

  Scenario: New user should able to join in 3 races
    Given I sign up
    When I visit "/races"
    And I join to public race for 3 times
    Then I should see "Partecipazione avvenuta con successo"

  Scenario: New user should not be able to join to 4 race
    Given I sign up
    When I visit "/races"
    And I join to public race for 4 times
    Then I should see "Partecipazione non avvenuta"

  Scenario: Pro attendee join in 4 races
    Given I logged in as a "pro attendee user"
    When I visit "/races"
    And I join to public race for 4 times
    Then I should see "Partecipazione avvenuta con successo"

  Scenario: Pro creator join in 4 races
    Given I logged in as a "pro creator user"
    When I visit "/races"
    And I join to public race for 3 times
    Then I should see "Partecipazione avvenuta con successo"

  Scenario: Pro creator join in 4 races
    Given I logged in as a "pro creator user"
    When I visit "/races"
    And I join to public race for 4 times
    Then I should see "Partecipazione non avvenuta"

  Scenario: User should not join in race when race reached max attendees cap
    Given I sign up
    When I visit "/races"
    And I join in a full race
    Then I should see "La gara ha raggiunto il massimo dei partecipanti"


  Scenario: User should not be able to join to its race
  Scenario: User should not be able to join to race when race is full