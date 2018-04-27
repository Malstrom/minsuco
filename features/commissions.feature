@race @commission @javascript
Feature: Commission
  Owner should see commission of race attendees
  Attendee should see its commission

  Scenario: User should see correct revenue of its piece
    Given I logged in having attendee account
    And Exists a race "test_race" with duration "10" years and "10"% revenue
    When I add a piece named "test_piece" having "1000" value, "10" years duration
    And I visit "test_race" race page
    Then I should see "100 €"