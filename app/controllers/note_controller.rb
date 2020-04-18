
class NotesController < ApplicationController
    
    get '/notes/new' do 
        erb :'/notes/new'
    end

    get '/notes/delete' do 
        @user = User.find(session[:id])
        @notes = @user.notes
        erb :'/notes/delete'
      end

    post '/notes/new' do
        @user = User.find(session[:id])
        @note = Note.create(name: params[:name], notes: params[:notes])
        if !@note.id.nil?
          @user.notes << @note
          @user.save
          erb :'/user/:id'
        else
          erb :'/user/failure'
        end
      end

      get '/notes/select' do 
        @user = User.find(session[:id])
        @notes = @user.notes
        erb :'/notes/select'
      end

      get '/notes/edit' do 
        @user = User.find(session[:id])
        erb :'/notes/edit'
      end

      post '/notes/edit' do 
        @user = User.find(session[:id])
        @note = Note.find(params[:note_id])
        erb :'notes/edit'
      end

      patch '/notes/edit' do 
        @user = User.find(session[:id])
        @note = Note.find(params[:note_id])
        @note.update(name: params[:note_name], notes: params[:notes])
        @user.save
        if @note.name == params[:note_name]
          erb :'/user/:id'
        else
          erb :'/user/failure'
        end
      end

      patch '/notes/delete' do 
        @user = User.find_by(session[:id])
        @note = Note.find(params[:note_id])
        if !!@note.destroy
          @user.save
          erb :'/user/:id'
        else
          erb :'/user/failure'
        end
      end
end