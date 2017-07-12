require_relative './slot'

class SlotSearch
  attr_reader :results

  def self.search(params)
    @duration = params[:duration].to_i
    earliest = get_earliest(params.keys)
    latest = get_latest(params.keys)
    @results = filter_slots(search_slots(params[:date], earliest, latest))
    @results
  end

  def self.get_earliest(keys)
    return 8 if keys[1] == 'morning'
    return 13 if keys[1] == 'afternoon'
    return 18
  end

  def self.get_latest(keys)
    return 24 - @duration if keys.count('evening') == 1
    return 18 + @duration - 1 if keys.count('afternoon') == 1
    return 13 + @duration - 1
  end

  def self.search_slots(date, earliest, latest)
    Slot.all(
    :date.gte => date,
    :date.lt => Date.parse(date).next_day(7),
    :hour.gte => earliest,
    :hour.lt => latest
    )
  end

  def self.filter_slots(slots)
    return_array = []
    0.upto(slots.length) do |i|
      collection = slots[i..(i + @duration - 1)]
      return_array << slots[i] if all_free(collection)
    end
    return_array
  end

  def self.all_free(collection)
    available = collection.select{ |slot| slot.booking_id == nil }
    available.length == @duration && (available.map{ |x| x.date == available[0].date }).count(false) == 0
  end
end
