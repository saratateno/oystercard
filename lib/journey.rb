class Journey

  MINIMUM_FARE = 1

  attr_reader :current, :log

  def initialize
    @current = Hash.new
    @log = Array.new
  end

  def begin(station)
    @current[:entry_station]= station
  end

  def end(station)
    @current[:exit_station]= station
    @log << @current
    @current = Hash.new
  end

  def fare
    MINIMUM_FARE
  end

  def in_journey?
    !@current.empty? 
  end

end
