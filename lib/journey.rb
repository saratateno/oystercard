class Journey

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

end
