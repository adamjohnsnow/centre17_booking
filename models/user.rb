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
  property :cash_balance, Float
  property :time_balance, Float
  property :status, String

  has n, :bookings
  has n, :payments

  def password=(pass)
    self.password_digest = BCrypt::Password.create(pass)
  end

  def self.create(firstname, surname, email, phone, password)
    @email = email
    return if duplicate_email?
    new_user(firstname, surname, email, phone, password)
    return @user
  end

  def self.new_user(firstname, surname, email, phone, password)
    @user = User.new(
            firstname: firstname,
            surname: surname,
            email: email,
            phone: phone,
            status: 'pending',
            cash_balance: 0,
            time_balance: 0
            )
    @user.password = password
    @user.save!
  end

  def self.login(params)
    @user = User.first(email: params[:email])
    @bcrypt = BCrypt::Password.new(@user.password_digest)
    return nil unless @user && @bcrypt == params[:password]
    return @user
  end

  def self.duplicate_email?
    User.count(:conditions => ['email = ?', @email]).positive?
  end

end