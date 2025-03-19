require 'sinatra'
require 'date'

# Enable sessions for better request handling
enable :sessions

# Global variable to store appointments - this is the minimal storage we need
$appointments = []

# Show the form to book an appointment
get '/' do
  erb :index
end

# Show appointments (new route for the second scenario)
get '/appointments' do
  @appointments = $appointments
  erb :appointments
end

# Handle form submission
post '/appointments' do
  # Extract data from form
  date = params[:date]
  time = params[:time]
  
  # Validate the appointment date (new validation for the third scenario)
  appointment_date = Date.parse(date) rescue nil
  if appointment_date && appointment_date < Date.today
    # Show error message for past dates
    @error = "Cannot book appointments in the past"
    return erb :index
  end
  
  # Validate the availability (new for fourth scenario)
  if $appointments.any? { |a| a[:date] == date && a[:time] == time }
    @error = "The selected time is unavailable"
    return erb :index
  end
  
  # Store the appointment
  $appointments << { date: date, time: time }
  
  # Redirect to prevent duplicate submissions
  redirect '/'
end

# Define the views
__END__

@@ index
<!DOCTYPE html>
<html>
<head>
  <title>Book an Appointment</title>
</head>
<body>
  <h1>Book an Appointment</h1>
  
  <% if @error %>
    <p style="color: red;"><%= @error %></p>
  <% end %>
  
  <form action="/appointments" method="post">
    <div>
      <label for="date">Date:</label>
      <input type="date" id="date" name="date" required>
    </div>
    <div>
      <label for="time">Time:</label>
      <input type="time" id="time" name="time" required>
    </div>
    <div>
      <button type="submit">Book Appointment</button>
    </div>
  </form>
  
  <p><a href="/appointments">View My Appointments</a></p>
</body>
</html>

@@ appointments
<!DOCTYPE html>
<html>
<head>
  <title>My Appointments</title>
</head>
<body>
  <h1>My Appointments</h1>
  
  <% if @appointments.empty? %>
    <p>You have no appointments scheduled.</p>
  <% else %>
    <ul>
      <% @appointments.each do |appointment| %>
        <li>Date: <%= appointment[:date] %>, Time: <%= appointment[:time] %></li>
      <% end %>
    </ul>
  <% end %>
  
  <p><a href="/">Book Another Appointment</a></p>
</body>
</html>