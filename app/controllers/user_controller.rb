class UserController < ApplicationController

    get '/signup' do
        erb :'/user/signup'
    end

    post '/signup' do
        u = User.create(params[:user])
        if u.id
            session[:user_id] = u.id
            redirect "/"
           # redirect "/user/#{u.id}"
          else
            @errors = u.errors.full_messages
            erb :'/user/signup'
          end
    end

    get '/login' do
        erb :'/user/login'
    end

    post '/login' do
        user = User.find_by(username: params[:user][:username])
        if user && user.authenticate(params[:user][:password])
          session[:user_id] = user.id
          flash[:message] = "login successful!"
          redirect "/"
          #redirect "/user/#{user.id}"
        else
          @errors = ["Invalid Login"]
          erb :'user/login'
        end
    end

    get '/users' do
        if current_user
            "hello, #{current_user.username}"
        else
            redirect '/login'
        end
    end

    get '/user/:id' do
        @user = User.find_by(id: params[:id])
        erb :'/user/show'
    end

    get '/user/:id/edit' do
        @user = User.find_by(id: params[:id])
        erb :'/user/edit'
    end

    patch '/user/:id' do
        @user = User.find_by(id: params[:id])
        @user.update(params[:user])
        redirect "/user/#{@user.id}"
    end


end