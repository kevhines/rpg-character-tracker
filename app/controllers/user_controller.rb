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


end