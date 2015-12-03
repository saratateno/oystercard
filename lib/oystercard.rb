require_relative 'journey'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

attr_reader :balance, :journey

 def initialize
   @balance = 0
   @journey = Journey.new
 end

 def top_up(amount)
   fail "ERROR - oystercard limited to £#{MAXIMUM_BALANCE}" if balance + amount > MAXIMUM_BALANCE
   @balance += amount
 end

  def touch_in(station)
    fail 'Insufficient funds: top up' if balance < MINIMUM_FARE
    journey.begin(station)
    deduct(journey.penalty)
  end

  def touch_out(station)
    journey.end(station)
    journey.penalty.zero? ? deduct(journey.fare) : deduct(journey.penalty)
  end

private

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    !!entry_station
  end
end
