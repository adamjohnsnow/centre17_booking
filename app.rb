require 'sinatra/base'
require 'sinatra/flash'
require 'pry'
require_relative './data_mapper_setup'


ENV['RACK_ENV'] ||= 'development'

class Centre17Booking < Sinatra::Base
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET'] || 'something'
  register Sinatra::Flash

  get '/' do
    @user = User.all
    erb :index
  end

  get '/home' do
  end

  post '/sign_in' do
    @user = User.login(params)
    bad_sign_in if @user.nil?
    session[:user] = @user.name
    session[:user_id] = @user.id
    redirect '/home'
  end

end
