@user @settings @javascript
Feature: User settings
  User should be able to update its data
  User should be able to change ita plan
  User should be reset its password
  User should be able to toggle notification

  Background:
    Given I sign up

  Scenario: New user should be able to change its name
    When I click to "IMPOSTAZIONI"
    And I change my "name" in "test_name"
    Then I should see "Dati aggiornati"
    
  Scenario: New user should be able to change its email
    When I click to "IMPOSTAZIONI"
    And I change my "email" in "newtest@email.com"
    Then I should see "Dati aggiornati"
    
  Scenario: New user should be able to change its RUI with valid RUI
    When I click to "IMPOSTAZIONI"
    And I change my "rui" in "12345"
    Then I should see "Dati aggiornati"
    
  Scenario: New user should not be able to change its RUI with invalid RUI
    When I click to "IMPOSTAZIONI"
    And I change my "rui" in "1234"
    Then I should see "Rui è troppo corto"

  Scenario: Basic user should be able to change plan to pro attendee
    When I visit user plan
    And I click to "Passa a un piano Pro Partecipanti"
    And I pay via stripe
    And I visit user plan
    Then I should see "Iscritto al piano Pro partecipanti"

  @current
  Scenario: Basic user should be able to change plan to pro creator
    When I visit user plan
    And I click to "Passa a un piano Pro Creatori"
    And I pay via stripe
    And I visit user plan
    Then I should see "Iscritto al piano Pro creatori"

  Scenario: Pro attendee user should be able to change plan to Pro creator
    When I visit user plan
    And I click to "Passa a un piano Pro Creatori"
    And I pay via stripe
    And I visit user plan
    Then I should see "Iscritto al piano Pro creatori"

  Scenario: User should be able to turn off all notifications
  Scenario: User should be able to turn off email notifications
  Scenario: User should be able to turn on all notifications
  Scenario: User should be able to turn on email notifications
#
