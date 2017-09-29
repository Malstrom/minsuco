Feature: New feature

  Scenario: Race should started if user have valid rui
    Given a user: "john" exists with email: "test@usergmail.com", rui: "12345678910", name: "john"
    And a race exists with name: "test_race", kind: "open", owner: user "john"
    Then a race: "test_race" should exist with status: "started"

  Scenario: Race should started if user have valid rui
    Given a user: "john" exists with email: "test@usergmail.com", rui: "12345678910", name: "john"
    And a race exists with name: "test_race", kind: "open", owner: user "john"
    Then a race: "test_race" should exist with status: "started"

  Scenario: Attendee should see expired alert in race page when race is expired
    Given a user: "john" exists with email: "test@usergmail.com", rui: "12345678910", name: "john"
    And a race exists with name: "test_race", ends_at: "01/01/2017", owner: user "john"
    When I logged in having basic account
    And I visit "test_race" race page
    Then I should see "Questa gara è finita il 01/01/2017"

  Scenario: Owner see attendees list when at least one attendee exists
    Given I logged in having creator account
    When 'Someone' join in my race
    Then I should see 'Someone' in a race page

#  Scenario: Commission calculation
#    Given Race have 10 perc commission from 0 to 10 years
#    When 'John' join in race with piece named 'first' value '10000' for 10 years
#    And I sleep "10" seconds
#    Then 'John' should 1000 of total revenue
