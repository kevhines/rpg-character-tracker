class NotesController < ApplicationController

    get '/notes' do
        if current_user 
            @notes = Note.all
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
            note.update(params[:note])
            redirect :"/notes"
        else
            redirect "/login"
        end
    end



end