
class NotesController < ApplicationController
    
    get '/notes/new' do
      redirect "/" if !user_logged_in?     
      erb :'/notes/new'

      # if !user_logged_in?
      #   redirect "/"
      # else
      #   erb :'/notes/new'
      # end

    end

    get '/notes' do
      @user = User.find(session[:id])
      erb :'/notes/index'
    end

    post '/notes' do
        @user = current_user
        @note = Note.create(name: params[:name], notes: params[:notes], user_id: @user.id)
        if !@note.id.nil?
          # @user.notes << @note
          # @user.save
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