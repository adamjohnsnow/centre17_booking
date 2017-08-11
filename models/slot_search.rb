class SlotSearch
  attr_reader :results

  def self.search(params)
    @date = Date.parse(params[:date])
    @duration = params[:duration].to_i
    @earliest = get_earliest(params.keys)
    @latest = get_latest(params.keys)
    find_available
    return @available
  end

  def self.get_earliest(keys)
    return 8 if keys[1] == 'morning'
    return 13 if keys[1] == 'afternoon'
    return 18
  end

  def self.get_latest(keys)
    return 23 - @duration if keys.count('evening') == 1
    return 18 - 1 if keys.count('afternoon') == 1
    return 13 - 1
  end

  def self.find_available
    @available = []
    7.times do
      @day = []
      search_day
      @date += 1
      @available << @day
    end
  end

  def self.search_day
    @hour = 8
    until @hour > @latest do
      search_slot = DateTime.parse(@date.strftime("%d/%m/%Y") + " " + @hour.to_s + ":00")
      @day << search_slot if search_duration(search_slot) && @hour >= @earliest
      @hour += 1
    end
  end

  def self.search_duration(slot)
    @duration.times do
      if Booking.first(:date_time => slot)
        @hour += Booking.first(:date_time => slot).duration
        return false
      end
      slot += (1/24.0)
    end
    return true
  end
end
