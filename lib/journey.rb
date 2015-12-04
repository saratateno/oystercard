class Journey

  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1

  def begin(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end

  def fare
    MINIMUM_FARE
  end

end
