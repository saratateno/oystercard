class Journey

  attr_reader :entry_station, :exit_station, :incur_penalty
  alias_method :incur_penalty?, :incur_penalty


  MINIMUM_FARE = 1

  def initialize
    @entry_station = nil
    @exit_station = nil
    @incur_penalty = true
  end

  def begin(station)
    @entry_station = station
  end

  def end(station)
    @incur_penalty = false if in_journey?
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
