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
    incur_penalty if in_journey?
    @current[:entry_station]= station
  end

  def end(station)
    @penalty_incurred = false
    incur_penalty if !in_journey?
    @current[:exit_station]= station
    add_to_log
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

private
  def add_to_log
    @log << @current
    @current = Hash.new
  end

  def incur_penalty
    @penalty_incurred = true
  end

end
