# Appointment Scheduling App

A simple appointment scheduling application developed using strict ATDD principles.

## Features

- Book appointments with date and time
- View all booked appointments
- Validation to prevent booking appointments in the past
- Validation to prevent double-booking the same time slot

## Setup

1. Install dependencies:

```bash
bundle install
```

2. Run the application:

```bash
bundle exec rackup -p 4567
```

3. Access the application at http://localhost:4567

## Running Tests

To run the acceptance tests:

```bash
bundle exec cucumber
```

## Development Process

This application was developed using strict Acceptance Test-Driven Development (ATDD) principles. Each feature was implemented following these steps:

1. Define one scenario at a time in Gherkin format
2. Run the test to see it fail
3. Implement step definitions for the scenario
4. Implement minimal code to make the test pass
5. Verify the test passes
6. Refactor if necessary
7. Move to the next scenario

For detailed development steps, see the [development_log.md](development_log.md) file.

## Future Enhancements

Potential future enhancements for this application:

1. **Persistent Storage**: Replace in-memory storage with a database
2. **User Authentication**: Add user accounts to manage appointments
3. **Appointment Editing**: Allow users to modify existing appointments
4. **Appointment Cancellation**: Allow users to cancel appointments
5. **Email Notifications**: Send confirmation emails for bookings
6. **Admin Interface**: Add an interface for managing appointments
7. **Time Slot Management**: Define available time slots instead of allowing any time
8. **Calendar View**: Add a visual calendar view of appointments