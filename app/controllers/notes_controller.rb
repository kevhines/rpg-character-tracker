class NotesController < ApplicationController

    get '/notes' do
        if current_user 
            @notes = Note.where("secret = 0").order(created_at: :desc)
            erb :"/notes/index"
        else
            redirect "/login"
        end  
    end
    
    get '/notes/new' do
        if current_user 
            erb :"/notes/new"
        else
            redirect "/login"
        end
    end

    post '/notes' do
        if current_user 
            params[:secret] ? params[:note][:secret] = 1 : params[:note][:secret] = 0
            @user.notes << Note.create(params[:note])
            redirect "/notes"
        else
            redirect "/login"
        end
    end  

    get '/notes/:id/edit' do
        if current_user 
            @note = Note.find_by(id: params[:id])
            erb :"/notes/edit"
        else
            redirect "/login"
        end
    end

    patch '/notes/:id' do
        if current_user 
            note = Note.find_by(id: params[:id])
            params[:secret] ? params[:note][:secret] = 1 : params[:note][:secret] = 0
            note.update(params[:note])
            redirect :"/notes"
        else
            redirect "/login"
        end
    end

    delete '/notes/:id' do
        if current_user 
            note = Note.find_by(id: params[:id])
            note.destroy
            redirect :"/users/#{@user.id}"
        else
            redirect "/login"
        end
    end


end