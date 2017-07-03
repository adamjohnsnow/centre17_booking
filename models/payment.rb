require 'data_mapper'
require_relative 'user'

class Payment
  include DataMapper::Resource

  property :id, Serial
  property :cash_payment, Float
  property :time_payment, Float
  property :date_time, DateTime

  belongs_to :user

end
