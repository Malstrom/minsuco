Feature: Authentication in app via standard for and social

  # new user

  Scenario: User should be see intent page after login
    Given I logged in as a "new_user"
    Then  I should see "intent" page

  Scenario: User should be see intent page after login with google
    Given I logged in as a "new_user" with social "google"
    Then  I should see "intent" page

  Scenario: User should be see intent page after login
    Given I logged in as a "new_user" with social "facebook"
    Then  I should see "intent" page

    # basic_user

  Scenario: User should be see intent page after login
    Given I logged in as a "basic_user"
    Then  I should not see "intent" page

  Scenario: User should not see intent if he it not legged in for first time
    Given I logged in as a "basic_user" with social "google"
    Then  I should not see "intent" page

  Scenario: User should not see intent if he it not legged in for first time
    Given I logged in as a "basic_user" with social "facebook"
    Then  I should not see "intent" page

    # pro_attedee

  Scenario: User should be see intent page after login
    Given I logged in as a "pro_attendee_user"
    Then  I should not see "intent" page

  Scenario: User should not see intent if he it not legged in for first time
    Given I logged in as a "pro_attendee_user" with social "google"
    Then  I should not see "intent" page

  Scenario: User should not see intent if he it not legged in for first time
    Given I logged in as a "pro_attendee_user" with social "facebook"
    Then  I should not see "intent" page

    # pro_creator

  Scenario: User should be see intent page after login
    Given I logged in as a "pro_creator_user"
    Then  I should not see "intent" page

  Scenario: User should not see intent if he it not legged in for first time
    Given I logged in as a "pro_creator_user" with social "google"
    Then  I should not see "intent" page

  Scenario: User should not see intent if he it not legged in for first time
    Given I logged in as a "pro_creator_user" with social "facebook"
    Then  I should not see "intent" page
    
    

