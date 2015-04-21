require 'sinatra'
require 'sinatra/json'


get '/user/:usenrame' do
  # do we even need this
end

put '/user/:username' do
  username = params[:username]
  password = params[:password]

  json result: 'ok'
end

post '/user/:username/authenticate' do
  username = params[:username]
  password = params[:password]

  # TODO check login; 200 OK or 401 Not Authorized

  json result: 'ok', groups: ['turska-users']
end

post '/user/:username/groups' do
  # TODO specify input format for a non-exhaustive group_name => boolean request
end

post '/user/:username/password' do
  username = params[:username]
  old_password = params[:old_password]
  new_password = params[:new_password] # nil on reset, set on change

  # TODO change or reset user password; 200 OK, 401 Not Authorized or 400 Bad Request

  json result: 'ok'
end
