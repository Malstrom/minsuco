@auth @javascript
Feature: App Authorizations
  User should be able to only its pages

  Scenario: User should not see setting page to another user
    Given I logged in having basic account
    When I visit edit page of another user
    Then I should see "Non sei autorizzato ad accedere a questa pagina"
