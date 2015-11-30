class Oystercard

  Limit = 90
  Limit_fail = "ERROR - oystercard limited to £#{Limit}"


attr_reader :balance

 def initialize
   @balance = 0
 end

 def top_up(amount)
   fail Limit_fail if balance + amount > Limit
   @balance += amount
 end

end
