class Oystercard

  Limit = 90
  Limit_fail = "ERROR - oystercard limited to £#{Limit}"


attr_reader :balance, :journey_status


 def initialize
   @balance = 0
 end

 def top_up(amount)
   fail Limit_fail if balance + amount > Limit
   @balance += amount
 end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
   @journey_status = true
  end

  def touch_out
    @journey_status = false
  end

  def in_journey?
    journey_status
  end

end
