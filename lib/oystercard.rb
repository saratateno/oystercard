class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

attr_reader :balance, :entry_station, :history, :current_journey

 def initialize
   @balance = 0
   @entry_station = nil
   @history = Hash.new
   @current_journey = Hash.new
 end

 def top_up(amount)
   fail "ERROR - oystercard limited to £#{MAXIMUM_BALANCE}" if balance + amount > MAXIMUM_BALANCE
   @balance += amount
 end

  def touch_in(station)
    fail 'Insufficient funds: top up' if balance < MINIMUM_FARE
   @entry_station = station
   @current_journey[:entry_station]=station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @current_journey[:exit_station]=station
    @history[:"journey#{index}"] = @current_journey
    @current_journey = Hash.new
  end

  def index
    history.count + 1
  end

private

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    !!entry_station
  end


end
