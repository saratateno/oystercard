class Journey

  attr_reader :info, :entry_station

  def initialize(entry_station)
    @entry_station = entry_station
    @info = { entry_station: entry_station, exit_station: nil}
  end

  def end(exit_station)
    @info[:exit_station] = exit_station
  end

  def in_journey?
    !!entry_station
  end
end
