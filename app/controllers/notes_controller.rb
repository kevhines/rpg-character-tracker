class NotesController < ApplicationController

    get '/notes' do
        redirect_if_not_logged_in
        @notes = Note.where("secret = 0").order(created_at: :desc)
        @secret_notes = Note.where("secret = 1 and user_id = #{current_user.id}")
        erb :"/notes/index"
    end
    
    get '/notes/new' do
        redirect_if_not_logged_in
        erb :"/notes/new"
    end

    post '/goods' do
        redirect_if_not_logged_in
        params[:secret] ? params[:good][:secret] = 1 : params[:good][:secret] = 0
        good = Good.create(params[:good])
        if good.id
            current_user.goods << good
            redirect "/users/#{current_user.id}"
        else 
            @errors = good.errors.full_messages
            erb :'/goods/new'
        end
    end  

    post '/notes' do
        redirect_if_not_logged_in
        params[:secret] ? params[:note][:secret] = 1 : params[:note][:secret] = 0
        note =  Note.create(params[:note])
        if note.id
            current_user.notes << note
            redirect "/users/#{current_user.id}"
        else
            @errors = note.errors.full_messages
            erb :'/notes/new'
        end
    end  

    get '/notes/:id/edit' do
        redirect_if_not_logged_in
        @note = Note.find_by(id: params[:id])
        redirect '/notes' if !@note
        redirect "/notes" unless belongs_to(@note) 
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