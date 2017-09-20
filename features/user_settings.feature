@user @settings @javascript
Feature: User settings
  User should be able to update its data
  User should be able to change ita plan
  User should be reset its password
  User should be able to toggle notification

  Background:
    Given I sign up

  Scenario: Basic user should be able to change plan to pro attendee
    When I visit user plan
    And I click to "Passa a un piano Pro Partecipanti"
    And I pay via stripe
    And I visit user plan
    Then I should see "Iscritto al piano Pro partecipanti"
    
  Scenario: Basic user should be able to change plan to pro creator
    When I visit user plan
    And I click to "Passa a un piano Pro Creatori"
    And I pay via stripe
    And I sleep "1" seconds
    And I visit user plan
    Then I should see "Iscritto al piano Pro creatori"

  Scenario: Pro attendee user should be able to change plan to Pro creator
    When I visit user plan
    And I click to "Passa a un piano Pro Creatori"
    And I pay via stripe
    And I visit user plan
    Then I should see "Iscritto al piano Pro creatori"

  Scenario: User should be set intent
    When I click to "Creare una mia gara e pubblicarla"
    And I click to "DASHBOARD"
    Then I should see "Dashboard"

    @current
  Scenario: User should able to change its theme
    When I click to "theme-options"
    And I click to 'theme-a' element
    And I visit "/"
    Then 'User' attribute 'theme' should 'theme-a'
