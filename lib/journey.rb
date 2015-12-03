class Journey

  MINIMUM_FARE = 1
  PENALTY = 6

  attr_reader :current, :log

  def initialize
    @current = Hash.new
    @log = Array.new
    @penalty_incurred = false
  end

  def begin(station)
    @penalty_incurred = true if in_journey?
    @current[:entry_station]= station
  end

  def end(station)
    @penalty_incurred = false
    @penalty_incurred = true if !in_journey?
    @current[:exit_station]= station
    @log << @current
    @current = Hash.new
  end

  def fare
    MINIMUM_FARE
  end

  def penalty
    @penalty_incurred ? PENALTY : 0
  end

  def in_journey?
    !@current.empty?
  end

end
