class UsersController < ApplicationController

    get '/signup' do
       if !!current_user
           redirect "/users/#{current_user.id}"
       else
           erb :'/users/signup'
       end
    end

    post '/signup' do
        u = User.create(params[:user])
        if u.id
            session[:user_id] = u.id
            redirect "/users/#{u.id}"
        else
            @errors = u.errors.full_messages
            erb :'/users/signup'
        end
    end

    get '/login' do
        if !!current_user
            redirect "/users/#{current_user.id}"
        else
            erb :'/users/login'
        end
    end

    post '/login' do
        user = User.find_by(username: params[:user][:username])
        if user && user.authenticate(params[:user][:password])
          session[:user_id] = user.id
          character_name_blank?(user)
          flash[:message] = "login successful!"
          redirect "/users/#{user.id}"
        else
          @errors = ["Invalid Login"]
          erb :'users/login'
        end
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

    get '/users' do
        redirect_if_not_logged_in
        @users = User.all
        erb :'/users/index'
    end

    get '/users/' do
        redirect '/users'
    end

    get '/users/:id' do
        redirect_if_not_logged_in
        @user = User.find_by(id: params[:id])
        redirect '/users' if !@user
        character_name_blank?(@user) if belongs_to(@user)
        @notes = @user.notes.where("secret = 0").order(created_at: :desc)
        @goods = @user.goods.where("secret = 0")
        @secret_notes = @user.notes.where("secret = 1").order(created_at: :desc)
        @secret_goods = @user.goods.where("secret = 1")
        erb :'/users/show'
    end

    get '/users/:id/edit' do
        redirect_if_not_logged_in
        @user = User.find_by(id: params[:id])
        erb :'/users/edit'
    end

    patch '/users/:id' do
        redirect_if_not_logged_in
        user = User.find_by(id: params[:id])
        if belongs_to(user)
            user.update(params[:user])
            character_name_blank?(user)
        end
        redirect "/users/#{user.id}"
    end
end