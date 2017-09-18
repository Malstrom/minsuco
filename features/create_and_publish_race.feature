@race @create_publish @javascript
Feature: Create race
  Race should not be created without RUI
  Public race should not be published if user have finish its rewards
  Public race should not be published if user not have Pro attendee plan
  New user should see Race new form after choose self intent

  Scenario: User should be create race
    Given I logged in having basic account
    When I fill race form
    Then I should see "La gara è stata creata"

  Scenario: User should not create race that start in past
    Given I logged in having basic account
    When I fill race attribute "race_starts_at" with "01/12/1987"
    Then I should see "La gara non puo iniziare prima di oggi"

  Scenario: Basic user should publish close race
    Given I logged in having basic account
    And I have create 1 open races
    And I complete my profile
    When I publish race as close
    Then I should see "Gara pubblicata sul portale"

  Scenario: Basic user should publish open race spending rewards
    Given I logged in having basic account
    And I have create 1 open races
    And I complete my profile
    When I publish race as open
    Then I should see "Gara pubblicata sul portale"
    And I should have '2' free public race

  Scenario: Premium attendee user should publish open race spending rewards
    Given I logged in having attendee account
    And I have create 1 open races
    And I complete my profile
    When I publish race as open
    Then I should see "Gara pubblicata sul portale"
    And I should have '2' free public race

  Scenario: Premium creator user should publish open race without spending reward
    Given I logged in having creator account
    And I have create 1 open races
    And I complete my profile
    When I publish race as open
    Then I should see "Gara pubblicata sul portale"
    And I should have '3' free public race

  Scenario: User without reward should pay and publish open race
    Given I logged in having basic account
    And I have create 1 open races
    And I not have reward for publish race
    And I complete my profile
    When I publish race as pay
    Then I should see "Gara pubblicata sul portale"
    And I should have '0' free public race

  Scenario: User should start and stop its races
    Given I logged in having basic account
    And I complete my profile
    And I create private race
    When I visit "private" race page
    And I stop race
    And I start race
    Then I should see "La gara è stata aggiornata"
