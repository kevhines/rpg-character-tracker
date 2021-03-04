require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
  end

  register Sinatra::Flash

  get "/" do
    redirect "/users"
  end

  helpers do
    
    def current_user
      user = User.find_by(id: session[:user_id])
    end

    def redirect_if_not_logged_in
      redirect '/login' unless current_user
    end

    def belongs_to(obj)
      if obj.class == User
        obj == current_user
      else
        obj.user_id == current_user.id
      end
    end

    def character_name_blank?(user)
      if user.character_name == "" || user.character_name == nil
        flash[:message] = "Give Your Character a Name."
        redirect "/users/#{user.id}/edit"
      end
    end
  
  end

end
