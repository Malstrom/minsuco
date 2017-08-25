@race @join_leave @javascript
Feature: Join in race
  New user should be able to join for max 3 times using rewards
  User with pro attendee plan should partecipate to unlimited races
  creator should not join to race without rewards

  Scenario: New user should able to join in 3 races
    Given I sign up
    When I visit "/races"
    And I join in a public race
    Then I should see "Partecipazione avvenuta con successo"

  @current
  Scenario: New user should join in private race spending reward
    Given I sign up
    And I have '1' rewards for join
    When I visit "/races"
    And I join in a private race
    Then I should have '0' free private join
    And "test@mail.com" should receive an email

  Scenario: New user should join in public race without spending reward
    Given I sign up
    And I have '1' rewards for join
    When I visit "/races"
    And I join in a public race
    Then I should have '1' free private join

  Scenario: User should not join in race when race reached max attendees cap
    Given I sign up
    When I visit "/races"
    And I join in a full race
    Then I should see "La gara ha raggiunto il massimo dei partecipanti"

  Scenario: User should not join in race whi join_value over value of race
    Given I sign up
    When I join in a race with 10001 join value where race value is 1000
    Then I should see "Non puoi partecipare a questa gara con questo importo"



