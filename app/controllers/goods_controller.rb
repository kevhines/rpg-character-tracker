class GoodsController < ApplicationController

    get '/goods' do
        if current_user 
            @goods = Good.where("secret = 0")
            erb :"/goods/index"
        else
            redirect "/login"
        end  
    end
    
    get '/goods/new' do
        if current_user 
            erb :"/goods/new"
        else
            redirect "/login"
        end
    end

    post '/goods' do
        if current_user 
            params[:secret] ? params[:good][:secret] = 1 : params[:good][:secret] = 0
            @user.goods << Good.create(params[:good])
            redirect "/goods"
        else
            redirect "/login"
        end
    end  

    get '/goods/:id/edit' do
        if current_user 
            @good = Good.find_by(id: params[:id])
            erb :"/goods/edit"
        else
            redirect "/login"
        end
    end

    patch '/goods/:id' do
        if current_user 
            good = Good.find_by(id: params[:id])
            params[:secret] ? params[:good][:secret] = 1 : params[:good][:secret] = 0
            #binding.pry
            good.update(params[:good])
            redirect :"/goods"
        else
            redirect "/login"
        end
    end

    delete '/goods/:id' do
        if current_user 
            good = Good.find_by(id: params[:id])
            good.destroy
            redirect :"/users/#{@user.id}"
        else
            redirect "/login"
        end
    end

end