Feature: Appointment Scheduling
  As a customer
  I want to book appointments
  So that I can schedule services at convenient times

  Scenario: Successfully booking an appointment
    Given I want to book an appointment
    When I select appointment date "2023-04-01" and time "14:00"
    Then my appointment should be stored
    And I should see a confirmation message

  Scenario: Viewing my appointments
    Given I have booked an appointment for "2023-04-01" at "14:00"
    When I view my appointments
    Then I should see my appointment for "2023-04-01" at "14:00"

  Scenario Outline: Booking appointments at different times
    Given I want to book an appointment
    When I select appointment date "<date>" and time "<time>"
    Then my appointment should be stored
    And I should see a confirmation message

    Examples:
      | date       | time  |
      | 2023-04-01 | 09:00 |
      | 2023-04-01 | 16:30 |
      | 2023-04-02 | 11:00 |

  Scenario: Attempting to book an appointment in the past
    Given I want to book an appointment
    When I select appointment date in the past
    Then I should see an error message

  Scenario: Attempting to book an appointment at an unavailable time
    Given another customer has booked an appointment for "2023-04-01" at "14:00"
    When I try to book an appointment for "2023-04-01" at "14:00"
    Then I should see an error message about unavailable time