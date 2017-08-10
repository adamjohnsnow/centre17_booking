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
    return 24 if keys.count('evening') == 1
    return 18 + @duration - 1 if keys.count('afternoon') == 1
    return 13 + @duration - 1
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
    (@earliest..@latest).each do |hour|
      search_slot = DateTime.parse(@date.strftime("%d/%m/%Y") + " " + hour.to_s + ":00")
      @day << search_slot unless Booking.first(:date_time => search_slot)
    end
  end
end
