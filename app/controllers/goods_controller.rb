class GoodsController < ApplicationController

    get '/goods' do
        redirect_if_not_logged_in
        @goods = Good.where("secret = 0")
        erb :"/goods/index"

    end
    
    get '/goods/new' do
        redirect_if_not_logged_in
        erb :"/goods/new"

    end

    post '/goods' do
        redirect_if_not_logged_in
        params[:secret] ? params[:good][:secret] = 1 : params[:good][:secret] = 0
        current_user.goods << Good.create(params[:good])
        redirect "/goods"
    end  

    get '/goods/:id/edit' do
        redirect_if_not_logged_in
        @good = Good.find_by(id: params[:id])
        erb :"/goods/edit"
    end

    patch '/goods/:id' do
        redirect_if_not_logged_in
        good = Good.find_by(id: params[:id])
        params[:secret] ? params[:good][:secret] = 1 : params[:good][:secret] = 0
        good.update(params[:good])
        redirect :"/goods"
    end

    delete '/goods/:id' do
        redirect_if_not_logged_in
        good = Good.find_by(id: params[:id])
        good.destroy
        redirect :"/users/#{current_user.id}"
    end
end