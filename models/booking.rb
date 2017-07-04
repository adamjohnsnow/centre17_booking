require 'data_mapper'
require_relative 'user'

class Booking
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text
  property :date_time, DateTime
  property :duration, Integer
  property :cash_quote, Float
  property :time_quote, Float
  property :status, String
  property :admin_notes, String

  belongs_to :user

end
