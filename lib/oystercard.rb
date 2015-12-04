require_relative 'journey'

class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance, :history, :journey

  def initialize
    @balance = 0
    @history = Hash.new
    @journey = Journey.new
  end

  def top_up(amount)
    fail "ERROR - oystercard limited to £#{MAXIMUM_BALANCE}" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail 'Insufficient funds: top up' if balance < Journey::MINIMUM_FARE
    @journey.begin(station)
  end

  def touch_out(station)
    deduct(Journey::MINIMUM_FARE)
    @journey.end(station)
    @history[:"journey#{index}"] = @journey.info
  end

  def index
    history.count + 1
  end

private

  def deduct(fare)
    @balance -= fare
  end
end
