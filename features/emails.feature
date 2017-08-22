#Feature:
#  Background:
#    Given all emails have been delivered
#
#  @current
#  Scenario: User join join in race
#    Given a user "john" exists with email: "john@gmail.com"
#    And a user "marco" exists with email: "marco@gmail.com"
#    And a race "test_race" exists with owner: user "john"
#    When a attendee exists with user: user "marco", race: race "test_race"
#    Then 1 email should be delivered to john@gmail.com
#    And the email should contain "ha partecipato ad una tua gara."