class UsersController < ApplicationController

    get '/signup' do
       # binding.pry
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
            redirect "/"
           # redirect "/users/#{u.id}"
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
            if user.character_name == "" || user.character_name == nil
                flash[:message] = "Give Your Character a Name First"
                redirect "/users/#{user.id}/edit"
            else
                flash[:message] = "login successful!"
                redirect "/users/#{user.id}"
            end
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
        if current_user
            "hello, #{current_user.username}"
        else
            redirect '/login'
        end
    end

    get '/users/:id' do
        if current_user
            if @user.character_name == "" || @user.character_name == nil
                flash[:message] = "Give Your Character a Name First"
                redirect "/users/#{@user.id}/edit"
            else
                @notes = @user.notes.order(created_at: :desc)
                @goods = @user.goods
                erb :'/users/show'
            end
        else
            redirect '/login'
        end
    end

    get '/users/:id/edit' do
        @user = User.find_by(id: params[:id])
        erb :'/users/edit'
    end

    patch '/users/:id' do
        user = User.find_by(id: params[:id])
        user.update(params[:user])
        if user.character_name == "" 
            flash[:message] = "Give Your Character a Name."
            redirect "/users/#{user.id}/edit"
        else 
            redirect "/users/#{user.id}"
        end
    end





end