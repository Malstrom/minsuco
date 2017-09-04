@email @event @javascript
Feature: Event email
  Should send to users

  Background:
    Given I sign up

  @current
  Scenario: User should receive email when invite one friend
    Given I create public race
    And I visit "public" race page
    When I invite friend "friend@test.com"
    Then "friend@test.com" should receive an email

  Scenario: User should invite friend from list of its friends
    Given I create public race
    And I have friend with email "friend@email.com"
    And I visit "public" race page
    When I invite all friends from my list
    Then "friend@email.com" should receive an email