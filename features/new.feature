Feature: New feature

  Scenario:Race should draft if user have no valid rui
    Given a user: "john" exists with email: "test@usergmail.com", rui: "", name: "john"
    And a race exists with name: "test_race", kind: "pay_for_publish", owner: user "john"
    Then a race: "test_race" should exist with status: "draft"

  Scenario: Race should strated if user have valid rui
    Given a user: "john" exists with email: "test@usergmail.com", rui: "12345678910", name: "john"
    And a race exists with name: "test_race", kind: "pay_for_publish", owner: user "john"
    Then a race: "test_race" should exist with status: "started"

  Scenario: Race should strated if user have valid rui
    Given a user: "john" exists with email: "test@usergmail.com", rui: "12345678910", name: "john"
    And a race exists with name: "test_race", kind: "pay_for_publish", owner: user "john"
    Then a race: "test_race" should exist with status: "started"