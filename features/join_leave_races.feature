@race @join_leave
Feature: Join in race
  New user should be able to join for max 3 times using rewards
  User with pro attendee plan should partecipate to unlimited races
  Pro creator user should not join to race without rewards

  @javascript
  Scenario: New user should able to join in 3 races
    Given I sign up
    When I visit "/races"
    And I join to public race for 3 times
    Then I should see "Sei dentro la gara"

  @javascript
  Scenario: New user should not be able to join to 4 race
    Given I sign up
    When I visit "/races"
    And I join to public race for 4 times
    Then I should see "Attenzione non è possibile partecipare alla gara"

  @javascript
  Scenario: Pro attendee join in 4 races
    Given I logged in as a "pro attendee user"
    When I visit "/races"
    And I join to public race for 4 times
    Then I should see "Sei dentro la gara"

  @javascript
  Scenario: Pro creator join in 4 races
    Given I logged in as a "pro creator user"
    When I visit "/races"
    And I join to public race for 3 times
    Then I should see "Sei dentro la gara"

  @javascript
  Scenario: Pro creator join in 4 races
    Given I logged in as a "pro creator user"
    When I visit "/races"
    And I join to public race for 4 times
    Then I should see "Attenzione non è possibile partecipare alla gara"

  @javascript
  Scenario: User should not join in race when race reached max attendees cap
    Given I sign up
    When I visit "/races"
    And I join in a full race
    Then I should see "La gara ha raggiunto il massimo dei partecipanti"


  Scenario: User should not be able to join to its race
  Scenario: User should not be able to join to race when race is full