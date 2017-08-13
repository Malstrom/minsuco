@auth @javascript
Feature: App Authorizations
  User should be able to only its pages


  @current
  Scenario: User should not see setting page to another user
    Given I logged in as a "basic user"
    When I visit edit page of another user
    Then I should see "Non sei autorizzato ad accedere a questa pagina"