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
    #erb :welcome
    erb :index
  end

  helpers do
    
    def current_user
      @user = User.find_by(id: session[:user_id])
    end

    def belongs_to(obj)
      #binding.pry
      if obj.class == User
        obj == current_user
      else
        obj.user_id == current_user.id
      end
    end

  end

end
