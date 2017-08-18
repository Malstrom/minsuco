@race @join_leave @javascript
Feature: Join in race
  New user should be able to join for max 3 times using rewards
  User with pro attendee plan should partecipate to unlimited races
  creator should not join to race without rewards

  @current
  Scenario: User should see no not be able to partecipate a race if its join amount it's over available partecipation
    Given I logged in as a "basic"
    When I create public race name "public_race"
    Then Someone join in a race named "public_race" with "1000"
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
    Then I should see "Non hai più gare gratuite"

  Scenario: Pro attendee join in 4 races
    Given I logged in as a "attendee"
    When I visit "/races"
    And I join to public race for 4 times
    Then I should see "Partecipazione avvenuta con successo"

  Scenario: Pro creator join in 4 races
    Given I logged in as a "creator"
    When I visit "/races"
    And I join to public race for 3 times
    Then I should see "Partecipazione avvenuta con successo"

  Scenario: Pro creator join in 4 races
    Given I logged in as a "creator"
    When I visit "/races"
    And I join to public race for 4 times
    Then I should see "Non hai più gare gratuite"

  Scenario: User should not join in race when race reached max attendees cap
    Given I sign up
    When I visit "/races"
    And I join in a full race
    Then I should see "La gara ha raggiunto il massimo dei partecipanti"

  Scenario: User should not join in race whi join_value over value of race
    Given I sign up
    When I visit "/races"
    And I join with "10000" in a race with value "1000"
    Then I should see "Non puoi partecipare a questa gara con questo importo"

  Scenario: User should confirm and deny joining in its races
    Given a user named "creator" is online
    And I create public race name "public_race"
    Given I logged in as a "basic"
    When I join in "public_race" with "1000" euro
    Then creator should "confirm" join race "public_race"


