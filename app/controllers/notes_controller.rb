class NotesController < ApplicationController

    get '/notes' do
        redirect_if_not_logged_in
        @notes = Note.where("secret = 0").order(created_at: :desc)
        @secret_notes = Note.where("secret = 1 and user_id = #{current_user.id}")
        erb :"/notes/index"
    end
    
    get '/notes/new' do
        redirect_if_not_logged_in
        # request.env["HTTP_REFERER"] - could store in a hidden field for a redirect?
        erb :"/notes/new"
    end

    post '/notes' do
        redirect_if_not_logged_in
        params[:secret] ? params[:note][:secret] = 1 : params[:note][:secret] = 0
        current_user.notes << Note.create(params[:note])
        redirect "/users/#{current_user.id}"
    end  

    get '/notes/:id/edit' do
        redirect_if_not_logged_in
        @note = Note.find_by(id: params[:id])
        redirect '/notes' if !@note
        redirect "/notes" unless belongs_to(@note) # haven't tested this yet
        erb :"/notes/edit"
    end

    patch '/notes/:id' do
        redirect_if_not_logged_in
        note = Note.find_by(id: params[:id])
        params[:secret] ? params[:note][:secret] = 1 : params[:note][:secret] = 0
        note.update(params[:note]) if belongs_to(note)
        redirect "/users/#{current_user.id}"
    end

    delete '/notes/:id' do
        redirect_if_not_logged_in
        note = Note.find_by(id: params[:id])
        note.destroy if belongs_to(note)
        redirect "/users/#{current_user.id}"
    end
end