class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

attr_reader :balance, :journey_status, :entry_station

 def initialize
   @balance = 0
   @entry_station = nil
 end

 def top_up(amount)
   fail "ERROR - oystercard limited to £#{MAXIMUM_BALANCE}" if balance + amount > MAXIMUM_BALANCE
   @balance += amount
 end

  def touch_in(station)
    fail 'Insufficient funds: top up' if balance < MINIMUM_FARE
   @journey_status = true
   @entry_station = station
  end

  def touch_out
    @journey_status = false
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    journey_status
  end

private

  def deduct(fare)
    @balance -= fare
  end
end
