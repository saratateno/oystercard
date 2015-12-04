class Journey

  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def begin(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
    @entry_station = nil
  end

  def fare
    MINIMUM_FARE
  end

  def in_journey?
    !!@entry_station
  end

end
