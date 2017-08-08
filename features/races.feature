Feature: Race

    # new_user

  Scenario: View all races in app
    Given I logged in as a "new_user"
    And   I click to "all_races"
    Then  I should see "all_races" "table"

  Scenario: View my created races
    Given I logged in as a "new_user"
    And   I click to "my_races"
    Then  I should see "my_races" "table"

  Scenario: View races where i am attendee
    Given I logged in as a "new_user"
    And   I click to "my_races"
    Then  I should see "attendee_races" "table"

  Scenario: New user should be able to create new races
    Given I logged in as a "new_user"
    And   I click to "attendee-btn"
    Then  I should see "all_races" "table"

  Scenario: New user should be able to create and publish public new race
    Given I logged in as a "new_user"
    And   I click to "creator-btn"
    And   I should see "create race" form
    And   I submit new race named "MyTestRace"
    And   I click to "public"
    And   I should see "stripe" "button"
    And   I pay race named "MyTestRace"
    Then  I should see "MyTestRace" race published with kind "public"

  Scenario: New user should be able to create and publish private new race
    Given I logged in as a "new_user"
    And   I click to "creator-btn"
    And   I should see "create race" "form"
    And   I submit new race named "MyTestRace"
    And   I click to "private" button
    And   I click to "publish"
    And   I pay race named "MyTestRace"
    Then  I should see "MyTestRace" race published with kind "private"

  Scenario: New user should be able to partecipate to race
    Given I logged in as a "new_user"
    And   I click to "attendee-btn"
    And   I should see "all_races" "table"
    And   I click to "PublicTestRace"
    When  I click to "partecipate"
    Then  I should see "partecipate" alert

    # basic_user
  
  Scenario: View all races in app
    Given I logged in as a "basic_user"
    And   I click to "all_races"
    Then  I should see "all_races" "table"

  Scenario: View my created races
    Given I logged in as a "basic_user"
    And   I click to "my_races"
    Then  I should see "my races" "table"

  Scenario: View races where i am attendee
    Given I logged in as a "basic_user"
    And   I click to "my_races"
    Then  I should see "attedee_races" "table"

  Scenario: Basic user should be able to create and publish public new race
    Given I logged in as a "new_user"
    And   I click to "new_race"
    And   I should see "create race" "form"
    And   I submit new race named "MyTestRace"
    And   I click to "public"
    And   I should see "stripe" "button"
    And   I pay race named "MyTestRace"
    Then  I should see "MyTestRace" race published with kind "public"

  Scenario: Basic user should be able to create and publish private new race
    Given I logged in as a "new_user"
    And   I click to "new_race"
    And   I should see "create race" "form"
    And   I submit new race named "MyTestRace"
    And   I click to "private" 
    And   I click to "publish"
    And   I pay race named "MyTestRace"
    Then  I should see "MyTestRace" race published with kind "private"

  Scenario: Basic user should be able to partecipate to race
    Given I logged in as a "new_user"
    And   I click to "attendee-btn"
    And   I should see "all_races" "table"
    And   I click to "PublicTestRace"
    When  I click to "partecipate"
    Then  I should see "partecipate" alert
    
    # pro_attendee_user

  Scenario: View all races in app
    Given I logged in as a "pro_attendee_user"
    And   I click to "all_races"
    Then  I should see "all_races" "table"

  Scenario: View my created races
    Given I logged in as a "pro_attendee_user"
    And   I click to "my_races"
    Then  I should see "my races" "table"

  Scenario: View races where i am attendee
    Given I logged in as a "pro_attendee_user"
    And   I click to "my_races"
    Then  I should see "attedee_races" "table"

  Scenario: Pro-attendee user should be able to create and publish public new race
    Given I logged in as a "new_user"
    And   I click to "new_race"
    And   I should see "create race" "form"
    And   I submit new race named "MyTestRace"
    And   I click to "public"
    And   I should see "stripe" "button"
    And   I pay race named "MyTestRace"
    Then  I should see "MyTestRace" race published with kind "public"

  Scenario: Pro-attendee user should be able to create and publish private new race
    Given I logged in as a "new_user"
    And   I click to "new_race"
    And   I should see "create race" "form"
    And   I submit new race named "MyTestRace"
    And   I click to "private"
    And   I click to "publish"
    And   I pay race named "MyTestRace"
    Then  I should see "MyTestRace" race published with kind "private"

  Scenario: Pro-attendee user should be able to partecipate to race
    Given I logged in as a "new_user"
    And   I click to "attendee-btn"
    And   I should see "all_races" "table"
    And   I click to "PublicTestRace"
    When  I click to "partecipate"
    Then  I should see "partecipate" alert
  
    # pro_creator_user

  Scenario: View all races in app
    Given I logged in as a "pro_creator_user"
    And   I click to "all_races"
    Then  I should see "all_races" "table"

  Scenario: View my created races
    Given I logged in as a "pro_creator_user"
    And   I click to "my_races"
    Then  I should see "my races" "table"

  Scenario: View races where i am attendee
    Given I logged in as a "pro_creator_user"
    And   I click to "my_races"
    Then  I should see "attedee_races" "table"
    
  Scenario: Pro-creator user should be able to create and publish public new race
    Given I logged in as a "new_user"
    And   I click to "new_race"
    And   I should see "create race" "form"
    And   I submit new race named "MyTestRace"
    And   I click to "public"
    And   I click to "publish"
    Then  I should see "MyTestRace" race published with kind "public"

  Scenario: Pro-creator user should be able to create and publish private new race
    Given I logged in as a "new_user"
    And   I click to "new_race"
    And   I should see "create race" "form"
    And   I submit new race named "MyTestRace"
    And   I click to "private"
    And   I click to "publish"
    And   I pay race named "MyTestRace"
    Then  I should see "MyTestRace" race published with kind "private"

  Scenario: Pro-creator user should be able to partecipate to race
    Given I logged in as a "new_user"
    And   I click to "attendee-btn"
    And   I should see "all_races" "table"
    And   I click to "PublicTestRace"
    When  I click to "partecipate"
    Then  I should see "partecipate" alert
