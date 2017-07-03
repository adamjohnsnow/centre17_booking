require 'bcrypt'
require 'data_mapper'

class User
  include DataMapper::Resource
  include BCrypt

  property :id, Serial
  property :firstname, String
  property :surname, String
  property :email, String, :unique => true
  property :phone, String
  property :password_digest, Text
  property :balance, Float

  has n, :bookings
  has n, :payments

end
