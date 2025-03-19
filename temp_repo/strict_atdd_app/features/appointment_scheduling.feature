Feature: Appointment Scheduling
  As a customer
  I want to book an appointment
  So that I can schedule a service at a convenient time

  Scenario: Successfully booking an appointment
    Given I want to book an appointment
    When I select appointment date "2030-04-01" and time "14:00"
    Then my appointment should be stored
    
  Scenario: Viewing my appointments
    Given I have booked an appointment for "2030-04-01" at "14:00"
    When I view my appointments
    Then I should see my appointment for "2030-04-01" at "14:00"
    
  Scenario: Attempting to book an appointment in the past
    Given I want to book an appointment
    When I select appointment date in the past
    Then I should see an error message about booking in the past
    
  Scenario: Attempting to book an appointment at an unavailable time
    Given another customer has booked an appointment for "2030-04-02" at "10:00"
    When I try to book an appointment for "2030-04-02" at "10:00"
    Then I should see an error message about unavailable time