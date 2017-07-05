require_relative './slot'

class SlotSearch
  attr_reader :results

  def initialize(params)
    earliest = get_earliest(params.keys)
    latest = get_latest(params.keys, params[:duration])
    @results = search_slots(params[:date], earliest , latest)
  end

  private

  def get_earliest(keys)
    return 8 if keys[1] == 'morning'
    return 13 if keys[1] == 'afternoon'
    return 18
  end

  def get_latest(keys, duration)
    return 24 - duration if keys.count('evening') == 1
    return 18 if keys.count('afternoon') == 1
    return 13
  end

  def search_slots(date, earliest, latest)
    Slot.all(
    :date.gte => date,
    :date.lt => Date.parse(date).next_day(7),
    :hour.gte => earliest,
    :hour.lt => latest,
    :status => 'available'
    )
  end
end
