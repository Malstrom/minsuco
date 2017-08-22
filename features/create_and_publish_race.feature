@race @create_publish @javascript
Feature: Create race
  Race should not be created without RUI
  Public race should not be published if user have finish its rewards
  Public race should not be published if user not have Pro attendee plan
  New user should see Race new form after choose self intent

  Scenario: New user should see new race page after intent page
    Given I sign up
    When I click to "Creare una mia gara è pubblicarla"
    Then I should see "Nuova gara"

  Scenario: User should create new race
    Given I logged in as a "basic"
    When I visit "/races/new"
    And I fill race form
    Then I should see "Come vuoi pubblicare la gara sul portale?"

  Scenario: User should not create race with start date before today
    Given I logged in as a "basic"
    When I visit "/races/new"
    And I fill race attribute "start_date" with "10/08/2017"
    Then I should see "La gara non puo iniziare nel passato"

  @javascript
  Scenario: Basic user should be able to publish race as public after payment trought
    Given I logged in as a "basic"
    When I visit "/races/new"
    And I fill race form
    And I publish race as "public_basic_user"
    Then I should see "Gara pubblicata sul portale"

  @javascript
  Scenario: Basic user should be able to publish race as a private
    Given I logged in as a "basic"
    When I visit "/races/new"
    And I fill race form
    And I publish race as "private"
    Then I should see "Gara pubblicata sul portale"

  @javascript
  Scenario: creator should be able to publish race as a private
    Given I logged in as a "creator"
    When I visit "/races/new"
    And I fill race form
    And I publish race as "public"
    Then I should see "Gara pubblicata sul portale"

  Scenario: creator should be able to publish race as a private
    Given I logged in as a "creator"
    When I visit "/races/new"
    And I fill race form
    And I publish race as "public"
    Then I should see "pubblica"

  Scenario: New user should be able to publish race as a public
    Given I sign up
    When I visit "/races/new"
    And I fill race form
    And I fill data in rui modal 'user_rui' value '12345'
    And I publish race as "public_basic_user"
    Then I should see "Gara pubblicata sul portale"

  @javascript
  Scenario: New user should be able to publish race as a private
    Given I sign up
    When I visit "/races/new"
    And I fill race form
    And I fill data in rui modal 'user_rui' value '12345'
    And I publish race as "private"
    Then I should see "Gara pubblicata sul portale"

  Scenario: User without RUI should be able to pay race but not publish it
    Given I sign up
    When I click to "Creare una mia gara è pubblicarla"
    And I fill race form
    And I close rui modal
    And I publish race as "public_basic_user"
    Then I should see "Non pubblicata"

  @javascript
  Scenario: User should start and stop its races
    Given I logged in as a "basic"
    And I create private race
    When I visit "private" race page
    And I stop race
    And I start race
    Then I should see "La gara è stata aggiornata"

  Scenario: Owner of race should see join list
    Given I logged in as a "creator"
    And I create public race
    When I visit "public" race page
    Then I should see "Partecipanti"




