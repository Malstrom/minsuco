Feature: New feature

  Scenario: Race should strated if user have valid rui
    Given a user: "john" exists with email: "test@usergmail.com", rui: "12345678910", name: "john"
    And a race exists with name: "test_race", kind: "open", owner: user "john"
    Then a race: "test_race" should exist with status: "started"

  Scenario: Race should strated if user have valid rui
    Given a user: "john" exists with email: "test@usergmail.com", rui: "12345678910", name: "john"
    And a race exists with name: "test_race", kind: "open", owner: user "john"
    Then a race: "test_race" should exist with status: "started"

  Scenario: Attendee should see expired alert in race page when race is expired
    Given a user: "john" exists with email: "test@usergmail.com", rui: "12345678910", name: "john"
    And a race exists with name: "test_race", ends_at: "01/01/2017", owner: user "john"
    When I logged in having basic account
    And I visit "test_race" race page
    Then I should see "Questa gara è finita il 01/01/2017"

