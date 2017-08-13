@user @settings @current @javascript
Feature: User settings
  User should be able to update its data
  User should be able to change ita plan
  User should be reset its password
  User should be able to toggle notification
  
  Scenario: New user should be able to change its name
    Given I sign up
    When I click to "IMPOSTAZIONI"
    And I change my "name" in "test_name"
    Then I should see "Dati aggiornati"
    
  Scenario: New user should be able to change its email
    Given I sign up
    When I click to "IMPOSTAZIONI"
    And I change my "email" in "newtest@email.com"
    Then I should see "Dati aggiornati"
    
  Scenario: New user should be able to change its RUI with valid RUI
    Given I sign up
    When I click to "IMPOSTAZIONI"
    And I change my "rui" in "12345"
    Then I should see "Dati aggiornati"
    
  Scenario: New user should not be able to change its RUI with invalid RUI
    Given I sign up
    When I click to "IMPOSTAZIONI"
    And I change my "rui" in "1234"
    Then I should see "Rui è troppo corto"
    
    
  Scenario: New user should be able to reset its password
  Scenario: Basic user should be able to change plan to pro attendee
  Scenario: Basic user should be able to change plan to pro creator
  Scenario: Pro attendee user should be able to change plan to Pro creator
  Scenario: Pro attendee user should be able to change plan to Basic
  Scenario: Pro creator user should be able to change plan to Pro attendee
  Scenario: Pro creator user should be able to change plan to Basic
  Scenario: User should be able to turn off all notifications
  Scenario: User should be able to turn off email notifications
  Scenario: User should be able to turn on all notifications
  Scenario: User should be able to turn on email notifications
#
