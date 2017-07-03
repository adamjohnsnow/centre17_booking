require 'data_mapper'
require_relative 'user'

class Booking
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text
  property :date_time, DateTime
  property :duration, Integer
  property :status, String

  belongs_to :user

end
