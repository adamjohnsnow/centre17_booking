require 'data_mapper'
require_relative 'booking'

class Slot
  include DataMapper::Resource
  PEAK_PRICE = 40
  OFF_PEAK_PRICE = 30

  property :id, Serial
  property :date, DateTime
  property :hour, Integer
  property :status, String
  property :base_price, Float
  property :booking_id, String

  def self.open_dates(start_date, end_date)
    this_date = Date.parse(start_date)
    until this_date == Date.parse(end_date) + 1 do
      this_hour = 8
      16.times do
        slot = Slot.create(
          date: this_date,
          hour: this_hour,
          status: 'available',
          base_price: get_price(this_date, this_hour)
          )
        this_hour += 1
      end
      this_date = this_date + 1
    end
  end

  def self.book_slots(date, time, duration)
    hour = time
    until hour == (time + duration) do
      slot = Slot.all(Slot.date => date, Slot.hour => hour)
      slot[0].status = 'booked'
      slot.save!
      hour += 1
    end
  end

  private

  def self.get_price(date, hour)
    return PEAK_PRICE if date.strftime('%a') == 'Sat' ||
                         date.strftime('%a') == 'Sun'
    if (date.strftime('%a') == 'Thur' || date.strftime('%a') == 'Fri') && hour >= 18
      return PEAK_PRICE
    end
    return OFF_PEAK_PRICE
  end
end