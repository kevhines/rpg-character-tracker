class GoodsController < ApplicationController

    get '/goods' do
        redirect_if_not_logged_in
        @goods = Good.where("secret = 0")
        @secret_goods = Good.where("secret = 1 and user_id = #{current_user.id}")
        erb :"/goods/index"
    end
    
    get '/goods/new' do
        redirect_if_not_logged_in
        erb :"/goods/new"

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

    get '/goods/:id/edit' do
        redirect_if_not_logged_in
        @good = Good.find_by(id: params[:id])
        redirect '/goods' if !@good
        redirect "/goods" unless belongs_to(@good)
        erb :"/goods/edit"
    end

    patch '/goods/:id' do
        redirect_if_not_logged_in
        good = Good.find_by(id: params[:id])
        params[:secret] ? params[:good][:secret] = 1 : params[:good][:secret] = 0
        good.update(params[:good]) if belongs_to(good)
        if good.errors.full_messages.empty?
            redirect "/users/#{current_user.id}"
        else
            flash[:message] = good.errors.full_messages[0]
            redirect "/goods/#{good.id}/edit"
        end
    end

    delete '/goods/:id' do
        redirect_if_not_logged_in
        good = Good.find_by(id: params[:id])
        good.destroy if belongs_to(good)
        redirect "/users/#{current_user.id}"
    end
end