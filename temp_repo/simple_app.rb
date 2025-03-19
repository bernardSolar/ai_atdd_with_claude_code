require 'sinatra'
require 'date'

# Simple in-memory storage
$appointments = []

get '/' do
  erb :index
end

get '/appointments' do
  erb :appointments
end

post '/appointments' do
  date = params[:date]
  time = params[:time]
  
  # Add appointment to storage
  $appointments << { date: date, time: time }
  
  redirect '/appointments'
end

__END__

@@ layout
<!DOCTYPE html>
<html>
<head>
  <title>Appointment Scheduler</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 40px; }
  </style>
</head>
<body>
  <h1>Appointment Scheduler</h1>
  <%= yield %>
</body>
</html>

@@ index
<h2>Book an Appointment</h2>
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

@@ appointments
<h2>My Appointments</h2>
<% if $appointments.empty? %>
  <p>You have no appointments scheduled.</p>
<% else %>
  <ul>
    <% $appointments.each do |appointment| %>
      <li>Date: <%= appointment[:date] %>, Time: <%= appointment[:time] %></li>
    <% end %>
  </ul>
<% end %>
<p><a href="/">Book Another Appointment</a></p>