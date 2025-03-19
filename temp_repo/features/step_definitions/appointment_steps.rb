require 'date'

Given('I want to book an appointment') do
  visit '/'
  expect(page).to have_content('Book an Appointment')
end

When('I select appointment date {string} and time {string}') do |date, time|
  fill_in 'date', with: date
  fill_in 'time', with: time
  click_button 'Book Appointment'
end

Then('my appointment should be stored') do
  appointments = Sinatra::Application.settings.appointment_manager.get_appointments
  expect(appointments).not_to be_empty
end

Then('I should see a confirmation message') do
  expect(page).to have_content('Appointment booked successfully')
end

Given('I have booked an appointment for {string} at {string}') do |date, time|
  Sinatra::Application.settings.appointment_manager.book_appointment(date, time)
end

When('I view my appointments') do
  visit '/appointments'
end

Then('I should see my appointment for {string} at {string}') do |date, time|
  expect(page).to have_content("Date: #{date}")
  expect(page).to have_content("Time: #{time}")
end

When('I select appointment date in the past') do
  yesterday = (Date.today - 1).to_s
  fill_in 'date', with: yesterday
  fill_in 'time', with: '14:00'
  click_button 'Book Appointment'
end

Then('I should see an error message') do
  expect(page).to have_content('Cannot book appointments in the past')
end

Given('another customer has booked an appointment for {string} at {string}') do |date, time|
  Sinatra::Application.settings.appointment_manager.book_appointment(date, time)
end

When('I try to book an appointment for {string} at {string}') do |date, time|
  visit '/'
  fill_in 'date', with: date
  fill_in 'time', with: time
  click_button 'Book Appointment'
end

Then('I should see an error message about unavailable time') do
  expect(page).to have_content('The selected time is unavailable')
end