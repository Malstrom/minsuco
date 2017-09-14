@race @join_leave @javascript
Feature: Join in race
  New user should be able to join for max 3 times using rewards
  User with pro attendee plan should partecipate to unlimited races
  creator should not join to race without rewards

  Scenario: New user should join in private race spending
    Given I sign up
    And I complete my profile
    And I have '1' rewards for join
    When I visit "/races"
    And I join in a close race
    Then I should have '0' free private join

  Scenario: New user should join in public race without spending reward
    Given I sign up
    And I complete my profile
    And I have '1' rewards for join
    When I visit "/races"
    And I join in a open race
    Then I should have '1' free private join

  Scenario: User should not join in race whi join_value over value of race
    Given I sign up
    And I complete my profile
    When I join in a race with 10001 join value where race value is 1000
    Then I should see "Non puoi partecipare a questa gara con questo importo"

  Scenario: User should leave race from race
    Given I sign up
    And I complete my profile
    And I visit "/races"
    When I join in a open race
    And I click to "Lascia gara"
    Then I should see "Partecipazione cancellata"

  Scenario: User should not join in race if not have rui
    Given I sign up
    When I visit "/races"
    And I join in a open race
    Then I should see "Per partecipare devi completare il tuo profilo personale"

  Scenario: User without join reward should not join in race
    Given I logged in having basic account
    And I not have reward for join race
    When I visit "/races"
    And I join in a open race
    Then I should see "Il tuo piano non ti permette di partecipare a questa gara"

  Scenario: Attendee should change value of its join_value
    Given I logged in having basic account
    And I join in a open race
    When I click to "Modifica partecipazione"
    And I fill "5000" in "join_value" input
    And I click to "Partecipa"
    Then I should see "Partecipazione aggiornata"
