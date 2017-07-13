require 'sinatra/base'
require 'sinatra/flash'
require 'pry'
require_relative './data_mapper_setup'
require_relative './models/slot_search'

ENV['RACK_ENV'] ||= 'development'

class Centre17Booking < Sinatra::Base
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET'] || 'something'
  register Sinatra::Flash

  get '/' do
    erb :index
  end

  get '/home' do
    @user = session[:user]
    @bookings = Booking.all(Booking.user_id => session[:user_id])
    erb :home
  end

  post '/sign-in' do
    @user = User.login(params)
    bad_sign_in if @user.nil?
    pending_approval if @user.status == 'pending'
    session[:user] = @user.firstname
    session[:user_id] = @user.id
    redirect '/home'
  end

  get '/sign-up' do
    erb :new_user
  end

  post '/sign-up' do
    params[:password] == params[:verify_password] ? register_user(params) : bad_password
  end

  get '/new-booking' do
    erb :new_booking
  end

  post '/new-booking' do
    session[:search] = params
    redirect '/search-results'
  end

  get '/search-results' do
    @results = SlotSearch.search(session[:search])
    @duration = session[:search][:duration].to_i
    erb :booking_search
  end

  get '/book' do
    @slots = Slot.get_collection(params[:id], params[:dur].to_i - 1)
    @duration = params[:dur].to_i
    erb :make_booking_request
  end

  post '/book' do
    Booking.book(params, session[:user_id])
    flash.next[:notice] = 'Thank you for your booking request. Someone from the CentrE17 team will be in touch with confirmation soon.'
    redirect '/home'
  end
  private

  def register_user(params)
    @user = User.create(params[:firstname], params[:surname],
    params[:email], params[:phone], params[:password], params[:comments])
    flash.next[:notice] = 'Your account has been sent for approval. Once validated you will receive an approval email. Thanks.'
    redirect '/'
  end

  def bad_password
    flash.next[:notice] = 'your passwords did not match, try again'
    redirect '/'
  end

  def pending_approval
    flash.next[:notice] = 'Your account has not yet been approved, please try again after you receive an approval email. Thanks.'
    redirect '/'
  end

  def bad_sign_in
    flash.next[:notice] = 'You could not be signed in, please try again or register'
    redirect '/'
  end
end
