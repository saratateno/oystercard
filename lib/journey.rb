class Journey

  attr_reader :entry_station, :exit_station, :incur_penalty, :info
  alias_method :incur_penalty?, :incur_penalty


  MINIMUM_FARE = 1
  PENALTY_CHARGE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
    @incur_penalty = true
    @info = Hash.new
  end

  def begin(station)
    @entry_station = station
    @info[:entry] = station
  end

  def end(station)
    @incur_penalty = false if in_journey?
    @exit_station = station
    @info[:exit] = station
    @entry_station = nil
  end

  def fare
    MINIMUM_FARE
  end

  def penalty
   incur_penalty ? PENALTY_CHARGE : 0
  end

  def in_journey?
    !!self.info[:entry]
  end



end
