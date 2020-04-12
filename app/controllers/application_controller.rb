require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :'main/welcome'
  end

  helpers do
    def user_logged_in?
      !!session[:id]
    end

    def urrent_user
      User.find(session[:id])
    end
  end

end


