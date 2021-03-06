require 'data_mapper'
require_relative 'user'

class Booking
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text
  property :cash_quote, Float
  property :time_quote, Float
  property :status, String
  property :admin_notes, String
  property :lighting, Boolean
  property :seating, Boolean
  property :audio, Boolean
  property :tickets, Boolean
  property :date_time, DateTime
  property :duration, Integer

  belongs_to :user

  def self.book(params, user_id)
    @booking = Booking.create(
    description: params[:description],
    title: params[:title],
    lighting: params[:lighting] == 'on',
    seating: params["seating"] == 'on',
    audio: params["audio"] == 'on',
    tickets: params[:tickets] == 'on',
    status: 'Pending',
    date_time: params["slot"],
    duration: params[:duration],
    user_id: user_id
    )
  end
end
