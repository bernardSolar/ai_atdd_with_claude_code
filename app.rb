require 'sinatra'
require 'sinatra/json'
require 'date'
require_relative 'lib/appointment_manager'

configure do
  # Initialize the appointment manager as a singleton
  set :appointment_manager, AppointmentManager.new
  
  # For testing purposes
  set :show_exceptions, false
  set :raise_errors, true
  enable :sessions
end

# Allow from any origin in development/test
before do
  response.headers['Access-Control-Allow-Origin'] = '*'
end

get '/' do
  erb :index
end

get '/appointments' do
  @appointments = settings.appointment_manager.get_appointments
  erb :appointments
end

post '/appointments' do
  date = params[:date]
  time = params[:time]
  
  result = settings.appointment_manager.book_appointment(date, time)
  
  if result[:success]
    session[:message] = result[:message]
    redirect '/appointments'
  else
    session[:error] = result[:message]
    redirect '/'
  end
end

# Views for the web interface
__END__

@@ layout
<!DOCTYPE html>
<html>
<head>
  <title>Appointment Scheduler</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 40px; }
    .message { color: green; }
    .error { color: red; }
  </style>
</head>
<body>
  <h1>Appointment Scheduler</h1>
  <% if session[:message] %>
    <p class="message"><%= session.delete(:message) %></p>
  <% end %>
  <% if session[:error] %>
    <p class="error"><%= session.delete(:error) %></p>
  <% end %>
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