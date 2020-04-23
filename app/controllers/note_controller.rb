
class NotesController < ApplicationController
    
    get '/notes/new' do 
        erb :'/notes/new'
    end

    get '/notes' do
      @user = User.find(session[:id])
      erb :'/notes/index'
    end

    get '/notes/delete' do 
        @user = User.find(session[:id])
        @notes = @user.notes
        erb :'/notes/delete'
      end

    post '/notes/new' do
        @user = User.find(current_user.id)
        @note = Note.create(name: params[:name], notes: params[:notes])
        if !@note.id.nil?
          @user.notes << @note
          @user.save
          redirect "/notes"
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

      # post '/notes/edit' do 
      #   @user = User.find(session[:id])
      #   @note = Note.find(params[:note_id])
      #   erb :'notes/edit'
      # end

      delete '/notes/delete' do 
        @user = User.find(current_user.id)
        @note = Note.find(params[:id])
        if !!@note.destroy
          @user.save
          redirect "/user/#{current_user.id}"
        else
          erb :'/user/failure'
        end
      end

      patch '/notes/:id/edit' do 
        @user = User.find(current_user.id)
        @note = Note.find(params[:id])
        if @note.user == current_user
          @note.update(name: params[:note_name], notes: params[:notes])
          @user.save
        else
          redirect "user/#{@user.id}"
        end
        if @note.name == params[:note_name]
          redirect "/user/#{@user.id}"
        else
          erb :'/user/failure'
        end
      end

      get '/notes/:id' do 
        @note = Note.find(params[:id])
        if @note.user == current_user
          erb :'/notes/show'
        else
          redirect "/user/#{current_user.id}"
        end
      end

      delete '/notes/:id/delete' do 
        @user = User.find(current_user.id)
        @note = Note.find(params[:id])
        if !!@note.destroy
          @user.save
          redirect "/user/#{current_user.id}"
        else
          erb :'/user/failure'
        end
      end

      get '/notes/:id/edit' do 
        @note = Note.find(params[:id])
        if @note.user == current_user
          erb :'/notes/edit'
        else
          redirect "/user/#{current_user.id}"
        end
      end

     
end