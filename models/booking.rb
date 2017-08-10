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
    description: params["description"],
    title: params["title"],
    lighting: params["lighting"] == 'on',
    seating: params["seating"] == 'on',
    audio: params["audio"] == 'on',
    status: 'Pending',
    user_id: user_id
    )
    book_slots(params["slot"].to_i, params["duration"].to_i)
  end

  def self.book_slots(slot, duration)
    duration.times do
      @booking.slots << Slot.get(slot)
      slot += 1
    end
    @booking.save!
  end
end
