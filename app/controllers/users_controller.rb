class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
          redirect to '/tweets'
        else
          erb :'/users/create_user'
        end
    end

    get '/login' do
      if logged_in?
        redirect to '/tweets'
      else
        erb :'/users/login'
      end
    end

    post '/signup' do
      #raise params.inspect
      username = params[:username]
      email = params[:email]
      password = params[:password]

      if username != "" && email != "" && password != ""
        user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
        user.save
        session[:user_id] = user.id
        redirect to '/tweets'
      else
        redirect to '/signup'
      end

    end

    post '/login' do
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect to "/tweets"
      else
            redirect to '/login'
      end
    end





end
