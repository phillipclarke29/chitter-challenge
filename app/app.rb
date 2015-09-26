require_relative 'data_mapper_setup'
require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'
require_relative 'helpers'



class ChitterWeb < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    'hello world'
  end

  get '/users/new' do
    erb :'new_users'
  end

  post '/users' do
  user = User.create(email: params[:email],
                name: params[:name],
                username: params[:username],
                password: params[:password])
    session[:user_id] = user.id
    redirect to('/')
  end



run! if app_file == $0
end
