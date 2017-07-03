require 'data_mapper'
require 'dm-postgres-adapter'
require_relative './models/user'
require_relative './models/booking'
require_relative './models/payment'

if ENV['RACK_ENV'] == 'test'
  @database = "postgres://localhost/centre17_test"
else
  @database = "postgres://localhost/centre17_development"
end

DataMapper.setup(:default, ENV['DATABASE_URL'] || @database)
DataMapper.finalize
DataMapper.auto_upgrade!
