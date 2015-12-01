class Oystercard

  Limit = 90
  Limit_fail = "ERROR - oystercard limited to £#{Limit}"
  Insufficient_funds = "Insufficient funds: top up"
  Minimum_fare = 1


attr_reader :balance, :journey_status

 def initialize
   @balance = 0
 end

 def top_up(amount)
   fail Limit_fail if balance + amount > Limit
   @balance += amount
 end

  def touch_in
    fail Insufficient_funds if balance < Minimum_fare
   @journey_status = true
  end

  def touch_out
    @journey_status = false
    deduct(Minimum_fare)
  end

  def in_journey?
    journey_status
  end

private

  def deduct(fare)
    @balance -= fare
  end


end
