require 'pry'

class UsersController < ApplicationController

  get '/user/main' do
    erb :'user/main'
  end

  get '/user/singup' do
    erb :'user/singup'
  end

  get '/user/login' do 
    erb :'/user/login'
  end
  
  get '/user/:id/edit' do 
    @user = User.find(current_user.id)
     erb :'/user/edit'
  end


  post "/user/singup" do
    @user = User.create(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
    if !@user.id.nil?
      redirect "/user/login"
    else
      erb :'/user/failure'
    end
  end

  post '/user/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id 
      redirect "/user/#{@user.id}"
    else
      erb :'/user/failure'
    end
  end
  

  get "/user/failure" do
    erb :'/user/failure'
  end

  get '/user/logout' do
    session.clear
    redirect to '/'
  end

  
  get '/user/:id' do 
    @user = User.find(current_user.id)
    erb :'/user/show'
  end

  patch '/user/:id' do 
    @user = User.find(current_user.id)
    @user.update(params[:user])
    @user.save
    redirect "/user/#{@user.id}"
  end

end

