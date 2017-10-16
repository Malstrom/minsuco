@race @join_leave @javascript
Feature: Join in race
  New user should be able to join for max 3 times using rewards
  User with pro attendee plan should partecipate to unlimited races
  creator should not join to race without rewards

  Scenario: User should join in open race
    Given I logged in having basic account
    When I visit a open race
    And I join with 0 pieces to join named 'first' with '1000' value for '1' years
    Then I should see "Partecipazione avvenuta con successo"

  Scenario: User should not join in open race if he have not rui
    Given I sign up
    When I visit a open race
    And I join with 1 pieces to join named 'first' with '1000' value for '1' years
    Then I should see "Per partecipare devi inserire nel tuo profilo un RUI valido"

  Scenario: User should join in close race using reward
    Given I logged in having basic account
    When I visit a close race
    And I join with 1 pieces to join named 'first' with '1000' value for '1' years
    Then I should see "Partecipazione avvenuta con successo"
    And I should have '2' free private join

  Scenario: User should not join in close race if he not have rewards
    Given I logged in having basic account
    And I have '0' rewards for join
    When I visit a close race
    And I join with 1 pieces to join named 'first' with '1000' value for '1' years
    Then I should see "Il tuo piano non ti permette di partecipare a questa gara"
    And I should have '0' free private join

  Scenario: User with premium attendee plan should join in private race not using reward
    Given I logged in having attendee account
    When I visit a close race
    And I join with 1 pieces to join named 'first' with '1000' value for '1' years
    Then I should see "Partecipazione avvenuta con successo"
    And I should have '3' free private join

  Scenario: User should not join in race if sum of pieces are higher then race target
    Given I logged in having basic account
    When I visit a open race
    And I join with 1 pieces to join named 'first' with '110000' value for '1' years
    Then I should see "Partecipazione fallita! La somma dei tuoi pezzi supera quella dell'obbiettivo della gara."

  Scenario: User should update its join
    Given I logged in having basic account
    When I visit a open race
    And I join with 1 pieces to join named 'first' with '1000' value for '1' years
    And I update my join piece named 'first' with '1500' value for '1' years
    Then I should see "Partecipazione aggiornata"

  Scenario: User should not join two times
    Given I already join in a race
    Then I should fail to join one more time

  Scenario: User should not join if race created for different recipient
    Given I am a agent
    When  There is a race only for brokers
    Then  I should not join

  Scenario: User should not join in self race
    Given I create race
    Then I should not join






