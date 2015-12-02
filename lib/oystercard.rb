require_relative 'journey'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

attr_reader :balance, :entry_station, :history, :current_journey

 def initialize
   @balance = 0
   @history = []
 end

 def top_up(amount)
   fail "ERROR - oystercard limited to £#{MAXIMUM_BALANCE}" if balance + amount > MAXIMUM_BALANCE
   @balance += amount
 end

  def touch_in(station)
    fail 'Insufficient funds: top up' if balance < MINIMUM_FARE
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @current_journey.end(station)
    @history << @current_journey.info
  end

private

  def deduct(fare)
    @balance -= fare
  end


end
