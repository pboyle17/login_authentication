require 'bundler'

Bundler.require

#establishing connection to postgresql db
ActiveRecord::Base.establish_connection(
  :database=>'bee_crypt',
  :adapter=>'postgresql'
)

#this will go in application controller
enable :sessions

#helper method to see if user exists
def does_user_exist (username)
  user = Account.find_by(:user_name=> username)
  if user
    return true
  else
    return false
  end
end

def authorization_check
  if session[:current_user]==nil
    redirect '/not_authorized'
  else
    return true
  end
end

get '/' do
  authorization_check
  @user_name=session[:current_user].user_name
  erb :index
end

post '/register' do
  p params

#check if the user someon is trying to register exists or not
if does_user_exist(params[:user_name])
  return {:message=>'womp womp ... user exists'}.to_json
end
#if we make it this far the user doesn not exist , so we make it
user=Account.create(user_email: params[:user_email], user_name: params[:user_name], password:params[:password])
session[:current_user]=user

redirect '/'

end

get '/not_authorized' do
  erb :not_authorized
end

get '/login' do
  erb :login
end

post '/login' do
  user = Account.authenticate(params[:user_name],params[:password])
  if user
    session[:current_user]=user
    @user_name=user
    redirect '/index'
  else
    @message = 'your password or account is incorrect'
  end
end

get '/logout' do
  authorization_check
  session[:current_user]=nil
  redirect '/'
end

get '/register' do
  erb :register #render the erb view
end

get '/index' do
  erb :index
end

get '/logout_successful' do
  erb :logout_successful
end
