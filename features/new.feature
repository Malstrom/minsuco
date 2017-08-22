
Feature: New feature

  Scenario:Race should draft if user have no valid rui
    Given a user: "john" exists with email: "test@usergmail.com", rui: "1234", name: "john"
    And a race exists with name: "test_race", kind: "pay_for_publish", owner: user "john"
    Then a race: "test_race" should exist with status: "draft"

  Scenario: Race should strated if user have valid rui
    Given a user: "john" exists with email: "test@usergmail.com", rui: "12345", name: "john"
    And a race exists with name: "test_race", kind: "pay_for_publish", owner: user "john"
    Then a race: "test_race" should exist with status: "draft"

