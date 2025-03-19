Given('I want to book an appointment') do
  visit '/'
end

When('I select appointment date {string} and time {string}') do |date, time|
  fill_in 'date', with: date
  fill_in 'time', with: time
  click_button 'Book Appointment'
end

Then('my appointment should be stored') do
  # Check if the appointment is in our global variable
  # Using a simple check without RSpec matchers for now
  expect($appointments.any? { |a| a[:date] == "2030-04-01" && a[:time] == "14:00" }).to eq(true)
end

# Steps for the second scenario
Given('I have booked an appointment for {string} at {string}') do |date, time|
  # Add an appointment directly to the storage
  $appointments << { date: date, time: time }
end

When('I view my appointments') do
  visit '/appointments'
end

Then('I should see my appointment for {string} at {string}') do |date, time|
  expect(page).to have_content("Date: #{date}")
  expect(page).to have_content("Time: #{time}")
end

# Steps for the third scenario
When('I select appointment date in the past') do
  # Use yesterday's date for a past appointment
  yesterday = Date.today.prev_day.strftime("%Y-%m-%d")
  fill_in 'date', with: yesterday
  fill_in 'time', with: "14:00"
  click_button 'Book Appointment'
end

Then('I should see an error message about booking in the past') do
  expect(page).to have_content("Cannot book appointments in the past")
end

# Steps for the fourth scenario
Given('another customer has booked an appointment for {string} at {string}') do |date, time|
  # Add an appointment directly to the storage
  $appointments << { date: date, time: time }
end

When('I try to book an appointment for {string} at {string}') do |date, time|
  visit '/'
  fill_in 'date', with: date
  fill_in 'time', with: time
  click_button 'Book Appointment'
end

Then('I should see an error message about unavailable time') do
  expect(page).to have_content("The selected time is unavailable")
end