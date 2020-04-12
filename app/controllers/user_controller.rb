require 'pry'

class UsersController < ApplicationController

  get '/user/main' do
    erb :'user/main'
  end

  get '/user/login' do 
    erb :'/user/login'
  end



  post "/user/singup" do
    @doctor = User.create(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
    if !@user.id.nil?
      erb :'/user/login'
    else
      redirect "/user/failure"
    end
  end

  post '/user/login' do
    @user = User.find_by(username: params[:username], email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id 
      erb :'/user/show' #poner aqui user/:id
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

  get '/user/id' do 
    @user = User.find(session[:doctor_id])
    erb :'/user/show' # cambiar a user/:id
  end

  get '/user/edit' do 
    @user = User.find(session[:id])
    erb :'/user/edit'
  end

  

  patch '/user/:id' do #cambiar a :id
    @user = User.find(session[:id])
    @user.update(params[:user])
    erb :'doctors/:id'
  end

  patch '/user/delete_note' do 
    @user = User.find_by(params[:id])
    @note = Note.find_by(params[:note_id])
    @note.destroy
    @user.save
    erb :'doctors/:id'
  end

  get '/user/select_note' do 
    @user = User.find(session[:id])
    @notes = @user.notes
    erb :'user/select_note'
  end

  post '/user/edit_note' do 
    @user = User.find(session[:id])
    @note = Note.find(params[:note_id])
    erb :'user/edit_note'
  end
  
  patch '/user/edit_note' do 
    @user = User.find_by(params[:id])
    @note = Note.find_by(params[:note_id])
    if !@note.nil?
      @user.notes << @note
      @user.save
    else
      @note = Note.create(name: params[:note_name], notes: params[:notes])
      @user.notes << @note
      @user.save
    end
    erb :'user/:id'
  end

end